local Player = script.Parent.Parent

function LoadValues()
	local Character = Player.Character
	if not Character or not Character.Parent then
		Character = Player.CharacterAdded:Wait()
	end
	Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)--Выключение возможности лазанья по вертикальным поверхностям
end