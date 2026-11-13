-- By Woowz11

--!strict
--!optimize 2
--!native

_G.Input = {

    -- Обновляет мышь
    MouseUpdate = function()
        _G.Value.Input_MousePosition = _G.Value.Service_UserInput:GetMouseLocation()

        local Delta = _G.Value.Input_MousePosition - (_G.Input.__OldMousePosition or _G.Value.Input_MousePosition)

        _G.Input.__OldMousePosition = _G.Value.Input_MousePosition

        if not _G.Value.Interface_CursorLock and not (Delta.X == 0 and Delta.Y == 0) then _G.Input.Event_MouseMoving(Delta) end
    end,

    -- Прошлая позиция мыши
    __OldMousePosition = Vector2.new(),

    -- Нажата клавиша
    Event_KeyPressDown = function(KeyCode : Enum.KeyCode)
        --#region Нажатие клавиши

            if KeyCode == _G.Value.Settings_Keys[7] then _G.Value.Other_CursorLock = not _G.Value.Other_CursorLock end
            if KeyCode == _G.Value.Settings_Keys[8] then _G.Value.Other_CameraType += 1 if _G.Value.Other_CameraType > 2 then _G.Value.Other_CameraType = 0 end end
            if KeyCode == _G.Value.Settings_Keys[9] then _G.Moving.Teleport(Vector3.new(0, 10, 100)) end

            if KeyCode == _G.Value.Settings_Keys[6] then _G.Moving.Jump() end

            if KeyCode == Enum.KeyCode.N then _G.Interface.Notify("HELLO " .. _G.Value.Game_Time_Life, 0) end

        --#endregion

        if KeyCode == Enum.KeyCode.Unknown then return end
        _G.Value.Input_PressedKeys[KeyCode] = true
    end,

    -- Отжата клавиша
    Event_KeyPressUp = function(KeyCode : Enum.KeyCode)
        --#region Отжатие клавиши
        
        --#endregion

        if KeyCode == Enum.KeyCode.Unknown then return end
        _G.Value.Input_PressedKeys[KeyCode] = false
    end,

    -- Вызывается при движении мыши
    Event_MouseMoving = function(Delta : Vector2)
        _G.Moving.Mouse(Delta)
    end,

    -- Клавиша зажата?
    KeyPressed = function(KeyCode : Enum.KeyCode) : boolean return _G.Value.Input_PressedKeys[KeyCode] or false end

}

return nil