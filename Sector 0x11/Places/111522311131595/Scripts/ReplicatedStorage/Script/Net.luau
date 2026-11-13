-- By Woowz11

--!strict
--!optimize 2
--!native

-- Пакеты (сервер -> клиент)
_G.Enum.PacketID_StC = table.freeze({
    -- Персонаж создался на стороне сервера
    CharacterCreated = 1,
    -- Отправляет информацию об сервере
    SendServerInfo = 2,
    -- Клиент зашёл, дополнительная информация с сервера (что за профиль к примеру)
    ClientJoined = 3,
    -- Отправляет изменения в физике
    ApplyPhysic = 4
})

-- Часто отправляемые пакеты (сервер -> клиент)
local PacketID_StC_Often = {
    [_G.Enum.PacketID_StC.SendServerInfo] = true,
    [_G.Enum.PacketID_StC.ApplyPhysic   ] = true
}

-- Пакеты (клиент -> сервер)
_G.Enum.PacketID_CtS = table.freeze({
    -- Игрок зашёл и загрузился, готов к загрузке от сервера
    ClientReady = 1,
    -- Отправляет информацию об клиенте
    SendClientInfo = 2,
    -- Клиент хочет заспавниться
    ClientSpawn = 3
})

-- Часто отправляемые пакеты (клиент -> сервер)
local PacketID_CtS_Often = {
    [_G.Enum.PacketID_CtS.SendClientInfo] = true
}

local Enum_PacketID_StC_Invert = {}
for K, V in pairs(_G.Enum.PacketID_StC) do Enum_PacketID_StC_Invert[V] = K end
local Enum_PacketID_CtS_Invert = {}
for K, V in pairs(_G.Enum.PacketID_CtS) do Enum_PacketID_CtS_Invert[V] = K end

