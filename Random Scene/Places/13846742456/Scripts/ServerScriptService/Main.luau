game.ReplicatedStorage.Random.OnServerInvoke = function(player,rndtype,values)
	local randomtype = rndtype
	-- create (smol, small, middle, big, huge) (plrposition,rndposition) - Создание случайного объекта
	-- take (buildings, weapons, vehicles, npc, other) (plrposition,rndposition) - Взятие объекта из списков [постройки, оружие, транспорт, нпс, разное] и его создание
	-- take_change (buildings, weapons, vehicles, npc, other) (plrposition,rndposition) - Прошлый вариант + случайное изменение объекта 
	-- change - Изменение объекта (Изменение декалей на другие, изменение скриптов, добавление или удаление предметов)
	-- settings (climate, terrain, player (moving, animation, character (full, partially)), gui, materials) - Изменение настроек сервера [климат, терраин, настройки игрока [управление, анимации, персонаж [полностью, частично]], ui, материалы]
	-- full - Выполняются все функции и некоторые несколько раз 

	
end