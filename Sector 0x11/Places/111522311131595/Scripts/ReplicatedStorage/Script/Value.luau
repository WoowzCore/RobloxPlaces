local Players = game:GetService("Players")
-- By Woowz11

--!strict
--!optimize 2
--!native

_G.Value = {} :: Type_Value

_G.Value.Function_Init = function()

    _G.Value.Serivce_Game = game

    _G.Value.Service_ReplicatedStorage = game:GetService("ReplicatedStorage"  )
    _G.Value.Service_Players           = game:GetService("Players"            )
    _G.Value.Service_Run               = game:GetService("RunService"         )
    _G.Value.Service_StarterUI         = game:GetService("StarterGui"         )
    _G.Value.Service_UserInput         = game:GetService("UserInputService"   )
    _G.Value.Service_ServerStorage     = game:GetService("ServerStorage"      )
    _G.Value.Service_Asset             = game:GetService("AssetService"       )
    _G.Value.Service_Content           = game:GetService("ContentProvider"    )
    _G.Value.Service_Localization      = game:GetService("LocalizationService")
    _G.Value.Service_Physic            = game:GetService("PhysicsService"     )
    _G.Value.Service_Tween             = game:GetService("TweenService"       )
    _G.Value.Service_StarterPlayer     = game:GetService("StarterPlayer"      )

    --#region Константы

        _G.Value.Info_Version = "0.0.5"
        _G.Value.Info_Name    = "Sector 0x11"

        _G.Value.Info_StudioSide = _G.Value.Service_Run:IsStudio()

        _G.Value.Debug = false

        _G.Value.Debug_TrueDebug = _G.Value.Debug or _G.Value.Info_StudioSide

        _G.Value.Function_UpdateDebug()

        _G.Value.Character_Rotation_Head_Limit = Vector2.new(-math.rad(70), math.rad(90))
        _G.Value.Client_Sensitivity = 0.006
        _G.Value.Client_JumpPower = 15

        _G.Value.Client_Language = 0

        _G.Value.Settings_Keys = {
            -- Ходьба вперёд
            [0] = Enum.KeyCode.W,
            -- Ходьба назад
            [1] = Enum.KeyCode.S,
            -- Ходьба вправо
            [2] = Enum.KeyCode.D,
            -- Ходьба влево
            [3] = Enum.KeyCode.A,

            -- Бег
            [4] = Enum.KeyCode.LeftShift,
            -- Медленная ходьба
            [5] = Enum.KeyCode.LeftAlt,

            -- Прыжок
            [6] = Enum.KeyCode.Space,

            -- Разблокировать/заблокировать мышь
            [7] = Enum.KeyCode.M,

            -- Поменять перспективу камеры
            [8] = Enum.KeyCode.F5,

            -- Телепорт в центр
            [9] = Enum.KeyCode.H
        }

    --#endregion

    _G.Value.Game_Players      = {}
    _G.Value.Game_Characters   = {}
    _G.Value.Game_Character_Count = 0
    _G.Value.Game_ServerInfo   = {
        Clients = {},
        WorldTime = 0,
        PhysicStep = 0
    }

    _G.Value.Client_HasCharacter = false
    _G.Value.Client_Alive = false
    _G.Value.Client_Dead  = true
    _G.Value.Client_Info = {}
    _G.Value.Client_FPS = 0

    _G.Value.Interface_ShowCursor = true
    _G.Value.Interface_CursorLock = false

    _G.Value.Other_CursorLock = true
    _G.Value.Other_CameraType = 0

    _G.Value.Input_PressedKeys = {}

    _G.Value.Character_Rotation_Head = 0
    _G.Value.Character_Rotation = 0

    _G.Value.Game_Time_Life  = 0
    _G.Value.Game_Time_World = 0
    _G.Value.Game_PhysicStep = 0
end

_G.Value.Function_UpdateDebug = function()
    _G.Value.Debug_Log_ResourceLoading = _G.Value.Debug_TrueDebug and true
    _G.Value.Debug_Log_PacketSend      = _G.Value.Debug_TrueDebug and 1 or 0
    _G.Value.Debug_Log_PacketGet       = _G.Value.Debug_TrueDebug and 1 or 0
    _G.Value.Debug_Log_Physic          = _G.Value.Debug_TrueDebug and true
    _G.Value.Debug_Draw_Raycast        = _G.Value.Debug_TrueDebug and false
    _G.Value.Debug_Draw_Bounds         = _G.Value.Debug_TrueDebug and true
    _G.Value.Debug_Draw_ServicesWorld  = _G.Value.Debug_TrueDebug and true
end

