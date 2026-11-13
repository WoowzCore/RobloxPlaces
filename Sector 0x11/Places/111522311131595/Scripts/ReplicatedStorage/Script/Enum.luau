-- By Woowz11

--!strict
--!optimize 2
--!native

_G.Enum = {}

-- Тип игрока
_G.Enum.PlayerType = table.freeze({
    -- Обычный пользователь
    Default = 0,
    -- Разработчик
    Developer = 1,
    -- Создатель
    Creator = 2,
    -- Друг
    Friend = 3
})

-- Языки
_G.Enum.Language = table.freeze({
    Russian = 0,
    English = 1
})

-- Тип уведомления
_G.Enum.NotifyType = table.freeze({
    -- Обычное уведомление
    Default = 0
})

return nil