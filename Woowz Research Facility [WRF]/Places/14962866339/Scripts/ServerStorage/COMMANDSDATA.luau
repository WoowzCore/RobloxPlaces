local commands = {}
local ss = game:GetService("ServerStorage")
local datas = require(script.Parent.Datas)
local l = require(ss.LIQUIDS)

local materials = "plastic,smoothplastic,metal,diamondplate,corrodedmetal,concrete,roofshingles,clayrooftiles,brick,ceramictiles,carpet,fabric,cardboard,wood,woodplanks,glass,sand,sandstone,rock,slate,plaster,limestone,granite,marble,cobblestone,asphalt,basalt,crackedlava,pebble,pavement,ground,leafygrass,grass,mud,snow,ice,glacier,foil,rubber,leather,forcefield,neon"

commands.Data = {
	["op"] = {["Title"]="admin.op",["Values"]={{"deop","checkbox","admin.op.deop",false}},["Settings"] = {["mainadmin"] = true}},
	
	["kill"] = {["Title"]="admin.kill",["Values"]={},["Settings"] = {}},
	
	["giveitem"] = {["Title"]="admin.give",["Values"]={{"item","list","admin.give.item",""},{"drop","checkbox","admin.give.physic",false}}},
	
	["prefab"] = {["Title"]="admin.prefab",["Values"]={{"prefab","list","admin.prefab.what",""},{"position","vector3","admin.position",Vector3.zero},{"rotation","vector3","admin.rotation",Vector3.zero},{"worldposition","checkbox","admin.globalposition",false}},["Settings"] = {}},

	["explode"] = {["Title"]="admin.explode",["Values"]={{"power","input","admin.explode.power","10"},{"position","vector3","admin.position",Vector3.zero},{"worldposition","checkbox","admin.globalposition",false}},["Settings"] = {}},
	
	["createparticle"] = {["Title"]="admin.particle",["Values"]={{"particle","list","admin.particle.what",""},{"position","vector3","admin.position",Vector3.zero},{"worldposition","checkbox","admin.globalposition",false},{"time","input","admin.particle.time","1"},{"size","input","admin.particle.size","1"}},["Settings"] = {}},
	
	["createobject"] = {["Title"]="admin.object",["Values"]={{"shape","list","admin.object.what","block,sphere,cylinder,wedge,wedgecorner"},{"position","vector3","admin.position",Vector3.zero},{"rotation","vector3","admin.rotation",Vector3.zero},{"worldposition","checkbox","admin.globalposition",false},{"size","vector3","admin.size",Vector3.one},{"anchored","checkbox","admin.object.anchored",false},{"collision","checkbox","admin.object.collision",true},{"color","color","admin.color",Color3.new(1,1,1)},{"transparency","input","admin.object.transparency",0},{"castshadow","checkbox","admin.object.shadow",true},{"material","list","admin.material",materials},{"drag","checkbox","admin.object.drag",false},{"texture","input","admin.object.texture",""}},["Settings"] = {}},

	["kick"] = {["Title"] = "admin.kick",["Values"]={{"reason","input","admin.kick.reason",""},{"show","checkbox","admin.kick.adminname",true}},["Settings"] = {["mainadmin"]=true}},
	
	["teleport"] = {["Title"] = "admin.tp",["Values"]={{"player","listplayer","admin.tp.player"},{"useposition","checkbox","admin.tp.useposition",false},{"position","vector3","admin.position",Vector3.new(0,2,0)}},["Settings"] = {}},
	
	["shakelab"] = {["Title"] = "admin.shakelab",["Values"]={{"power","input","admin.shakelab.power","10"}},["Settings"] = {["hasplayer"] = false}},
	
	["shakecamera"] = {["Title"] = "admin.shake",["Values"]={{"power","input","admin.shake.power","10"},{"time","input","admin.shake.time","5"},{"faststart","checkbox","admin.shake.faststart",false}},["Settings"] = {["hasplayer"] = false}},
	
	["playsound"] = {["Title"] = "admin.sound",["Values"]={{"id","input","admin.sound.id","271111328"},{"volume","input","admin.sound.volume","50"},{"speed","input","admin.sound.speed","100"},{"distance","input","admin.sound.distance","30"},{"loop","checkbox","admin.sound.loop",false}},["Settings"] = {}},
	
	["stopsounds"] = {["Title"]="admin.stopsounds",["Values"]={},["Settings"] = {["hasplayer"] = false}},
	
	["stopshake"] = {["Title"]="admin.stopshakes",["Values"]={},["Settings"] = {["hasplayer"] = false}},
	
	["destroyprefabs"] = {["Title"]="admin.destroyobjects",["Values"]={},["Settings"] = {["hasplayer"] = false}},
	
	["dummy"] = {["Title"]="admin.dummy",["Values"]={{"skin","input","admin.dummy.user",""},{"dead","checkbox","admin.dummy.dead",false}},["Settings"] = {}},
	
	["hurt"] = {["Title"]="admin.hurt",["Values"]={{"power","input","admin.hurt.power","10"},{"type","list","admin.hurt.type","none,impact,sharp,inside,outside,burn,shock,acid,frezze,shoot,nooxygen"},{"part","list","admin.hurt.part","Head,Torso,Left Arm,Right Arm,Left Leg,Right Leg,All"},{"dummys","checkbox","admin.hurt.alldummy",false}},["Settings"] = {}},

	["restart"] = {["Title"]="admin.restart",["Values"]={{"holiday","list","admin.restart.holiday","skip,none,Christmas,Halloween,Easter,Cosmonautics,WRFDay"},{"accept","checkbox","admin.restart.accept",false}},["Settings"] = {["mainadmin"]=true,["hasplayer"] = false}},
	
	["randsceneskin"] = {["Title"]="admin.labcolor",["Values"]={{"random","checkbox","admin.labcolor.random",false}},["Settings"] = {["mainadmin"]=true,["hasplayer"] = false}},
	
	["destroycorpses"] = {["Title"]="admin.destroycorpses",["Values"]={},["Settings"] = {["hasplayer"] = false}},
	
	["destroydecals"] = {["Title"]="admin.destroydecals",["Values"]={},["Settings"] = {["hasplayer"] = false}},
	
	["freecamera"] = {["Title"]="admin.freecamera",["Values"]={},["Settings"] = {["hasplayer"] = false}},

	["siren"] = {["Title"]="admin.siren",["Values"]={{"id","list","admin.siren.type",""}},["Settings"] = {["hasplayer"] = false}},
	
	["turnlight"] = {["Title"]="admin.turnlight",["Values"]={{"turn","checkbox","admin.turnlight.enable",false}},["Settings"]={["hasplayer"]=false}},
	
	["emergency"] = {["Title"]="admin.emergency",["Values"]={{"turn","checkbox","admin.emergency.enable",true}},["Settings"]={["hasplayer"]=false}},
	
	--["sethealth"] = {["Title"]="admin.sethealth",["Values"]={{"health","input","admin.sethealth.health","100"}},["Settings"]={}},
	
	["getposition"] = {["Title"]="admin.getposition",["Values"]={},["Settings"]={["noeveryone"]=true}},
	
	["setliquid"] = {["Title"]="admin.setliquid",["Values"]={{"liquid","list","admin.setliquid.liquid",""}},["Setitngs"]={["noeveryone"]=true}},
	
	["setplayerdata"] = {["Title"]="admin.setplayerdata",["Values"]={{"name","list","admin.setplayerdata.name","Здоровье,Стамина,Отравление,Опьянение,Паралич"},{"value","input","admin.setplayerdata.value","0"}},["Setitngs"]={}}
}

