local rs = game:GetService("ReplicatedStorage")
local pb = require(script.Parent:WaitForChild("PlayerBase"))

local seat = nil

while wait() do
	if pb.Seat then
		if pb.MovingData.Crawl or pb.Ragdoll or pb.SeatWeld == CFrame.new(Vector3.zero) then
			rs.PlayerSeat:FireServer(false,pb.SeatWeld)
		end
		
		local x,y,z = pb.Seat.CFrame:ToOrientation()
		if x>0.4 or x<-0.4 or z>0.4 or z<-0.4 then
			pb.Input.Ragdoll = true
		end
	end
	if seat ~= pb.Seat then
		seat = pb.Seat
		if pb.Seat == nil then
			rs.PlayerSeat:FireServer(false,pb.SeatWeld)
		else
			rs.PlayerSeat:FireServer(true,pb.SeatWeld)
		end
	end
end