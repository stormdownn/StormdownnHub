-- StormdownnHub_V1

-- =======
-- INÍCIO/SENHA
-- =======

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local panelOpen = false

-- Limpa GUIs anteriores
for _, name in pairs({"StormdownnHub_Login", "StormdownnHub_Main", "ToggleButton"}) do
	local old = guiParent:FindFirstChild(name)
	if old then old:Destroy() end
end

-- Login GUI
local loginGui = Instance.new("ScreenGui", guiParent)
loginGui.Name = "StormdownnHub_Login"
loginGui.ResetOnSpawn = false

local loginFrame = Instance.new("Frame", loginGui)
loginFrame.Size = UDim2.new(0, 320, 0, 180)
loginFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
loginFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loginFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
loginFrame.BorderSizePixel = 0
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", loginFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Stormdownn Hub Login"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextSize = 24

local passwordBox = Instance.new("TextBox", loginFrame)
passwordBox.Size = UDim2.new(0.9, 0, 0, 50)
passwordBox.Position = UDim2.new(0.05, 0, 0, 70)
passwordBox.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
passwordBox.ClearTextOnFocus = true
passwordBox.Font = Enum.Font.GothamBold
passwordBox.TextColor3 = Color3.fromRGB(0, 0, 0)
passwordBox.TextSize = 22
passwordBox.PlaceholderText = "Digite a senha..."
passwordBox.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", passwordBox).CornerRadius = UDim.new(0, 8)

local loginButton = Instance.new("TextButton", loginFrame)
loginButton.Size = UDim2.new(0.9, 0, 0, 40)
loginButton.Position = UDim2.new(0.05, 0, 0, 130)
loginButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loginButton.Font = Enum.Font.GothamBold
loginButton.TextSize = 20
loginButton.Text = "Entrar"
Instance.new("UICorner", loginButton).CornerRadius = UDim.new(0, 8)

local incorrectLabel = Instance.new("TextLabel", loginFrame)
incorrectLabel.Size = UDim2.new(1, 0, 0, 24)
incorrectLabel.Position = UDim2.new(0, 0, 1, -24)
incorrectLabel.BackgroundTransparency = 1
incorrectLabel.Text = ""
incorrectLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
incorrectLabel.Font = Enum.Font.Gotham
incorrectLabel.TextSize = 16

local HUB_PASSWORD = "stormdownn"

-- =======
-- HUB PRINCIPAL
-- =======

-- Main GUI
local mainGui = Instance.new("ScreenGui", guiParent)
mainGui.Name = "StormdownnHub_Main"
mainGui.ResetOnSpawn = false
mainGui.Enabled = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 360, 0, 300)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

-- Tornar o painel principal arrastável
local draggingMain = false
local dragStartMain, startPosMain
mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingMain = true
		dragStartMain = input.Position
		startPosMain = mainFrame.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if draggingMain and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStartMain
		mainFrame.Position = UDim2.new(startPosMain.X.Scale, startPosMain.X.Offset + delta.X, startPosMain.Y.Scale, startPosMain.Y.Offset + delta.Y)
	end
end)

-- Cabeçalho
local headerLabel = Instance.new("TextLabel", mainFrame)
headerLabel.Size = UDim2.new(1, 0, 0, 50)
headerLabel.Text = "🌩️ StormdawnnHub_V1 🌩️"
headerLabel.Font = Enum.Font.GothamBold
headerLabel.TextSize = 28
headerLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
headerLabel.BackgroundTransparency = 1

-- Lista de scripts
local scriptsFrame = Instance.new("ScrollingFrame", mainFrame)
scriptsFrame.Size = UDim2.new(1, -20, 1, -60)
scriptsFrame.Position = UDim2.new(0, 10, 0, 50)
scriptsFrame.BackgroundTransparency = 1
scriptsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scriptsFrame.ScrollBarThickness = 6
scriptsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scriptsFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
local uiLayout = Instance.new("UIListLayout", scriptsFrame)
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0, 8)

local features = {
	"Fly", "NoClip", "ESP", "KillPlayers", "WalkFling", "PuxarPlayer",
	"SuperRingParts", "Sledgehammer", "Magnet", "LagOthers", "Telekinesis"
}

for _, feature in ipairs(features) do
	local btn = Instance.new("TextButton", scriptsFrame)
	btn.Size = UDim2.new(0.95, 0, 0, 40)
	btn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
	btn.TextColor3 = Color3.fromRGB(0, 0, 0)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 20
	btn.Text = feature .. ": OFF"
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	local active = false
	btn.MouseButton1Click:Connect(function()
		active = not active
		btn.Text = feature .. ": " .. (active and "ON" or "OFF")
	end)
end

-- Botão flutuante (fica solto ou fixo)
local toggleButton = Instance.new("TextButton", guiParent)
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.5, -25, 0, 10)
toggleButton.AnchorPoint = Vector2.new(0.5, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "✦"
toggleButton.ZIndex = 10
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 22
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)

-- Drag do botão quando solto
local dragging = false
local dragStart, startPos
toggleButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = toggleButton.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		toggleButton.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- Abrir e fechar o painel

local panelOpen = false

toggleButton.MouseButton1Click:Connect(function()
	panelOpen = not panelOpen

	mainGui.Enabled = panelOpen
	mainFrame.Visible = panelOpen

	if panelOpen then
	toggleButton.Position = UDim2.new(0.5, -25, 0, -30)
	toggleButton.AnchorPoint = Vector2.new(0.5, 0)
else
	toggleButton.Position = UDim2.new(0.5, -25, 0, 10)
	toggleButton.AnchorPoint = Vector2.new(0.5, 0)
end

-- Sempre mantenha o botão no guiParent para que ele continue visível
toggleButton.Parent = guiParent
toggleButton.Visible = true
	toggleButton.Visible = true -- Garante que sempre aparece
end)

-- Verificação de login
loginButton.MouseButton1Click:Connect(function()
	if passwordBox.Text == HUB_PASSWORD then
		loginGui:Destroy()
		mainGui.Enabled = true
		mainFrame.Visible = true

		toggleButton.Visible = true
		toggleButton.Parent = mainFrame
		toggleButton.Position = UDim2.new(0.5, -25, 0, -30)
		toggleButton.AnchorPoint = Vector2.new(0.5, 0)
	else
		incorrectLabel.Text = "Senha incorreta!"
		wait(1.5)
		incorrectLabel.Text = ""
		passwordBox.Text = ""
	end
end)