_G.Net = {

    -- RemoteEvent (сервер -> клиент)
    RemoteEvent_StC = nil,
    -- RemoteEvent (клиент -> сервер)
    RemoteEvent_CtS = nil,

    -- События для RemoteEvent (сервер -> клиент)
    Handlers_StC = {} :: {[number] : (any) -> ()},
    -- События для RemoteEvent (клиент -> сервер)
    Handlers_CtS = {} :: {[number] : (Player, any) -> ()},

    -- Запускает синхронизацию
    Launch = function()
        _G.Other.Try(function()
            _G.Net.RemoteEvent_StC = _G.Instance.GetOrCreate("RemoteEvent", "RemoteEvent_StC", _G.Game.Folders.Net)
            _G.Net.RemoteEvent_CtS = _G.Instance.GetOrCreate("RemoteEvent", "RemoteEvent_CtS", _G.Game.Folders.Net)

            if _G.Value.Info_ServerSide then
                _G.Net.RemoteEvent_CtS.OnServerEvent:Connect(function(Player : Player, PacketID : number, Data : any)
                    if _G.Value.Debug_Log_PacketGet >= (PacketID_CtS_Often[PacketID] and 2 or 1) then _G.Logger.Debug("Получен   пакет S🟧←- C🟦 [" .. Enum_PacketID_CtS_Invert[PacketID] .. "] | " .. Player.Name .. " | " .. tostring(Data)) end
                    local Handler = _G.Net.Handlers_CtS[PacketID]
                    if Handler then
                        Handler(Player, Data)
                    else
                        _G.Logger.Error("Вызван ивент CtS [" .. PacketID .. "], но Handler на такой ивент нету!")
                    end
                end)
            else
                _G.Net.RemoteEvent_StC.OnClientEvent:Connect(function(PacketID : number, Data : any)
                    if _G.Value.Debug_Log_PacketGet >= (PacketID_StC_Often[PacketID] and 2 or 1) then _G.Logger.Debug("Получен   пакет C🟦←- S🟧 [" .. Enum_PacketID_StC_Invert[PacketID] .. "] | " .. tostring(Data)) end
                    local Handler = _G.Net.Handlers_StC[PacketID]
                    if Handler then
                        Handler(Data)
                    else
                        _G.Logger.Error("Вызван ивент StC [" .. PacketID .. "], но Handler на такой ивент нету!")
                    end
                end)
            end
        end):Catch(function(e)
            _G.Logger.Error(e, "Произошла ошибка при синхронизации Net!")
        end)
    end,

    -- Сервер отправляет пакет клиенту
    Send_StC = function(Player : Player, PacketID : number, Data : any)
        if _G.Value.Info_ClientSide then _G.Logger.Error("Невозможно отправить пакет StC [" .. Enum_PacketID_StC_Invert[PacketID] .. "], потому-что вызывается на клиенте!") end
        if _G.Value.Debug_Log_PacketSend >= (PacketID_StC_Often[PacketID] and 2 or 1) then _G.Logger.Debug("Отправлен пакет S🟧 -→C🟦 [" .. Enum_PacketID_StC_Invert[PacketID] .. "] | " .. Player.Name .. " | " .. tostring(Data)) end
        _G.Net.RemoteEvent_StC:FireClient(Player, PacketID, Data)
    end,

    -- Клиент отправляет пакет серверу
    Send_CtS = function(PacketID : number, Data : any)
        if _G.Value.Info_ServerSide then _G.Logger.Error("Невозможно отправить пакет CtS [" .. Enum_PacketID_StC_Invert[PacketID] .. "], потому-что вызывается на сервере!") end
        if _G.Value.Debug_Log_PacketSend >= (PacketID_CtS_Often[PacketID] and 2 or 1) then _G.Logger.Debug("Отправлен пакет C🟦 -→S🟧 [" .. Enum_PacketID_CtS_Invert[PacketID] .. "] | " .. tostring(Data)) end
        _G.Net.RemoteEvent_CtS:FireServer(PacketID, Data)
    end,

    -- Соеденяет получение пакета сервер -> клиент
    Connect_StC = function(PacketID : number, Callback : (any) -> ())
        if _G.Value.Info_ServerSide then _G.Logger.Error("Невозможно сделать получение пакета StC [" .. Enum_PacketID_StC_Invert[PacketID] .. "], потому-что вызывается на сервере!") end
        _G.Net.Handlers_StC[PacketID] = Callback
    end,

    -- Соеденяет получение пакета клиент -> сервер
    Connect_CtS = function(PacketID : number, Callback : (Player, any) -> (), Often : boolean?)
        if _G.Value.Info_ClientSide then _G.Logger.Error("Невозможно сделать получение пакета CtS [" .. Enum_PacketID_StC_Invert[PacketID] .. "], потому-что вызывается на клиенте!") end
        _G.Net.Handlers_CtS[PacketID] = Callback
    end,

    -- Устанавливает владельца для обработки физики объекта
    SetPhysicOwner = function(Object : BasePart | Model, Player : Player?)
        _G.Other.Try(function()
            Object = _G.Physic.ModelPrimaryPartOrPart(Object)

            if _G.Value.Info_ClientSide then _G.Logger.Error("Владельца для обработки физики объекта можно устанавливать только на сервере!") end
            if Player == nil then
                Object:SetNetworkOwnershipAuto()
            else
                Object:SetNetworkOwner(Player)
            end
        end):Catch(function(e)
            _G.Logger.Warn(e, "Произошла ошибка в SetPhysicOwner!\nОбъект: " .. _G.Instance.Info(Object) .. "\nИгрок: " .. _G.Instance.Info(Player))
        end)
    end,

    -- ===========================================================================
    -- Упрощение

    -- Упрощает CFrame
    CFrameToSimple = function(Original : CFrame)
        if Original == nil then return -1 end
        local Position = Original.Position
        local P, Y, R = Original:ToEulerAnglesXYZ()
        return { Position.X, Position.Y, Position.Z, P, Y, R }
    end,

    -- Усложняет CFrame
    SimpleToCFrame = function(Simple) : CFrame
        if Simple == -1 then return nil end
        return CFrame.new(Simple[1], Simple[2], Simple[3]) * CFrame.Angles(Simple[4], Simple[5], Simple[6])
    end

}

return nil