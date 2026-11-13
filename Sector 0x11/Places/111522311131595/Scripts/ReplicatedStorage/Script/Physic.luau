-- By Woowz11

--!strict
--!optimize 2
--!native

_G.Physic = {

    -- Получает Part из модели или Part
    ModelPrimaryPartOrPart = function(Object : BasePart | Model) : BasePart?
        if Object:IsA("Model") then 
            if Object.PrimaryPart == nil then _G.Logger.Error("У модели нету PrimaryPart!") end
            return Object.PrimaryPart
        else return Object end
    end,

    -- Получает первый объект по пути луча
    RaycastSingle = function(Start : Vector3, End : Vector3, Params : RaycastParams?, ColorBad : Color3?, ColorGood : Color3?) : RaycastResult?
        local Result : RaycastResult? = workspace:Raycast(Start, End - Start, Params)
        if _G.Value.Debug_Draw_Raycast then
            _G.Gizmos.Line(Start, Result and Result.Position or End, Result and (ColorGood or Color3.new(0,1,0)) or (ColorBad or Color3.new(1,0,0)))
        end
        return Result
    end,

    -- Получает все объекты по пути луча
    Raycast = function(Start : Vector3, End : Vector3, Params : RaycastParams?, ColorBad : Color3?, ColorGood : Color3?) : {RaycastResult}
        local Result = {}

        local Direction = End - Start
        local Distance = Direction.Magnitude
        Direction = Direction.Unit
        local Traveled = 0

        local Params__ : RaycastParams = Params and Params:Clone() or RaycastParams.new()
        if not Params__.FilterDescendantsInstances then Params__.FilterDescendantsInstances = {} end
        Params__.FilterType = Enum.RaycastFilterType.Exclude

        local CurrentStart = Start
        while Traveled < Distance do
            local Distance__ = Distance - Traveled
            local Hit : RaycastResult = workspace:Raycast(CurrentStart, Direction * Distance__, Params__)
            if not Hit then
                if _G.Value.Debug_Draw_Raycast then
                    _G.Gizmos.Line(CurrentStart, End, ColorBad or Color3.new(1,0,0), nil, nil, false)
                end
                break
            end

            table.insert(Result, Hit)

            if _G.Value.Debug_Draw_Raycast then
                _G.Gizmos.Line(CurrentStart, Hit.Position, ColorGood or Color3.new(0,1,0), nil, nil, false)
            end

            table.insert(Params__.FilterDescendantsInstances, Hit.Instance)

            Traveled += (Hit.Position - CurrentStart).Magnitude + 0.01
            CurrentStart = Start + Direction * Traveled
        end

        return Result
    end,

    -- Получает ближайший объект внутри сферы
    SpherecastSingle = function(Origin : Vector3, Direction : Vector3, Diameter : number, Params : OverlapParams?, ColorBad : Color3?, ColorGood : Color3?, ColorNeutral : Color3?) : RaycastResult?
        local Radius = Diameter * 0.5
        local Result : RaycastResult? = workspace:Spherecast(Origin, Radius, Direction, Params)
        if _G.Value.Debug_Draw_Raycast then
            _G.Gizmos.Point(Origin + Direction, Result and (ColorGood or Color3.new(0,1,0)) or (ColorBad or Color3.new(1,0,0)), nil, Diameter, false)
            _G.Gizmos.Point(Origin            , ColorNeutral or Color3.new(1,1,0)                                               , nil, Diameter, false)
        end
        return Result
    end,

    -- Создаёт игнорирующий RaycastParams
    IgnoreParams = function(Objects : {Instance}) : RaycastParams
        local RaycastParams__ = RaycastParams.new()
        RaycastParams__.FilterType = Enum.RaycastFilterType.Exclude
        RaycastParams__.FilterDescendantsInstances = Objects
        return RaycastParams__
    end,

    -- Применяет импульс
    Impulse = function(Object : BasePart, Impulse : Vector3)
        if _G.Value.Info_ClientSide then
            Object.AssemblyLinearVelocity += Impulse
        else
            local Owner = Object:GetNetworkOwner()
            if Owner then
                if _G.World.Physic.__PhysicUpdates[Owner.UserId] == nil then _G.World.Physic.__PhysicUpdates[Owner.UserId] = {} end
                table.insert(_G.World.Physic.__PhysicUpdates[Owner.UserId], {0, Object, Impulse.X, Impulse.Y, Impulse.Z})
            else
                Object.AssemblyLinearVelocity += Impulse
            end
        end
    end,

    -- Возвращает объекты внутри коробки
    BoundsInBox = function(Transform : CFrame, Size : Vector3, Params : OverlapParams?) : {BasePart}
        return workspace:GetPartBoundsInBox(Transform, Size, Params)
    end,

    -- Возвращает объекты внутри сферы
    BoundsInSphere = function(Position : Vector3, Diameter : number, Params : OverlapParams?) : {BasePart}
        if _G.Value.Debug_Draw_Bounds then _G.Gizmos.Point(Position, Color3.new(1,0,1), 0.875, Diameter, false) end
        return workspace:GetPartBoundsInRadius(Position, Diameter * 0.5, Params)
    end,

    -- Возвращает объекты гипотетически пересикаемые с объектом
    NearestParts = function(Object : BasePart) : {BasePart}
        return _G.Physic.BoundsInSphere(Object.Position, _G.Transform.BoundingSphereRadius(Object.Size) * 2)
    end,

    -- Делает симуляцию вращения (подходит для статичных объектов)
    SimulateRotation = function(Object : BasePart, DT : number, Pitch : number, Yaw : number, Roll : number)
        local OldCFrame = Object.CFrame
        local NewCFrame = _G.Transform.RotatePYR(OldCFrame, Pitch * DT, Yaw * DT, Roll * DT)
        Object.CFrame = NewCFrame

        local Delta = NewCFrame * OldCFrame:Inverse()
        local Axis, Angle = Delta:ToAxisAngle()
        Object.AssemblyAngularVelocity = Axis * (Angle / DT)

        local Timer = Object:GetAttribute("__SRT") or 0
        Timer += DT

        if Timer > 1 then
            for _, Part in ipairs(_G.Physic.NearestParts(Object)) do
                _G.Physic.WakeUp(Part)
            end

            Timer = 0
        end

        Object:SetAttribute("__SRT", Timer)
    end,

    -- Будит объект
    WakeUp = function(Object : BasePart)
        if Object.Anchored then return end
        _G.Physic.Impulse(Object, Vector3.new(0, 0.1, 0))
    end

}

return nil