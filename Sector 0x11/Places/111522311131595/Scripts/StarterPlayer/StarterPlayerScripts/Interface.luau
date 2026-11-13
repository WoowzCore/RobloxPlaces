-- By Woowz11

--!strict
--!optimize 2
--!native

local GameOverlay_Date : TextLabel = nil

local DebugOverlay_FPS         : TextLabel = nil
local DebugOverlay_Step        : TextLabel = nil
local DebugOverlay_WorldTime   : TextLabel = nil
local DebugOverlay_AwakeParts  : TextLabel = nil
local DebugOverlay_LUA         : TextLabel = nil
local DebugOverlay_Ping        : TextLabel = nil
local DebugOverlay_Coordinates : TextLabel = nil
local DebugOverlay_Speed       : TextLabel = nil

local Notification_ShowTween     = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local Notification_HideTween     = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In )
local Notification_Notifications = {}

_G.Interface = {

    -- Запускает интерфейс
    Launch = function()
        task.spawn(_G.Interface.DisableCore) -- Вызов на фоне

        _G.Value.Interface_UI = _G.Instance.Clone(_G.Instance.Get(_G.Value.Service_StarterUI, "UI"), _G.Value.Client_PlayerUI)
        _G.Value.Interface_UI.Enabled = true

        _G.Interface.Init_MainMenu     ()
        _G.Interface.Init_GameOverlay  ()
        _G.Interface.Init_DebugOverlay ()
        _G.Interface.Init_Notifications()
        
        _G.Interface.Open_MainMenu()
    end,

    -- Отключает дефолтный интерфейс
    DisableCore = function()
        _G.Value.Service_StarterUI:SetCoreGuiEnabled(Enum.CoreGuiType.All, false) -- Отключает дефолтный интерфейс

        -- Отключает Core правильно
        local DisableCore = function(Core : string)
            repeat
                local Success = pcall(function() _G.Value.Service_StarterUI:SetCore(Core, false) end)
                task.wait(1)
            until Success
        end

        DisableCore("ResetButtonCallback") -- Отключает кнопку респавна
    end,

    -- Обновляет интерфейс
    Update = function()
        _G.Value.Interface_CursorLock = _G.Value.Other_CursorLock and not _G.Value.Interface_MainMenu.Visible
        _G.Value.Interface_ShowCursor = not _G.Value.Interface_CursorLock

        _G.Value.Service_UserInput.MouseIconEnabled = _G.Value.Interface_ShowCursor
        _G.Value.Service_UserInput.MouseBehavior    = _G.Value.Interface_CursorLock and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default

        if _G.Value.Interface_GameOverlay.Visible then
            GameOverlay_Date.Text = string.format(
                "%02d:%02d:%02d.%03d %02d.%02d.%04d",
                _G.Value.Game_Time_Game.hour, _G.Value.Game_Time_Game.min, _G.Value.Game_Time_Game.sec, _G.Value.Game_Time_Game.ms,
                _G.Value.Game_Time_Game.day, _G.Value.Game_Time_Game.month, _G.Value.Game_Time_Game.year
            )
        end

        _G.Interface.Update_DebugOverlay()
    end,

    -- Уведомить (_G.Enum.NotifyType)
    Notify = function(Message : string, Type : number)
        table.insert(Notification_Notifications, {Message, Type})

        local Notification : Frame = _G.Instance.Clone(_G.Value.Resource_UI_Notification, _G.Value.Interface_Notifications:FindFirstChild("List"))
        local Background = Notification:FindFirstChild("Background")
        Background:FindFirstChild("Text").Text = Message

        local Size = Notification.Size

        Notification.Size = UDim2.new(Size.Width.Scale, Size.Width.Offset, Size.Height.Scale, 1)

        local ShowTween = _G.Value.Service_Tween:Create(Notification, Notification_ShowTween, { Size = UDim2.new(Size.Width.Scale, Size.Width.Offset, Size.Height.Scale, Size.Height.Offset) })

        ShowTween.Completed:Connect(function()
            task.delay(2, function()
                local HideTween = _G.Value.Service_Tween:Create(Notification, Notification_HideTween, { Size = UDim2.new(Size.Width.Scale, Size.Width.Offset, Size.Height.Scale, 1) })

                HideTween.Completed:Connect(function()
                    Notification:Destroy()
                end)

                HideTween:Play()
            end)
        end)

        ShowTween:Play()

        _G.Sound.PlayClient(_G.Value.Resource_Sound_Notification)
    end,

    -- Переводит содержимое TextLabel
    Translate = function(TextLabel : TextLabel)
        TextLabel.Text = _G.Translate.Translate(TextLabel.Text)
    end,

    --#region Главное меню

        -- Инициализирует
        Init_MainMenu = function()
            _G.Value.Interface_MainMenu = _G.Instance.Get(_G.Value.Interface_UI, "MainMenu")

            _G.Interface.Translate(_G.Instance.Get(_G.Value.Interface_MainMenu, "PlaceName"))

            _G.Instance.Get(_G.Value.Interface_MainMenu, "PlayButton").Activated:Connect(function()
                _G.Interface.Close_MainMenu()
                _G.Interface.Open_GameOverlay()

                _G.Client.Spawn()
            end)
        end,

        -- Открывает
        Open_MainMenu = function()
            if _G.Value.Interface_MainMenu.Visible then return end

            _G.Value.Interface_MainMenu.Visible = true
        end,

        -- Закрывает
        Close_MainMenu = function()
            if not _G.Value.Interface_MainMenu.Visible then return end

            _G.Value.Interface_MainMenu.Visible = false
        end,

    --#endregion

    --#region Игровой оверлей

        -- Инициализирует
        Init_GameOverlay = function()
            _G.Value.Interface_GameOverlay = _G.Instance.Get(_G.Value.Interface_UI, "GameOverlay")
            _G.Value.Interface_GameOverlay.Visible = false

            _G.Interface.Translate(_G.Instance.Get(_G.Value.Interface_GameOverlay, "Warning"))

            GameOverlay_Date = _G.Instance.Get(_G.Value.Interface_GameOverlay, "Date")
        end,

        -- Открывает
        Open_GameOverlay = function()
            if _G.Value.Interface_GameOverlay.Visible then return end

            _G.Value.Interface_GameOverlay.Visible = true
        end,

        -- Закрывает
        Close_GameOverlay = function()
            if not _G.Value.Interface_GameOverlay.Visible then return end

            _G.Value.Interface_GameOverlay.Visible = false
        end,

    --#endregion

    -- Возвращает цвет относительно чисел
    DebugColorLerp = function(Number : number, Normal: number, Bad: number, Good: number) : Color3
        if Number < Normal then
            return Color3.new(1, 0, 0):Lerp(Color3.new(1, 1, 1), math.clamp((Number - Bad) / (Normal - Bad), 0, 1))
        else
            return Color3.new(1, 1, 1):Lerp(Color3.new(0, 1, 0), math.clamp((Number - Normal) / (Good - Normal), 0, 1))
        end
    end,

    --#region Отладочный оверлей

        -- Инициализирует
        Init_DebugOverlay = function()
            _G.Value.Interface_DebugOverlay = _G.Instance.Get(_G.Value.Interface_UI, "DebugOverlay")
            _G.Value.Interface_DebugOverlay.Visible = true

            DebugOverlay_FPS         = _G.Instance.Get(_G.Value.Interface_DebugOverlay, "FPS"        )
            DebugOverlay_Step        = _G.Instance.Get(_G.Value.Interface_DebugOverlay, "Step"       )
            DebugOverlay_WorldTime   = _G.Instance.Get(_G.Value.Interface_DebugOverlay, "WorldTime"  )
            DebugOverlay_AwakeParts  = _G.Instance.Get(_G.Value.Interface_DebugOverlay, "AwakeParts" )
            DebugOverlay_LUA         = _G.Instance.Get(_G.Value.Interface_DebugOverlay, "LUA"        )
            DebugOverlay_Ping        = _G.Instance.Get(_G.Value.Interface_DebugOverlay, "Ping"       )
            DebugOverlay_Coordinates = _G.Instance.Get(_G.Value.Interface_DebugOverlay, "Coordinates")
            DebugOverlay_Speed       = _G.Instance.Get(_G.Value.Interface_DebugOverlay, "Speed"      )
        end,

        -- Открывает
        Open_DebugOverlay = function()
            if _G.Value.Interface_DebugOverlay.Visible then return end

            _G.Value.Interface_DebugOverlay.Visible = true
        end,

        -- Закрывает
        Close_DebugOverlay = function()
            if not _G.Value.Interface_DebugOverlay.Visible then return end

            _G.Value.Interface_DebugOverlay.Visible = false
        end,

        -- Обновляет
        Update_DebugOverlay = function()
            if _G.Value.Interface_DebugOverlay == nil or not _G.Value.Interface_DebugOverlay.Visible then return end

            -- Текущий FPS
            local FPS = _G.Value.Client_FPS
            DebugOverlay_FPS.Text = "FPS: " .. FPS
            DebugOverlay_FPS.TextColor3 = _G.Interface.DebugColorLerp(FPS, 60, 0, 120)
            
            -- Скорость работы сервера
            local Step = _G.Value.Game_PhysicStep
            DebugOverlay_Step.Text = "Step: " .. Step
            DebugOverlay_Step.TextColor3 = _G.Interface.DebugColorLerp(Step, 0.01, 0.06, 0.0)
            
            -- Время карты
            DebugOverlay_WorldTime.Text = "WT: " .. _G.Other.Round(_G.Value.Game_Time_World, 1)
            
            -- Кол-во не спящих объектов
            local AP = workspace:GetNumAwakeParts()
            DebugOverlay_AwakeParts.Text = "A.P.: " .. AP
            DebugOverlay_AwakeParts.TextColor3 = _G.Interface.DebugColorLerp(AP, 300, 1000, 0)
            
            -- Сколько потребляет памяти LUA?
            DebugOverlay_LUA.Text = "LUA: " .. collectgarbage("count")

            -- Пинг
            local Ping = math.round(_G.Value.Client_Player:GetNetworkPing() * 1000)
            DebugOverlay_Ping.Text = "Ping: " .. Ping
            DebugOverlay_Ping.TextColor3 = _G.Interface.DebugColorLerp(Ping, 160, 360, 0)

            -- Координаты
            local Position = _G.Value.Character_ColD and _G.Value.Character_ColD.Position or Vector3.zero
            DebugOverlay_Coordinates.Text = "Pos: " .. _G.Other.Round(Position.X, 1) .. ", " .. _G.Other.Round(Position.Y, 1) .. ", " .. _G.Other.Round(Position.Z, 1)

            -- Скорость
            local Speed = _G.Value.Character_ColD and _G.Value.Character_ColD.AssemblyLinearVelocity.Magnitude or 0
            DebugOverlay_Speed.Text = "Spd.: " .. _G.Other.Round(Speed, 2)
        end,

    --#endregion

    --#region Уведомления

        -- Инициализирует
        Init_Notifications = function()
            _G.Value.Interface_Notifications = _G.Instance.Get(_G.Value.Interface_UI, "Notifications")
            _G.Value.Interface_Notifications.Visible = true
        end,

        -- Открывает
        Open_Notifications = function()
            if _G.Value.Interface_Notifications.Visible then return end

            _G.Value.Interface_Notifications.Visible = true
        end,

        -- Закрывает
        Close_Notifications = function()
            if not _G.Value.Interface_Notifications.Visible then return end

            _G.Value.Interface_Notifications.Visible = false
        end,

        -- Обновляет
        UpdateNotifications = function()
            if not _G.Value.Interface_Notifications.Visible then return end
        end

    --#endregion

}

return nil