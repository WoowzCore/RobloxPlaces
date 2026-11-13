-- Thanks for Meanwhile & XaXa for this script.
-- Remember this was designed for Meanwhile weapons so any other weapons might not work.
-- You have no permission to repubish this in you model even if it edited.
-- If your found then you will be ban from my place.
-- original Manofthelol Script

Tool = script.Parent
local Mouse = true
local Spin = script.Parent.Spin.Value
local Heat = script.Parent.Heat.Value
local chamber = true
local Player = Tool.Parent
local Dist = 0.20 
local firing = false
local enabled = true
local reloading = false

rotvalueB1 = 90
rotvalueB2 = 30
rotvalueB3 = 330
rotvalueB4 = 270
rotvalueB5 = 210
rotvalueB6 = 150

local arms = nil
local torso = nil
local weld33 = nil -- right arm
local weld55 = nil -- left arm
local welds = {}

function ReloadSequence()
Tool.S1.Transparency = 1
wait()
Tool.S2.Transparency = 1
wait()
Tool.S3.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), 0.2, math.rad(-90))
Tool.S4.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), 0.1, math.rad(-90))
Tool.S5.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), 0, math.rad(-90))
Tool.S6.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.1, math.rad(-90))
Tool.S7.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.2, math.rad(-90))
Tool.S8.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.3, math.rad(-90))
Tool.S9.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.4, math.rad(-90))
Tool.S10.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.5, math.rad(-90))
Tool.S11.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.6, math.rad(-90))
Tool.S12.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.7, math.rad(-90))
local mag = Tool.Mag:clone()
mag.CFrame = Tool.Mag.CFrame
mag.CanCollide = false
mag.Parent = game.Workspace
Tool.Mag.Transparency = 1

local mag = Tool.Mag2:clone()
mag.CFrame = Tool.Mag.CFrame
mag.CanCollide = false
mag.Parent = game.Workspace
Tool.Mag2.Transparency = 1

local mag = Tool.Mag3:clone()
mag.CFrame = Tool.Mag.CFrame
mag.CanCollide = false
mag.Parent = game.Workspace
Tool.Mag3.Transparency = 1

Tool.Handle.M1:play()
wait(1)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.8, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.9, math.rad(-90))
wait(.2)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -1, math.rad(-90))
Tool.Mag.Transparency = 0
Tool.Mag2.Transparency = 0
Tool.Mag3.Transparency = 0
Tool.Mag.Mesh.Offset = Vector3.new(0, 0, 0.4)
Tool.Mag2.Mesh.Offset = Vector3.new(0, 0, 0.4)
Tool.Mag3.Mesh.Offset = Vector3.new(0, 0, 0.4)
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.9, math.rad(-90))
Tool.Mag.Mesh.Offset = Vector3.new(0, 0, 0.3)
Tool.Mag2.Mesh.Offset = Vector3.new(0, 0, 0.3)
Tool.Mag3.Mesh.Offset = Vector3.new(0, 0, 0.3)
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.8, math.rad(-90))
Tool.Mag.Mesh.Offset = Vector3.new(0, 0, 0.2)
Tool.Mag2.Mesh.Offset = Vector3.new(0, 0, 0.2)
Tool.Mag3.Mesh.Offset = Vector3.new(0, 0, 0.2)
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.7, math.rad(-90))
Tool.Mag.Mesh.Offset = Vector3.new(0, 0, 0.1)
Tool.Mag2.Mesh.Offset = Vector3.new(0, 0, 0.1)
Tool.Mag3.Mesh.Offset = Vector3.new(0, 0, 0.1)
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.6, math.rad(-90))
Tool.Mag.Mesh.Offset = Vector3.new(0, 0, 0)
Tool.Mag2.Mesh.Offset = Vector3.new(0, 0, 0)
Tool.Mag3.Mesh.Offset = Vector3.new(0, 0, 0)
Tool.Handle.M2:play()
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(309), -0.61, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(308), -0.62, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(307), -0.63, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(306), -0.64, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(305), -0.65, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(304), -0.66, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(303), -0.67, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(302), -0.68, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(301), -0.69, math.rad(-90))
Tool.S12.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(300), -0.7, math.rad(-90))
Tool.S11.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(301), -0.69, math.rad(-90))
Tool.S10.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(302), -0.68, math.rad(-90))
Tool.S9.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(303), -0.67, math.rad(-90))
Tool.S8.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(304), -0.66, math.rad(-90))
Tool.S7.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(305), -0.65, math.rad(-90))
Tool.S6.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(306), -0.64, math.rad(-90))
Tool.S5.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(307), -0.63, math.rad(-90))
Tool.S4.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(308), -0.62, math.rad(-90))
Tool.S3.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(309), -0.61, math.rad(-90))
Tool.S2.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.6, math.rad(-90))
Tool.S1.Transparency = 0
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.5, math.rad(-90))
wait(.03)
Tool.Mag.Mesh.Offset = Vector3.new(0, 0, 0)
Tool.Handle.M2:play()
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.4, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.3, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.2, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.1, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), 0, math.rad(-90))
wait(.5)
weld33.C1 = CFrame.new(-0.75, -1.2, 0.35) * CFrame.fromEulerAnglesXYZ(math.rad(-70), math.rad(-35), 0)
weld55.C1 = CFrame.new(-0.35, 2, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(295), 0, math.rad(-90))
end

