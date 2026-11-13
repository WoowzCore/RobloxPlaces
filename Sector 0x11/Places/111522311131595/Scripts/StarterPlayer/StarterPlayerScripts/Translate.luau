-- By Woowz11

--!strict
--!optimize 2
--!native

_G.Translate = {

    -- Получить перевод определённого языка
    GetSpecial = function(Language : number, Key : string) : string
        if #Key == 0 then return "" end
        if #Key >= 2 and string.sub(Key, 1, 1) == "{" and string.sub(Key, -1) == "}" then Key = string.sub(Key, 2, -2) end

        local Data = _G.Translate.Data[Language]
        if Data == nil then _G.Logger.Error("Не найден язык [" .. Language .. "]!") end
        local Result = Data[Key]
        if Result == nil then
            Result = _G.Translate.Data[_G.Enum.Language.English][Key]
            if Result == nil then
                Result = _G.Translate.Data[_G.Enum.Language.Russian][Key]
                if Result == nil then _G.Logger.Error("Не найден ключ для языка [\"" .. Key .. "\"]") end
            end
        end
        return Result
    end,

    -- Получить перевод
    Get = function(Key : string) : string return _G.Translate.GetSpecial(_G.Value.Client_Language, Key) end,

    -- Переводит всю строку определённого языка
    TranslateSpecial = function(Language : number, String : string) : string
        if #String == 0 then return "" end

        local Result = String:gsub("{(.-)}", function(Key)
            local Translation = _G.Translate.GetSpecial(Language, Key)
            return Translation
        end)

        return Result
    end,

    -- Переводит всю строку
    Translate = function(String : string) : string return _G.Translate.TranslateSpecial(_G.Value.Client_Language, String) end,

    -- Поддерживаемые языки
    Languages = {
        [_G.Enum.Language.Russian] = {"RU", "🇷🇺", "{Russian}"},
        [_G.Enum.Language.English] = {"EN", "🇺🇸", "{English}"}
    },

    -- Сами переводы
    Data = {
        -- Русский
        [_G.Enum.Language.Russian] = {
            ["Russian"] = "Русский",
            ["English"] = "Английский",

            ["PlaceName"] = _G.Value.Info_Name .. " " .. _G.Value.Info_Version,

            ["Warning_Development"] = "Плейс находится в разработке!"
        },

        -- Английский
        [_G.Enum.Language.English] = {
            ["Russian"] = "Russian",
            ["English"] = "English",

            ["Warning_Development"] = "Place is under development!"
        }
    }

}

return nil