-- By Woowz11

--!strict
--!optimize 2
--!native

-- Запуск сервера (НЕ ИЗМЕНЯТЬ)

local StartTime = os.clock()
require("@game/ReplicatedStorage/Script/Bootstrap")(true, StartTime, { "EventsS", "RestrictedInfo", "World", "Services_World/Physic", "Services_World/TransformParts", "Server" })

_G.Other.Try(function()
    _G.Server.Launch()
end):Catch(function(e)
    _G.Logger.Error(e, "Произошла ошибка при запуске сервера!")
end)