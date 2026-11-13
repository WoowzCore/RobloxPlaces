-- By Woowz11

--!strict
--!optimize 2
--!native

_G.Render = {

    -- Обновляется каждый кадр
    Render = function(DT : number)
        _G.Render.Update_Camera()
    end,

    -- Устанавливает настройки для камеры
    Setup_Camera = function()
        _G.Value.Client_Camera.CameraSubject = nil
        _G.Value.Client_Camera.CameraType    = Enum.CameraType.Scriptable
    end,

    -- Обновляет камеру
    Update_Camera = function()
        if _G.Value.Client_Dead then return end

        local CameraTransform = _G.Value.Character_Eyes.WorldCFrame

        if _G.Value.Other_CameraType > 0 then
            CameraTransform = _G.Transform.OffsetLocal(CameraTransform, 0, 0, _G.Value.Other_CameraType == 1 and 5 or -5)
            if _G.Value.Other_CameraType == 2 then
                CameraTransform = _G.Transform.RotatePYR(CameraTransform, 0, math.rad(180), 0)
            end
        end

        _G.Value.Client_Camera.CFrame = CameraTransform
        _G.Value.Client_Camera.FieldOfView = 90
    end

}

return nil