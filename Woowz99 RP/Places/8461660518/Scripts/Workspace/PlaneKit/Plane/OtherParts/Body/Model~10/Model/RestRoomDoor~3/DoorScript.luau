local CloseClick = script.Parent.Closed.ClickDetector
local OpenClick = script.Parent.Open.ClickDetector
local DoorClose = script.Parent.Closed
local DoorOpen = script.Parent.Open

function MakeOpen()
	DoorClose.P1.Transparency = 1
	DoorClose.P1.CanCollide = false
	DoorClose.P2.Transparency = 1
	DoorClose.P2.CanCollide = false
	DoorClose.P3.Transparency = 1
	DoorClose.P3.CanCollide = false
	-----------------------------
	DoorOpen.P1.Transparency = 0
	DoorOpen.P1.CanCollide = true
	DoorOpen.P2.Transparency = 0
	DoorOpen.P2.CanCollide = true
	DoorOpen.P3.Transparency = 0
	DoorOpen.P3.CanCollide = true
end

function MakeClose()
	DoorClose.P1.Transparency = 0
	DoorClose.P1.CanCollide = true
	DoorClose.P2.Transparency = 0
	DoorClose.P2.CanCollide = true
	DoorClose.P3.Transparency = 0
	DoorClose.P3.CanCollide = true
	-----------------------------
	DoorOpen.P1.Transparency = 1
	DoorOpen.P1.CanCollide = false
	DoorOpen.P2.Transparency = 1
	DoorOpen.P2.CanCollide = false
	DoorOpen.P3.Transparency = 1
	DoorOpen.P3.CanCollide = false
end

OpenClick.MouseClick:Connect(MakeClose)
CloseClick.MouseClick:Connect(MakeOpen)