function ReloadSequence2()
Tool.S1.Transparency = 1
wait()
Tool.S2.Transparency = 1
wait()
Tool.S3.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), 0.2, math.rad(-90))
Tool.S4.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), 0.1, math.rad(-90))
Tool.S5.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), 0, math.rad(-90))
Tool.S6.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.1, math.rad(-90))
Tool.S7.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.2, math.rad(-90))
Tool.S8.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.3, math.rad(-90))
Tool.S9.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.4, math.rad(-90))
Tool.S10.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.5, math.rad(-90))
Tool.S11.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.6, math.rad(-90))
Tool.S12.Transparency = 1
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.7, math.rad(-90))
local mag = Tool.Mag:clone()
mag.CFrame = Tool.Mag.CFrame
mag.CanCollide = false
mag.Parent = game.Workspace
Tool.Mag.Transparency = 1

local mag = Tool.Mag2:clone()
mag.CFrame = Tool.Mag.CFrame
mag.CanCollide = false
mag.Parent = game.Workspace
Tool.Mag2.Transparency = 1

local mag = Tool.Mag3:clone()
mag.CFrame = Tool.Mag.CFrame
mag.CanCollide = false
mag.Parent = game.Workspace
Tool.Mag3.Transparency = 1

Tool.Handle.M1:play()
wait(1)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.8, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.9, math.rad(-90))
wait(.2)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -1, math.rad(-90))
Tool.Mag.Transparency = 0
Tool.Mag2.Transparency = 0
Tool.Mag3.Transparency = 0
Tool.Mag.Mesh.Offset = Vector3.new(0, 0, 0.4)
Tool.Mag2.Mesh.Offset = Vector3.new(0, 0, 0.4)
Tool.Mag3.Mesh.Offset = Vector3.new(0, 0, 0.4)
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.9, math.rad(-90))
Tool.Mag.Mesh.Offset = Vector3.new(0, 0, 0.3)
Tool.Mag2.Mesh.Offset = Vector3.new(0, 0, 0.3)
Tool.Mag3.Mesh.Offset = Vector3.new(0, 0, 0.3)
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.8, math.rad(-90))
Tool.Mag.Mesh.Offset = Vector3.new(0, 0, 0.2)
Tool.Mag2.Mesh.Offset = Vector3.new(0, 0, 0.2)
Tool.Mag3.Mesh.Offset = Vector3.new(0, 0, 0.2)
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.7, math.rad(-90))
Tool.Mag.Mesh.Offset = Vector3.new(0, 0, 0.1)
Tool.Mag2.Mesh.Offset = Vector3.new(0, 0, 0.1)
Tool.Mag3.Mesh.Offset = Vector3.new(0, 0, 0.1)
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.6, math.rad(-90))
Tool.Mag.Mesh.Offset = Vector3.new(0, 0, 0)
Tool.Mag2.Mesh.Offset = Vector3.new(0, 0, 0)
Tool.Mag3.Mesh.Offset = Vector3.new(0, 0, 0)
Tool.Handle.M2:play()
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(309), -0.61, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(308), -0.62, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(307), -0.63, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(306), -0.64, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(305), -0.65, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(304), -0.66, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(303), -0.67, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(302), -0.68, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(301), -0.69, math.rad(-90))
Tool.S12.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(300), -0.7, math.rad(-90))
Tool.S11.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(301), -0.69, math.rad(-90))
Tool.S10.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(302), -0.68, math.rad(-90))
Tool.S9.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(303), -0.67, math.rad(-90))
Tool.S8.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(304), -0.66, math.rad(-90))
Tool.S7.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(305), -0.65, math.rad(-90))
Tool.S6.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(306), -0.64, math.rad(-90))
Tool.S5.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(307), -0.63, math.rad(-90))
Tool.S4.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(308), -0.62, math.rad(-90))
Tool.S3.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(309), -0.61, math.rad(-90))
Tool.S2.Transparency = 0
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.6, math.rad(-90))
Tool.S1.Transparency = 0
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.5, math.rad(-90))
wait(.03)
Tool.Mag.Mesh.Offset = Vector3.new(0, 0, 0)
Tool.Handle.M2:play()
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.3, math.rad(-90))
wait(.5)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.4, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.5, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(310), -0.6, math.rad(-90))
Tool.Handle.Close:play()
Tool.Handle.Engine:play()
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1.1, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(308), -0.5, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1.2, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(306), -0.4, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1.3, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(304), -0.3, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1.4, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(302), -0.2, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1.5, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(300), 0.1, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1.6, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(298), 0, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1.7, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(296), 0, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1.8, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(295), 0, math.rad(-90))
wait(.03)
weld55.C1 = CFrame.new(-0.35, 1.9, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(295), 0, math.rad(-90))
wait(.03)
weld33.C1 = CFrame.new(-0.75, -1.2, 0.35) * CFrame.fromEulerAnglesXYZ(math.rad(-70), math.rad(-35), 0)
weld55.C1 = CFrame.new(-0.35, 2, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(295), 0, math.rad(-90))
end

