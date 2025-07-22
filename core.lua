-- StormdownnHub V1 - Login + Painel com Botão Flutuante Sincronizado

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

-- GUI Principal
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "StormdownnHub"
mainGui.ResetOnSpawn = false
mainGui.Parent = player:WaitForChild("PlayerGui")

-- Tela de Login
local loginGui = Instance.new("Frame")
loginGui.Size = UDim2.new(0, 350, 0, 200)
loginGui.Position = UDim2.new(0.5, -175, 0.5, -100)
loginGui.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
loginGui.Parent = mainGui
loginGui.Active = true
loginGui.Draggable = true
Instance.new("UICorner", loginGui).CornerRadius = UDim.new(0, 10)

local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Size = UDim2.new(1, 0, 0, 60)
welcomeLabel.Position = UDim2.new(0, 0, 0, 10)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.Text = "\ud83c\udf29\ufe0f WELCOME \ud83c\udf29\ufe0f\nTO\n\u26a1StormdownnHub_V1\u26a1"
welcomeLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
welcomeLabel.Font = Enum.Font.GothamBlack
welcomeLabel.TextSize = 20
welcomeLabel.TextWrapped = true
welcomeLabel.Parent = loginGui

local passwordBox = Instance.new("TextBox")
passwordBox.PlaceholderText = "Digite a senha"
passwordBox.Size = UDim2.new(0.85, 0, 0, 40)
passwordBox.Position = UDim2.new(0.5, -150, 0.55, -20)
passwordBox.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
passwordBox.TextColor3 = Color3.fromRGB(80, 80, 80)
passwordBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
passwordBox.Font = Enum.Font.Gotham
passwordBox.TextSize = 16
passwordBox.ClearTextOnFocus = false
passwordBox.Text = ""
passwordBox.Parent = loginGui
Instance.new("UICorner", passwordBox).CornerRadius = UDim.new(0, 8)

local loginButton = Instance.new("TextButton")
loginButton.Size = UDim2.new(0.5, 0, 0, 35)
loginButton.Position = UDim2.new(0.25, 0, 0.75, 0)
loginButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loginButton.Text = "Entrar"
loginButton.Font = Enum.Font.GothamBold
loginButton.TextSize = 18
loginButton.Parent = loginGui
Instance.new("UICorner", loginButton).CornerRadius = UDim.new(0, 8)

local incorrectLabel = Instance.new("TextLabel")
incorrectLabel.Size = UDim2.new(1, 0, 0, 20)
incorrectLabel.Position = UDim2.new(0, 0, 1, -20)
incorrectLabel.BackgroundTransparency = 1
incorrectLabel.Text = ""
incorrectLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
incorrectLabel.Font = Enum.Font.Gotham
incorrectLabel.TextSize = 14
incorrectLabel.Parent = loginGui

local HUB_PASSWORD = "storm123"

-- Painel Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = mainGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Botão Flutuante
local BotaoFlutuante = Instance.new("TextButton")
BotaoFlutuante.Name = "BotaoFlutuante"
BotaoFlutuante.Size = UDim2.new(0, 40, 0, 40)
BotaoFlutuante.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BotaoFlutuante.TextColor3 = Color3.fromRGB(255, 255, 255)
BotaoFlutuante.Text = "\u2726"
BotaoFlutuante.Font = Enum.Font.GothamBold
BotaoFlutuante.TextSize = 22
BotaoFlutuante.ZIndex = 100
BotaoFlutuante.Visible = false
Instance.new("UICorner", BotaoFlutuante).CornerRadius = UDim.new(1, 0)
BotaoFlutuante.Parent = mainGui

local painelAberto = false

local function abrirPainel()
	MainFrame.Position = UDim2.new(
		BotaoFlutuante.Position.X.Scale,
		BotaoFlutuante.Position.X.Offset - 180,
		BotaoFlutuante.Position.Y.Scale,
		BotaoFlutuante.Position.Y.Offset - 20
	)

	BotaoFlutuante.Parent = MainFrame
	BotaoFlutuante.Position = UDim2.new(0, MainFrame.Size.X.Offset / 2 - 20, 0, -20)
	BotaoFlutuante.Draggable = false
	MainFrame.Visible = true
	painelAberto = true
end

local function fecharPainel()
	local posPainel = MainFrame.Position
	local offsetX = BotaoFlutuante.Position.X.Offset
	local offsetY = BotaoFlutuante.Position.Y.Offset

	local globalX = posPainel.X.Offset + offsetX
	local globalY = posPainel.Y.Offset + offsetY

	BotaoFlutuante.Parent = mainGui
	BotaoFlutuante.Position = UDim2.new(0, globalX, 0, globalY)
	BotaoFlutuante.Draggable = true
	MainFrame.Visible = false
	painelAberto = false
end

local function alternarPainel()
	if painelAberto then
		fecharPainel()
	else
		abrirPainel()
	end
end

BotaoFlutuante.MouseButton1Click:Connect(alternarPainel)

-- Drag quando fechado
local dragging = false
local dragStart, startPos

BotaoFlutuante.InputBegan:Connect(function(input)
	if not painelAberto and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		dragging = true
		dragStart = input.Position
		startPos = BotaoFlutuante.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		BotaoFlutuante.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Ao clicar no botão de login
loginButton.MouseButton1Click:Connect(function()
	if passwordBox.Text:match("^%s*(.-)%s*$") == HUB_PASSWORD then
		loginGui:Destroy()
		mainGui.Enabled = true
		BotaoFlutuante.Visible = true
		abrirPainel()
	else
		incorrectLabel.Text = "Senha incorreta!"
		wait(1.5)
		incorrectLabel.Text = ""
		passwordBox.Text = ""
	end
end)
