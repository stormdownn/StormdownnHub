
--// StormdownnHub V1 - Script Principal

----------------------------
--==[ PARTE 1: TELA DE LOGIN ]==--
----------------------------

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local password = "stormdownn"

local gui = player:WaitForChild("PlayerGui")
local existingLoginGui = gui:FindFirstChild("StormdownnHub_Login")
if existingLoginGui then existingLoginGui:Destroy() end

local loginGui = Instance.new("ScreenGui", gui)
loginGui.Name = "StormdownnHub_Login"
loginGui.ResetOnSpawn = false

local frame = Instance.new("Frame", loginGui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Text = "StormdownnHub Login"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Size = UDim2.new(1, 0, 0, 40)
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1

local input = Instance.new("TextBox", frame)
input.PlaceholderText = "Digite a senha..."
input.Font = Enum.Font.Gotham
input.TextSize = 16
input.Size = UDim2.new(0.9, 0, 0, 40)
input.Position = UDim2.new(0.05, 0, 0.4, 0)
input.TextColor3 = Color3.new(1, 1, 1)
input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local inputCorner = Instance.new("UICorner", input)
inputCorner.CornerRadius = UDim.new(0, 8)

local button = Instance.new("TextButton", frame)
button.Text = "Entrar"
button.Font = Enum.Font.GothamBold
button.TextSize = 16
button.Size = UDim2.new(0.5, 0, 0, 35)
button.Position = UDim2.new(0.25, 0, 0.7, 0)
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local buttonCorner = Instance.new("UICorner", button)
buttonCorner.CornerRadius = UDim.new(0, 8)

button.MouseButton1Click:Connect(function()
	if input.Text == password then
		loginGui:Destroy()
		loadMainHub()
	else
		button.Text = "Senha incorreta!"
		wait(1)
		button.Text = "Entrar"
	end
end)

----------------------------
--==[ PARTE 2: INTERFACE PRINCIPAL E BOTÕES ]==--
----------------------------

function loadMainHub()
	local HttpService = game:GetService("HttpService")
	local Lighting = game:GetService("Lighting")

	local existingGui = player:FindFirstChild("PlayerGui"):FindFirstChild("StormdownnHub_Main")
	if existingGui then existingGui:Destroy() end

	local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
	ScreenGui.Name = "StormdownnHub_Main"
	ScreenGui.ResetOnSpawn = false

	local Background = Instance.new("ImageLabel", ScreenGui)
	Background.Name = "Background"
	Background.Size = UDim2.new(1, 0, 1, 0)
	Background.Position = UDim2.new(0, 0, 0, 0)
	Background.Image = "rbxassetid://15327849226" -- Aizawa
	Background.ImageTransparency = 0.5
	Background.ScaleType = Enum.ScaleType.Crop
	Background.ZIndex = 0

	local BlurEffect = Instance.new("BlurEffect")
	BlurEffect.Size = 12
	BlurEffect.Parent = Lighting

	local MainFrame = Instance.new("Frame", ScreenGui)
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 400, 0, 350)
	MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
	MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	MainFrame.BackgroundTransparency = 0.2
	MainFrame.BorderSizePixel = 0
	MainFrame.Active = true
	MainFrame.Draggable = true

	local UICorner = Instance.new("UICorner", MainFrame)
	UICorner.CornerRadius = UDim.new(0, 12)

	local Title = Instance.new("TextLabel", MainFrame)
	Title.Text = "StormdownnHub V1"
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 22
	Title.Size = UDim2.new(1, 0, 0, 40)
	Title.BackgroundTransparency = 1
	Title.TextColor3 = Color3.new(1, 1, 1)

	local UIListLayout = Instance.new("UIListLayout", MainFrame)
	UIListLayout.Padding = UDim.new(0, 8)
	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

	local Spacer = Instance.new("Frame", MainFrame)
	Spacer.Size = UDim2.new(1, 0, 0, 45)
	Spacer.BackgroundTransparency = 1

	local function createToggleButton(name)
		local button = Instance.new("TextButton", MainFrame)
		button.Name = name .. "_Button"
		button.Size = UDim2.new(0.9, 0, 0, 35)
		button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		button.TextColor3 = Color3.new(1, 1, 1)
		button.Text = name .. ": OFF"
		button.Font = Enum.Font.Gotham
		button.TextSize = 16

		local corner = Instance.new("UICorner", button)
		corner.CornerRadius = UDim.new(0, 6)

		local active = false
		button.MouseButton1Click:Connect(function()
			active = not active
			button.Text = name .. ": " .. (active and "ON" or "OFF")
			if name == "Fly" then
				print("Fly toggled:", active)
			end
		end)
	end

	local features = {
		"Fly", "NoClip", "ESP", "KillPlayers", "WalkFling", "PuxarPlayer",
		"EmotesR6", "EmotesR15", "RingParts", "Magnet", "LagOthers", "Telekinesis"
	}

	for _, feature in ipairs(features) do
		createToggleButton(feature)
	end

	local SettingsButton = Instance.new("TextButton", ScreenGui)
	SettingsButton.Name = "SettingsButton"
	SettingsButton.Text = "⚙️"
	SettingsButton.Font = Enum.Font.GothamBold
	SettingsButton.TextSize = 22
	SettingsButton.TextColor3 = Color3.new(1, 1, 1)
	SettingsButton.Size = UDim2.new(0, 40, 0, 40)
	SettingsButton.Position = UDim2.new(1, -50, 1, -50)
	SettingsButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	SettingsButton.ZIndex = 3

	local corner = Instance.new("UICorner", SettingsButton)
	corner.CornerRadius = UDim.new(1, 0)

	SettingsButton.MouseButton1Click:Connect(function()
		loadSettings()
	end)
