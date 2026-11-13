-- By Woowz11

--!strict
--!optimize 2
--!native

-- Запуск клиента (НЕ ИЗМЕНЯТЬ)

local StartTime = os.clock()
require("@game/ReplicatedStorage/Script/Bootstrap")(false, StartTime, { "EventsC", "Translate", "Interface", "Render", "Input", "Moving", "Client" })

_G.Other.Try(function()
    _G.Client.Launch()
end):Catch(function(e)
    _G.Logger.Error(e, "Произошла ошибка при запуске клиента!")
end)