-- StormdownnHub_V1

-- =======
-- INÍCIO/SENHA
-- =======

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI Principal
local loginGui = Instance.new("ScreenGui")
loginGui.Name = "StormdownnLogin"
loginGui.ResetOnSpawn = false
loginGui.Parent = playerGui

-- Mensagem de Boas-Vindas (3 linhas, centralizada, preta)
local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Parent = loginGui
welcomeLabel.Size = UDim2.new(0, 400, 0, 100)
welcomeLabel.Position = UDim2.new(0.5, -200, 0.1, 0)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
welcomeLabel.Font = Enum.Font.GothamBlack
welcomeLabel.TextSize = 24
welcomeLabel.TextWrapped = true
welcomeLabel.TextXAlignment = Enum.TextXAlignment.Center
welcomeLabel.TextYAlignment = Enum.TextYAlignment.Center
welcomeLabel.Text = "🌩️ BEM-VINDO 🌩️\nAO\n⚡StormdownnHub_V1⚡"

-- Quadro do login (branco com leve transparência)
local loginFrame = Instance.new("Frame")
loginFrame.Name = "LoginFrame"
loginFrame.Parent = loginGui
loginFrame.Size = UDim2.new(0, 350, 0, 200)
loginFrame.Position = UDim2.new(0.5, -175, 0.4, -100)
loginFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
loginFrame.BackgroundTransparency = 0.2
loginFrame.BorderSizePixel = 0

-- Caixa de senha (levemente escurecida)
local passwordBox = Instance.new("TextBox")
passwordBox.Parent = loginFrame
passwordBox.PlaceholderText = "Digite a senha"
passwordBox.Size = UDim2.new(0, 280, 0, 40)
passwordBox.Position = UDim2.new(0.5, -140, 0.4, -20)
passwordBox.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
passwordBox.TextColor3 = Color3.fromRGB(0, 0, 0)
passwordBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
passwordBox.Font = Enum.Font.Gotham
passwordBox.TextSize = 16
passwordBox.ClearTextOnFocus = false
passwordBox.Text = ""

-- Botão de entrar (preto com texto branco)
local loginButton = Instance.new("TextButton")
loginButton.Parent = loginFrame
loginButton.Text = "ENTRAR"
loginButton.Size = UDim2.new(0, 280, 0, 40)
loginButton.Position = UDim2.new(0.5, -140, 0.7, -20)
loginButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loginButton.Font = Enum.Font.GothamBold
loginButton.TextSize = 16

-- Verificação da senha
local senhaCorreta = "Stormdownn123" -- 🛡️ Senha do Hub

loginButton.MouseButton1Click:Connect(function()
	if passwordBox.Text == senhaCorreta then
		loginGui:Destroy()
		loadstring(game:HttpGet("AQUI_VAI_A_INTERFACE"))() -- ← Aqui você cola a Parte 2 depois
	else
		passwordBox.Text = ""
		passwordBox.PlaceholderText = "Senha incorreta!"
	end
end)

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
