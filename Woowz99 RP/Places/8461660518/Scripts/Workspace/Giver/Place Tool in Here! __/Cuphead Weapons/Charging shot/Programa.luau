-- Programa hecho por: VeryGood2 --

-- Configuraciones --
local Poder_de_carga_comun = 24
local Poder_de_carga_completa = 208
local Tiempo_de_espera_para_carga = 1.25
local Velocidad = 300
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
	Funcion_principal = Raton.Button1Down:connect(function()
		Haciendo_click = true
		if Disparando then return end
		Cateto.Particulas.Enabled = true
		Disparando = true
		local Carga = 0
		repeat wait(0.1)
			Carga = Carga + 0.1
		until Carga > Tiempo_de_espera_para_carga or Haciendo_click == false
		if Carga > Tiempo_de_espera_para_carga then
			Cateto.Carga_completa.TimePosition = 0
			Cateto.Carga_completa:Play()
			Cateto.Completa.Enabled = true
			repeat if Equipado == false then Haciendo_click = false Disparando = false return end wait(0.1) until Haciendo_click == false
			Cateto.Disparo_laser_cargado:Play()
			local Laser = Instance.new("Part")
			Laser.Parent = Herramienta
			Laser.Name = "Laser"
			Laser.Size = Vector3.new(2.5,2.5,5)
			Laser.Color = Color3.fromRGB(141,81,21)
			Laser.CanCollide = false
			Laser.CFrame = CFrame.new(Cateto.Position,Raton.Hit.p) * CFrame.new(0,0,-2.5)
			Laser.Material = Enum.Material.Neon
			local Modelo3D = Instance.new("SpecialMesh")
			Modelo3D.Name = "Modelo3D"
			Modelo3D.Parent = Laser
			Modelo3D.MeshType = Enum.MeshType.Sphere
			local Anti_gravedad = Instance.new("BodyForce")
			Anti_gravedad.Name = "Anti_gravedad"
			Anti_gravedad.Parent = Laser
			Anti_gravedad.Force = Vector3.new(0,4300,0)
			local Impulso = Instance.new("BodyThrust")
			Impulso.Name = "Impulso"
			Impulso.Parent = Laser
			Impulso.Force = Vector3.new(0,0,-Velocidad*24)
			local Sonido = Instance.new("Sound")
			Sonido.Name = "Explosion"
			Sonido.Parent = Laser
			Sonido.Volume = 1
			Sonido.SoundId = "rbxassetid://926264402"
			Sonido.PlayOnRemove = true
			Laser.Touched:connect(function(ParteX)
				if ParteX.Transparency == 1 or ParteX.CanCollide == false or ParteX.Parent == Personaje or ParteX.Name == "Laser" then return end
				local Explosion = Instance.new("Explosion")
				Explosion.Parent = workspace
				Explosion.Name = "Explosion"
				Explosion.Position = Laser.Position
				Explosion.ExplosionType = Enum.ExplosionType.NoCraters
				Explosion.BlastRadius = 8
				Explosion.BlastPressure = 250000
				Explosion.DestroyJointRadiusPercent = 0
				Explosion.Hit:connect(function(ParteXI)
					local HumanoX = ParteXI.Parent:FindFirstChildOfClass("Humanoid")
					if HumanoX and HumanoX ~= Humano and HumanoX:FindFirstChild("Afectado") == nil then
						local Etiqueta = Instance.new("Folder")
						Etiqueta.Parent = HumanoX
						Etiqueta.Name = "Afectado"
						game.Debris:AddItem(Etiqueta,0.1)
						HumanoX:TakeDamage(Poder_de_carga_completa)
					end
				end)
				Laser:remove()
			end)
			game.Debris:AddItem(Laser,1.5)
		else
			Cateto.Disparo_laser_comun:Play()
			local Laser = Instance.new("Part")
			Laser.Parent = Herramienta
			Laser.Name = "Laser"
			Laser.Size = Vector3.new(0.5,0.5,2.5)
			Laser.Color = Color3.fromRGB(141,81,21)
			Laser.CFrame = CFrame.new(Cateto.Position,Raton.Hit.p) * CFrame.new(0,0,-1.25)
			Laser.CanCollide = false
			Laser.Material = Enum.Material.Neon
			local Modelo3D = Instance.new("SpecialMesh")
			Modelo3D.Name = "Modelo3D"
			Modelo3D.Parent = Laser
			Modelo3D.MeshType = Enum.MeshType.Sphere
			local Anti_gravedad = Instance.new("BodyForce")
			Anti_gravedad.Name = "Anti_gravedad"
			Anti_gravedad.Parent = Laser
			Anti_gravedad.Force = Vector3.new(0,86,0)
			local Impulso = Instance.new("BodyThrust")
			Impulso.Name = "Impulso"
			Impulso.Parent = Laser
			Impulso.Force = Vector3.new(0,0,-Velocidad/1.5)
			Laser.Touched:connect(function(ParteX)
				if ParteX.Transparency == 1 or ParteX.CanCollide == false or ParteX.Parent == Personaje or ParteX.Name == "Laser" then return end
				local HumanoX = ParteX.Parent:FindFirstChildOfClass("Humanoid")
				if HumanoX then
					HumanoX:TakeDamage(Poder_de_carga_comun)
				end
				local Posicion_de_impacto = Laser.CFrame * CFrame.new(0,0,-0.75)
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
			wait(0.1)
		end
		Disparando = false
		Cateto.Completa.Enabled = false
		Cateto.Particulas.Enabled = false
	end)
	Raton.Button1Up:connect(function()
		Haciendo_click = false
	end)
end)
Herramienta.Unequipped:connect(function()
	Equipado = false
	Animacion_al_equipar:Stop()
	Cateto.Completa.Enabled = false
	Cateto.Particulas.Enabled = false
	Funcion_principal:disconnect()
end)
-- Codigo --