type Type_Value = {

    --#region Информация

        -- Название плейса
        Info_Name : string,
        -- Версия плейса
        Info_Version : string,

        -- Запущено на серверной стороне?
        Info_ServerSide : boolean,
        -- Запущено на клиентской стороне?
        Info_ClientSide : boolean,

        -- Запущено в студии?
        Info_StudioSide : boolean,

        -- Время запуска
        Info_StartTime : number,

    --#endregion

    --#region Отладка

        -- Включена массовая отладка? (так же включает для публики)
        Debug : boolean,

        -- Отладка включена?
        Debug_TrueDebug : boolean,

        -- Показывает загрузку ресурсов
        Debug_Log_ResourceLoading : boolean,

        -- Показывает отправку пакетов (0 - Ничего, 1 - Нечастые, 2 - Все)
        Debug_Log_PacketSend : number,
        -- Показывает получение пакетов (0 - Ничего, 1 - Нечастые, 2 - Все)
        Debug_Log_PacketGet : number,

        -- Выводить информацию об физике
        Debug_Log_Physic : boolean,

        -- Отображать лучи
        Debug_Draw_Raycast : boolean,

        -- Отображать пересечения
        Debug_Draw_Bounds : boolean,

        -- Рисует отладку об Services_World
        Debug_Draw_ServicesWorld : boolean,

    --#endregion

    --#region Сервисы

        -- Папка "ReplicatedStorage"
        Service_ReplicatedStorage : ReplicatedStorage,
        -- Папка "ServerStorage"
        Service_ServerStorage : ServerStorage,
        -- Игроки
        Service_Players : Players,
        -- Запуск
        Service_Run : RunService,
        -- Игра
        Serivce_Game : DataModel,
        -- Папка "StarterGUI"
        Service_StarterUI : StarterGui,
        -- Управление
        Service_UserInput : UserInputService,
        -- Ассеты
        Service_Asset : AssetService,
        -- Контент
        Service_Content : ContentProvider,
        -- Перевод
        Service_Localization : LocalizationService,
        -- Физика
        Service_Physic : PhysicsService,
        -- Анимации
        Service_Tween : TweenService,
        -- Папка "StartPlayer"
        Service_StarterPlayer : StarterPlayer,

    --#endregion

    --#region Игра

        -- Игроки на плейсе
        Game_Players : {[number] : Player},

        -- Персонажы игроков
        Game_Characters : {[Player] : Model},

        -- Кол-во персонажей игроков
        Game_Character_Count : number,

        -- Информация об сервере
        Game_Server : Type_ServerInfo,

        -- Сколько секунд уже существует?
        Game_Time_Life : number,

        -- Сколько секунд уже существует мир?
        Game_Time_World : number,

        -- UTC время
        Game_Time_UTC : {},

        -- Московское время
        Game_Time_Moscow : {},

        -- Игровое время
        Game_Time_Game : {},

        -- Время в будущем
        Game_Time_Future : {},

        -- Скорость работы физики
        Game_PhysicStep : number,

    --#endregion

    --#region Ресурсы

        -- Объект тело игрока
        Resource_Object_Character : Instance,

        -- Белая текстура
        Resource_Texture_White : string,

        -- Уведомление
        Resource_Sound_Notification : string,

        -- Уведомление
        Resource_UI_Notification : Frame,

    --#endregion

    -- ===========================================================================
    -- Только на клиенте

    --#region Клиент

        -- Клиентский игрок
        Client_Player : Player,

        -- ID игрока (СТРОКА!!!)
        Client_UserID : string,

        -- Камера
        Client_Camera : Camera,

        -- У игрока есть тело?
        Client_HasCharacter : boolean,

        -- Игрок живой?
        Client_Alive : boolean,
        -- Игрок мёртвый?
        Client_Dead : boolean,

        -- Направление движения
        Client_MovingAxis : Vector2,

        -- Направление движения (повёрнутое)
        Client_MovingAxisRotated : Vector3,

        -- Направление движения (финальное, с скоростью)
        Client_MovingDirection : Vector3,

        -- Игрок двигается?
        Client_Moving : boolean,

        -- Скорость игрока
        Client_MovingSpeed : number,

        -- Сила прыжка
        Client_JumpPower : number,

        -- Сенса мыши
        Client_Sensitivity : number,

        -- Пол под ногами игрока
        Client_Raycast_Ground : RaycastParams?,

        -- Градус пола
        Client_GroundAngle : number,

        -- Информация об клиенте
        Client_Info : Type_ClientInfo,

        -- Папка со скриптами игрока
        Client_PlayerScripts : PlayerScripts,

        -- Папка с интерфейсом игрока
        Client_PlayerUI : PlayerGui,

        -- Выбранный язык
        Client_Language : number,

        -- FPS
        Client_FPS : number,

    --#endregion

    --#region Профиль

        -- Тип игрока (_G.Enum.PlayerType)
        Profile_PlayerType : number,

        -- Аккаунт разработчика?
        Profile_Developer : boolean,

    --#endregion

    --#region Персонаж

        -- Тело игрока
        Character_Character : Model,

        -- Части тела
        Character_Head  : BasePart,
        Character_Neck  : BasePart,
        Character_BodyU : BasePart,
        Character_BodyD : BasePart,
        Character_ArmRU : BasePart,
        Character_ArmR  : BasePart,
        Character_ArmRD : BasePart,
        Character_ArmLU : BasePart,
        Character_ArmL  : BasePart,
        Character_ArmLD : BasePart,
        Character_LegRU : BasePart,
        Character_LegR  : BasePart,
        Character_LegRD : BasePart,
        Character_LegLU : BasePart,
        Character_LegL  : BasePart,
        Character_LegLD : BasePart,

        -- Коллайдеры
        Character_ColD : BasePart,
        Character_Col  : BasePart,

        -- Соеденения с частями тела
        Character_Motor_Head  : Motor6D,
        Character_Motor_Neck  : Motor6D,
        Character_Motor_BodyU : Motor6D,
        Character_Motor_BodyD : Motor6D,
        Character_Motor_ArmRU : Motor6D,
        Character_Motor_ArmR  : Motor6D,
        Character_Motor_ArmRD : Motor6D,
        Character_Motor_ArmLU : Motor6D,
        Character_Motor_ArmL  : Motor6D,
        Character_Motor_ArmLD : Motor6D,
        Character_Motor_LegRU : Motor6D,
        Character_Motor_LegR  : Motor6D,
        Character_Motor_LegRD : Motor6D,
        Character_Motor_LegLU : Motor6D,
        Character_Motor_LegL  : Motor6D,
        Character_Motor_LegLD : Motor6D,
        Character_Motor_Col   : Motor6D,

        -- Позиция глаз
        Character_Eyes : Attachment,

        -- Объект отвечающий за движение
        Character_MoveForce : LinearVelocity,

        -- Лимит поворота головы по Pitch
        Character_Rotation_Head_Limit : Vector2,

        -- Поворот головы Pitch
        Character_Rotation_Head : number,

        -- Поворот персонажа Yaw
        Character_Rotation : number,

    --#endregion

    --#region Интерфейс

        -- Интерфейс
        Interface_UI : ScreenGui,

        -- Главное меню
        Interface_MainMenu : Frame,

        -- Игровой оверлей
        Interface_GameOverlay : Frame,

        -- Отладочный оверлей
        Interface_DebugOverlay : Frame,

        -- Уведомления
        Interface_Notifications : Frame,

        -- Отображать курсор?
        Interface_ShowCursor : boolean,

        -- Центрировать курсор?
        Interface_CursorLock : boolean,
    
    --#endregion

    --#region Управление

        -- Мышь
        Input_Mouse : Mouse,

        -- Нажатые клавиши
        Input_PressedKeys : {[Enum.KeyCode] : boolean},
        
        -- Позиция мыши
        Input_MousePosition : Vector2,

    --#endregion

    --#region Остальное

        -- Заблокировать курсор в центре?
        Other_CursorLock : boolean,
        -- Вид от камеры, 0 - Первое лицо, 1 - Третье лицо, 2 - Третье лицо спереди
        Other_CameraType : number,

    --#endregion

    --#region Настройки

        -- Клавиши
        Settings_Keys : {[number] : Enum.KeyCode}

    --#endregion

    -- ===========================================================================
    -- Только на сервере

    --#region Сервер

        -- бебе баба

    --#endregion
    
}

