-- By Woowz11

--!strict
--!optimize 2
--!native

--[[

-- * - значит самогенерируемое

User [number] - Персонаж пользователя, UserID

ThatPlayer [string] - Это коллайдер игрока?

Rotate       [bool]   - Вращает объект каждый тик
Rotate_Pitch [number] - Скорость вращения по Pitch
Rotate_Yaw   [number] - Скорость вращения по Yaw
Rotate_Roll  [number] - Скорость вращения по Roll

Move         [bool]    - Двигает объект каждый тип
Move_Speed   [number]  - Скорость движения
Move_End     [Vector3] - Финальная позиция объекта
Move_End_Add [Vector3] - Move_End = Move_Start + Move_End_Add
Move_Start*  [Vector3] - Начальная позиция
Move_Offset  [number]  - Offset для позиции (0-1)

]]

_G.World = {

    -- Загружает мир
    Launch = function()
        -- Рост игрока 5 stud = 2 метра
        workspace.Gravity = 24.5

        _G.Value.Game_Time_World = 0

        for _, Object in ipairs(workspace:GetDescendants()) do
            if Object:IsA("BasePart") then
                
                _G.World.TransformParts.TryAdd(Object)
                _G.World.Physic.TryAdd(Object)

            end
        end

        --_G.Sound.PlayAmbient("rbxassetid://140733404109810")

        _G.Logger.Info("Мир загружен!")
    end,

    -- Выгружает мир
    Stop = function()
        _G.World.TransformParts.ClearAll()
        _G.World.Physic.ClearAll()
    end,

    -- Обновляет мир
    Step = function(DT : number)
        _G.World.TransformParts.Step(DT)

        _G.World.Physic.Step(DT)
    end
}

return nil