function Reload()
Tool.Left.Value = Tool.Ammo.Value
	if script.Parent.Ammo.Value < script.Parent.MaxAmmo.Value and reloading == false and script.Parent.StoredAmmo.Value >= 1 then
		reloading = true
		script.Parent.Ammo.Value = 0
		ReloadChoose()
      script.Parent.StoredAmmo.Value = script.Parent.StoredAmmo.Value + script.Parent.Left.Value
		if script.Parent.StoredAmmo.Value >= script.Parent.MaxAmmo.Value then
			script.Parent.StoredAmmo.Value = script.Parent.StoredAmmo.Value - script.Parent.MaxAmmo.Value
			script.Parent.Ammo.Value = script.Parent.MaxAmmo.Value
         script.Parent.Recoil.Value = 5
		elseif script.Parent.StoredAmmo.Value < script.Parent.MaxAmmo.Value and script.Parent.StoredAmmo.Value >= 1 then
         script.Parent.Ammo.Value = script.Parent.StoredAmmo.Value 
			script.Parent.StoredAmmo.Value = 0
			script.Parent.Recoil.Value = 5
		end
		reloading = false
	end
end

function ReloadChoose()
   if script.Parent.Left.Value == 0 then
      ReloadSequence2()
   elseif script.Parent.Left.Value >= 1 then
      ReloadSequence()
   end
end

function Equip(mouse)
wait(.1)

	print("Equipped")
	if game.Players.LocalPlayer ~= nil then
		Gui = Tool.OverheatBar:clone()
		Gui.Parent = game.Players.LocalPlayer.PlayerGui
			end

