


function onClicked()
script.Parent.ClickDetector.MaxActivationDistance=0
script.Parent.Parent.Core.A:Play()
script.Parent.BrickColor=BrickColor.new("Bright red")
wait(10)
script.Parent.Parent.Door.CanCollide=true
script.Parent.Parent.Door.Transparency=0
script.Parent.Parent.Core.A:Stop()
script.Parent.Parent.Core.B:Play()
script.Parent.Parent.Motor.BodyAngularVelocity.AngularVelocity=Vector3.new(0,0.2,0)
wait(10)
script.Parent.Parent.Core.Decoupler:Play()
script.Parent.Parent.Booster.Engine1.ParticleEmitter.Enabled=true
script.Parent.Parent.Booster.Engine1.Smoke.Enabled=true
script.Parent.Parent.Booster.Engine2.ParticleEmitter.Enabled=true
script.Parent.Parent.Booster.Engine2.Smoke.Enabled=true
script.Parent.Parent.Booster.Engine3.ParticleEmitter.Enabled=true
script.Parent.Parent.Booster.Engine3.Smoke.Enabled=true
script.Parent.Parent.Booster.Engine4.ParticleEmitter.Enabled=true
script.Parent.Parent.Booster.Engine4.Smoke.Enabled=true
script.Parent.Parent.Core.C:Play()
script.Parent.Parent.E1.BrickColor=BrickColor.new("Lime green")
for i = -2, 75,1 do
wait(0.1)
script.Parent.Parent.Core.BodyVelocity.Velocity=Vector3.new(0,i,0)
end
wait(1)

wait(30)
script.Parent.Parent.Booster.Engine1.ParticleEmitter.Enabled=false
script.Parent.Parent.Booster.Engine1.Smoke.Enabled=false
script.Parent.Parent.Booster.Engine2.ParticleEmitter.Enabled=false
script.Parent.Parent.Booster.Engine2.Smoke.Enabled=false
script.Parent.Parent.Booster.Engine3.ParticleEmitter.Enabled=false
script.Parent.Parent.Booster.Engine3.Smoke.Enabled=false
script.Parent.Parent.Booster.Engine4.ParticleEmitter.Enabled=false
script.Parent.Parent.Booster.Engine4.Smoke.Enabled=false
script.Parent.Parent.Core.C:Stop()
script.Parent.Parent.E1.BrickColor=BrickColor.new("Really red")
wait(0.5)
script.Parent.Parent.Core.Decoupler:Play()
script.Parent.Parent.Joint1:Destroy()
script.Parent.Parent.Joint2:Destroy()
script.Parent.Parent.Joint3:Destroy()
script.Parent.Parent.Joint4:Destroy()
wait(0.1)
script.Parent.Parent.Engine5.ParticleEmitter.Enabled=true
script.Parent.Parent.Core.D:Play()
script.Parent.Parent.Core.BodyVelocity.Velocity=Vector3.new(0,100,0)
script.Parent.Parent.E2.BrickColor=BrickColor.new("Lime green")
wait(60)
script.Parent.Parent.Engine5.ParticleEmitter.Enabled=false
script.Parent.Parent.Core.D:Stop()
script.Parent.BrickColor=BrickColor.new("Deep orange")
script.Parent.Parent.E2.BrickColor=BrickColor.new("Really red")
wait(1)
script.Parent.Parent.Joint5:BreakJoints()
script.Parent.Parent.Core.Decoupler:Play()
wait(5)
script.Parent.Parent.Core.E:Play()
script.Parent.Parent.Engine6.ParticleEmitter.Enabled=true
script.Parent.Parent.Core.BodyVelocity.Velocity=Vector3.new(0,125,0)
script.Parent.Parent.E3.BrickColor=BrickColor.new("Lime green")
end
  
  script.Parent.ClickDetector.MouseClick:connect(onClicked)

