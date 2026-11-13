local screen = script.Parent.Screen
local videop = screen.Background.Bottom.Center.Video 
local data = game:GetService("ServerScriptService").ServerInfo.ADDisplay

local videos_base = {
	{"5608359401",{"Безопасное обращение с оружием","NO FRIENDLIES FIRE","тест анимация"}},
	{"5670804538",{"Пираты видео","Бухта мем","Pirate"}},
	{"5608368298",{"Madness Combat","Драка","test"}},
	{"5670824523",{"MINECARTS ROBLOX FREE PLAY","21.02.2029.22:35-174","Roblox memes №189"}},
	{"5608268502",{"Съёмка с дрона - рифы","Пейзажи","Пром тест фейковой реальности"}},
	{"5608413286",{"анимация часы","задник фон часы шестерёнки векторы"}},
	{"5608330602",{"Инцидент","WATCH YOUR STEP!","Ржака анимации"}},
	{"5608411652",{"эффект шума","NOISE SCREEN"}},
	{"5608360493",{"ikbhriojgsopryisep","test2"}},
	{"5608392925",{"анимация небо птицы","Flash animation Sky Birds"}},
	{"5608384572",{"Particle Disco Light","Новый уровень PTTR диско" }},
	{"5608321996",{"ЭЭ","Beacon Hair Drink Bloxy Cola","Вот что люди смотрят в 2029, деградация общества"}},
	{"5608369138",{"Ошибка","We'll be right back"}},
	{"5608327482",{"💀","Eat","СПАСИТЕ МЕНЯ ДЕРЖАТ ТУТ Я КОЕ КАК"}},
	{"5608304953",{"Реклама пиццы","Pizza's 25% off"}},
	{"5608390467",{"Радиация в чистом виде","Special animation spheres - animtool"}},
	{"5608370112",{"кринжатина","Анимация человек с мечом","Pirate sword - new game"}},
	{"5608410985",{"TV LOADING","Помеха","Color noise"}},
	{"5608339667",{"PLEASE WAIT","test3","Первая анимация на RatTok"}},
	{"5608386285",{"Нашёл в подвале Zooi","TV Set","Retro set tv's"}},
	{"5608309393",{"Gameplay 8bit 'Roblox Platformer'","СТРИМЕР СПАЛИЛ НА ВИДЕО","пиксельная анимация"}},
	{"5608422571",{"Ломание костей чек","XRay moment","Скелет: что такое"}},
	{"5670826209",{"История стройка Москвы","Казанский сабор","Bricks"}},
	{"5608349310",{"Система обнаружения сломанных костей версия 21.6","Skeleton construction"}},
	{"5608412605",{"Считалочка от 9 до 0","Топ цифр"}},
	{"5608337069",{"CONNECTING","Загрузка"}},
	{"5670806798",{"РЕКЛАМА: BOMB SIMULATOR","NOOB MEMESESSSFXRQWF"}},
	{"5670799859",{"Топ ДТП","Анимация автомобили сплошная"}},
	{"5670869502",{"Водопад","Тест 2 Фейковая реальность"}},
	{"5608403837",{"Retro Disco Ball","Дискотека"}},
	{"5608297917",{"Скример","Jumpscare"}},
	{"5608281849",{"трюк магия собака","Волшебница","Magic Tricks"}}
}
local videos = {}

