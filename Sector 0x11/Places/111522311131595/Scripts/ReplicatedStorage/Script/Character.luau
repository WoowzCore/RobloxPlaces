-- By Woowz11

--!strict
--!optimize 2
--!native

local Animation_Walk_Time = 0
local Animation_Arm_Right = CFrame.new()
local Animation_Arm_Left  = CFrame.new()
local Animation_Leg_Right = CFrame.new()
local Animation_Leg_Left  = CFrame.new()

_G.Character = {

    -- Создаёт персонажа гуманоида
    CreateCharacter_Humanoid = function() : Instance
        local Character = _G.Instance.Clone(_G.Value.Resource_Object_Character, workspace)
        return Character
    end,

    -- Создаёт персонажа игрока
    CreateCharacter_Player = function(Player : Player) : Instance
        local Character = _G.Character.CreateCharacter_Humanoid()
        Character.Name = Player.Name
        return Character
    end,

    -- ===========================================================================
    -- Персонаж игрока

    -- Обновляет части персонажа игрока
    CharacterUpdateParts_Player = function()
        local Get = function(Name : string) : BasePart return _G.Instance.Get(_G.Value.Character_Character, Name) end

        _G.Value.Character_Head  = Get("Head"   )
        _G.Value.Character_Neck  = Get("Neck"   )
        _G.Value.Character_BodyU = Get("Body U" )
        _G.Value.Character_BodyD = Get("Body D" )
        _G.Value.Character_ArmRU = Get("Arm R U")
        _G.Value.Character_ArmR  = Get("Arm R"  )
        _G.Value.Character_ArmRD = Get("Arm R D")
        _G.Value.Character_ArmLU = Get("Arm L U")
        _G.Value.Character_ArmL  = Get("Arm L"  )
        _G.Value.Character_ArmLD = Get("Arm L D")
        _G.Value.Character_LegRU = Get("Leg R U")
        _G.Value.Character_LegR  = Get("Leg R"  )
        _G.Value.Character_LegRD = Get("Leg R D")
        _G.Value.Character_LegLU = Get("Leg L U")
        _G.Value.Character_LegL  = Get("Leg L"  )
        _G.Value.Character_LegLD = Get("Leg L D")

        _G.Value.Character_ColD  = Get("Collider D")
        _G.Value.Character_Col   = Get("Collider"  )

        local GetMotor = function(Name : string) : Motor6D return _G.Instance.Get(_G.Value.Character_ColD, Name) end

        _G.Value.Character_Motor_Head  = GetMotor("Motor Head"    )
        _G.Value.Character_Motor_Neck  = GetMotor("Motor Neck"    )
        _G.Value.Character_Motor_BodyU = GetMotor("Motor Body U"  )
        _G.Value.Character_Motor_BodyD = GetMotor("Motor Body D"  )
        _G.Value.Character_Motor_ArmRU = GetMotor("Motor Arm R U" )
        _G.Value.Character_Motor_ArmR  = GetMotor("Motor Arm R"   )
        _G.Value.Character_Motor_ArmRD = GetMotor("Motor Arm R D" )
        _G.Value.Character_Motor_ArmLU = GetMotor("Motor Arm L U" )
        _G.Value.Character_Motor_ArmL  = GetMotor("Motor Arm L"   )
        _G.Value.Character_Motor_ArmLD = GetMotor("Motor Arm L D" )
        _G.Value.Character_Motor_LegRU = GetMotor("Motor Leg R U" )
        _G.Value.Character_Motor_LegR  = GetMotor("Motor Leg R"   )
        _G.Value.Character_Motor_LegRD = GetMotor("Motor Leg R D" )
        _G.Value.Character_Motor_LegLU = GetMotor("Motor Leg L U" )
        _G.Value.Character_Motor_LegL  = GetMotor("Motor Leg L"   )
        _G.Value.Character_Motor_LegLD = GetMotor("Motor Leg L D" )
        _G.Value.Character_Motor_Col   = GetMotor("Motor Collider")

        _G.Value.Character_Eyes = _G.Instance.Get(_G.Value.Character_Head, "Eyes")

        _G.Value.Character_MoveForce = _G.Instance.Get(_G.Value.Character_ColD, "Move Force")
    end,

    -- Анимирует руку персонажа игрока
    CharacterAnimation_Player_Arm = function(Motor_ArmU : Motor6D, Motor_Arm : Motor6D, Motor_ArmD : Motor6D, Right : boolean, DT : number)
        local AnimationSpeed = 0.01

        local Time = Right and _G.Value.Game_Time_Life or (_G.Value.Game_Time_Life + 10)

        local Time1 = Time * (Right and 1.1 or 1)
        local Time2 = Time * (Right and 1 or 1.1)

        Motor_ArmU.Transform = _G.Transform.SimulateChildMotor6D(Motor_ArmU, _G.Value.Character_Motor_BodyU)

        local MovingRotation = CFrame.Angles(0, 0, 0)
        if _G.Value.Character_ColD.AssemblyLinearVelocity.Magnitude > 2 then
            MovingRotation = CFrame.Angles(math.sin(Animation_Walk_Time * 0.005) * 0.5 * (Right and -1 or 1), 0, 0)
        end

        if Right then
            Animation_Arm_Right = Animation_Arm_Right:Lerp(MovingRotation, DT * 10)
        else
            Animation_Arm_Left = Animation_Arm_Left:Lerp(MovingRotation, DT * 10)
        end

        Motor_ArmU.Transform = _G.Transform.RotatePYR(Motor_ArmU.Transform, math.sin(Time1) * AnimationSpeed, math.cos(Time2) * AnimationSpeed, 0) * (Right and Animation_Arm_Right or Animation_Arm_Left)

        Motor_Arm .Transform = _G.Transform.SimulateChildMotor6D(Motor_Arm, Motor_ArmU)

        Motor_Arm.Transform = _G.Transform.RotatePYR(Motor_Arm.Transform, ((math.sin(Time2) + 0.5) * 2) * AnimationSpeed, math.cos(Time1) * AnimationSpeed, 0)

        Motor_ArmD.Transform = _G.Transform.SimulateChildMotor6D(Motor_ArmD, Motor_Arm )
    end,

    -- Анимирует ногу персонажа игрока
    CharacterAnimation_Player_Leg = function(Motor_LegU : Motor6D, Motor_Leg : Motor6D, Motor_LegD : Motor6D, Right : boolean, DT : number)
        Motor_LegU.Transform = _G.Transform.SimulateChildMotor6D(Motor_LegU, _G.Value.Character_Motor_BodyD)

        local MovingRotation = CFrame.Angles(0, 0, 0)
        if _G.Value.Character_ColD.AssemblyLinearVelocity.Magnitude > 2 then
            MovingRotation = CFrame.Angles(math.sin(Animation_Walk_Time * 0.005) * 1.25 * (Right and 1 or -1), 0, 0)
        end

        if Right then
            Animation_Leg_Right = Animation_Leg_Right:Lerp(MovingRotation, DT * 10)
        else
            Animation_Leg_Left = Animation_Leg_Left:Lerp(MovingRotation, DT * 10)
        end
        Motor_LegU.Transform *= Right and Animation_Leg_Right or Animation_Leg_Left

        Motor_Leg .Transform = _G.Transform.SimulateChildMotor6D(Motor_Leg , Motor_LegU )
        Motor_LegD.Transform = _G.Transform.SimulateChildMotor6D(Motor_LegD, Motor_Leg  )
    end,

    -- Анимирует персонажа игрока
    CharacterAnimation_Player = function(DT : number)
        _G.Value.Character_ColD.AssemblyAngularVelocity = Vector3.zero
        _G.Value.Character_ColD.CFrame = _G.Transform.SetRotationPYR(_G.Value.Character_ColD.CFrame, 0, 0, 0)

        local HeadRotation = _G.Transform.RotationPYR(0, _G.Value.Character_Rotation, 0)

        --#region Вращение тела

            local _, HeadYaw, _ = HeadRotation:ToEulerAnglesYXZ()
            local _, BodyYaw, _ = _G.Value.Character_Motor_BodyD.Transform:ToEulerAnglesYXZ()
            local YawDifference = HeadYaw - BodyYaw
            while YawDifference > math.pi  do YawDifference -= 2 * math.pi end
            while YawDifference < -math.pi do YawDifference += 2 * math.pi end

            local Limit = math.rad(45)
            local YawStep = 0
            if YawDifference > Limit then
                YawStep = YawDifference - Limit
            elseif YawDifference < -Limit then
                YawStep = YawDifference + Limit
            end

            _G.Value.Character_Motor_BodyD.Transform = _G.Transform.RotatePYR(_G.Value.Character_Motor_BodyD.Transform, 0, YawStep, 0)

            if _G.Value.Client_Moving or _G.Moving.GroundDoRotate then
                _G.Value.Character_Motor_BodyD.Transform = _G.Value.Character_Motor_BodyD.Transform:Lerp(_G.Transform.SetRotationPYR(_G.Value.Character_Motor_BodyD.Transform, 0, _G.Value.Character_Rotation, 0), DT * 10)
            end

            _G.Value.Character_Motor_BodyU.Transform = _G.Value.Character_Motor_BodyD.Transform
            _G.Value.Character_Motor_Neck .Transform = _G.Value.Character_Motor_BodyU.Transform

            if _G.Value.Client_Raycast_Ground ~= nil then
                Animation_Walk_Time += _G.Value.Character_ColD.AssemblyLinearVelocity.Magnitude
            end

            _G.Character.CharacterAnimation_Player_Arm(_G.Value.Character_Motor_ArmRU, _G.Value.Character_Motor_ArmR, _G.Value.Character_Motor_ArmRD, true , DT)
            _G.Character.CharacterAnimation_Player_Arm(_G.Value.Character_Motor_ArmLU, _G.Value.Character_Motor_ArmL, _G.Value.Character_Motor_ArmLD, false, DT)

            _G.Character.CharacterAnimation_Player_Leg(_G.Value.Character_Motor_LegRU, _G.Value.Character_Motor_LegR, _G.Value.Character_Motor_LegRD, true , DT)
            _G.Character.CharacterAnimation_Player_Leg(_G.Value.Character_Motor_LegLU, _G.Value.Character_Motor_LegL, _G.Value.Character_Motor_LegLD, false, DT)

        --#endregion

        _G.Value.Character_Motor_Head.Transform = HeadRotation * _G.Transform.RotationPYR(_G.Value.Character_Rotation_Head, 0, 0)

        --#region Сохранение анимации
            _G.Value.Client_Info.Motor_Head  = _G.Value.Character_Motor_Head.Transform
            _G.Value.Client_Info.Motor_Neck  = _G.Value.Character_Motor_Neck.Transform
            _G.Value.Client_Info.Motor_BodyU = _G.Value.Character_Motor_BodyU.Transform
            _G.Value.Client_Info.Motor_BodyD = _G.Value.Character_Motor_BodyD.Transform
            _G.Value.Client_Info.Motor_ArmRU = _G.Value.Character_Motor_ArmRU.Transform
            _G.Value.Client_Info.Motor_ArmR  = _G.Value.Character_Motor_ArmR.Transform
            _G.Value.Client_Info.Motor_ArmRD = _G.Value.Character_Motor_ArmRD.Transform
            _G.Value.Client_Info.Motor_ArmLU = _G.Value.Character_Motor_ArmLU.Transform
            _G.Value.Client_Info.Motor_ArmL  = _G.Value.Character_Motor_ArmL.Transform
            _G.Value.Client_Info.Motor_ArmLD = _G.Value.Character_Motor_ArmLD.Transform
            _G.Value.Client_Info.Motor_LegRU = _G.Value.Character_Motor_LegRU.Transform
            _G.Value.Client_Info.Motor_LegR  = _G.Value.Character_Motor_LegR.Transform
            _G.Value.Client_Info.Motor_LegRD = _G.Value.Character_Motor_LegRD.Transform
            _G.Value.Client_Info.Motor_LegLU = _G.Value.Character_Motor_LegLU.Transform
            _G.Value.Client_Info.Motor_LegL  = _G.Value.Character_Motor_LegL.Transform
            _G.Value.Client_Info.Motor_LegLD = _G.Value.Character_Motor_LegLD.Transform
        --#endregion
    end,

    -- Применяет анимацию игроку
    CharacterAnimation_Player_Apply = function(
        Character : Model,
        Motor_Head  : CFrame,
        Motor_Neck  : CFrame,
        Motor_BodyU : CFrame,
        Motor_BodyD : CFrame,
        Motor_ArmRU : CFrame,
        Motor_ArmR  : CFrame,
        Motor_ArmRD : CFrame,
        Motor_ArmLU : CFrame,
        Motor_ArmL  : CFrame,
        Motor_ArmLD : CFrame,
        Motor_LegRU : CFrame,
        Motor_LegR  : CFrame,
        Motor_LegRD : CFrame,
        Motor_LegLU : CFrame,
        Motor_LegL  : CFrame,
        Motor_LegLD : CFrame,
        DT : number?
    )
        if Character == nil then return end

        local ColD = Character:FindFirstChild("Collider D")

        local Head  = ColD:FindFirstChild("Motor Head"   )
        local Neck  = ColD:FindFirstChild("Motor Neck"   )
        local BodyU = ColD:FindFirstChild("Motor Body U" )
        local BodyD = ColD:FindFirstChild("Motor Body D" )
        local ArmRU = ColD:FindFirstChild("Motor Arm R U")
        local ArmR  = ColD:FindFirstChild("Motor Arm R"  )
        local ArmRD = ColD:FindFirstChild("Motor Arm R D")
        local ArmLU = ColD:FindFirstChild("Motor Arm L U")
        local ArmL  = ColD:FindFirstChild("Motor Arm L"  )
        local ArmLD = ColD:FindFirstChild("Motor Arm L D")
        local LegRU = ColD:FindFirstChild("Motor Leg R U")
        local LegR  = ColD:FindFirstChild("Motor Leg R"  )
        local LegRD = ColD:FindFirstChild("Motor Leg R D")
        local LegLU = ColD:FindFirstChild("Motor Leg L U")
        local LegL  = ColD:FindFirstChild("Motor Leg L"  )
        local LegLD = ColD:FindFirstChild("Motor Leg L D")

        if DT == nil then
            Head .Transform  = Motor_Head  or CFrame.identity
            Neck .Transform  = Motor_Neck  or CFrame.identity
            BodyU.Transform  = Motor_BodyU or CFrame.identity
            BodyD.Transform  = Motor_BodyD or CFrame.identity
            ArmRU.Transform  = Motor_ArmRU or CFrame.identity
            ArmR .Transform  = Motor_ArmR  or CFrame.identity
            ArmRD.Transform  = Motor_ArmRD or CFrame.identity
            ArmLU.Transform  = Motor_ArmLU or CFrame.identity
            ArmL .Transform  = Motor_ArmL  or CFrame.identity
            ArmLD.Transform  = Motor_ArmLD or CFrame.identity
            LegRU.Transform  = Motor_LegRU or CFrame.identity
            LegR .Transform  = Motor_LegR  or CFrame.identity
            LegRD.Transform  = Motor_LegRD or CFrame.identity
            LegLU.Transform  = Motor_LegLU or CFrame.identity
            LegL .Transform  = Motor_LegL  or CFrame.identity
            LegLD.Transform  = Motor_LegLD or CFrame.identity
        else
            DT *= 10
            Head.Transform   = Head .Transform:Lerp(Motor_Head  or CFrame.identity, DT)
            Neck.Transform   = Neck .Transform:Lerp(Motor_Neck  or CFrame.identity, DT)
            BodyU.Transform  = BodyU.Transform:Lerp(Motor_BodyU or CFrame.identity, DT)
            BodyD.Transform  = BodyD.Transform:Lerp(Motor_BodyD or CFrame.identity, DT)
            ArmRU.Transform  = ArmRU.Transform:Lerp(Motor_ArmRU or CFrame.identity, DT)
            ArmR.Transform   = ArmR .Transform:Lerp(Motor_ArmR  or CFrame.identity, DT)
            ArmRD.Transform  = ArmRD.Transform:Lerp(Motor_ArmRD or CFrame.identity, DT)
            ArmLU.Transform  = ArmLU.Transform:Lerp(Motor_ArmLU or CFrame.identity, DT)
            ArmL.Transform   = ArmL .Transform:Lerp(Motor_ArmL  or CFrame.identity, DT)
            ArmLD.Transform  = ArmLD.Transform:Lerp(Motor_ArmLD or CFrame.identity, DT)
            LegRU.Transform  = LegRU.Transform:Lerp(Motor_LegRU or CFrame.identity, DT)
            LegR.Transform   = LegR .Transform:Lerp(Motor_LegR  or CFrame.identity, DT)
            LegRD.Transform  = LegRD.Transform:Lerp(Motor_LegRD or CFrame.identity, DT)
            LegLU.Transform  = LegLU.Transform:Lerp(Motor_LegLU or CFrame.identity, DT)
            LegL.Transform   = LegL .Transform:Lerp(Motor_LegL  or CFrame.identity, DT)
            LegLD.Transform  = LegLD.Transform:Lerp(Motor_LegLD or CFrame.identity, DT)
        end
    end
}

return nil