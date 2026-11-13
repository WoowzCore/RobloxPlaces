-- By Woowz11

--!strict
--!optimize 2
--!native

local FPS_Frames = 0
local FPS_Timer  = 0

_G.Client = {

    -- Запускает клиент
    Launch = function()
        _G.Value.Client_Player      = _G.Value.Service_Players.LocalPlayer
        _G.Value.Client_Info.Player = _G.Value.Client_Player

        _G.Value.Client_UserID = tostring(_G.Value.Client_Player.UserId)
        _G.Value.Client_Camera = workspace.CurrentCamera
        _G.Value.Input_Mouse   = _G.Value.Client_Player:GetMouse()

        _G.Client.DetectLanguage()

        _G.Value.Client_PlayerScripts = _G.Instance.Get(_G.Value.Client_Player, "PlayerScripts")
        _G.Value.Client_PlayerUI      = _G.Instance.Get(_G.Value.Client_Player, "PlayerGui"    )

        _G.Client.RemoveDefault()

        _G.Events.ConnectEvents()

        _G.Interface.Launch()

        _G.Logger.Info("Клиент запущен!")

        _G.Net.Connect_StC(_G.Enum.PacketID_StC.CharacterCreated, _G.Client.CharacterCreated)
        _G.Net.Connect_StC(_G.Enum.PacketID_StC.SendServerInfo  , _G.Client.GetServerInfo  )

        _G.Net.Connect_StC(_G.Enum.PacketID_StC.ApplyPhysic, _G.Client.ApplyPhysic)

        _G.Net.Connect_StC(_G.Enum.PacketID_StC.ClientJoined, function(Data)
            local Profile = Data[1]

            _G.Value.Profile_PlayerType = Profile[1]

            _G.Value.Profile_Developer = _G.Value.Profile_PlayerType == _G.Enum.PlayerType.Developer or _G.Value.Profile_PlayerType == _G.Enum.PlayerType.Creator
        
            if _G.Value.Profile_Developer then _G.Value.Debug_TrueDebug = true _G.Value.Function_UpdateDebug() end

            _G.Logger.System("Профиль: " .. _G.Value.Profile_PlayerType)
        end)
        _G.Net.Send_CtS(_G.Enum.PacketID_CtS.ClientReady)
        _G.Client.SendClientInfo()
    end,

    -- Удаляет некоторое дефолтное
    RemoveDefault = function()
        _G.Instance.Destroy(_G.Value.Client_PlayerScripts:FindFirstChild("RbxCharacterSounds"))
    end,

    -- Выбирает нужный язык
    DetectLanguage = function()
        local Language = _G.Value.Service_Localization:GetCountryRegionForPlayerAsync(_G.Value.Client_Player)
        local Result = _G.Enum.Language.English

        local RussianLanguageCountries = {
            "RU", "BY", "KZ", "KG", "UA", "MD", "LV", "EE", "LT", "UZ", "TJ", "TM", "AM", "AZ", "GE"
        }

        for _, Country in ipairs(RussianLanguageCountries) do
            if Language == Country then Result = _G.Enum.Language.Russian end
        end

        _G.Value.Client_Language = Result
    end,

    -- Заспавнить игрока
    Spawn = function()
        _G.Net.Send_CtS(_G.Enum.PacketID_CtS.ClientSpawn)
    end,

    -- Вызывается при остановке
    Stopping = function()
        _G.Logger.Info("Клиент вышел!")

        _G.Value.Client_Player = nil
    end,

    -- Получает информацию об сервере
    GetServerInfo = function(ServerInfo)
        _G.Value.Game_ServerInfo = _G.Value.Function_Raw_To_ServerInfo(ServerInfo)
        _G.Client.SendClientInfo()
    end,

    -- Отправляет информацию об клиенте
    SendClientInfo = function()
        _G.Net.Send_CtS(_G.Enum.PacketID_CtS.SendClientInfo, _G.Value.Function_ClientInfo_To_Raw(_G.Value.Client_Info))
    end,

    -- Персонаж создался на сервере
    CharacterCreated = function(Character : Model)
        _G.Value.Character_Character = Character
        _G.Value.Client_Info.Character = Character

        _G.Value.Game_Characters[_G.Value.Client_Player] = Character

        _G.Render.Setup_Camera()

        _G.Character.CharacterUpdateParts_Player()
        _G.Client.Update_AliveFlags()
    end,

    -- Обновляет информацию "игрок живой?"
    Update_AliveFlags = function()
        _G.Value.Client_HasCharacter = _G.Value.Character_Character ~= nil
        _G.Value.Client_Alive = _G.Value.Client_HasCharacter
        _G.Value.Client_Dead  = not _G.Value.Client_Alive
    end,

    -- Обновляет каждый тик
    Update = function(DT : number)
        for UserID, ClientInfo in pairs(_G.Value.Game_ServerInfo.Clients) do
            if UserID ~= _G.Value.Client_UserID then
                _G.Character.CharacterAnimation_Player_Apply(ClientInfo.Character,  ClientInfo.Motor_Head, ClientInfo.Motor_Neck, ClientInfo.Motor_BodyU, ClientInfo.Motor_BodyD, ClientInfo.Motor_ArmRU, ClientInfo.Motor_ArmR, ClientInfo.Motor_ArmRD, ClientInfo.Motor_ArmLU, ClientInfo.Motor_ArmL, ClientInfo.Motor_ArmLD, ClientInfo.Motor_LegRU, ClientInfo.Motor_LegR, ClientInfo.Motor_LegRD, ClientInfo.Motor_LegLU, ClientInfo.Motor_LegL, ClientInfo.Motor_LegLD, DT)
            end
        end

        if _G.Value.Client_Dead then return end
        _G.Client.Heartbeat(DT)
    end,

    -- Обновляет каждый тик, пока игрок жив
    Heartbeat = function(DT : number)
        if _G.Value.Character_ColD.Position.Y <= -500 then _G.Moving.Teleport(Vector3.new(0, 300, 100)) end
    end,

    -- Обновляет каждый кадр
    Update_Render = function(DT : number)
        _G.Client.CalculateFPS(DT)
        _G.Input.MouseUpdate()
        _G.Interface.Update()

        if _G.Value.Client_Dead then return end
        _G.Client.Heartbeat_Render(DT)
    end,

    -- Обновляет каждый кадр, пока игрок жив
    Heartbeat_Render = function(DT : number)
        _G.Moving.Update(DT)
        _G.Character.CharacterAnimation_Player(DT)
    end,

    -- Посчитать FPS
    CalculateFPS = function(DT : number)
        FPS_Frames += 1
        FPS_Timer  += DT
        if FPS_Timer >= 1 then
            _G.Value.Client_FPS = FPS_Frames
            FPS_Frames = 0
            FPS_Timer  = 0
        end
    end,

    -- Применяет физику
    ApplyPhysic = function(Actions : {})
        for _, Action in ipairs(Actions) do
            local ID = Action[1]
            if ID == 0 then
                local Object : BasePart = Action[2]
                Object.AssemblyLinearVelocity += Vector3.new(Action[3], Action[4], Action[5])
            end
        end
    end

}

return nil