-- Пакет с информацией об клиенте
type Type_ClientInfo = {
    Player : Player,
    Character : Model,

    Motor_Head  : CFrame,
    Motor_Neck  : CFrame,
    Motor_BodyU : CFrame,
    Motor_BodyD : CFrame,
    Motor_ArmRU : CFrame,
    Motor_ArmR  : CFrame,
    Motor_ArmRD : CFrame,
    Motor_ArmLU : CFrame,
    Motor_ArmL  : CFrame,
    Motor_ArmLD : CFrame,
    Motor_LegRU : CFrame,
    Motor_LegR  : CFrame,
    Motor_LegRD : CFrame,
    Motor_LegLU : CFrame,
    Motor_LegL  : CFrame,
    Motor_LegLD : CFrame
}

_G.Value.Function_ClientInfo_To_Raw = function(ClientInfo : Type_ClientInfo)
    return {
        [1 ] = _G.Net.CFrameToSimple(ClientInfo.Motor_Head),
        [2 ] = _G.Net.CFrameToSimple(ClientInfo.Motor_Neck),
        [3 ] = _G.Net.CFrameToSimple(ClientInfo.Motor_BodyU),
        [4 ] = _G.Net.CFrameToSimple(ClientInfo.Motor_BodyD),
        [5 ] = _G.Net.CFrameToSimple(ClientInfo.Motor_ArmRU),
        [6 ] = _G.Net.CFrameToSimple(ClientInfo.Motor_ArmR),
        [7 ] = _G.Net.CFrameToSimple(ClientInfo.Motor_ArmRD),
        [8 ] = _G.Net.CFrameToSimple(ClientInfo.Motor_ArmLU),
        [9 ] = _G.Net.CFrameToSimple(ClientInfo.Motor_ArmL),
        [10] = _G.Net.CFrameToSimple(ClientInfo.Motor_ArmLD),
        [11] = _G.Net.CFrameToSimple(ClientInfo.Motor_LegRU),
        [12] = _G.Net.CFrameToSimple(ClientInfo.Motor_LegR),
        [13] = _G.Net.CFrameToSimple(ClientInfo.Motor_LegRD),
        [14] = _G.Net.CFrameToSimple(ClientInfo.Motor_LegLU),
        [15] = _G.Net.CFrameToSimple(ClientInfo.Motor_LegL),
        [16] = _G.Net.CFrameToSimple(ClientInfo.Motor_LegLD),

        [17] = ClientInfo.Player,
        [18] = ClientInfo.Character
    }
