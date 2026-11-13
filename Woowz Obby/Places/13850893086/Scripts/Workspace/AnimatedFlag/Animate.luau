--ActualFreedom

--[[ReadMe*
	Please improve upon this script as needed, I'm a noob scripter and I only script 
	through ways I know that work. This loop works, so I'm happy with it. But please, 
	edit as you may.
	
	This model uses MeshParts to animate the flag. The previous frame turns transparent
	while the next frame becomes visible.
	
	If you would like to use your own custom flag, for your ROBLOX group or country, 
	select all the children in the "Flag" model and paste in a ROBLOX decal asset in 
	the "TextureID" slot. If you receive an error, try subtracting 1 from the decal id.
		
		http://www.roblox.com/asset/?id={decal id}
		rbxassetid://{decal id}
	
	Any ROBLOX decal in the Developers Library will work, or you may upload your own 
	flag decal to insert in. Rectangular decals are recommended for this flag. 
		*If you use a decal with a transparent background in the MeshPart's TextureID, 
		the transparent background will default to black. Instead, insert the actual
		decal into every MeshPart in "Flag." This will allow you to change the BrickColor
		of the flag with the decal on top.
	
	The flags have been UV mapped to flip the flag design on the other side. 
		e.g. You won't see the blue box of the United States flag on the other side
			 of the flag on its end, but close to the pole for both sides.
				
	Thank you and have a wonderful day.
	(MeshParts rendered using Blender)
--]]

sp=script.Parent
flag=sp.Flag

reset=function()
	for _,meshpart in pairs (flag:GetChildren()) do
		if meshpart:IsA("MeshPart") then
			meshpart.Transparency=1
		end
	end
end

waittime=.04 --Time between each "Frame"

while true do
	wait(waittime)
	reset()
	flag["2"].Transparency=0
	wait(waittime)
	reset()
	flag["3"].Transparency=0
	wait(waittime)
	reset()
	flag["4"].Transparency=0	
	wait(waittime)
	reset()
	flag["5"].Transparency=0
	wait(waittime)
	reset()
	flag["6"].Transparency=0
	wait(waittime)
	reset()
	flag["7"].Transparency=0
	wait(waittime)
	reset()
	flag["8"].Transparency=0
	wait(waittime)
	reset()
	flag["9"].Transparency=0
	wait(waittime)
	reset()
	flag["10"].Transparency=0
	wait(waittime)
	reset()
	flag["11"].Transparency=0
	wait(waittime)
	reset()
	flag["12"].Transparency=0
	wait(waittime)
	reset()
	flag["13"].Transparency=0
	wait(waittime)
	reset()
	flag["14"].Transparency=0
	wait(waittime)
	reset()
	flag["15"].Transparency=0
	wait(waittime)
	reset()
	flag["16"].Transparency=0
	wait(waittime)
	reset()
	flag["1"].Transparency=0
end