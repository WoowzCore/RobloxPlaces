-- By Woowz11

--!strict
--!optimize 2
--!native

return function(ServerSide : boolean, StartTime : number, Scripts : table)
    local Scripts_Replicated = { "Value", "Enum", "Logger", "Info", "Resource", "Game", "Gizmos", "Transform", "Instance", "Physic", "Sound", "Character", "Player", "Net", "Other" }

    print("<—————————— ( Загрузка " .. (ServerSide and "S" or "C") .. " ) ——————————>")
    print("↓")

    -- Общая загрузка по времени
    local TotalLoadTime : number = 0

    -- Создаёт сообщение об загрузке
    local Message = function(Script : string, Type : string, LoadTime : number) return Type .. " " .. string.format("%.6f", LoadTime) .. " | " .. Script end

    -- Загружает скрипт
    local Load = function(Script : string, Parent : string, Type : string)
        local StartTime = os.clock()

        require(Parent .. "/" .. Script)
        
        local EndTime = os.clock()
        local LoadTime = EndTime - StartTime
        print(Message(Script, Type, LoadTime))

        TotalLoadTime += LoadTime
    end

    --#region Загрузка скриптов из Replicated
        local LoadTime = os.clock() - StartTime
        print(Message("Bootstrap", "S/C🟩", LoadTime)) -- Bootstrap типо загрузился
        TotalLoadTime += LoadTime
        for _, Script in ipairs(Scripts_Replicated) do
            Load(Script, "@game/ReplicatedStorage/Script", "S/C🟩")

            if Script == "Value" then
                _G.Value.Info_ServerSide =     ServerSide
                _G.Value.Info_ClientSide = not ServerSide

                _G.Value.Info_StartTime = StartTime
            end
        end
    --#endregion

    --#region Загрузка скриптов из Server/Client
        local Folder = ServerSide and "@game/ServerScriptService" or "@game/StarterPlayer/StarterPlayerScripts"
        for _, Script in ipairs(Scripts) do
            Load(Script, Folder, ServerSide and "  S🟧" or "  C🟦")
        end
    --#endregion

    print("↑")
    print("<——————————— ( " .. string.format("%.6f", TotalLoadTime) .. " ) ———————————>")
    print("")

    _G.Game.Launch()
end