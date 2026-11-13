-- By Woowz11

--!strict
--!optimize 2
--!native

_G.Resource = {

    -- Загружает объект
    LoadObject = function(Object : string, Server : boolean?) : Instance
        if Server == nil then Server = false end
        if Server and _G.Value.Info_ClientSide then return nil end

        if _G.Value.Debug_Log_ResourceLoading then _G.Logger.Debug("Загрузка объекта из ресурсов [\"" .. Object .. "\"]..." .. (Server and " (С сервера)" or "")) end

        return _G.Instance.Get(Server and _G.Game.Folders.StorageS or _G.Game.Folders.StorageR, Object)
    end,

    -- Загружает интерфейс
    LoadUI = function(Object : string) : Frame
        if _G.Value.Debug_Log_ResourceLoading then _G.Logger.Debug("Загрузка интерфейса из ресурсов [\"" .. Object .. "\"]...") end

        return _G.Instance.Get(_G.Game.Folders.StorageU, Object)
    end,

    -- Загружает текстуру
    LoadTexture = function(URI : string) : string
        if _G.Value.Debug_Log_ResourceLoading then _G.Logger.Debug("Загрузка текстуры из ресурсов [\"" .. URI .. "\"]...") end

        return "rbxassetid://" .. URI
    end,

    -- Загружает звук
    LoadSound = function(URI : string) : string
        if _G.Value.Debug_Log_ResourceLoading then _G.Logger.Debug("Загрузка звука из ресурсов [\"" .. URI .. "\"]...") end

        return "rbxassetid://" .. URI
    end,

    -- Загружает все ресурсы
    LoadAll = function()
        _G.Value.Resource_Object_Character = _G.Resource.LoadObject("Character", true)

        if _G.Value.Info_ClientSide then
            _G.Value.Resource_UI_Notification = _G.Resource.LoadUI("Notification")
        end

        _G.Value.Resource_Texture_White = _G.Resource.LoadTexture("93687479579595")

        _G.Value.Resource_Sound_Notification = _G.Resource.LoadSound("137402801272072")

        _G.Logger.Info("Загружены все ресурсы!")
    end

}

return nil