wait(0.01)
arms = {Tool.Parent:FindFirstChild("Left Arm"), Tool.Parent:FindFirstChild("Right Arm")}
torso = Tool.Parent:FindFirstChild("Torso")
if arms ~= nil and torso ~= nil then
local sh = {torso:FindFirstChild("Left Shoulder"), torso:FindFirstChild("Right Shoulder")}
if sh ~= nil then
local yes = true
if yes then
yes = false
sh[1].Part1 = nil
sh[2].Part1 = nil
falsearm1 = arms[1]:clone()
local mesh1 = Tool.Larm:clone()
mesh1.Parent = falsearm1
local armweld1 = Instance.new("Weld")
falsearm1.BrickColor = BrickColor.new("Light orange") -- this is the arm colour incase u want to change it
falsearm1.Parent = Tool
armweld1.Parent = falsearm1
armweld1.Part0 = falsearm1
armweld1.Part1 = arms[1]
falsearm2 = arms[2]:clone()
local mesh2 = Tool.Rarm:clone()
mesh2.Parent = falsearm2
local armweld2 = Instance.new("Weld")
falsearm2.BrickColor = BrickColor.new("Light orange") -- this is the 2nd arm colour incase u want to change it
falsearm2.Parent = Tool
armweld2.Parent = falsearm2
armweld2.Part0 = falsearm2
armweld2.Part1 = arms[2]
local weld1 = Instance.new("Weld") -- left arm
weld55 = weld1
weld1.Part0 = torso
weld1.Parent = torso
weld1.Part1 = arms[1]
weld1.C1 = CFrame.new(-0.35, 2, 0.6) * CFrame.fromEulerAnglesXYZ(math.rad(295), 0, math.rad(-90))
welds[1] = weld1
local weld2 = Instance.new("Weld") -- right arm
weld33 = weld2
weld2.Part0 = torso
weld2.Parent = torso
weld2.Part1 = arms[2]
weld2.C1 = CFrame.new(-0.75, -1.2, 0.35) * CFrame.fromEulerAnglesXYZ(math.rad(-70), math.rad(-35), 0)
welds[2] = weld2
end
else
print("sh")
end
else
print("arms")
end
end

function Unequip(mouse)
Gui:Remove()
if arms ~= nil and torso ~= nil then
local sh = {torso:FindFirstChild("Left Shoulder"), torso:FindFirstChild("Right Shoulder")}
if sh ~= nil then
local yes = true
if yes then
yes = false
sh[1].Part1 = arms[1]
sh[2].Part1 = arms[2]
welds[1].Parent = nil
welds[2].Parent = nil
falsearm1:remove()
falsearm2:remove()
end
else
print("sh")
end
else
print("arms")
end
end




colors = {199}

local pellet = Instance.new("Part")
pellet.Name = "Bullet"
pellet.Shape = 1
pellet.formFactor = 3
pellet.BrickColor = BrickColor.new(24)
pellet.Size = Vector3.new(.2,.2,.2)
pellet.Locked = true