local function CompileVideoName(video)
	local result = video[2][math.random(1,#video[2])]
	
	local endsymbol = {"","","","","!","?","!","?","...","?!",".mov",".mp4"}
	result = result .. endsymbol[math.random(1,#endsymbol)]
	if math.random(0,100)>50 then
		result = string.gsub(result," ","_")
	end
	
	return result
end

local function CompileVideos()
	local result = {}
	local videos_a = videos_base
	local videos_b = {}
	
	for j = 1, #videos_a do
		local i = math.random(1,#videos_a)
		table.insert(videos_b,videos_a[i])
		table.remove(videos_a,i)
	end
	
	for _, video in pairs(videos_b) do
		table.insert(result,{video[1],CompileVideoName(video)})
	end
	
	videos = result
end
CompileVideos()

local selectedvideo = math.random(1,#videos)
local videoAutoNext = (math.random(0,100)>50)
local videoplay = (math.random(0,100)>50)
local videomute = (math.random(0,100)>25)

local function PlayVideo()	
	screen.Background.Bottom.Center.Bottom.Play.Image = "rbxassetid://16467173644"
	videoplay = true
	--videop:Play()
	script.Parent.Parent.Playing.Value = true
end

local function StopVideo()
	screen.Background.Bottom.Center.Bottom.Play.Image = "rbxassetid://16467168567"
	videoplay = false
	--videop:Pause()
	script.Parent.Parent.Playing.Value = false
end


local function PressPlayVideo()
	if videoplay then
		StopVideo()
	else
		PlayVideo()
	end
end

local function SetVideo(id)
	videop.TimePosition = 0
	local video = videos[id]
	screen.Background.Bottom.Center.Title.TextLabel.Text = "RatTok - ("..video[2]..")"
	videop.Video = "rbxassetid://"..video[1]
end
SetVideo(selectedvideo)

local function PressNextVideo()
	selectedvideo += 1
	if selectedvideo > #videos then
		selectedvideo = 1
	end
	SetVideo(selectedvideo)
	PlayVideo()
end

local function PressPrevVideo()
	selectedvideo -= 1
	if selectedvideo < 1 then
		selectedvideo = #videos
	end
	SetVideo(selectedvideo)
	PlayVideo()
end

local function UpdateVideoData()
	local volume = 0.5
	if videomute then
		volume = 0
	end
	videop.Volume = volume
	
	if videomute then
		screen.Background.Bottom.Center.Bottom.Mute.Image = "rbxassetid://16467161054"
	else
		screen.Background.Bottom.Center.Bottom.Mute.Image = "rbxassetid://16467140054"
	end
	if videoAutoNext then
		screen.Background.Bottom.Center.Bottom.AutoNext.Image = "rbxassetid://16467129345"
	else
		screen.Background.Bottom.Center.Bottom.AutoNext.Image = "rbxassetid://16467135553"
	end
end

local function PressMuteVideo()
	videomute = not videomute
	UpdateVideoData()
end

local videotime = 0
local function PressAutoNextVideo()
	videotime = videop.TimeLength
	videoAutoNext = not videoAutoNext
	UpdateVideoData()
	videop.TimePosition = 0
end

script.Parent.Button_AutoNext.ClickDetector.ClickDetectorScript.Event.Event:Connect(PressAutoNextVideo)
script.Parent.Button_Mute.ClickDetector.ClickDetectorScript.Event.Event:Connect(PressMuteVideo)
script.Parent.Button_Prev.ClickDetector.ClickDetectorScript.Event.Event:Connect(PressPrevVideo)
script.Parent.Button_Play.ClickDetector.ClickDetectorScript.Event.Event:Connect(PressPlayVideo)
script.Parent.Button_Next.ClickDetector.ClickDetectorScript.Event.Event:Connect(PressNextVideo)

if videoplay then
	PlayVideo()
else
	videop.TimePosition = videop.TimeLength * (math.random(0,100)/100)
	StopVideo()
end
UpdateVideoData()

local randtimer = math.random(100,400)

------------------------------------------------------------------------------------------------------------------------------------------------------
local birsha_n,birsha_o = screen.Background.Top.NewText,screen.Background.Top.OldText

data.Text1:GetPropertyChangedSignal("Value"):Connect(function()
	birsha_o.Text = data.Text1.Value
end)
data.Text2:GetPropertyChangedSignal("Value"):Connect(function()
	birsha_n.Text = data.Text2.Value
end)
data.TextPosition:GetPropertyChangedSignal("Value"):Connect(function()
	birsha_o.Position = UDim2.new(-data.TextPosition.Value,0,0,0)
	birsha_n.Position = UDim2.new(-data.TextPosition.Value+1,0,0,0)
end)

local timer = 0
while wait(0.1) do
	timer += 1
	if timer > randtimer then
		randtimer = math.random(50,150)
		timer = 0
		if videoAutoNext and videoplay then
			PressNextVideo()
		end
	end
end