-- Programa hecho por: VeryGood2 --

-- Configuraciones --
local Dolor = 16
local Velocidad = 250
-- Configuraciones --

-- Codigo --
local Herramienta = script.Parent
local Equipado = false
local Haciendo_click = true
local Cateto
local Jugador = game.Players.LocalPlayer
local Personaje
local Humano
repeat wait() Personaje = Jugador.Character until Personaje
repeat wait() Humano = Personaje:FindFirstChildOfClass("Humanoid") until Humano
repeat wait() Cateto = Herramienta:FindFirstChild("Handle") until Cateto
local Animacion_al_equipar = Humano:LoadAnimation(script.Equipado)
local Animacion_al_disparar = Humano:LoadAnimation(script.Disparo)
Herramienta.Handle:WaitForChild("Mesh"):remove()
Herramienta.Handle.Size = Vector3.new(0.2,0.2,0.2)
Herramienta.Handle.Transparency = 1
Herramienta.Parent = Jugador.Backpack

Herramienta.Equipped:connect(function(Raton)
	Equipado = true
	Animacion_al_equipar:Play()
	Raton.Button1Down:connect(function()
		if Haciendo_click == true then return end
		Haciendo_click = true
		Cateto.Disparos:Play()
		Cateto.Particulas.Enabled = true
		repeat
			Animacion_al_disparar:Play()
			local Laser = Instance.new("Part")
			Laser.Parent = Herramienta
			Laser.Name = "Laser"
			Laser.Size = Vector3.new(0.5,0.5,3)
			Laser.BrickColor = BrickColor.new("Toothpaste")
			Laser.CFrame = CFrame.new(Cateto.Position,Raton.Hit.p) * CFrame.new(0,0,-1.5) * CFrame.Angles(math.rad(math.random(-3,3))/5,math.rad(math.random(-3,3))/5,0)
			Laser.CanCollide = false
			Laser.Material = Enum.Material.Neon
			local Modelo3D = Instance.new("SpecialMesh")
			Modelo3D.Name = "Modelo3D"
			Modelo3D.Parent = Laser
			Modelo3D.MeshType = Enum.MeshType.Sphere
			local Anti_gravedad = Instance.new("BodyForce")
			Anti_gravedad.Name = "Anti_gravedad"
			Anti_gravedad.Parent = Laser
			Anti_gravedad.Force = Vector3.new(0,105,0)
			local Impulso = Instance.new("BodyThrust")
			Impulso.Name = "Impulso"
			Impulso.Parent = Laser
			Impulso.Force = Vector3.new(0,0,-Velocidad)
			Laser.Touched:connect(function(ParteX)
				if ParteX.Transparency == 1 or ParteX.CanCollide == false or ParteX.Parent == Personaje or ParteX.Name == "Laser" then return end
				local HumanoX = ParteX.Parent:FindFirstChildOfClass("Humanoid")
				if HumanoX then
					HumanoX:TakeDamage(Dolor)
				end
				local Posicion_de_impacto = Laser.CFrame * CFrame.new(0,0,-1)
				local Punto_de_impacto = Instance.new("Part")
				Punto_de_impacto.Parent = workspace
				Punto_de_impacto.Name = "Punto_de_impacto"
				Punto_de_impacto.Size = Vector3.new(0.2,0.2,0.2)
				Punto_de_impacto.CFrame = Posicion_de_impacto
				Punto_de_impacto.Anchored = true
				Punto_de_impacto.Transparency = 1
				Punto_de_impacto.CanCollide = false
				local Particulas = Cateto.Impacto:Clone()
				Particulas.Parent = Punto_de_impacto
				Particulas.Enabled = true
				game.Debris:AddItem(Punto_de_impacto,0.15)
				Laser:remove()
			end)
			game.Debris:AddItem(Laser,1)
		wait(0.1) until Haciendo_click == false or Equipado == false or Humano.Health == 0
		Cateto.Particulas.Enabled = false
		Animacion_al_disparar:Stop()
		Cateto.Disparos:Stop()
	end)
	Raton.Button1Up:connect(function()
		Haciendo_click = false
	end)
end)
Herramienta.Unequipped:connect(function()
	Equipado = false
	Animacion_al_equipar:Stop()
end)
-- Codigo --