Tool.Equipped:connect(function(mouse)

function Shelling()
local ammo = script.Parent.Ammo
if ammo.Value == 12 then
Tool.S12.Transparency = 1
end
if ammo.Value == 11 then
Tool.S11.Transparency = 1
Tool.S12.Transparency = 1
end
if ammo.Value == 10 then
Tool.S10.Transparency = 1
Tool.S11.Transparency = 1
Tool.S12.Transparency = 1
end
if ammo.Value == 9 then
Tool.S9.Transparency = 1
Tool.S10.Transparency = 1
Tool.S11.Transparency = 1
Tool.S12.Transparency = 1
end
if ammo.Value == 8 then
Tool.S8.Transparency = 1
Tool.S9.Transparency = 1
Tool.S10.Transparency = 1
Tool.S11.Transparency = 1
Tool.S12.Transparency = 1
end
if ammo.Value == 7 then
Tool.S7.Transparency = 1
Tool.S8.Transparency = 1
Tool.S9.Transparency = 1
Tool.S10.Transparency = 1
Tool.S11.Transparency = 1
Tool.S12.Transparency = 1
end
if ammo.Value == 6 then
Tool.S6.Transparency = 1
Tool.S7.Transparency = 1
Tool.S8.Transparency = 1
Tool.S9.Transparency = 1
Tool.S10.Transparency = 1
Tool.S11.Transparency = 1
Tool.S12.Transparency = 1
end
if ammo.Value == 5 then
Tool.S5.Transparency = 1
Tool.S6.Transparency = 1
Tool.S7.Transparency = 1
Tool.S8.Transparency = 1
Tool.S9.Transparency = 1
Tool.S10.Transparency = 1
Tool.S11.Transparency = 1
Tool.S12.Transparency = 1
end
if ammo.Value == 4 then
Tool.S4.Transparency = 1
Tool.S5.Transparency = 1
Tool.S6.Transparency = 1
Tool.S7.Transparency = 1
Tool.S8.Transparency = 1
Tool.S9.Transparency = 1
Tool.S10.Transparency = 1
Tool.S11.Transparency = 1
Tool.S12.Transparency = 1
end
if ammo.Value == 3 then
Tool.S3.Transparency = 1
Tool.S4.Transparency = 1
Tool.S5.Transparency = 1
Tool.S6.Transparency = 1
Tool.S7.Transparency = 1
Tool.S8.Transparency = 1
Tool.S9.Transparency = 1
Tool.S10.Transparency = 1
Tool.S11.Transparency = 1
Tool.S12.Transparency = 1
end
if ammo.Value == 2 then
Tool.S2.Transparency = 1
Tool.S3.Transparency = 1
Tool.S4.Transparency = 1
Tool.S5.Transparency = 1
Tool.S6.Transparency = 1
Tool.S7.Transparency = 1
Tool.S8.Transparency = 1
Tool.S9.Transparency = 1
Tool.S10.Transparency = 1
Tool.S11.Transparency = 1
Tool.S12.Transparency = 1
end
if ammo.Value == 1 then
Tool.S1.Transparency = 1
Tool.S2.Transparency = 1
Tool.S3.Transparency = 1
Tool.S4.Transparency = 1
Tool.S5.Transparency = 1
Tool.S6.Transparency = 1
Tool.S7.Transparency = 1
Tool.S8.Transparency = 1
Tool.S9.Transparency = 1
Tool.S10.Transparency = 1
Tool.S11.Transparency = 1
Tool.S12.Transparency = 1
end
end

function fire(v)
if enabled == true then
Spin = Spin + 1
if Spin < 40 then
Heat = Heat + 0.2
return 
else
end
if Spin >= 45 then
Spin = 45
end
Heat = Heat + 2
firing = true
local ammo = script.Parent.Ammo
if ammo.Value >= 1 then
	ammo.Value = ammo.Value - 1

	script.Fire:Play()

	local vCharacter = Tool.Parent
	local vPlayer = game.Players:playerFromCharacter(vCharacter)

	local missile = Instance.new("Part")

        

	local spawnPos = vCharacter.PrimaryPart.Position
	


	spawnPos  = spawnPos + (v * 8)

	missile.Position = spawnPos
	missile.Size = Vector3.new(1,1,1)
	missile.Velocity = v * 500 
	missile.BrickColor = BrickColor.new(24)
	missile.Shape = 0
	missile.BottomSurface = 0
	missile.TopSurface = 0
	missile.Name = "Bullet"
	missile.Elasticity = 0
	missile.Reflectance = .3
	missile.Friction = .9
   missile.CanCollide = false

	local force = Instance.new("BodyForce")
	force.force = Vector3.new(math.random(-5, 5),math.random(95, 105),math.random(-5, 5))
	force.Parent = missile

	local mesh = Instance.new("SpecialMesh")
	mesh.Scale = Vector3.new(.1,.1,.1)
	mesh.MeshType = "Sphere"
	mesh.Parent = missile

	local new_script = script.Parent.Bullet:clone()
	new_script.Disabled = false
	new_script.Parent = missile

	local creator_tag = Instance.new("ObjectValue")
	creator_tag.Value = vPlayer
	creator_tag.Name = "creator"
	creator_tag.Parent = missile

	missile.Parent = game.Workspace

	cam = game.Workspace.CurrentCamera
	local cam_rot = cam.CoordinateFrame - cam.CoordinateFrame.p
	local cam_scroll = (cam.CoordinateFrame.p - cam.Focus.p).magnitude
	local ncf = CFrame.new(cam.Focus.p)*cam_rot*CFrame.fromEulerAnglesXYZ(0.01, 0, 0)
	cam.CoordinateFrame = ncf*CFrame.new(0, 0, cam_scroll)
	Tool.Flash.Transparency = .5
	Tool.Flash.Smoke.Enabled = true
	wait()
	Tool.Flash.Transparency = 1
	Tool.Flash.Smoke.Enabled = false
	Shelling()
	elseif ammo.Value == 0 then
	Reload()
end
elseif enabled == false then
end



end
end)

function KeyDownFunctions(key)
	if key == "r" then
		Reload()
	end
end

function computeDirection(pos)
	local invrtDir = 1 / math.sqrt((pos.magnitude * pos.magnitude))
	local dir = Vector3.new(pos.x * invrtDir, pos.y * invrtDir, pos.z * invrtDir)
	return dir