function commands.PregenerateCommands()
	for id, command in pairs(commands.Data) do
		local set = command["Settings"]
		if set == nil then
			command["Settings"] = {}
			set = command["Settings"]
		end
		
		if set["mainadmin"] == nil then
			set["mainadmin"] = false
		end
		if set["mainadmin_everyone"] == nil then
			set["mainadmin_everyone"] = false
		end
		if set["hasplayer"] == nil then
			set["hasplayer"] = true
		end
		if set["canusemainadmin"] == nil then
			set["canusemainadmin"] = true
		end
		if set["noeveryone"] == nil then
			set["noeveryone"] = false
		end
		
		commands.Data[id]["Settings"] = set
	end
	
	for id, _ in pairs(datas.Sirens) do
		if id ~= "empty" then
			commands.Data["siren"]["Values"][1][4] = commands.Data["siren"]["Values"][1][4]..","..id
		end
	end
	commands.Data["siren"]["Values"][1][4] = "empty"..commands.Data["siren"]["Values"][1][4]
	for _, item in pairs(ss.ITEMS:GetChildren()) do
		local zapataya = ","
		if commands.Data["giveitem"]["Values"][1][4] == "" then
			zapataya = ""
		end
		commands.Data["giveitem"]["Values"][1][4] = commands.Data["giveitem"]["Values"][1][4]..zapataya..item.Name
	end
	
	for _, item in pairs(ss.PARTICLES:GetChildren()) do
		local zapataya = ","
		if commands.Data["createparticle"]["Values"][1][4] == "" then
			zapataya = ""
		end
		commands.Data["createparticle"]["Values"][1][4] = commands.Data["createparticle"]["Values"][1][4]..zapataya..item.Name
	end
	
	for _, item in pairs(ss.SCRIPTOBJECTS:GetChildren()) do
		local zapataya = ","
		if commands.Data["prefab"]["Values"][1][4] == "" then
			zapataya = ""
		end
		commands.Data["prefab"]["Values"][1][4] = commands.Data["prefab"]["Values"][1][4]..zapataya..item.Name
	end
	for _, item in pairs(ss.PACKAGES:GetChildren()) do
		local zapataya = ","
		if commands.Data["prefab"]["Values"][1][4] == "" then
			zapataya = ""
		end
		commands.Data["prefab"]["Values"][1][4] = commands.Data["prefab"]["Values"][1][4]..zapataya..item.Name
	end
	for liquid in pairs(l.list) do
		local zapataya = ","
		if commands.Data["setliquid"]["Values"][1][4] == "" then
			zapataya = ""
		end
		commands.Data["setliquid"]["Values"][1][4] = commands.Data["setliquid"]["Values"][1][4]..zapataya..liquid
	end
end

return commands
