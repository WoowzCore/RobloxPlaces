-- By Woowz11

--!strict
--!optimize 2
--!native

_G.Instance = {

    -- Клонирует объект
    Clone = function(Original : Instance, NewParent : Instance?) : Instance
        local NewObject = Original:Clone()
        if NewParent ~= nil then NewObject.Parent = NewParent end
        return NewObject
    end,

    -- Создаёт объект
    Create = function(Object : string, Parent : Instance?, Name : string?) : Instance
        local Object = Instance.new(Object, Parent)
        if Name ~= nil then Object.Name = Name end
        return Object
    end,

    -- СПолучает или создаёт
    GetOrCreate = function(Object : string, Name : string, Parent : Instance?) : Instance
        if Parent then
            local ExistingObject = Parent:FindFirstChild(Name)
            if ExistingObject and ExistingObject.ClassName == Object then return ExistingObject end
        end

        return _G.Instance.Create(Object, Parent, Name)
    end,

    -- Получает объект у объекта, выдаёт ошибку если объекта нету
    Get = function(Object : Instance, Name : string) : Instance
        local Object__ = Object:FindFirstChild(Name)
        if Object__ == nil then _G.Logger.Error("Не найден объект [\"" .. Name .. "\"] у объекта [\"" .. tostring(Object) .. "\"]!") end
        return Object__
    end,

    -- Уничтожает объект если он есть
    Destroy = function(Object : Instance?)
        if Object ~= nil then Object:Destroy() end
    end,

    -- Выводит доп. информацию об объекте
    Info = function(Object : Instance) : string
        if Object == nil then return "nil" end

        if Object:IsA("Player") then
            return Object.Name .. " (" .. Object.UserId .. ")"
        elseif Object:IsA("BasePart") then
            return Object.Name .. " (" .. typeof(Object) .. ") [" .. tostring(Object.Color) .. ", " .. tostring(Object.Material) .. ", " .. tostring(Object.Parent) .. ", (" .. tostring(Object.Position) .. ")]"
        else
            return tostring(Object)
        end
    end

}

return nil