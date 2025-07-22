-- StormdownnHub_V1 completo com login + hub + botão flutuante sincronizado

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local HUB_PASSWORD = "stormdownn" -- Senha do hub

-- ===== Tela de Login =====
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

-- ===== Interface do Hub =====
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
MainFrame.Visible = false

-- Botão dentro do painel (50% para fora no topo)
local BotaoAberto = Instance.new("TextButton", MainFrame)
BotaoAberto.Size = UDim2.new(0, 40, 0, 40)
BotaoAberto.Position = UDim2.new(0.5, -20, 0, -20) -- metade para fora do topo do painel
BotaoAberto.Text = "✦"
BotaoAberto.Font = Enum.Font.GothamBold
BotaoAberto.TextSize = 22
BotaoAberto.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BotaoAberto.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", BotaoAberto).CornerRadius = UDim.new(1, 0)
BotaoAberto.Visible = false

-- Botão fora do painel (arrastável quando painel fechado)
local BotaoFechado = Instance.new("TextButton", mainGui)
BotaoFechado.Size = UDim2.new(0, 40, 0, 40)
BotaoFechado.Position = UDim2.new(0.5, -20, 0, 5) -- posição inicial
BotaoFechado.Text = "✦"
BotaoFechado.Font = Enum.Font.GothamBold
BotaoFechado.TextSize = 22
BotaoFechado.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BotaoFechado.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", BotaoFechado).CornerRadius = UDim.new(1, 0)
BotaoFechado.Visible = false

local painelAberto = false

-- Função para sincronizar posição de um botão no outro
local function syncPos(fromBtn, toBtn)
	toBtn.Position = fromBtn.Position
end

-- Abrir o painel
local function abrirPainel()
	MainFrame.Visible = true
	BotaoAberto.Visible = true
	BotaoFechado.Visible = false
	painelAberto = true
	syncPos(BotaoFechado, BotaoAberto)
end

-- Fechar o painel
local function fecharPainel()
	MainFrame.Visible = false
	BotaoAberto.Visible = false
	BotaoFechado.Visible = true
	painelAberto = false
	syncPos(BotaoAberto, BotaoFechado)
end

-- Alternar painel
local function alternarPainel()
	if painelAberto then
		fecharPainel()
	else
		abrirPainel()
	end
end

-- Clique nos botões alternam o painel
BotaoAberto.MouseButton1Click:Connect(alternarPainel)
BotaoFechado.MouseButton1Click:Connect(alternarPainel)

-- Sistema de arrasto para BotaoFechado (quando painel fechado)
local dragging = false
local dragStart
local startPos

BotaoFechado.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = BotaoFechado.Position

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
		BotaoFechado.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
		-- Sincroniza posição do botão dentro do painel (mesmo se invisível)
		syncPos(BotaoFechado, BotaoAberto)
	end
end)

-- Sistema de arrasto para BotaoAberto (quando painel aberto)
local draggingOpen = false
local dragStartOpen
local startPosOpen

BotaoAberto.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		draggingOpen = true
		dragStartOpen = input.Position
		startPosOpen = BotaoAberto.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				draggingOpen = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if draggingOpen and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStartOpen
		BotaoAberto.Position = UDim2.new(
			startPosOpen.X.Scale,
			startPosOpen.X.Offset + delta.X,
			startPosOpen.Y.Scale,
			startPosOpen.Y.Offset + delta.Y
		)
		-- Sincroniza posição do botão fora do painel (mesmo se invisível)
		syncPos(BotaoAberto, BotaoFechado)
	end
end)

-- Validação da senha e abertura do hub
loginButton.MouseButton1Click:Connect(function()
	local textoDigitado = passwordBox.Text:match("^%s*(.-)%s*$")
	if textoDigitado == HUB_PASSWORD then
		loginGui:Destroy()
		mainGui.Enabled = true
		abrirPainel()
	else
		incorrectLabel.Text = "Senha incorreta!"
		wait(1.5)
		incorrectLabel.Text = ""
		passwordBox.Text = ""
	end
end)

-- Inicialmente mostrar a tela de login e esconder o hub e botões
loginGui.Enabled = true
mainGui.Enabled = false
BotaoAberto.Visible = false
BotaoFechado.Visible = false
