-- By Woowz11

--!strict
--!optimize 2
--!native

_G.Transform = {

    -- ===========================================================================
    -- Позиция

    -- Устанавливает позицию
    SetPosition = function(Transform : CFrame, X : number | Vector3, Y : number?, Z : number?) : CFrame
        if typeof(X) == "Vector3" then return CFrame.new(X.X, X.Y, X.Z) * Transform.Rotation end
        return CFrame.new(X, Y, Z) * Transform.Rotation
    end,

    -- Меняет относительно позицию в мировых координатах
    OffsetWorld = function(Transform : CFrame, X : number | Vector3 | CFrame, Y : number?, Z : number?) : CFrame
        if typeof(X) == "number" then return Transform + Vector3.new(X, Y, Z) end
        local Offset__ = typeof(X) == "Vector3" and X or X.Position
        return Transform + Offset__
    end,

    -- Меняет относительно позицию в локальных координатах
    OffsetLocal = function(Transform : CFrame, X : number | Vector3 | CFrame, Y : number?, Z : number?) : CFrame
        if typeof(X) == "number" then return Transform * CFrame.new(X, Y, Z) end
        local Offset__ = typeof(X) == "Vector3" and CFrame.new(X) or X
        return Transform * Offset__
    end,

    -- ===========================================================================
    -- Поворот

    -- Устанавливает поворот (Pitch, Yaw, Roll)
    SetRotationPYR = function(Transform : CFrame, Pitch : number | Vector3 | CFrame, Yaw : number?, Roll : number?) : CFrame
        local Rotation = typeof(Pitch) == "CFrame" and Pitch or _G.Transform.RotationPYR(Pitch, Yaw, Roll)
        return CFrame.new(Transform.Position) * Rotation
    end,

    -- Возвращает поворот (Pitch, Yaw, Roll)
    GetRotationPYR = function(Transform : CFrame) : Vector3
        local P, Y, R = Transform:ToEulerAnglesXYZ()
        return Vector3.new(P, Y, R)
    end,

    -- Создаёт поворот (Pitch, Yaw, Roll)
    RotationPYR = function(Pitch : number | Vector3, Yaw : number?, Roll : number?) : CFrame
        if typeof(Pitch) == "Vector3" then return CFrame.Angles(Pitch.X, Pitch.Y, Pitch.Z) end
        return CFrame.Angles(Pitch, Yaw or 0, Roll or 0)
    end,

    -- Поворачивает (Pitch, Yaw, Roll)
    RotatePYR = function(Transform : CFrame, Pitch : number | Vector3 | CFrame, Yaw : number?, Roll : number?) : CFrame
        local Rotation = typeof(Pitch) == "CFrame" and Pitch or _G.Transform.RotationPYR(Pitch, Yaw, Roll)
        return Transform * Rotation
    end,

    -- ===========================================================================
    -- Размер

    -- Возвращает радиус описывающий указанный паралепипед размерами
    BoundingSphereRadius = function(Size : Vector3) : number
        return math.sqrt(Size.X * Size.X + Size.Y * Size.Y + Size.Z * Size.Z) * 0.5
    end,

    -- ===========================================================================
    -- Соединения

    -- Симулирует трансформацию Motor6D так, что кажется будто он ребёнок другого Motor6D
    SimulateChildMotor6D = function(Child : Motor6D, Parent : Motor6D) : CFrame
        local ToParent = Child.C0:ToObjectSpace(Parent.C0)
        local ToChild  = ToParent:Inverse()

        return ToParent * _G.Transform.OffsetWorld(Parent.Transform.Rotation * ToChild, Parent.Transform.Position)
    end
    
}

return nil