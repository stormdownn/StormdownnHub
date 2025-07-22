-- StormdownnHub_V1

-- =======
-- INÍCIO/SENHA
-- =======

-- Parte 1: Tela de Boas-Vindas e Senha (Estilizado)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI Principal
local loginGui = Instance.new("ScreenGui")
loginGui.Name = "StormdownnLogin"
loginGui.ResetOnSpawn = false
loginGui.Parent = playerGui

-- Container principal
local loginFrame = Instance.new("Frame")
loginFrame.Name = "LoginFrame"
loginFrame.Parent = loginGui
loginFrame.Size = UDim2.new(0, 360, 0, 230)
loginFrame.Position = UDim2.new(0.5, -180, 0.5, -115)
loginFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
loginFrame.BorderSizePixel = 0

-- Borda arredondada
local corner = Instance.new("UICorner", loginFrame)
corner.CornerRadius = UDim.new(0, 12)

-- Mensagem de boas-vindas (3 linhas)
local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Name = "welcomeLabel"
welcomeLabel.Parent = loginFrame
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.Size = UDim2.new(1, 0, 0.25, 0) -- ⬅️ Tamanho levemente reduzido
welcomeLabel.Position = UDim2.new(0, 0, 0, 10)
welcomeLabel.Text = "🌩️ WELCOME 🌩️\nTO\n⚡StormdownnHub_V1⚡"
welcomeLabel.Font = Enum.Font.GothamBold
welcomeLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
welcomeLabel.TextStrokeTransparency = 0.5
welcomeLabel.TextScaled = true
welcomeLabel.TextWrapped = true

-- Caixa de senha (levemente escurecida)
local passwordBox = Instance.new("TextBox")
passwordBox.Parent = loginFrame
passwordBox.PlaceholderText = "Digite a senha"
passwordBox.Size = UDim2.new(0.85, 0, 0, 40)
passwordBox.Position = UDim2.new(0.5, -150, 0.55, -20)
passwordBox.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
passwordBox.TextColor3 = Color3.fromRGB(0, 0, 0)
passwordBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
passwordBox.Font = Enum.Font.Gotham
passwordBox.TextSize = 16
passwordBox.ClearTextOnFocus = false
passwordBox.Text = ""
local pwCorner = Instance.new("UICorner", passwordBox)
pwCorner.CornerRadius = UDim.new(0, 8)

-- Botão de entrar (preto com letras brancas)
local loginButton = Instance.new("TextButton")
loginButton.Parent = loginFrame
loginButton.Text = "ENTRAR"
loginButton.Size = UDim2.new(0.85, 0, 0, 40)
loginButton.Position = UDim2.new(0.5, -150, 0.8, -20)
loginButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loginButton.Font = Enum.Font.GothamBold
loginButton.TextSize = 16
local btnCorner = Instance.new("UICorner", loginButton)
btnCorner.CornerRadius = UDim.new(0, 8)

-- Senha correta
local senhaCorreta = "stormdownn"

-- Validação da senha
loginButton.MouseButton1Click:Connect(function()
	if passwordBox.Text == senhaCorreta then
		loginGui:Destroy()
		loadstring(game:HttpGet("AQUI_VAI_A_INTERFACE"))()
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
