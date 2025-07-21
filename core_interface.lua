-- Parte 2: Interface principal
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "StormdownnHubUI"

local mainFrame = Instance.new("Frame", gui)
mainFrame.Name = "MainPanel"
mainFrame.Size = UDim2.new(0, 450, 0, 300)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true

local scriptsScroll = Instance.new("ScrollingFrame", mainFrame)
scriptsScroll.Size = UDim2.new(1, 0, 1, -40)
scriptsScroll.Position = UDim2.new(0, 0, 0, 40)
scriptsScroll.CanvasSize = UDim2.new(0, 0, 5, 0)
scriptsScroll.ScrollBarThickness = 6
scriptsScroll.BackgroundTransparency = 1

local function createButton(text, callback)
	local btn = Instance.new("TextButton", scriptsScroll)
	btn.Size = UDim2.new(0.9, 0, 0, 40)
	btn.Position = UDim2.new(0.05, 0, 0, (#scriptsScroll:GetChildren() - 1) * 45)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 18
	btn.TextScaled = true
	btn.MouseButton1Click:Connect(callback)
end

createButton("Ring Parts", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/stormdownn/StormdownnHub/main/scripts/ringparts.lua"))()
end)

createButton("Magnet", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/stormdownn/StormdownnHub/main/scripts/magnet.lua"))()
end)

local settingsButton = Instance.new("ImageButton", mainFrame)
settingsButton.Name = "SettingsBtn"
settingsButton.Size = UDim2.new(0, 32, 0, 32)
settingsButton.Position = UDim2.new(1, -40, 0, 5)
settingsButton.Image = "rbxassetid://6031280882"
settingsButton.BackgroundTransparency = 1
settingsButton.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/stormdownn/StormdownnHub/main/core_settings.lua"))()
end)
