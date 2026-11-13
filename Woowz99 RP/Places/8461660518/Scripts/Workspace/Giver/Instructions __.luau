--[[

Instructions


	>Setting up the tool
		1.	Right click your tool and cut/ copy it.
		2.	Select the "Place Tool in Here! <<" object inside the "Giver" model
		3.	Paste
		4.	Done! You can make your giver give multiple tools.

	>Permissions
		1.	If you want to allow people to have multiple of the same tool, go into:
			
				Giver -> Button -> Script
			
			and  in the Settings section, change "allow_duplicates = false"
			to "allow_diplicates = true"
		2.	If you only want a certain team to be able to take these tools,
			go into Settings and add your team name in quotation marks next to "allow_team ={"
			The name has to appear in purple text in order to work.

			Example: 	allow_team ={"Blue Team"}
			
		3.	If you want multiple teams to have access, add a comma and in another set
			of quotations put the second team name. Continue for as many teams as you need.
			
			Example:	allow_team ={"Blue Team", "Red Team"}

	>Displayed Text
		1.	If you don't edit anything, the first tool's name (inside the folder) will be displayed.
			If you don't want this, you can change the name to what you want by changing:
			
				Giver -> Block -> NameDisplay -> TextLabel -> Text
			
			You can change the text color from here as well.
--]]