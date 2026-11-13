-- By Woowz11

--!strict
--!optimize 2
--!native

_G.Server = {

    -- Запускает сервер
    Launch = function()
        -- Отключение автозагрузки игроков
        _G.Value.Service_Players.CharacterAutoLoads = false
        _G.Value.Service_StarterPlayer.EnableMouseLockOption = false

        _G.Instance.Get(_G.Value.Service_StarterUI, "UI").Enabled = false -- Отключение интерфейса на сервере

        _G.Events.ConnectEvents()

        _G.Events.Event_ServerLaunch()

        _G.Logger.Info("Сервер запущен!")

        _G.Net.Connect_CtS(_G.Enum.PacketID_CtS.ClientReady, function(Player : Player)
            _G.Server.SendServerInfo(Player)

            local PlayerType = _G.Enum.PlayerType.Default

            if Player.UserId == _G.Info.Server.Users.Creator then PlayerType = _G.Enum.PlayerType.Creator end

            if PlayerType == _G.Enum.PlayerType.Default then
                for _, ID in ipairs(_G.Info.Server.Users.Friends) do
                    if ID == Player.UserId then PlayerType = _G.Enum.PlayerType.Friend end
                end
            end
            _G.Net.Send_StC(Player, _G.Enum.PacketID_StC.ClientJoined, {
                -- Профиль
                [1] = {
                    -- Тип пользователя
                    [1] = PlayerType
                }
            })
        end)

        _G.Net.Connect_CtS(_G.Enum.PacketID_CtS.ClientSpawn, function(Player : Player)
            _G.Events.Event_PlayerAdded_Sync(Player)
        end)

        _G.Net.Connect_CtS(_G.Enum.PacketID_CtS.SendClientInfo, function(Player : Player, ClientInfo)
            _G.Value.Game_ServerInfo.Clients[Player.UserId] = _G.Value.Function_Raw_To_ClientInfo(ClientInfo)
        end)
    end,

    -- Игрок зашёл на сервер
    PlayerJoin = function(Player : Player)
        _G.Server.CreatePlayer(Player)
    end,

    -- Отправляет информацию об сервере игроку
    SendServerInfo = function(Player : Player)
        _G.Net.Send_StC(Player, _G.Enum.PacketID_StC.SendServerInfo, _G.Value.Function_ServerInfo_To_Raw(_G.Value.Game_ServerInfo))
    end,

    -- Отправляет информацию об сервере всем игрока
    SendServerInfoEveryone = function()
        for UserID, Player in pairs(_G.Value.Game_Players) do
            _G.Server.SendServerInfo(Player)
        end
    end,

    -- Создаёт игрока
    CreatePlayer = function(Player : Player)
        local Character = _G.Character.CreateCharacter_Player(Player)
        Character:SetAttribute("User", Player.UserId)
        _G.Value.Game_Characters[Player] = Character
        _G.Value.Game_Character_Count += 1
        Character.Parent = _G.Game.Folders.Players

        _G.Net.SetPhysicOwner(Character, Player)

        _G.Net.Send_StC(Player, _G.Enum.PacketID_StC.CharacterCreated, Character)

        _G.World.Physic.UpdatePhysicOwners()
    end
}

return nil