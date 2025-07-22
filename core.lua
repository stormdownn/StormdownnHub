-- StormdownnHub_V1

-- =======
-- INÍCIO/SENHA
-- ======= 

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local HUB_PASSWORD = "stormdownn" -- Mude sua senha aqui

-- Tela de login
local loginGui = Instance.new("ScreenGui")
loginGui.Name = "StormdownnLogin"
loginGui.ResetOnSpawn = false
loginGui.Parent = playerGui

local loginFrame = Instance.new("Frame")
loginFrame.Name = "LoginFrame"
loginFrame.Parent = loginGui
loginFrame.Size = UDim2.new(0, 360, 0, 230)
loginFrame.Position = UDim2.new(0.5, -180, 0.5, -115)
loginFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
loginFrame.BorderSizePixel = 0
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 12)

local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Name = "welcomeLabel"
welcomeLabel.Parent = loginFrame
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.Size = UDim2.new(1, 0, 0.25, 0)
welcomeLabel.Position = UDim2.new(0, 0, 0, 10)
welcomeLabel.Text = "🌩️ WELCOME 🌩️\nTO\n⚡StormdownnHub_V1⚡"
welcomeLabel.Font = Enum.Font.GothamBold
welcomeLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
welcomeLabel.TextStrokeTransparency = 0.5
welcomeLabel.TextScaled = true
welcomeLabel.TextWrapped = true

local passwordBox = Instance.new("TextBox")
passwordBox.Parent = loginFrame
passwordBox.PlaceholderText = "Digite a senha"
passwordBox.Size = UDim2.new(0.85, 0, 0, 40)
passwordBox.Position = UDim2.new(0.5, -150, 0.55, -20)
passwordBox.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
passwordBox.TextColor3 = Color3.fromRGB(120, 120, 120)
passwordBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
passwordBox.Font = Enum.Font.Gotham
passwordBox.TextSize = 16
passwordBox.ClearTextOnFocus = false
passwordBox.Text = ""
Instance.new("UICorner", passwordBox).CornerRadius = UDim.new(0, 8)

local loginButton = Instance.new("TextButton")
loginButton.Parent = loginFrame
loginButton.Text = "ENTRAR"
loginButton.Size = UDim2.new(0.85, 0, 0, 40)
loginButton.Position = UDim2.new(0.5, -150, 0.8, -20)
loginButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loginButton.Font = Enum.Font.GothamBold
loginButton.TextSize = 16
Instance.new("UICorner", loginButton).CornerRadius = UDim.new(0, 8)

local incorrectLabel = Instance.new("TextLabel")
incorrectLabel.Parent = loginFrame
incorrectLabel.BackgroundTransparency = 1
incorrectLabel.Size = UDim2.new(1, 0, 0, 20)
incorrectLabel.Position = UDim2.new(0, 0, 0.95, 0)
incorrectLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
incorrectLabel.Font = Enum.Font.GothamBold
incorrectLabel.TextSize = 14
incorrectLabel.Text = ""
incorrectLabel.TextWrapped = true

-- =======
-- HUB PRINCIPAL
-- =======

-- GUI Hub
local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "StormdownnHub"
mainGui.ResetOnSpawn = false
mainGui.Enabled = false

local MainFrame = Instance.new("Frame", mainGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

MainFrame.Active = true
MainFrame.Draggable = true

local BotaoFlutuante = Instance.new("TextButton")
BotaoFlutuante.Name = "BotaoFlutuante"
BotaoFlutuante.Size = UDim2.new(0, 40, 0, 40)
BotaoFlutuante.Position = UDim2.new(0.5, -20, 0, -20) -- metade fora do painel no topo central
BotaoFlutuante.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BotaoFlutuante.TextColor3 = Color3.fromRGB(255, 255, 255)
BotaoFlutuante.Text = "✦"
BotaoFlutuante.Font = Enum.Font.GothamBold
BotaoFlutuante.TextSize = 22
BotaoFlutuante.ZIndex = 100
Instance.new("UICorner", BotaoFlutuante).CornerRadius = UDim.new(1, 0)
BotaoFlutuante.Visible = false
BotaoFlutuante.Parent = mainGui

local painelAberto = true

-- Guarda a posição do botão quando o painel está fechado
local posFechado = nil

local function fixarBotaoNoTopoDoPainel()
	BotaoFlutuante.Position = UDim2.new(0.5, -20, 0, -20)
	BotaoFlutuante.Parent = MainFrame
	BotaoFlutuante.Draggable = false
end

local function alternarPainel()
	painelAberto = not painelAberto

	if painelAberto then
		MainFrame.Visible = true
		fixarBotaoNoTopoDoPainel()
	else
		MainFrame.Visible = false
		BotaoFlutuante.Parent = mainGui
		BotaoFlutuante.Draggable = true
		-- Se já tiver posição salva, aplica, senão usa a atual
		if posFechado then
			BotaoFlutuante.Position = posFechado
		else
			posFechado = BotaoFlutuante.Position
		end
	end
end

BotaoFlutuante.MouseButton1Click:Connect(alternarPainel)

local dragging, dragStart, startPos

BotaoFlutuante.InputBegan:Connect(function(input)
	if not painelAberto and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		dragging = true
		dragStart = input.Position
		startPos = BotaoFlutuante.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
				posFechado = BotaoFlutuante.Position
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

loginButton.MouseButton1Click:Connect(function()
	local textoDigitado = passwordBox.Text:match("^%s*(.-)%s*$")
	if textoDigitado == HUB_PASSWORD then
		loginGui:Destroy()
		mainGui.Enabled = true
		MainFrame.Visible = true
		painelAberto = true

		BotaoFlutuante.Visible = true
		fixarBotaoNoTopoDoPainel()
	else
		incorrectLabel.Text = "Senha incorreta!"
		wait(1.5)
		incorrectLabel.Text = ""
		passwordBox.Text = ""
	end
end)