end


function check(en)
if not Tool.Enabled then
return false
end
if Tool.Enabled then
return true
end
if not enabled then
return false
end
if enabled then
return true
end
end


function onActivated()

	if (not Tool.Enabled) or (not enabled) then
		return
	end

	--Tool.Enabled = false

	local character = Tool.Parent;
	local humanoid = character.Humanoid
	if humanoid == nil or humanoid.Health <= 0 then
		Tool:Remove()
		return 
	end



	local targetPos = humanoid.TargetPoint
	local lookAt = (targetPos - character.Head.Position).unit

if (check()) then

end
	fire(lookAt)
wait()
	onActivated()

	return
	--Tool.Enabled = true
end


function onButton1Up(mouse)
firing = false
enabled = false
Tool.Enabled = false
wait(.2)
firing = false
enabled = true
Tool.Enabled = true

end

function onEquippedLocal(mouse)

	if mouse == nil then
		print("Mouse not found")
		return 
	end

	mouse.Button1Down:connect(function() onButton1Down(mouse) end)	
	mouse.Button1Up:connect(function() onButton1Up(mouse)end)
	mouse.KeyDown:connect(KeyDownFunctions)
end

function onEquippedLocal2(mouse)
wait(.2)
while Mouse == true do

Spin = Spin - .5
if not firing then
Heat = Heat - .75
end

	mouse.Icon = "http://www.roblox.com/asset/?id=45003129"

--Spin Limit
if Spin <= 0 then
Spin = 0
end
if Spin > 10 then
cam = game.Workspace.CurrentCamera
local cam_rot = cam.CoordinateFrame - cam.CoordinateFrame.p
local cam_scroll = (cam.CoordinateFrame.p - cam.Focus.p).magnitude
local ncf = CFrame.new(cam.Focus.p)*cam_rot*CFrame.fromEulerAnglesXYZ(0.001, 0, 0)
cam.CoordinateFrame = ncf*CFrame.new(0, 0, cam_scroll)
script.Ding.Pitch = .6 + (.3 * (Spin/40))
script.Ding:Play()
end
if Spin > 45 then 
Spin = 45
end

--Heat Limit
if Heat <= 0 then
enabled = true
Heat = 0
end

if Heat >= 150 then
enabled = false
Heat = 150
end

rotvalueB1 = rotvalueB1 + Spin
rotvalueB2 = rotvalueB2 + Spin
rotvalueB3 = rotvalueB3 + Spin
rotvalueB4 = rotvalueB4 + Spin
rotvalueB5 = rotvalueB5 + Spin
rotvalueB6 = rotvalueB6 + Spin

Tool.B1.Mesh.Offset = Vector3.new(math.sin(math.rad(rotvalueB1)) * Dist, 0, math.cos(math.rad(rotvalueB1)) * Dist)
Tool.B2.Mesh.Offset = Vector3.new(math.sin(math.rad(rotvalueB2)) * Dist, 0, math.cos(math.rad(rotvalueB2)) * Dist)
Tool.B3.Mesh.Offset = Vector3.new(math.sin(math.rad(rotvalueB3)) * Dist, 0, math.cos(math.rad(rotvalueB3)) * Dist)
Tool.B4.Mesh.Offset = Vector3.new(math.sin(math.rad(rotvalueB4)) * Dist, 0, math.cos(math.rad(rotvalueB4)) * Dist)
Tool.B5.Mesh.Offset = Vector3.new(math.sin(math.rad(rotvalueB5)) * Dist, 0, math.cos(math.rad(rotvalueB5)) * Dist)
Tool.B6.Mesh.Offset = Vector3.new(math.sin(math.rad(rotvalueB6)) * Dist, 0, math.cos(math.rad(rotvalueB6)) * Dist)

game.Players.LocalPlayer.PlayerGui.OverheatBar.HeatRed.Size = UDim2.new(0, Heat, 0, 10)
wait()

end
end



Tool.Equipped:connect(onEquippedLocal)
Tool.Equipped:connect(onEquippedLocal2)
Tool.Equipped:connect(Equip)
Tool.Unequipped:connect(Unequip)
script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(equip1)
script.Parent.Unequipped:connect(unequip1)