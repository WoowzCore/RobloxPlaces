-- By Woowz11

--!strict
--!optimize 2
--!native

local OldGroundPart     : BasePart? = nil
local OldGroundCFrame   : CFrame?   = nil
local OldGroundVelocity : Vector3 = Vector3.new(0, 0, 0)

_G.Moving = {

    -- Обновляет движения
    Update = function(DT : number)
        _G.Moving.Raycasts()
        _G.Moving.ApplyGroundChanges(DT)

        local W = _G.Input.KeyPressed(_G.Value.Settings_Keys[0])
        local S = _G.Input.KeyPressed(_G.Value.Settings_Keys[1])
        local D = _G.Input.KeyPressed(_G.Value.Settings_Keys[2])
        local A = _G.Input.KeyPressed(_G.Value.Settings_Keys[3])

        _G.Value.Client_MovingAxis = Vector2.new(((D and A) and 0 or (D and 1 or (A and -1 or 0))), ((W and S) and 0 or (W and -1 or (S and 1 or 0))))
        if _G.Value.Client_MovingAxis.Magnitude > 0 then
            _G.Value.Client_MovingAxis = _G.Value.Client_MovingAxis.Unit
        end

        _G.Value.Client_MovingAxisRotated = _G.Transform.RotationPYR(0, _G.Value.Character_Rotation, 0):VectorToWorldSpace(Vector3.new(_G.Value.Client_MovingAxis.X, 0, _G.Value.Client_MovingAxis.Y))

        _G.Value.Client_MovingSpeed = _G.Input.KeyPressed(_G.Value.Settings_Keys[4]) and 30 or (_G.Input.KeyPressed(_G.Value.Settings_Keys[5]) and 5 or 10)

        _G.Value.Client_MovingDirection = _G.Value.Client_MovingAxisRotated * _G.Value.Client_MovingSpeed

        if _G.Value.Client_Raycast_Ground then
            local GroundNormal = _G.Value.Client_Raycast_Ground.Normal
            _G.Value.Client_GroundAngle = math.deg(math.acos(GroundNormal.Y))

            local MaxForceScale = 1
            if _G.Value.Client_GroundAngle >= 25 then
                MaxForceScale = math.clamp(1 - (_G.Value.Client_GroundAngle - 25) / (60 - 25), 0, 1)
            end

            _G.Value.Character_MoveForce.MaxForce = 500 * MaxForceScale

            _G.Value.Client_MovingDirection = (_G.Value.Client_MovingDirection - GroundNormal * _G.Value.Client_MovingDirection:Dot(GroundNormal))

            _G.Value.Character_MoveForce.VectorVelocity = _G.Value.Client_MovingDirection
            _G.Value.Client_Moving = _G.Value.Character_MoveForce.VectorVelocity.Magnitude > 0.01
        else
            _G.Value.Client_Moving = false
            _G.Value.Client_GroundAngle = -1
            _G.Value.Character_MoveForce.MaxForce = 0
        end
    end,

    -- Создаёт лучи
    Raycasts = function()
        -- Детект пола
        _G.Value.Client_Raycast_Ground = _G.Physic.SpherecastSingle((_G.Transform.OffsetLocal(_G.Value.Character_ColD.CFrame, 0, 0.1, 0)).Position, Vector3.new(0, -0.2, 0), _G.Value.Character_ColD.Size.X, _G.Physic.IgnoreParams({_G.Value.Character_Character}))
    end,

    -- Вращает и двигает игрока если пол двигается вращается
    ApplyGroundChanges = function(DT : number)
        local Ray = _G.Value.Client_Raycast_Ground

        if Ray then
            local Part    = Ray.Instance
            local Current = Part.CFrame

            if Part == OldGroundPart and OldGroundCFrame then
                local Delta = Current * OldGroundCFrame:Inverse()

                _G.Value.Character_ColD.CFrame = Delta * _G.Value.Character_ColD.CFrame

                local P, Y, R = Delta:ToEulerAnglesXYZ()
                _G.Value.Character_Rotation += Y

                _G.Moving.GroundDoRotate = Y ~= 0

                OldGroundVelocity = (Current.Position - OldGroundCFrame.Position)
            else
                _G.Moving.GroundDoRotate = false
                OldGroundVelocity = Vector3.new(0, 0, 0)
            end

            OldGroundPart = Part
            OldGroundCFrame = Current

        else
            _G.Moving.GroundDoRotate = false
            OldGroundPart = nil
            OldGroundCFrame = nil
            OldGroundVelocity = Vector3.new(0, 0, 0)
        end
    end,

    -- Пол вращается?
    GroundDoRotate = false,

    -- Двигать голову и тело с помощью мыши
    Mouse = function(Delta : Vector2)
        if not _G.Value.Interface_CursorLock then return end

        _G.Value.Character_Rotation_Head -= Delta.Y * _G.Value.Client_Sensitivity
        _G.Value.Character_Rotation_Head = math.clamp(_G.Value.Character_Rotation_Head, _G.Value.Character_Rotation_Head_Limit.X, _G.Value.Character_Rotation_Head_Limit.Y)

        _G.Value.Character_Rotation -= Delta.X * _G.Value.Client_Sensitivity
    end,

    -- Прыгнуть
    Jump = function()
        if not _G.Value.Client_Raycast_Ground then return end

        local GroundNormal = _G.Value.Client_Raycast_Ground.Normal
        local Impulse = GroundNormal * _G.Value.Client_JumpPower

        Impulse += OldGroundVelocity * 100 -- Криво работает

        _G.Physic.Impulse(_G.Value.Character_ColD, Impulse)
    end,

    -- Телепортировать
    Teleport = function(Position : Vector3) _G.Player.Teleport(_G.Value.Client_Player, Position) end

}

return nil