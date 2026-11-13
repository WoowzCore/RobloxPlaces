-- By Woowz11

--!strict
--!optimize 2
--!native

_G.Events = {

    -- Вызывается при запуске клиента
    Event_ClientLaunch = function()

    end,

    -- Вызывается при закрытии клиента
    Event_ClientClose = function()
        _G.Client.Stopping()
    end,

    -- Вызывается каждый кадр при рендере
    Event_Render = function(DeltaTime : number)
        _G.Gizmos.ClearAll()

        _G.Client.Update_Render(DeltaTime)
        _G.Render.       Render(DeltaTime)

        _G.Sound.Update()
    end,

    -- Вызывается каждый раз при заканчивании симуляции физики
    Event_Update = function(DeltaTime : number)
        _G.Game.Update(DeltaTime)

        _G.Client.Update(DeltaTime)
    end,

    -- Вызывается каждый раз перед заканчивании симуляции физики
    Event_PreUpdate = function(DeltaTime : number)
        
    end,

    -- Вызывается когда новый игрок добавился
    Event_PlayerAdded = function(Player : Player)
        _G.Value.Game_Players[Player.UserId] = Player
    end,

    -- Вызывается когда игрок удаляется
    Event_PlayerRemoving = function(Player : Player)
        _G.Value.Game_Players[Player.UserId] = nil
    end,

    -- Действие управление начинается
    Event_InputBegan = function(Input : InputObject, GameProcessedEvent : boolean)
        if Input.UserInputType == Enum.UserInputType.Keyboard then
            _G.Input.Event_KeyPressDown(Input.KeyCode)
        end
    end,

    -- Действие управление изменилось
    Event_InputChanged = function(Input : InputObject, GameProcessedEvent : boolean)
        if Input.UserInputType == Enum.UserInputType.MouseMovement and _G.Value.Interface_CursorLock then
            _G.Input.Event_MouseMoving(Vector2.new(Input.Delta.X, Input.Delta.Y), not (Input.Delta.X == 0 and Input.Delta.Y == 0)) 
        end
    end,

    -- Действие управление заканчивается
    Event_InputEnded = function(Input : InputObject, GameProcessedEvent : boolean)
        if Input.UserInputType == Enum.UserInputType.Keyboard then
            _G.Input.Event_KeyPressUp(Input.KeyCode)
        end
    end,

    -- Соеденяет ивенты
    ConnectEvents = function()
        _G.Value.Service_Run.RenderStepped :Connect(_G.Events.Event_Render   )
        _G.Value.Service_Run.Heartbeat     :Connect(_G.Events.Event_Update   )
        _G.Value.Service_Run.Stepped       :Connect(_G.Events.Event_PreUpdate)

        _G.Value.Service_Players.PlayerAdded:Connect(_G.Events.Event_PlayerAdded)
        _G.Value.Service_Players.PlayerRemoving:Connect(function(Player : Player)
            _G.Events.Event_PlayerRemoving(Player)

            if Player == _G.Value.Client_Player then _G.Events.Event_ClientClose() end
        end)

        _G.Value.Service_UserInput.InputBegan  :Connect(_G.Events.Event_InputBegan  )
        _G.Value.Service_UserInput.InputChanged:Connect(_G.Events.Event_InputChanged)
        _G.Value.Service_UserInput.InputEnded  :Connect(_G.Events.Event_InputEnded  )

        _G.Logger.Info("Клиентские ивенты соеденены!")
    end
}

return nil