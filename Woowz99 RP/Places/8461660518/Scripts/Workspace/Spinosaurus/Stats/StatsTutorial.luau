-------------------------------------------------
-- Customizable Dinosaur AI by Cat67383 --
-------------- Written 1/15/2022 --------------
-------------------------------------------------

---------------------
-- STATS VALUES --
---------------------

-- ATTACK: How much damage the dinosaur will inflict on enemies

-- DEFENSE: How much damage is removed from the damage caused by an attack (if a dinosaur with 100 damage attacks a dinosaur with 25 defense, the dinosaur would only take 75 damage)

-- DOMINANCE: Part of the social system, the most dominant dinosaur is the alpha of the territory. Dominance increases when a dinosaur wins a fight and decreases when
-- it loses. Dominance does not affect the strength of a dinosaur and does not make it any less likely to win fights.

-- DEFAULT DEFENSE: Starts off the same as Defense and then never changes. Also a cap for how much defense a dinosaur can grow.

-- DIET: What the dinosaur eats (can ONLY be "Herbivore", "Carnivore", or "Omnivore".)

-- SPRINT/WALK SPEED: How fast the dinosaur will move while sprinting or walking.

-- REGEN RATE: How much health is recovered per second (while not in combat). Default is 0.25, but for hybrid dinosaurs it is recommended that you set this to 1.

-----------------------------
-- HOW THE AI WORKS --
-----------------------------
-- Food is how much food the dinosaur has left (when it is at 0, it will stop decreasing and the dinosaur will take damage)
-- Appetite is how much food is lost per second, and also how much damage the dinosaur will take per second if its food is at 0.
-- All dinosaurs have 100 health. Health regenerates while the dinosaur is not in combat.
-- If a dinosaur's food is low, it will hunt humans and other dinosaurs.
-- Herbivores can ONLY get food from eating off the floor and will not hunt for food, but can fight carnivores attacking them. Carnivores can ONLY get food from other dinosaurs.
-- Omnivores are able to both eat grass and get food from killing players.
-- Piscivores will NOT be added, so if you have a Spinosaurus, Baryonyx or Suchomimus, set the Diet to Carnivore.

-- WARNING: THE DINOSAUR MUST HAVE A HUMANOIDROOTPART, ALL WORKING ANIMATIONS, AND GROWL, HIT, ROAR AND HURT SOUNDS IN THE HUMANOIDROOTPART.
-- IT ALSO REQUIRES THE STATS FOLDER, THIS SCRIPT, A HUMANOID, THE AI, AND THE FIXDAMAGE SCRIPT.
-- IF IT DOES NOT HAVE ALL OF THESE REQUIREMENTS, IT WILL NOT WORK.

--------------------------------------------------------------------------------------
-- this fixes the sprint speed if it's below the walk speed (DO NOT TOUCH) --
--------------------------------------------------------------------------------------
if script.Parent.WalkSpeed.Value==0 or script.Parent.WalkSpeed.Value<0 then
	script.Parent.WalkSpeed.Value=1
end
if script.Parent.SprintSpeed.Value<script.Parent.WalkSpeed.Value then
	script.Parent.SprintSpeed.Value=script.Parent.WalkSpeed.Value+1
end