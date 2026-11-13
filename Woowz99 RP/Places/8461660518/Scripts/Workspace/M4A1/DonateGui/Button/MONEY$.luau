local productId = 192030868
local player = game.Players.LocalPlayer

script.Parent.MouseButton1Click:connect(function()
	script.Parent.Sound:Play()
	game:GetService("MarketplaceService"):PromptPurchase(player, productId)
end)
