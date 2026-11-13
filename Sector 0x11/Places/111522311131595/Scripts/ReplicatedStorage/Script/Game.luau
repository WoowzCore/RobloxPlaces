-- By Woowz11

--!strict
--!optimize 2
--!native

_G.Game = {

    -- Дополнительные папки
    Folders = {},

    -- Запускает игру (вызывается до запуска сервера и клиента)
    Launch = function()
        _G.Logger.System("Добро пожаловать на " .. _G.Value.Info_Name .. " (" .. _G.Value.Info_Version .. ")!")

        --#region Создание временных папок

            -- Указывается камера для того, что-бы сервер автоматически не реплицировал содержимое на клиенты

            _G.Game.Folders.Data     = _G.Instance.GetOrCreate("Folder", "__Data"  , workspace                         )
            _G.Game.Folders.Players  = _G.Instance.GetOrCreate("Folder", "Players" , _G.Game.Folders.Data              )
            _G.Game.Folders.Net      = _G.Instance.GetOrCreate("Folder", "__Net"   , _G.Value.Service_ReplicatedStorage)
            _G.Game.Folders.StorageR = _G.Instance.GetOrCreate("Folder", "Storage" , _G.Value.Service_ReplicatedStorage)
            _G.Game.Folders.StorageS = _G.Instance.GetOrCreate("Folder", "Storage" , _G.Value.Service_ServerStorage    )
            _G.Game.Folders.Gizmos   = _G.Instance.GetOrCreate("Folder", "__Gizmos", workspace.CurrentCamera           )
            _G.Game.Folders.GizmosU  = _G.Instance.GetOrCreate("Folder", "Used"    , _G.Game.Folders.Gizmos            )
            _G.Game.Folders.StorageU = _G.Instance.GetOrCreate("Folder", "Storage" , _G.Value.Service_StarterUI        )
            _G.Game.Folders.Sound    = _G.Instance.GetOrCreate("Folder", "Sound"   , _G.Game.Folders.Data              )
            _G.Game.Folders.SoundU   = _G.Instance.GetOrCreate("Folder", "Used"    , _G.Game.Folders.Sound             )
            _G.Game.Folders.SoundC   = _G.Instance.GetOrCreate("Folder", "Client"  , _G.Game.Folders.Sound             )
            _G.Game.Folders.SoundCU  = _G.Instance.GetOrCreate("Folder", "Used"    , _G.Game.Folders.SoundC            )

        --#endregion

        _G.Resource.LoadAll()

        _G.Net.Launch()

        _G.Game.Update(0)

        _G.Logger.Info("Игра запущена!")
    end,

    -- Обновляется на сервере и на клиенте
    Update = function(DT : number)
        _G.Value.Game_Time_Life += DT
        if _G.Value.Info_ServerSide then
            _G.Value.Game_Time_World += DT
            if _G.Value.Game_ServerInfo then
                _G.Value.Game_ServerInfo.WorldTime = _G.Value.Game_Time_World
            end

            _G.Value.Game_PhysicStep = _G.Other.Round(DT, 2)
            _G.Value.Game_ServerInfo.PhysicStep = _G.Value.Game_PhysicStep
        else
            _G.Value.Game_Time_World = _G.Value.Game_ServerInfo.WorldTime or 0

            _G.Value.Game_PhysicStep = _G.Value.Game_ServerInfo.PhysicStep
        end

        local MS = tick()
        MS = math.floor((MS - math.floor(MS)) * 1000)

        _G.Value.Game_Time_UTC = os.date("!*t", os.time())
        _G.Value.Game_Time_UTC.ms = MS

        _G.Value.Game_Time_Moscow = _G.Other.TimeOffset(_G.Value.Game_Time_UTC, 3)

        _G.Value.Game_Time_Game = table.clone(_G.Value.Game_Time_Moscow)
        _G.Value.Game_Time_Game.year += 121

        _G.Value.Game_Time_Future = table.clone(_G.Value.Game_Time_Moscow)
        _G.Value.Game_Time_Future.year += 1686
    end

}

return nil