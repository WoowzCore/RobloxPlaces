-- By Woowz11

--!strict
--!optimize 2
--!native

local Terrain = workspace.Terrain
local Camera  = workspace.CurrentCamera

-- Создано элементов
local Created = 0

local LinePool   = {}
local LineActive = {}

local PointPool   = {}
local PointActive = {}

local ModelPool   = {}
local ModelActive = {}

-- Получить линию из пула
local GetLine = function() : LineHandleAdornment
    local Line : LineHandleAdornment = table.remove(LinePool)

    if Line then return Line end

    Line = _G.Instance.Create("LineHandleAdornment", _G.Game.Folders.Gizmos, "Line " .. Created)
    Created += 1

    Line.AlwaysOnTop = true
    Line.AdornCullingMode = Enum.AdornCullingMode.Automatic
    Line.Visible = false
    Line.Adornee = Terrain
    Line.ZIndex = -1

    return Line
end

-- Получить линию из пула
local GetPoint = function() : SphereHandleAdornment
    local Point : SphereHandleAdornment = table.remove(PointPool)

    if Point then return Point end

    Point = _G.Instance.Create("SphereHandleAdornment", _G.Game.Folders.Gizmos, "Point " .. Created)
    Created += 1

    Point.AlwaysOnTop = true
    Point.AdornCullingMode = Enum.AdornCullingMode.Automatic
    Point.Visible = false
    Point.Adornee = Terrain
    Point.ZIndex = -1

    return Point
end

-- Получить модель из пула
local GetModel = function() : Part
    local Model : Part = table.remove(ModelPool)

    if Model then return Model end

    Model = _G.Instance.Create("Part", _G.Game.Folders.Gizmos, "Model " .. Created)
    Created += 1

    Model.CastShadow = false
    Model.Material = Enum.Material.Neon
    Model.Anchored = true
    Model.CanCollide = false
    Model.CanTouch = false
    Model.AudioCanCollide = false
    Model.CanQuery = false
    Model.EnableFluidForces = false
    Model.Massless = true
    Model.Locked = true
    Model.Transparency = 1

    return Model
end

_G.Gizmos = {

    -- Можно рисовать?
    NotCanDraw =_G.Value.Info_ServerSide and not _G.Value.Info_StudioSide,

    -- Рисует линию
    Line = function(Start : Vector3, End : Vector3, Color : Color3?, Transparent : number?, Thickness : number?, CameraAutoSize : boolean?) : LineHandleAdornment
        if _G.Gizmos.NotCanDraw then return end
        
        local Line = GetLine()
        Line.Parent = _G.Game.Folders.GizmosU
        table.insert(LineActive, Line)

        Thickness = Thickness or 10

        if CameraAutoSize == nil then CameraAutoSize = true end

        if CameraAutoSize then
            Thickness *= 0.075
            Thickness *= (Camera.CFrame.Position - ((Start + End) * 0.5)).Magnitude
        end

        Line.Visible = true
        Line.Thickness = Thickness
        Line.Color3 = Color or Color3.new(1, 1, 1)
        Line.Transparency = Transparent or 0

        local Direction = End - Start
        Line.CFrame = CFrame.lookAt(Start, End)
        Line.Length = Direction.Magnitude

        return Line
    end,

    -- Рисует точку
    Point = function(Position : Vector3, Color : Color3?, Transparent : number?, Diameter : number?, CameraAutoSize : boolean?) : SphereHandleAdornment
        if _G.Gizmos.NotCanDraw then return end

        local Point = GetPoint()
        Point.Parent = _G.Game.Folders.GizmosU
        table.insert(PointActive, Point)

        Diameter = Diameter or 10

        if CameraAutoSize == nil then CameraAutoSize = true end
        
        if CameraAutoSize then
            Diameter *= 0.001
            Diameter *=(Camera.CFrame.Position - Position).Magnitude
        end

        Point.Visible = true
        Point.Radius = Diameter * 0.5
        Point.Color3 = Color or Color3.new(1, 1, 1)
        Point.Transparency = Transparent or 0

        Point.CFrame = CFrame.new(Position)

        return Point
    end,

    -- Рисует парт
    Part = function(Original : BasePart, Position : Vector3?, Color : Color3?)
        if _G.Gizmos.NotCanDraw then return end

        local P, Y, R = Original.CFrame:ToEulerAnglesXYZ()
        _G.Gizmos.Model(Position or Original.Position, Vector3.new(P, Y, R), Original.Size, Color or Original.Color)
    end,

    -- Рисует модель
    Model = function(Position : Vector3, Rotation : Vector3, Size : Vector3, Color : Color3) : MeshPart
        if _G.Gizmos.NotCanDraw then return end

        local Model = GetModel()
        Model.Parent = _G.Game.Folders.GizmosU
        table.insert(ModelActive, Model)

        Model.Transparency = 0
        Model.CFrame = CFrame.new(Position) * CFrame.Angles(Rotation.X, Rotation.Y, Rotation.Z)
        Model.Size = Size
        Model.Color = Color

        return Model
    end,

    -- Рисует RaycastResult
    CastResult = function(CastResult : RaycastResult?, Color : Color3?, Transparent : number?, Size : number?, NormalColor : Color3?, NormalLength : number?, CameraAutoSize : boolean?)
        if _G.Gizmos.NotCanDraw then return end
        
        if CastResult == nil then return end

        if CameraAutoSize == nil then CameraAutoSize = false end
        
        Size = Size or 0.1
        NormalLength = Size * (NormalLength or 10)
        
        --[[if CameraAutoSize then
            NormalLength *= 0.001
            NormalLength *= (__Camera.CFrame.Position - CastResult.Position).Magnitude
        end]]

        _G.Gizmos.Point(CastResult.Position, Color, Transparent, Size, CameraAutoSize)
        _G.Gizmos.Line (CastResult.Position, CastResult.Position + CastResult.Normal * NormalLength, NormalColor or Color3.new(0,0,1), Transparent, Size * 100, CameraAutoSize)
    end,

    -- Уничтожает всё нарисованное
    ClearAll = function()
        if _G.Gizmos.NotCanDraw then return end

        for i = 1, #LineActive do
            local Line = LineActive[i]
            Line.Visible = false
            Line.Parent = _G.Game.Folders.Gizmos
            table.insert(LinePool, Line)
        end
        table.clear(LineActive)

        for i = 1, #PointActive do
            local Point = PointActive[i]
            Point.Visible = false
            Point.Parent = _G.Game.Folders.Gizmos
            table.insert(PointPool, Point)
        end
        table.clear(PointActive)

        for i = 1, #ModelActive do
            local Model = ModelActive[i]
            Model.Transparency = 1
            Model.Parent = _G.Game.Folders.Gizmos
            table.insert(ModelPool, Model)
        end
        table.clear(ModelActive)
    end

}

return nil