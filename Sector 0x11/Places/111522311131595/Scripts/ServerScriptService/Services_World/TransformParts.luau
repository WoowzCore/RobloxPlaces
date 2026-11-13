-- By Woowz11

--!strict
--!optimize 2
--!native

local S_Rotate = {}
local S_Move   = {}

_G.World.TransformParts = {

    -- Пытается добавить объект в систему
    TryAdd = function(Object : BasePart)
        if Object:GetAttribute("Rotate") ~= nil then table.insert(S_Rotate, Object) Object.Anchored = true end
        if Object:GetAttribute("Move"  ) ~= nil then table.insert(S_Move  , Object) Object.Anchored = true Object:SetAttribute("Move_Start", Object.Position) end
    end,

    -- Пытается удалить объект из системы
    TryRemove = function(Object : BasePart)
        if Object:GetAttribute("Rotate") ~= nil then table.remove(S_Rotate, Object) end
        if Object:GetAttribute("Move"  ) ~= nil then table.remove(S_Move  , Object) end
    end,

    -- Очищает всю систему
    ClearAll = function()
        table.clear(S_Rotate)
        table.clear(S_Move  )
    end,

    -- Обновляет систему
    Step = function(DT : number)
        for _, Object : BasePart in ipairs(S_Rotate) do
            if Object:GetAttribute("Rotate") then
                _G.Physic.SimulateRotation(Object, DT, Object:GetAttribute("Rotate_Pitch") or 0, Object:GetAttribute("Rotate_Yaw") or 0, Object:GetAttribute("Rotate_Roll") or 0)
            end
        end

        for _, Object : BasePart in ipairs(S_Move) do
            if Object:GetAttribute("Move") then
                local Start = Object:GetAttribute("Move_Start")
                local End   = Object:GetAttribute("Move_End"  ) or (Start + Object:GetAttribute("Move_End_Add"))

                local Offset = Object:GetAttribute("Move_Offset") or 0

                local T = (math.sin(_G.Value.Game_Time_World * (Object:GetAttribute("Move_Speed") or 1) + Offset * math.pi) + 1) * 0.5

                Object.CFrame = _G.Transform.SetPosition(Object.CFrame, Start:Lerp(End, T))
                if _G.Value.Debug_Draw_ServicesWorld then
                    _G.Gizmos.Line(Start, End, Color3.new(0,1,1):Lerp(Color3.new(1,1,0), T), nil, nil, false)

                    _G.Gizmos.Part(Object, Start, Color3.new(0,1,1))
                    _G.Gizmos.Part(Object, End  , Color3.new(1,1,0))
                end
            end
        end
    end

}

return nil