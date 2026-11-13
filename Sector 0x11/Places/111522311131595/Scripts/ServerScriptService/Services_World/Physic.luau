-- By Woowz11

--!strict
--!optimize 2
--!native

local S_Physic = {}

local Timer_UpdatePhyiscOwners = 30
local Timer_ApplyPhysic = 0

_G.World.Physic = {

    -- Пытается добавить объект в систему
    TryAdd = function(Object : BasePart)
        if not Object.Anchored then table.insert(S_Physic, Object) end
    end,

    -- Пытается удалить объект из системы
    TryRemove = function(Object : BasePart)
       
    end,

    -- Очищает всю систему
    ClearAll = function()
       
    end,

    -- Изменения в физике
    __PhysicUpdates = {},

    -- Обновляет систему
    Step = function(DT : number)
        Timer_UpdatePhyiscOwners += DT

        if Timer_UpdatePhyiscOwners > 30 then
            Timer_UpdatePhyiscOwners = 0
            
            _G.World.Physic.UpdatePhysicOwners()
        end

        Timer_ApplyPhysic += DT

        if Timer_ApplyPhysic > 1 then
            Timer_ApplyPhysic = 0

            for UserID, Actions in pairs(_G.World.Physic.__PhysicUpdates) do
                _G.World.Physic.ApplyPhysic(_G.Player.GetPlayerInServer(UserID), Actions)
            end

            table.clear(_G.World.Physic.__PhysicUpdates)
        end
    end,

    -- Отправляет изменения физики
    ApplyPhysic = function(Player : Player, Actions : {})
        if Player == nil then return end

        _G.Net.Send_StC(Player, _G.Enum.PacketID_StC.ApplyPhysic, Actions)
    end,

    -- Обновляет владельцев объектов физики
    UpdatePhysicOwners = function()
        if _G.Value.Debug_Log_Physic then _G.Logger.Debug("Переопределены владельцы физичных объектов!\nКол-во персонажей: " .. _G.Value.Game_Character_Count) end
        if _G.Value.Game_Character_Count > 0 then
            for _, PhysBox : BasePart in ipairs(S_Physic) do
                local Nearest
                local NearestDistance = math.huge
                for Player, Character : Model in pairs(_G.Value.Game_Characters) do
                    local Distance = (PhysBox.Position - Character.PrimaryPart.Position).Magnitude
                    if Distance < NearestDistance then
                        Nearest = Player
                        NearestDistance = Distance
                    end
                end

                _G.Net.SetPhysicOwner(PhysBox, Nearest)
            end
        end
    end

}

return nil