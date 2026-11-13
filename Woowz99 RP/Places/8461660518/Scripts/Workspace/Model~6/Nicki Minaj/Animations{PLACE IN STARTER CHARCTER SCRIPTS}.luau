-- Decompiled with the Synapse X Luau decompiler.

local l__mouse__1 = game.Players.LocalPlayer:GetMouse();
local v2 = game.Players:WaitForChild("" .. script.Parent.Name .. "");
local l__Character__3 = v2.Character;
local l__Humanoid__4 = l__Character__3:WaitForChild("Humanoid");
Toggle = false;
local v5 = Instance.new("Animation", l__Character__3);
v5.Name = "Actions";
v5.AnimationId = "http://www.roblox.com/Asset?ID=431926970";
local u1 = l__Humanoid__4:LoadAnimation(v5);
local l__LocalPlayer__2 = game.Players.LocalPlayer;
v2.Chatted:connect(function(p1)
	if p1:sub(1, 6) == "/e dab" then
		u1:Stop();
		v5.AnimationId = "rbxassetid://6362254266";
		l__Humanoid__4:LoadAnimation(v5):Play();
		return;
	end;
	if p1:sub(1, 6) == "/e hs1" then
		u1:Stop();
		v5.AnimationId = "rbxassetid://6362257492";
		l__Humanoid__4:LoadAnimation(v5):Play();
		return;
	end;
	if p1:sub(1, 14) == "/e hitdemfolks" then
		u1:Stop();
		v5.AnimationId = "rbxassetid://6362259030";
		l__Humanoid__4:LoadAnimation(v5):Play();
		return;
	end;
	if p1:sub(1, 10) == "/hidenames" then
		local v6 = game.Players:GetChildren();
		for v7 = 1, #v6 do
			v6[v7].Character:WaitForChild("Head"):FindFirstChild("Card").Frame.Namey.Text = "";
		end;
		return;
	end;
	if p1:sub(1, 7) == "/hideui" then
		l__LocalPlayer__2:WaitForChild("PlayerGui"):WaitForChild("Stats"):FindFirstChild("Frame").Visible = false;
		l__LocalPlayer__2:WaitForChild("PlayerGui"):WaitForChild("Stats"):FindFirstChild("Tutorial").Visible = false;
		l__LocalPlayer__2:WaitForChild("PlayerGui"):WaitForChild("Stats"):FindFirstChild("Vehicle").Visible = false;
		return;
	end;
	if p1:sub(1, 7) == "/showui" then
		l__LocalPlayer__2:WaitForChild("PlayerGui"):WaitForChild("Stats"):FindFirstChild("Frame").Visible = true;
		l__LocalPlayer__2:WaitForChild("PlayerGui"):WaitForChild("Stats"):FindFirstChild("Tutorial").Visible = true;
		l__LocalPlayer__2:WaitForChild("PlayerGui"):WaitForChild("Stats"):FindFirstChild("Vehicle").Visible = true;
		return;
	end;
	if p1:sub(1, 5) == "/drop" then
		u1:Stop();
		v5.AnimationId = "rbxassetid://6351708446";
		l__Humanoid__4:LoadAnimation(v5):Play();
		return;
	end;
	if p1:sub(1, 6) == "/e hs2" then
		u1:Stop();
		v5.AnimationId = "rbxassetid://6362263732";
		l__Humanoid__4:LoadAnimation(v5):Play();
		return;
	end;
	if p1:sub(1, 8) == "/e hands" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://6362265728";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e crossarms" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://6362266906";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 7) == "/e lean" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://6362272388";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 7) == "/e hips" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://6362273671";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 6) == "/e gs1" then
		u1:Stop();
		v5.AnimationId = "rbxassetid://6362275207";
		l__Humanoid__4:LoadAnimation(v5):Play();
		return;
	end;
	if p1:sub(1, 6) == "/e gs2" then
		u1:Stop();
		v5.AnimationId = "rbxassetid://6362276284";
		l__Humanoid__4:LoadAnimation(v5):Play();
		return;
	end;
	if p1:sub(1, 6) == "/e gs3" then
		u1:Stop();
		v5.AnimationId = "rbxassetid://6362277149";
		l__Humanoid__4:LoadAnimation(v5):Play();
		return;
	end;
	if p1:sub(1, 6) == "/e gs4" then
		u1:Stop();
		v5.AnimationId = "rbxassetid://6362278148";
		l__Humanoid__4:LoadAnimation(v5):Play();
		return;
	end;
	if p1:sub(1, 9) == "/e turnup" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://6362279211";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 9) == "/e busted" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://6362280150";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 6) == "/e sit" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://6362281052";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 8) == "/e squat" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://6362281900";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 8) == "/e kneel" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://6362287421";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 5) == "/e ko" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://6362288944";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 7) == "/e pray" then
		if Toggle ~= false then
			Toggle = false;
			anim1:Stop();
			return;
		end;
	else
		return;
	end;
	Toggle = true;
	u1:Stop();
	v5.AnimationId = "rbxassetid://6362289961";
	anim1 = l__Humanoid__4:LoadAnimation(v5);
	anim1:Play();
end);
