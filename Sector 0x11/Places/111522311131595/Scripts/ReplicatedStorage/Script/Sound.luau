-- By Woowz11

--!strict
--!optimize 2
--!native

-- Создано звуков
local Created = 0

local SoundPool   = {}
local SoundActive = {}

local SoundLogic = {}

local GetSound = function() : Sound
    local Sound : Sound = table.remove(SoundPool)

    if Sound then return Sound end

    local SoundAttachment : Attachment = _G.Instance.Create("Attachment", _G.Value.Info_ServerSide and _G.Game.Folders.Sound or _G.Game.Folders.SoundC, "Sound " .. Created)
    Created += 1

    Sound = _G.Instance.Create("Sound", SoundAttachment)

    return Sound
end

_G.Sound = {

    -- Обновляет звуки
    Update = function()
        for _, SoundInfo in ipairs(SoundLogic) do
            local Sound  = SoundInfo[1]
            local Target = SoundInfo[2]

            Sound.Parent.CFrame = CFrame.new(Target.CFrame.Position)
        end
    end,

    -- Проиграть звук на указанной позиции
    PlayAt = function(Sound : string, Position : Vector3 | Instance, Volume : number?, RollOfMode : Enum.RollOffMode?, MaxDistance : Vector2?) : Sound
        if Position == nil then return end

        Volume = Volume or 1
        RollOfMode = RollOfMode or Enum.RollOffMode.InverseTapered
        MaxDistance = Vector2.new(10, 10000)

        local Sound__ : Sound = GetSound()
        Sound__.Parent.Parent = _G.Value.Info_ServerSide and _G.Game.Folders.SoundU or _G.Game.Folders.SoundCU
        table.insert(SoundActive, Sound__)

        if typeof(Position) == "Vector3" then
            Sound__.Parent.CFrame = CFrame.new(Position)
        else
            table.insert(SoundLogic, { Sound__, Position })
        end

        Sound__.SoundId = Sound
        Sound__.Volume = Volume
        Sound__.RollOffMode = RollOfMode
        Sound__.RollOffMinDistance = MaxDistance.X
        Sound__.RollOffMaxDistance = MaxDistance.Y
        
        Sound__.Ended:Connect(function()
            local Index = table.find(SoundActive, Sound__)
            if Index then
                table.remove(SoundActive, Index)
                table.insert(SoundPool  , Sound__)

                Sound__.Parent.Parent = _G.Value.Info_ServerSide and _G.Game.Folders.Sound or _G.Game.Folders.SoundC
            end

            Index = table.find(SoundLogic, function(v) return v[1] == Sound__ end)
            if Index then
                table.remove(SoundLogic, Index)
            end
        end)
        
        Sound__:Play()

        return Sound
    end,

    -- Проигрывает звук по всей карте
    PlayAmbient = function(Sound : string) : Sound
        return _G.Sound.PlayAt(Sound, Vector3.zero, 1, Enum.RollOffMode.Linear, Vector2.new(100000, 100000))
    end,

    -- Проиграть звук на клиенте
    PlayClient = function(Sound : string) : Sound
        if _G.Value.Info_ServerSide then return end

        return _G.Sound.PlayAt(Sound, _G.Value.Client_Camera)
    end

}

return nil