end
_G.Value.Function_Raw_To_ClientInfo = function(Raw) : Type_ClientInfo
    local Character = Raw[18]

    local Result = {
        Motor_Head  = _G.Net.SimpleToCFrame(Raw[1 ]),
        Motor_Neck  = _G.Net.SimpleToCFrame(Raw[2 ]),
        Motor_BodyU = _G.Net.SimpleToCFrame(Raw[3 ]),
        Motor_BodyD = _G.Net.SimpleToCFrame(Raw[4 ]),
        Motor_ArmRU = _G.Net.SimpleToCFrame(Raw[5 ]),
        Motor_ArmR  = _G.Net.SimpleToCFrame(Raw[6 ]),
        Motor_ArmRD = _G.Net.SimpleToCFrame(Raw[7 ]),
        Motor_ArmLU = _G.Net.SimpleToCFrame(Raw[8 ]),
        Motor_ArmL  = _G.Net.SimpleToCFrame(Raw[9 ]),
        Motor_ArmLD = _G.Net.SimpleToCFrame(Raw[10]),
        Motor_LegRU = _G.Net.SimpleToCFrame(Raw[11]),
        Motor_LegR  = _G.Net.SimpleToCFrame(Raw[12]),
        Motor_LegRD = _G.Net.SimpleToCFrame(Raw[13]),
        Motor_LegLU = _G.Net.SimpleToCFrame(Raw[14]),
        Motor_LegL  = _G.Net.SimpleToCFrame(Raw[15]),
        Motor_LegLD = _G.Net.SimpleToCFrame(Raw[16]),

        Player    = Raw[17],
        Character = Character
    }
    
    return Result
end

-- Пакет с информацией об сервере
type Type_ServerInfo = {
    -- Клиенты
    Clients : {[number] : Type_ClientInfo},

    -- Сколько секунд существует мир?
    WorldTime : number,

    -- Скорость работы сервера
    PhysicStep : number,
}

_G.Value.Function_ServerInfo_To_Raw = function(ServerInfo : Type_ServerInfo)
    local Clients__ = {}
    for UserID, ClientInfo in pairs(ServerInfo.Clients) do
        Clients__[UserID] = _G.Value.Function_ClientInfo_To_Raw(ClientInfo)
    end

    return {
        [1] = Clients__,
        [2] = ServerInfo.WorldTime,
        [3] = ServerInfo.PhysicStep
    }
end
_G.Value.Function_Raw_To_ServerInfo = function(Raw) : Type_ServerInfo
    local Clients__ = {}
    for UserID, ClientInfo in pairs(Raw[1]) do
        Clients__[UserID] = _G.Value.Function_Raw_To_ClientInfo(ClientInfo)
    end

    return {
        Clients    = Clients__,
        WorldTime  = Raw[2],
        PhysicStep = Raw[3]
    }
end

_G.Value.Function_Init()

return nil