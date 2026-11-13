-- By Woowz11

--!strict
--!optimize 2
--!native

local Send_ServerInfo_Time = 0

_G.Events = {

    -- Вызывается при запуске сервера
    Event_ServerLaunch = function()
        _G.World.Launch()
    end,

    -- Вызывается при закрытии сервера
    Event_ServerClose = function()
        _G.Logger.Info("Сервер закрывается...\nПроработал секунд: " .. string.format("%.6f", os.clock() - _G.Value.Info_StartTime))
    end,

    -- Вызывается каждый раз при заканчивании симуляции физики
    Event_Update = function(DeltaTime : number)
        _G.Game.Update(DeltaTime)

        for UserID, ClientInfo in pairs(_G.Value.Game_ServerInfo.Clients) do
            _G.Character.CharacterAnimation_Player_Apply(ClientInfo.Character,  ClientInfo.Motor_Head, ClientInfo.Motor_Neck, ClientInfo.Motor_BodyU, ClientInfo.Motor_BodyD, ClientInfo.Motor_ArmRU, ClientInfo.Motor_ArmR, ClientInfo.Motor_ArmRD, ClientInfo.Motor_ArmLU, ClientInfo.Motor_ArmL, ClientInfo.Motor_ArmLD, ClientInfo.Motor_LegRU, ClientInfo.Motor_LegR, ClientInfo.Motor_LegRD, ClientInfo.Motor_LegLU, ClientInfo.Motor_LegL, ClientInfo.Motor_LegLD)
        end

        _G.World.Step(DeltaTime)
        _G.Sound.Update()
        
        Send_ServerInfo_Time += DeltaTime
        if Send_ServerInfo_Time > 0.1 then
            Send_ServerInfo_Time = 0
            _G.Server.SendServerInfoEveryone()
        end
    end,

    -- Вызывается каждый раз перед заканчивании симуляции физики
    Event_PreUpdate = function(DeltaTime : number)
        _G.Gizmos.ClearAll()
    end,

    -- Вызывается когда новый игрок добавился
    Event_PlayerAdded = function(Player : Player)
        _G.Value.Game_Players[Player.UserId] = Player
        _G.Server.SendServerInfoEveryone()
        _G.Logger.Info(_G.Instance.Info(Player) .. " пытается зайти!")
    end,

    -- Вызывается когда игрок удаляется
    Event_PlayerRemoving = function(Player : Player)
        _G.Value.Game_Players     [Player.UserId] = nil
        _G.Value.Game_ServerInfo.Clients[Player.UserId] = nil
        _G.Server.SendServerInfoEveryone()
        _G.Logger.Info(_G.Instance.Info(Player) .. " вышел!")
    end,

    -- Вызывается когда новый игрок добавился (синхронизировано)
    Event_PlayerAdded_Sync = function(Player : Player)
        _G.Logger.Info(_G.Instance.Info(Player) .. " зашёл!")

        _G.Server.PlayerJoin(Player)
    end,

    -- Соеденяет ивенты
    ConnectEvents = function()
        _G.Value.Serivce_Game:BindToClose(_G.Events.Event_ServerClose)

        _G.Value.Service_Run.Heartbeat:Connect(_G.Events.Event_Update   )
        _G.Value.Service_Run.Stepped  :Connect(_G.Events.Event_PreUpdate)

        _G.Value.Service_Players.PlayerAdded   :Connect(_G.Events.Event_PlayerAdded   )
        _G.Value.Service_Players.PlayerRemoving:Connect(_G.Events.Event_PlayerRemoving)

        _G.Logger.Info("Серверные ивенты соеденены!")
    end

}

return nil