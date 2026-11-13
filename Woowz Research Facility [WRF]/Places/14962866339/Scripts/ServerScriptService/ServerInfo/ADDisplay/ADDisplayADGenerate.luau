local base = require(script.Parent.Parent.Parent.Base)
local function GenerateBirsha()
	local result = ""

	if math.random(0,100)>=50 then
		local function GeneretaTorg()
			local r = ""
			local moneys = {"крона","франк","бат","лира","иена","динар","песо","фунт","рупия","гривна"}
			local moneysto = {"₽","$","€"}
			local minplus = "+"
			if math.random(0,100)>=50 then
				minplus = "-"
			end
			r = moneys[math.random(1,#moneys)].."/"..moneysto[math.random(1,#moneysto)].." "..minplus..tostring(math.random(1,10000)/10000)

			return r
		end
		result = result .. GeneretaTorg() .. " | " .. GeneretaTorg() .. " | " .. GeneretaTorg() .. " |"
	else
		if math.random(0,100)>50 then
			if math.random(0,100)>50 then
				--Выборы
				local kandidants = {"Дексон Кэдред","Вилсон Витлоу","Нейрокс Дмитриевич","Кашпан Депо","Александрович Марокс","ИИ \"Стёпа\""}
				local kandidant1,kandidant2 = "",""
				local id = math.random(1,#kandidants)
				kandidant1 = kandidants[id]
				table.remove(kandidants,id)
				kandidant2 = kandidants[math.random(1,#kandidants)]
				if math.random(0,100)>50 then
					result = kandidant1.." сдвигает "..kandidant2.." на "..math.random(1,5).." позиций!"
				else
					result = kandidant1.." ведёт переговоры с "..kandidant2
				end
			else
				--WRF зоны
				local zone = math.random(-1,24)
				if math.random(0,100)>50 then
					result = "В зоне "..zone.." произошёл инцидент!"
				else
					result = "Зона "..zone.." проявила себя сегодня!"
				end
			end
		else
			if true then--math.random(0,100)>50 then
				--Смерть
				local names = base.Names
				local familii = base.Surnames
				local profesii = base.Professions
				result = "Сегодня умер "..profesii[math.random(1,#profesii)].." "..names[math.random(1,#names)].." "..familii[math.random(1,#familii)].." "..math.random(20,80).." лет!"
			else
				--Разработки
			end
		end
	end

	return result
end

script.Parent.Text1.Value = GenerateBirsha()
script.Parent.Text2.Value = GenerateBirsha()
local pos = 0
while wait(0.1) do
	pos += 0.01
	if pos >1 then
		pos = 0
		script.Parent.Text1.Value = script.Parent.Text2.Value
		script.Parent.Text2.Value = GenerateBirsha()
	end
	script.Parent.TextPosition.Value = pos
end