-- How to install
-- Put the "[FE+] Pedals" script into the Plugins folder
-- Move the "BP","CP" and "GP" groups to fit the interior, and put them in the Misc group
-- Copy and paste the following into MiscWeld under initialize.

MakeWeld(misc.BP.SS,car.DriveSeat,"Motor",.1)
ModelWeld(misc.BP.Parts,misc.BP.SS)
MakeWeld(misc.GP.SS,car.DriveSeat,"Motor",.1)
ModelWeld(misc.GP.Parts,misc.GP.SS)
MakeWeld(misc.CP.SS,car.DriveSeat,"Motor",.1)
ModelWeld(misc.CP.Parts,misc.CP.SS)

-- Enjoy your working pedals and shifting sound! -Mayonez_Mercenary