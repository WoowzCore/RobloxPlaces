local character = script.Parent
wait(1)
-- Arms
character.LeftUpperArm.Material = "Ice"
character.RightUpperArm.Material = "Ice"
character.LeftLowerArm.Material = "Ice"
character.RightLowerArm.Material = "Ice"
-- Hands
character.LeftHand.Material = "Ice"
character.RightHand.Material = "Ice"
-- Legs
character.LeftUpperLeg.Material = "Ice"
character.RightUpperLeg.Material = "Ice"
character.LeftLowerLeg.Material = "Ice"
character.RightLowerLeg.Material = "Ice"
-- Foots
character.LeftFoot.Material = "Ice"
character.RightFoot.Material = "Ice"
-- Torso
character.UpperTorso.Material = "Ice"
character.LowerTorso.Material = "Ice"
character.HumanoidRootPart.Material = "Ice"
character.Head.Material = "Ice"
-- Physics

-- Torso

character.HumanoidRootPart.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,1)
character.UpperTorso.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,5)
character.LowerTorso.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,5)

-- Arm And Leg

character.LeftUpperArm.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,1)
character.RightUpperArm.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,1)
character.RightUpperLeg.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,1)
character.LeftUpperLeg.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,1)
character.Head.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,1)
character.RightLowerLeg.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,1)
character.RightLowerArm.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,1)
character.LeftLowerLeg.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,1)
character.LeftLowerArm.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,1)
character.RightHand.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,1)
character.LeftHand.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,1)
character.RightFoot.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,1)
character.LeftFoot.CustomPhysicalProperties = PhysicalProperties.new(1,2,1,20,1)


-- Ragdoll On
wait(1)
local UTJoint = character.UpperTorso:FindFirstChild("WaistRigAttachment")
local LTJoint = character.LowerTorso:FindFirstChild("WaistRigAttachment")
-- Head
local Neck = character.UpperTorso:FindFirstChild("NeckRigAttachment")
local Head = character.Head:FindFirstChild("NeckRigAttachment")
-- Right Arms
local RUA = character.UpperTorso:FindFirstChild("RightShoulderRigAttachment")
local RUARig = character.RightUpperArm:FindFirstChild("RightShoulderRigAttachment")
local RLA = character.RightUpperArm:FindFirstChild("RightElbowRigAttachment")
local RLARig = character.RightLowerArm:FindFirstChild("RightElbowRigAttachment")
local RH = character.RightLowerArm:FindFirstChild("RightWristRigAttachment")
local RHRig = character.RightHand:FindFirstChild("RightWristRigAttachment")
-- Left Arms
local LUA = character.UpperTorso:FindFirstChild("LeftShoulderRigAttachment")
local LUARig = character.LeftUpperArm:FindFirstChild("LeftShoulderRigAttachment")
local LLA = character.LeftUpperArm:FindFirstChild("LeftElbowRigAttachment")
local LLARig = character.LeftLowerArm:FindFirstChild("LeftElbowRigAttachment")
local LH = character.LeftLowerArm:FindFirstChild("LeftWristRigAttachment")
local LHRig = character.LeftHand:FindFirstChild("LeftWristRigAttachment")
--Left Legs
local LUL = character.LowerTorso:FindFirstChild("LeftHipRigAttachment")
local LULRig = character.LeftUpperLeg:FindFirstChild("LeftHipRigAttachment")
local LLL = character.LeftUpperLeg:FindFirstChild("LeftKneeRigAttachment")
local LLLRig = character.LeftLowerLeg:FindFirstChild("LeftKneeRigAttachment")
local LF = character.LeftLowerLeg:FindFirstChild("LeftAnkleRigAttachment")
local LFRig = character.LeftFoot:FindFirstChild("LeftAnkleRigAttachment")
--Right Legs
local RUL = character.LowerTorso:FindFirstChild("RightHipRigAttachment")
local RULRig = character.RightUpperLeg:FindFirstChild("RightHipRigAttachment")
local RLL = character.RightUpperLeg:FindFirstChild("RightKneeRigAttachment")
local RLLRig = character.RightLowerLeg:FindFirstChild("RightKneeRigAttachment")
local RF = character.RightLowerLeg:FindFirstChild("RightAnkleRigAttachment")
local RFRig = character.RightFoot:FindFirstChild("RightAnkleRigAttachment")
--Hand
local RHL = character.RightHand:FindFirstChild("RightWristRigAttachment")
local RHR = character.LeftHand:FindFirstChild("LeftWristRigAttachment")




-- Torso
character.Constraint.ConstraintUpperTorso.Attachment0 = UTJoint
character.Constraint.ConstraintUpperTorso.Attachment1 = LTJoint
-- Head
character.Constraint.ConstraintHead.Attachment0 = Neck
character.Constraint.ConstraintHead.Attachment1 = Head
-- Right Arms
character.Constraint.ConstraintRightUpperArm.Attachment0 = RUA
character.Constraint.ConstraintRightUpperArm.Attachment1 = RUARig
character.Constraint.ConstraintRightLowerArm.Attachment0 = RLA
character.Constraint.ConstraintRightLowerArm.Attachment1 = RLARig
character.Constraint.ConstraintRightHand.Attachment0 = RH
character.Constraint.ConstraintRightHand.Attachment1 = RHRig
-- Left Arms
character.Constraint.ConstraintLeftUpperArm.Attachment0 = LUA
character.Constraint.ConstraintLeftUpperArm.Attachment1 = LUARig
character.Constraint.ConstraintLeftLowerArm.Attachment0 = LLA
character.Constraint.ConstraintLeftLowerArm.Attachment1 = LLARig
character.Constraint.ConstraintLeftHand.Attachment0 = LH
character.Constraint.ConstraintLeftHand.Attachment1 = LHRig
-- Left Legs
character.Constraint.ConstraintLeftUpperLeg.Attachment0 = LUL
character.Constraint.ConstraintLeftUpperLeg.Attachment1 = LULRig
character.Constraint.ConstraintLeftLowerLeg.Attachment0 = LLL
character.Constraint.ConstraintLeftLowerLeg.Attachment1 = LLLRig
character.Constraint.ConstraintLeftFoot.Attachment0 = LF
character.Constraint.ConstraintLeftFoot.Attachment1 = LFRig
-- Right Legs
character.Constraint.ConstraintRightUpperLeg.Attachment0 = RUL
character.Constraint.ConstraintRightUpperLeg.Attachment1 = RULRig
character.Constraint.ConstraintRightLowerLeg.Attachment0 = RLL
character.Constraint.ConstraintRightLowerLeg.Attachment1 = RLLRig
character.Constraint.ConstraintRightFoot.Attachment0 = RF
character.Constraint.ConstraintRightFoot.Attachment1 = RFRig
--Hand
character.Constraint.ConstraintHand.Attachment1 = RHR
character.Constraint.ConstraintHand.Attachment0 = RHL
--Blood On
character.Constraint.Blood.Parent = character.UpperTorso
character.Constraint.Damage.Parent = character.UpperTorso