end

----------------------------
--==[ PARTE 3: TELA DE CONFIGURAÇÕES ]==--
----------------------------

function loadSettings()
	local gui = player:WaitForChild("PlayerGui")
	local existing = gui:FindFirstChild("StormdownnHub_Settings")
	if existing then existing:Destroy() end

	local ScreenGui = Instance.new("ScreenGui", gui)
	ScreenGui.Name = "StormdownnHub_Settings"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local Frame = Instance.new("Frame", ScreenGui)
	Frame.Size = UDim2.new(0, 350, 0, 300)
	Frame.Position = UDim2.new(0.5, -175, 0.5, -150)
	Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Frame.BackgroundTransparency = 0.1
	Frame.Active = true
	Frame.Draggable = true

	local UICorner = Instance.new("UICorner", Frame)
	UICorner.CornerRadius = UDim.new(0, 12)

	local Title = Instance.new("TextLabel", Frame)
	Title.Text = "Configurações"
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 20
	Title.Size = UDim2.new(1, 0, 0, 40)
	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.BackgroundTransparency = 1

	local Creator1 = Instance.new("ImageLabel", Frame)
	Creator1.Size = UDim2.new(0, 50, 0, 50)
	Creator1.Position = UDim2.new(0, 20, 0, 60)
	Creator1.Image = "rbxassetid://15327849226"
	Creator1.BackgroundTransparency = 1

	local Creator2 = Instance.new("ImageLabel", Frame)
	Creator2.Size = UDim2.new(0, 50, 0, 50)
	Creator2.Position = UDim2.new(0, 90, 0, 60)
	Creator2.Image = "rbxassetid://17423995385"
	Creator2.BackgroundTransparency = 1

	local TextCreators = Instance.new("TextLabel", Frame)
	TextCreators.Text = "Criadores: STORMDOWNN, CHATGPT"
	TextCreators.Font = Enum.Font.Gotham
	TextCreators.TextSize = 16
	TextCreators.Position = UDim2.new(0, 20, 0, 120)
	TextCreators.Size = UDim2.new(1, -40, 0, 30)
	TextCreators.TextColor3 = Color3.new(1, 1, 1)
	TextCreators.BackgroundTransparency = 1

	local PlayerName = Instance.new("TextLabel", Frame)
	PlayerName.Text = "Usuário: " .. player.Name
	PlayerName.Font = Enum.Font.Gotham
	PlayerName.TextSize = 16
	PlayerName.Position = UDim2.new(0, 20, 0, 160)
	PlayerName.Size = UDim2.new(1, -40, 0, 25)
	PlayerName.TextColor3 = Color3.new(1, 1, 1)
	PlayerName.BackgroundTransparency = 1

	local Location = Instance.new("TextLabel", Frame)
	Location.Text = "Localização: StormNet v1 (Wi-Fi Detectado)"
	Location.Font = Enum.Font.Gotham
	Location.TextSize = 16
	Location.Position = UDim2.new(0, 20, 0, 190)
	Location.Size = UDim2.new(1, -40, 0, 25)
	Location.TextColor3 = Color3.new(1, 1, 1)
	Location.BackgroundTransparency = 1

	local ThemeButton = Instance.new("TextButton", Frame)
	ThemeButton.Text = "Modo Tema: Claro"
	ThemeButton.Font = Enum.Font.Gotham
	ThemeButton.TextSize = 16
	ThemeButton.Size = UDim2.new(0.8, 0, 0, 35)
	ThemeButton.Position = UDim2.new(0.1, 0, 0.85, 0)
	ThemeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	ThemeButton.TextColor3 = Color3.new(1, 1, 1)

	local UICorner2 = Instance.new("UICorner", ThemeButton)
	UICorner2.CornerRadius = UDim.new(0, 8)

	local darkMode = true
	ThemeButton.MouseButton1Click:Connect(function()
		darkMode = not darkMode
		if darkMode then
			Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			ThemeButton.Text = "Modo Tema: Claro"
		else
			Frame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
			ThemeButton.Text = "Modo Tema: Escuro"
		end
	end)
end
