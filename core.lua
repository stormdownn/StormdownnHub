-- StormdownnHub_V1

-- =======
-- INÍCIO/SENHA
-- =======

--// Serviços principais
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")

--// Constantes
local HUB_PASSWORD = "stormdownn" -- senha

--// GUI de login
local loginGui = Instance.new("ScreenGui", guiParent)
loginGui.Name = "StormdownnLogin"
loginGui.ResetOnSpawn = false

local loginFrame = Instance.new("Frame", loginGui)
loginFrame.Size = UDim2.new(0, 300, 0, 200)
loginFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
loginFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
loginFrame.BorderSizePixel = 0
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 8)

local testGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
local testFrame = Instance.new("Frame", testGui)
testFrame.Size = UDim2.new(0, 400, 0, 300)
testFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
testFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local welcome = Instance.new("TextLabel", testFrame)
welcome.Size = UDim2.new(1, -20, 0, 80)
welcome.Position = UDim2.new(0, 10, 0, 10)
welcome.BackgroundTransparency = 1
welcome.TextColor3 = Color3.fromRGB(0, 0, 0)
welcome.Font = Enum.Font.GothamBlack
welcome.TextSize = 20
welcome.TextWrapped = true
welcome.Text = "🌩️ BEM-VINDO 🌩️\nAO\n⚡StormdownnHub_V1⚡"
welcome.TextXAlignment = Enum.TextXAlignment.Center

local title = Instance.new("TextLabel", loginFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = ""
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.Font = Enum.Font.GothamBlack
title.TextSize = 22

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
loginButton.Size = UDim2.new(0.6, 0, 0, 40)
loginButton.Position = UDim2.new(0.2, 0, 0, 130)
loginButton.Text = "Entrar"
loginButton.Font = Enum.Font.GothamBold
loginButton.TextSize = 18
loginButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", loginButton).CornerRadius = UDim.new(0, 8)

local incorrectLabel = Instance.new("TextLabel", loginFrame)
incorrectLabel.Size = UDim2.new(1, 0, 0, 20)
incorrectLabel.Position = UDim2.new(0, 0, 1, -20)
incorrectLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
incorrectLabel.Font = Enum.Font.Gotham
incorrectLabel.TextSize = 14
incorrectLabel.Text = ""
incorrectLabel.BackgroundTransparency = 1

-- =======
-- HUB PRINCIPAL
-- =======

-- Interface principal
local mainGui = Instance.new("ScreenGui", guiParent)
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

-- Deixar painel arrastável
MainFrame.Active = true
MainFrame.Draggable = true

-- Criação do botão flutuante
local BotaoFlutuante = Instance.new("TextButton")
BotaoFlutuante.Name = "BotaoFlutuante"
BotaoFlutuante.Size = UDim2.new(0, 40, 0, 40)
BotaoFlutuante.Position = UDim2.new(0.5, -20, 0, 5) -- posição inicial fixada no topo do painel
BotaoFlutuante.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- cor preta
BotaoFlutuante.TextColor3 = Color3.fromRGB(255, 255, 255)
BotaoFlutuante.Text = "✦" -- símbolo do botão
BotaoFlutuante.Font = Enum.Font.GothamBold
BotaoFlutuante.TextSize = 22
BotaoFlutuante.ZIndex = 100
Instance.new("UICorner", BotaoFlutuante).CornerRadius = UDim.new(1, 0)
BotaoFlutuante.Visible = false
BotaoFlutuante.Parent = mainGui

local painelAberto = true

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Fixar o botão no topo do painel
local function fixarBotaoNoPainel()
	BotaoFlutuante.Position = UDim2.new(0.5, -20, 0, 5)
	BotaoFlutuante.AnchorPoint = Vector2.new(0, 0)
end

-- Alternar painel + comportamento do botão
 -- Fixar o botão no topo do painel
local function alternarPainel()
	painelAberto = not painelAberto

	if painelAberto then
		MainFrame.Visible = true
		BotaoFlutuante.Parent = MainFrame
		fixarBotaoNoPainel()
		BotaoFlutuante.Draggable = false
	else
		MainFrame.Visible = false
		BotaoFlutuante.Parent = mainGui
		BotaoFlutuante.Draggable = true
	end
end

-- Clique do botão
BotaoFlutuante.MouseButton1Click:Connect(alternarPainel)

BotaoFlutuante.MouseButton1Click:Connect(alternarPainel)

-- Mostrar botão e painel após login
loginButton.MouseButton1Click:Connect(function()
	if passwordBox.Text:match("^%s*(.-)%s*$") == HUB_PASSWORD then
		loginGui:Destroy()
		mainGui.Enabled = true
		MainFrame.Visible = true
		painelAberto = true

		BotaoFlutuante.Visible = true
		fixarBotaoNoPainel()
	else
		incorrectLabel.Text = "Senha incorreta!"
		wait(1.5)
		incorrectLabel.Text = ""
		passwordBox.Text = ""
	end
end)

-- Código para arrastar o botão livremente quando o painel estiver fechado
local dragging, dragStart, startPos

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

-- Sistema de arrasto
local dragging, dragInput, dragStart, startPos

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
