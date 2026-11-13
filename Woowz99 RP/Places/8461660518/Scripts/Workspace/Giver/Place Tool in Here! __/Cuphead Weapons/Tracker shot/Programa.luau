-- Programa hecho por: VeryGood2 --

-- Configuraciones --
local Dolor = 10
local Velocidad = 150
local Distancia_de_deteccion = 100
-- Configuraciones --

-- Codigo --
local Herramienta = script.Parent
local Equipado = false
local Haciendo_click = true
local Disparando = false
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
		if Disparando == true then return end
		Haciendo_click = true
		Disparando = true
		Cateto.Particulas.Enabled = true
		repeat
			Cateto.Disparos:Play()
			Animacion_al_disparar:Play()
			local Laser = Instance.new("Part")
			Laser.Parent = Herramienta
			Laser.Name = "Laser"
			Laser.Size = Vector3.new(1,1,1)
			Laser.BrickColor = BrickColor.new("Lime green")
			Laser.CFrame = CFrame.new(Cateto.Position,Raton.Hit.p) * CFrame.new(0,0,-1.5) * CFrame.Angles(math.rad(math.random(-15,15))/5,math.rad(math.random(-15,15))/5,0)
			Laser.CanCollide = false
			Laser.Material = Enum.Material.Neon
			local Evento = Instance.new("BindableEvent")
			Evento.Name = "Buscar_objetivo"
			Evento.Parent = Laser
			local Modelo3D = Instance.new("SpecialMesh")
			Modelo3D.Name = "Modelo3D"
			Modelo3D.Parent = Laser
			Modelo3D.MeshId = "http://www.roblox.com/asset/?id=120647846"
			local Anti_gravedad = Instance.new("BodyForce")
			Anti_gravedad.Name = "Anti_gravedad"
			Anti_gravedad.Parent = Laser
			Anti_gravedad.Force = Vector3.new(0,138,0)
			local Impulso = Instance.new("BodyThrust")
			Impulso.Name = "Impulso"
			Impulso.Parent = Laser
			Impulso.Force = Vector3.new(0,0,-Velocidad)
			local Rotacion_angular = Instance.new("RocketPropulsion")
			Rotacion_angular.MaxSpeed = Velocidad/2
			Rotacion_angular.MaxTorque = Vector3.new(400000,400000,0)
			Rotacion_angular.MaxThrust = 500
			Rotacion_angular.Name = "Impulso_algular"
			Rotacion_angular.Parent = Laser
			Evento.Event:connect(function()
				local Objetivo_mas_cercano
				local Ticks = 0
				repeat wait(0.1)
					Objetivo_mas_cercano = nil
					local Distancia_mas_cercana = math.huge
					for _,Objeto in pairs(workspace:GetChildren()) do
						local Posible_humanoX = Objeto:FindFirstChildOfClass("Humanoid")
						local CatetoX = Objeto:FindFirstChild("HumanoidRootPart")
						if Objeto.ClassName == "Model" and Posible_humanoX and CatetoX and Posible_humanoX ~= Humano then
							local Calculo = (Laser.Position - CatetoX.Position).magnitude
							if Calculo < Distancia_mas_cercana and Calculo < Distancia_de_deteccion and Posible_humanoX.Health > 0 then
								Distancia_mas_cercana = Calculo
								Objetivo_mas_cercano = CatetoX
							end
						end
					end
					if Objetivo_mas_cercano then
						Impulso:remove()
						Rotacion_angular.Target = Objetivo_mas_cercano
						Rotacion_angular:Fire()
					end
					Ticks = Ticks + 1
				until Ticks > 35
			end)
			Evento:Fire()
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
			game.Debris:AddItem(Laser,3.5)
		wait(0.15) until Haciendo_click == false or Equipado == false or Humano.Health == 0
		Disparando = false
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