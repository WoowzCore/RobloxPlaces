-- By Woowz11

--!strict
--!optimize 2
--!native

_G.Player = {

    -- Получает игрока на сервере, возвращает nil если не найден
    GetPlayerInServer = function(UserID : number) : Player
        return _G.Value.Game_Players[UserID]
    end,

    -- Получает тело
    GetCharacter = function(Player : Player) : (Model, BasePart)
        local Character = _G.Value.Game_Characters[Player]
        return Character, Character:FindFirstChild("Collider D")
    end,

    -- Телепортирует игрока
    Teleport = function(Player : Player, Position : Vector3)
        local Character, ColD = _G.Player.GetCharacter(Player)

        ColD.CFrame = CFrame.new(Position) ColD.AssemblyLinearVelocity = Vector3.zero
    end
    
}

return nil