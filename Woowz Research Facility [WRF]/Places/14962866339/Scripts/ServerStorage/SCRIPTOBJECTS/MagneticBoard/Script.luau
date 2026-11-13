local typedata = script.Parent.TypeData.Value

local texts = {
	["Zone13"] = {
		"нужны нам ли новые партнёры?","россек стал хуже делать камеры вид. набл.",
		"на 04.08.2028 акция ржд упала на 2%","ребята сегодня нужно отдать все отчёты",
		"босс что-то не договаривает","","","","павел коваленко оборзел! свергнем его",
		"дедлайн через неделю","в следущем месяце пересмотр документов насчёт патентов",
		"у новых работников образование никудышное","нужно создавать личный сайт",
		"защита комплекса хромает","стройматериалы подорожали",
		"сегодня 3 компьютера сгорело из-за непонятного вируса",
		"LUKA хочет подписать новое соглашение","владелец ИП Корякин был обнаружен с владельцем Костех",
		"чё ещё за программы","!!!!!!",
		"ненавижу эту работу","12+637=649",
		"не интеликтуально как-то",
		"C# для чайников","Сайт лёг - найти проблему","CSS для чайников - читать",
		"n!=1*2*3*4*5*6*...*n","math.clamp используйте чаще","МИР НЕ РЕАЛЕН!","Кто голосовал на выборах","Кырдык",
		"ALT+F4","4 ядра","https:// устарел","Учите html, css, javascript, надо делать сайт","Приглашаю на дискотеку. Д. Маркансчак (21.02.2029 20:00 ДК Клуб \"Ёжъ\")",
		"Дайте пароль от облачного хранилища","не хватает финансирования","компьютеры тормозят","экраны фейковой реальности разрешены","какой призедент лучше"
		
	}	
}

local colors = {{"red",Color3.fromRGB(135, 20, 20)},{"green",Color3.fromRGB(44, 135, 39)},{"yellow",Color3.fromRGB(173, 150, 33)},{"blue",Color3.fromRGB(53, 89, 173)},{"black",Color3.fromRGB(39, 39, 40)}}
local color = colors[math.random(1,#colors)]

local images = {
	["Zone13"] = {"16459420205","16459425528"}
}

if texts[typedata] == nil then
	local selecti = {}
	for i, i2 in pairs(texts) do
		table.insert(selecti,i)
	end	
	typedata = selecti[math.random(1,#selecti)]
	script.Parent.TypeData.Value = typedata
end

local function AddSymbols(text)
	local symbols = {"!","?","!","?","?!","..."}
	local result = ""
	if math.random(0,100)>=60 then
		result = symbols[math.random(1,#symbols)]
	end
	return text..result
end

script.Parent.Line1.Value = AddSymbols(texts[typedata][math.random(1,#texts[typedata])])
script.Parent.Line2.Value = AddSymbols(texts[typedata][math.random(1,#texts[typedata])])
script.Parent.Line3.Value = AddSymbols(texts[typedata][math.random(1,#texts[typedata])])

if math.random(0,100)>65 then
	script.Parent.Line1Color.Value = color[1]
end
if math.random(0,100)>65 then
	script.Parent.Line2Color.Value = color[1]
end
if math.random(0,100)>65 then
	script.Parent.Line3Color.Value = color[1]
end

script.Parent.Color.Value = color[1]
script.Parent.Tool_Pencil_Color.Part.Color = color[2]
script.Parent.Tool_Pencil_Color.Union.Color = color[2]
script.Parent.Image.Value = "rbxassetid://"..images[typedata][math.random(1,#images[typedata])]

script.Parent.GuiLeft.Value = (math.random(0,100)>50)

local sp = script.Parent
local positions = {sp.pos1,sp.pos2,sp.pos3,sp.pos4,sp.pos5,sp.pos6,sp.pos7,sp.pos8}

local rotcframe,rotcframe1 = script.Parent.Tool_Pencil_Color.PrimaryPart.CFrame,script.Parent.Tool_Pencil.PrimaryPart.CFrame
if math.random(0,100)>50 then
	script.Parent.Tool_Pencil_Color:SetPrimaryPartCFrame(rotcframe1)
end
if math.random(0,100)>50 then
	script.Parent.Tool_Pencil:SetPrimaryPartCFrame(rotcframe)
end

local function getpos()
	local pos = math.random(1,#positions)
	local result = positions[pos]
	table.remove(positions,pos)
	return result.Position
end

script.Parent.Tool_Sponge:MoveTo(getpos())
script.Parent.Tool_Pencil:MoveTo(getpos())
script.Parent.Tool_Pencil_Color:MoveTo(getpos())

if color[1] == "black" and math.random(0,100)>=25 then
	script.Parent.Tool_Pencil_Color:Destroy()
end

local spongecolors = {Color3.fromRGB(173, 173, 176),Color3.fromRGB(204, 167, 82),Color3.fromRGB(107, 172, 83),Color3.fromRGB(134, 115, 172),Color3.fromRGB(132, 131, 116),Color3.fromRGB(175, 63, 65)}
script.Parent.Tool_Sponge.Part.Color = spongecolors[math.random(1,#spongecolors)]