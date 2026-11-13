-- By Woowz11

--!strict
--!optimize 2
--!native

-- Префикс сообщения
local __Prefix = (_G.Value.Info_ServerSide and "S🟧" or "C🟦") .. " : "

-- Префикс сообщения (предупреждение)
local __Prefix_Warn = __Prefix .. "⚠ : "

-- Префикс сообщения (отладочного)
local __Prefix_Debug = __Prefix .. "🟣 : "

-- Префикс сообщения (новоая строка)
local __Prefix_NewLine = "\n" .. (_G.Value.Info_StudioSide and "  ~~:~~:~~.~~~  " or "~~:~~:~~ -- ")

_G.Logger = {
    
    -- Превращает сообщение в свой стиль
    __Message = function(Prefix : string, ... : any)
        local Objects = table.pack(...)
        local Messages = {}
        for i = 1, Objects.n do
            Messages[i] = tostring(Objects[i])
        end

        local Message = table.concat(Messages, ", ")
        Message = Message:gsub("\n", __Prefix_NewLine .. Prefix) -- сделать что-бы он делал по другому если запущено вне студии
        return Prefix .. Message
    end,

    -- Системное сообщение (отображается в любом случае)
    System = function(... : any)
        print(_G.Logger.__Message(__Prefix, ...))
    end,

    -- Информационное сообщение
    Info = function(... : any)
        if _G.Value.Debug_TrueDebug or _G.Value.Info_ServerSide then
            print(_G.Logger.__Message(__Prefix, ...))
        end
    end,

    -- Ошибка
    Error = function(... : any)
        error(_G.Logger.__Message(__Prefix, ...))
    end,

    -- Предупреждение
    Warn = function(... : any)
        print(_G.Logger.__Message(__Prefix_Warn, ...))
    end,

    -- Отладочное сообщение
    Debug = function(... : any)
        if _G.Value.Debug_TrueDebug or _G.Value.Info_ServerSide then
            print(_G.Logger.__Message(__Prefix_Debug, ...))
        end
    end

}

return nil