-- Parte 1: Inicialização e Login
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local password = "stormdownn"

local loginScreen = Instance.new("ScreenGui", game.CoreGui)
loginScreen.Name = "StormdownnLogin"

local blur = Instance.new("BlurEffect", game:GetService("Lighting"))
blur.Size = 20

local frame = Instance.new("Frame", loginScreen)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Active = true
frame.Draggable = true
frame.Name = "LoginFrame"
frame.ClipsDescendants = true

local title = Instance.new("TextLabel", frame)
title.Text = "StormdownnHub Login"
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(0, 0, 0)

local input = Instance.new("TextBox", frame)
input.Size = UDim2.new(0.8, 0, 0.3, 0)
input.Position = UDim2.new(0.1, 0, 0.4, 0)
input.PlaceholderText = "Enter password"
input.Font = Enum.Font.Gotham
input.TextSize = 16
input.TextColor3 = Color3.fromRGB(0, 0, 0)
input.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
input.ClearTextOnFocus = false
input.Text = ""
input.TextScaled = true

local button = Instance.new("TextButton", frame)
button.Text = "Login"
button.Size = UDim2.new(0.5, 0, 0.2, 0)
button.Position = UDim2.new(0.25, 0, 0.75, 0)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 18
button.TextScaled = true

button.MouseButton1Click:Connect(function()
	if input.Text:lower() == password then
		loginScreen:Destroy()
		blur:Destroy()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/stormdownn/StormdownnHub/main/core_interface.lua"))()
	end
end)
