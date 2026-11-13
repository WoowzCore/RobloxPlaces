local base = {}

base.Places = {
	["A"] = 16670358869 --Самая первая карта, на которую попадает игрок при заходе на плейс
}

base.PlaceID = 0
base.CurrentPlace = ""
base.Seed = 0
base.FullSeed = ""

base.RandomSeed = 0

function base.GenerateSeed()
	base.PlaceID = game.PlaceId
	for place,id in pairs(base.Places) do
		if id == base.PlaceID then
			base.CurrentPlace = place
			break
		end
	end
	base.Seed = math.random(0,100000000)
	base.FullSeed = base.CurrentPlace.."_"..tostring(base.Seed)
	math.randomseed(base.Seed)
	base.RandomSeed = math.random(0,10000)
end

function base.RandomFromSeed(min : number?,max : number?,add : number?,seed)
	local thatfloat = ((min == nil and max == nil) or (min == 0 and max == 1))
	if min == nil then min = 0 end
	if max == nil then max = 1 end
	if add == nil then add = 0 end
	if min >= max then error("Минимальное случайное число не может быть больше или равно максимальному! ["..tostring(min).." / "..tostring(max).."]") return 0 end
	math.randomseed(math.abs(seed+math.floor(add::number)))
	if thatfloat then
		return math.random()
	else
		return math.random(min,max)
	end
end

function base.r(min : number?,max : number?,add : number?) --Рандомизация в while wait() do
	return base.RandomFromSeed(min,max,add,base.RandomSeed)
end

function base.R(min : number?,max : number?,add : number?) --Рандомизация при запуске
	return base.RandomFromSeed(min,max,add,base.Seed)
end

base.Config = nil

return base
