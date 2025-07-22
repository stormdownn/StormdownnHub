-- [ LocalScript ] dentro de StarterGui
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local playerGui = player:WaitForChild("PlayerGui")

-- Senha fixa
local senhaCorreta = "stormdownn"

-- Login UI
local loginGui = Instance.new("ScreenGui", playerGui)
loginGui.Name = "StormdownnLogin"
loginGui.ResetOnSpawn = false

local loginFrame = Instance.new("Frame", loginGui)
loginFrame.Size = UDim2.new(0, 350, 0, 220)
loginFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
loginFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", loginFrame)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Position = UDim2.new(0, 0, 0.10, 0)
title.BackgroundTransparency = 1
title.Text = "🌩️ WELCOME 🌩️\nTO\n⚡StormdownnHub_V1⚡"
title.Font = Enum.Font.GothamBold
title.TextScaled = false
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextWrapped = true
title.TextYAlignment = Enum.TextYAlignment.Center

local password = Instance.new("TextBox", loginFrame)
password.Size = UDim2.new(0.8, 0, 0, 40)
password.Position = UDim2.new(0.1, 0, 0.55, 0)
password.PlaceholderText = "Senha"
password.TextColor3 = Color3.fromRGB(80, 80, 80)
password.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
password.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
password.Font = Enum.Font.Gotham
password.TextSize = 16
Instance.new("UICorner", password).CornerRadius = UDim.new(0, 8)

local entrarBtn = Instance.new("TextButton", loginFrame)
entrarBtn.Size = UDim2.new(0.5, 0, 0, 35)
entrarBtn.Position = UDim2.new(0.25, 0, 0.8, 0)
entrarBtn.Text = "Entrar"
entrarBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
entrarBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
entrarBtn.Font = Enum.Font.GothamBold
entrarBtn.TextSize = 16
Instance.new("UICorner", entrarBtn).CornerRadius = UDim.new(0, 8)

-- ===== HUB PRINCIPAL=====

-- GUI principal (oculta até login)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StormdownnUI"
screenGui.ResetOnSpawn = false
screenGui.Enabled = false
screenGui.Parent = playerGui

-- Painel principal
local painel = Instance.new("Frame", screenGui)
painel.Size = UDim2.new(0, 400, 0, 300)
painel.Position = UDim2.new(0.5, -200, 0.5, -150)
painel.BackgroundColor3 = Color3.new(1, 1, 1)
painel.Visible = true
painel.Active = true
painel.Draggable = true
Instance.new("UICorner", painel).CornerRadius = UDim.new(0, 12)

-- UIListLayout para organizar as categorias
local layout = Instance.new("UIListLayout", painel)
layout.Padding = UDim.new(0, 10)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Função para criar categorias e scripts
local function criarCategoria(nome, scripts)
	local container = Instance.new("Frame", painel)
	container.Size = UDim2.new(1, -20, 0, #scripts * 30 + 30)
	container.BackgroundTransparency = 1
	container.LayoutOrder = 1

	local titulo = Instance.new("TextLabel", container)
	titulo.Size = UDim2.new(1, 0, 0, 25)
	titulo.Text = nome
	titulo.TextColor3 = Color3.new(0, 0, 0)
	titulo.BackgroundTransparency = 1
	titulo.Font = Enum.Font.SourceSansBold
	titulo.TextSize = 20
	titulo.TextXAlignment = Enum.TextXAlignment.Left

	local lista = Instance.new("UIListLayout", container)
	lista.Padding = UDim.new(0, 5)
	lista.SortOrder = Enum.SortOrder.LayoutOrder

	for _, nomeScript in ipairs(scripts) do
		local item = Instance.new("Frame", container)
		item.Size = UDim2.new(1, 0, 0, 25)
		item.BackgroundTransparency = 1

		local nomeLabel = Instance.new("TextLabel", item)
		nomeLabel.Size = UDim2.new(1, -60, 1, 0)
		nomeLabel.Text = nomeScript
		nomeLabel.BackgroundTransparency = 1
		nomeLabel.TextColor3 = Color3.new(0, 0, 0)
		nomeLabel.Font = Enum.Font.SourceSans
		nomeLabel.TextSize = 16
		nomeLabel.TextXAlignment = Enum.TextXAlignment.Left

		local botao = Instance.new("TextButton", item)
		botao.Size = UDim2.new(0, 40, 1, 0)
		botao.Position = UDim2.new(1, -45, 0, 0)
		botao.AnchorPoint = Vector2.new(0, 0)
		botao.Text = "O"
		botao.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
		botao.TextColor3 = Color3.new(0, 0, 0)
		botao.Font = Enum.Font.SourceSansBold
		botao.TextSize = 16
		Instance.new("UICorner", botao).CornerRadius = UDim.new(1, 0)

		-- Alternar O/I
		botao.MouseButton1Click:Connect(function()
			if botao.Text == "O" then
				botao.Text = "I"
				botao.BackgroundColor3 = Color3.new(0, 0, 0)
				botao.TextColor3 = Color3.new(1, 1, 1)
			else
				botao.Text = "O"
				botao.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
				botao.TextColor3 = Color3.new(0, 0, 0)
			end
		end)
	end
end

-- Categorias e scripts
local scriptsPadroes = {
	"GodMode", "Anti-Fall", "Speed Hack", "Jump Hack", "Noclip", "Freeze Position",
	"Auto Survive", "Controle do Tempo", "Modo Criativo", "Zoom Infinito",
	"Auto Heal", "Fly", "Telecinésie"
}

local scriptsMalvados = {
	"Marreta que quebra o mapa", "Lagador de Partes", "Explosão em Área", "Loop Kill",
	"Magnet Player", "Controlar outro jogador", "Mute Geral", "Chuva de Objetos",
	"Delete Players", "Invisibilidade Forçada", "Super Ring Parts"
}

-- Botão flutuante
local botao = Instance.new("TextButton", screenGui)
botao.Size = UDim2.new(0, 40, 0, 40)
botao.Text = "+"
botao.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
botao.TextColor3 = Color3.new(1, 1, 1)
botao.TextSize = 24
botao.BorderSizePixel = 0
botao.ZIndex = 10
botao.Active = true
botao.Draggable = false
Instance.new("UICorner", botao).CornerRadius = UDim.new(1, 0)

-- Controle de estado
local painelAberto = true
local ultimaPosicao = UDim2.new(0.5, -20, 0, 0)

-- Função magnética
local function acoplarBotao()
	botao.Position = UDim2.new(0, painel.Position.X.Offset + painel.Size.X.Offset / 2 - 20, 0, painel.Position.Y.Offset - 20)
	botao.Draggable = false
end

local function liberarBotao()
	botao.Position = ultimaPosicao
	botao.Draggable = true
end

-- Inicializar botão na posição certa
local function acoplarBotao()
	local painelX = painel.AbsolutePosition.X
	local painelY = painel.AbsolutePosition.Y
	local painelWidth = painel.AbsoluteSize.X
	local botaoWidth = botao.AbsoluteSize.X

	local x = painelX + (painelWidth / 2) - (botaoWidth / 2)
	local y = painelY - (botao.AbsoluteSize.Y / 2)

	botao.Position = UDim2.new(0, x, 0, y)
	botao.Draggable = false
end

-- Toggle painel
botao.MouseButton1Click:Connect(function()
	painelAberto = not painelAberto
	if painelAberto then
		painel.Position = UDim2.new(0, botao.Position.X.Offset - painel.Size.X.Offset / 2 + 20, 0, botao.Position.Y.Offset + 20)
		painel.Visible = true
		acoplarBotao()
	else
		ultimaPosicao = botao.Position
		painel.Visible = false
		liberarBotao()
	end
end)

-- Atualizar posição do botão se for arrastado enquanto fechado
botao:GetPropertyChangedSignal("Position"):Connect(function()
	if not painelAberto then
		ultimaPosicao = botao.Position
	end
end)

-- Manter botão magnético quando painel for arrastado
painel:GetPropertyChangedSignal("Position"):Connect(function()
	if painelAberto then
		acoplarBotao()
	end
end)

-- Login
-- loginGui fica ativado no começo
loginGui.Enabled = true

-- hub principal começa desativado
screenGui.Enabled = false

entrarBtn.MouseButton1Click:Connect(function()
	if password.Text:lower():gsub("%s+", "") == senhaCorreta then
		loginGui:Destroy()        -- remove tela de login
		screenGui.Enabled = true   -- ativa o hub
		game:GetService("RunService").RenderStepped:Wait()
		acoplarBotao()
	else
		password.Text = ""
		password.PlaceholderText = "Senha incorreta!"
	end
end)-- [ LocalScript ] dentro de StarterGui
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local playerGui = player:WaitForChild("PlayerGui")

-- Senha fixa
local senhaCorreta = "stormdownn"

-- Login UI
local loginGui = Instance.new("ScreenGui", playerGui)
loginGui.Name = "StormdownnLogin"
loginGui.ResetOnSpawn = false

local loginFrame = Instance.new("Frame", loginGui)
loginFrame.Size = UDim2.new(0, 350, 0, 220)
loginFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
loginFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", loginFrame)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Position = UDim2.new(0, 0, 0.10, 0)
title.BackgroundTransparency = 1
title.Text = "🌩️ WELCOME 🌩️\nTO\n⚡StormdownnHub_V1⚡"
title.Font = Enum.Font.GothamBold
title.TextScaled = false
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextWrapped = true
title.TextYAlignment = Enum.TextYAlignment.Center

local password = Instance.new("TextBox", loginFrame)
password.Size = UDim2.new(0.8, 0, 0, 40)
password.Position = UDim2.new(0.1, 0, 0.55, 0)
password.PlaceholderText = "Senha"
password.TextColor3 = Color3.fromRGB(80, 80, 80)
password.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
password.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
password.Font = Enum.Font.Gotham
password.TextSize = 16
Instance.new("UICorner", password).CornerRadius = UDim.new(0, 8)

local entrarBtn = Instance.new("TextButton", loginFrame)
entrarBtn.Size = UDim2.new(0.5, 0, 0, 35)
entrarBtn.Position = UDim2.new(0.25, 0, 0.8, 0)
entrarBtn.Text = "Entrar"
entrarBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
entrarBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
entrarBtn.Font = Enum.Font.GothamBold
entrarBtn.TextSize = 16
Instance.new("UICorner", entrarBtn).CornerRadius = UDim.new(0, 8)

-- ===== HUB PRINCIPAL=====

-- GUI principal (oculta até login)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StormdownnUI"
screenGui.ResetOnSpawn = false
screenGui.Enabled = false
screenGui.Parent = playerGui

-- Painel principal
local painel = Instance.new("Frame", screenGui)
painel.Size = UDim2.new(0, 400, 0, 300)
painel.Position = UDim2.new(0.5, -200, 0.5, -150)
painel.BackgroundColor3 = Color3.new(1, 1, 1)
painel.Visible = true
painel.Active = true
painel.Draggable = true
Instance.new("UICorner", painel).CornerRadius = UDim.new(0, 12)

-- Botões de categoria
local categoria1 = Instance.new("TextButton", painel)
categoria1.Size = UDim2.new(0.8, 0, 0.2, 0)
categoria1.Position = UDim2.new(0.1, 0, 0.2, 0)
categoria1.Text = "Scripts Padrões"
categoria1.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
categoria1.TextColor3 = Color3.fromRGB(0, 0, 0)
categoria1.Font = Enum.Font.GothamBold
categoria1.TextScaled = true
Instance.new("UICorner", categoria1).CornerRadius = UDim.new(0, 10)

local categoria2 = Instance.new("TextButton", painel)
categoria2.Size = UDim2.new(0.8, 0, 0.2, 0)
categoria2.Position = UDim2.new(0.1, 0, 0.5, 0)
categoria2.Text = "Scripts Malvados"
categoria2.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
categoria2.TextColor3 = Color3.fromRGB(0, 0, 0)
categoria2.Font = Enum.Font.GothamBold
categoria2.TextScaled = true
Instance.new("UICorner", categoria2).CornerRadius = UDim.new(0, 10)

-- Frames das categorias
local framePadroes = Instance.new("Frame", painel)
framePadroes.Size = UDim2.new(1, 0, 1, 0)
framePadroes.Position = UDim2.new(0, 0, 0, 0)
framePadroes.BackgroundTransparency = 1
framePadroes.Visible = false

local frameMalvados = Instance.new("Frame", painel)
frameMalvados.Size = UDim2.new(1, 0, 1, 0)
frameMalvados.Position = UDim2.new(0, 0, 0, 0)
frameMalvados.BackgroundTransparency = 1
frameMalvados.Visible = false

-- Botão de voltar
local function criarBotaoVoltar(parent)
	local voltar = Instance.new("TextButton", parent)
	voltar.Size = UDim2.new(0, 80, 0, 30)
	voltar.Position = UDim2.new(0, 10, 0, 10)
	voltar.Text = "< Voltar"
	voltar.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	voltar.TextColor3 = Color3.new(0, 0, 0)
	voltar.Font = Enum.Font.Gotham
	voltar.TextSize = 14
	Instance.new("UICorner", voltar).CornerRadius = UDim.new(0, 8)
	return voltar
end

-- Botões de voltar
local voltar1 = criarBotaoVoltar(framePadroes)
local voltar2 = criarBotaoVoltar(frameMalvados)

-- Lógica de clique
categoria1.MouseButton1Click:Connect(function()
	categoria1.Visible = false
	categoria2.Visible = false
	framePadroes.Visible = true
end)

categoria2.MouseButton1Click:Connect(function()
	categoria1.Visible = false
	categoria2.Visible = false
	frameMalvados.Visible = true
end)

voltar1.MouseButton1Click:Connect(function()
	framePadroes.Visible = false
	categoria1.Visible = true
	categoria2.Visible = true
end)

voltar2.MouseButton1Click:Connect(function()
	frameMalvados.Visible = false
	categoria1.Visible = true
	categoria2.Visible = true
end) e 

-- UIListLayout para organizar as categorias
local layout = Instance.new("UIListLayout", painel)
layout.Padding = UDim.new(0, 10)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Função para criar categorias e scripts
local function criarCategoria(nome, scripts)
	local container = Instance.new("Frame", painel)
	container.Size = UDim2.new(1, -20, 0, #scripts * 30 + 30)
	container.BackgroundTransparency = 1
	container.LayoutOrder = 1

	local titulo = Instance.new("TextLabel", container)
	titulo.Size = UDim2.new(1, 0, 0, 25)
	titulo.Text = nome
	titulo.TextColor3 = Color3.new(0, 0, 0)
	titulo.BackgroundTransparency = 1
	titulo.Font = Enum.Font.SourceSansBold
	titulo.TextSize = 20
	titulo.TextXAlignment = Enum.TextXAlignment.Left

	local lista = Instance.new("UIListLayout", container)
	lista.Padding = UDim.new(0, 5)
	lista.SortOrder = Enum.SortOrder.LayoutOrder

	for _, nomeScript in ipairs(scripts) do
		local item = Instance.new("Frame", container)
		item.Size = UDim2.new(1, 0, 0, 25)
		item.BackgroundTransparency = 1

		local nomeLabel = Instance.new("TextLabel", item)
		nomeLabel.Size = UDim2.new(1, -60, 1, 0)
		nomeLabel.Text = nomeScript
		nomeLabel.BackgroundTransparency = 1
		nomeLabel.TextColor3 = Color3.new(0, 0, 0)
		nomeLabel.Font = Enum.Font.SourceSans
		nomeLabel.TextSize = 16
		nomeLabel.TextXAlignment = Enum.TextXAlignment.Left

		local botao = Instance.new("TextButton", item)
		botao.Size = UDim2.new(0, 40, 1, 0)
		botao.Position = UDim2.new(1, -45, 0, 0)
		botao.AnchorPoint = Vector2.new(0, 0)
		botao.Text = "O"
		botao.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
		botao.TextColor3 = Color3.new(0, 0, 0)
		botao.Font = Enum.Font.SourceSansBold
		botao.TextSize = 16
		Instance.new("UICorner", botao).CornerRadius = UDim.new(1, 0)

		-- Alternar O/I
		botao.MouseButton1Click:Connect(function()
			if botao.Text == "O" then
				botao.Text = "I"
				botao.BackgroundColor3 = Color3.new(0, 0, 0)
				botao.TextColor3 = Color3.new(1, 1, 1)
			else
				botao.Text = "O"
				botao.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
				botao.TextColor3 = Color3.new(0, 0, 0)
			end
		end)
	end
end

-- Categorias e scripts
local scriptsPadroes = {
	"GodMode", "Anti-Fall", "Speed Hack", "Jump Hack", "Noclip", "Freeze Position",
	"Auto Survive", "Controle do Tempo", "Modo Criativo", "Zoom Infinito",
	"Auto Heal", "Fly", "Telecinésie"
}

local scriptsMalvados = {
	"Marreta que quebra o mapa", "Lagador de Partes", "Explosão em Área", "Loop Kill",
	"Magnet Player", "Controlar outro jogador", "Mute Geral", "Chuva de Objetos",
	"Delete Players", "Invisibilidade Forçada", "Super Ring Parts"
}

-- Botão flutuante
local botao = Instance.new("TextButton", screenGui)
botao.Size = UDim2.new(0, 40, 0, 40)
botao.Text = "+"
botao.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
botao.TextColor3 = Color3.new(1, 1, 1)
botao.TextSize = 24
botao.BorderSizePixel = 0
botao.ZIndex = 10
botao.Active = true
botao.Draggable = false
Instance.new("UICorner", botao).CornerRadius = UDim.new(1, 0)

-- Controle de estado
local painelAberto = true
local ultimaPosicao = UDim2.new(0.5, -20, 0, 0)

-- Função magnética
local function acoplarBotao()
	botao.Position = UDim2.new(0, painel.Position.X.Offset + painel.Size.X.Offset / 2 - 20, 0, painel.Position.Y.Offset - 20)
	botao.Draggable = false
end

local function liberarBotao()
	botao.Position = ultimaPosicao
	botao.Draggable = true
end

-- Inicializar botão na posição certa
local function acoplarBotao()
	local painelX = painel.AbsolutePosition.X
	local painelY = painel.AbsolutePosition.Y
	local painelWidth = painel.AbsoluteSize.X
	local botaoWidth = botao.AbsoluteSize.X

	local x = painelX + (painelWidth / 2) - (botaoWidth / 2)
	local y = painelY - (botao.AbsoluteSize.Y / 2)

	botao.Position = UDim2.new(0, x, 0, y)
	botao.Draggable = false
end

-- Toggle painel
botao.MouseButton1Click:Connect(function()
	painelAberto = not painelAberto
	if painelAberto then
		painel.Position = UDim2.new(0, botao.Position.X.Offset - painel.Size.X.Offset / 2 + 20, 0, botao.Position.Y.Offset + 20)
		painel.Visible = true

			-- Categorias de scripts (botões no centro do painel)
local categoria1 = Instance.new("TextButton", painel)
categoria1.Size = UDim2.new(0.4, 0, 0, 40)
categoria1.Position = UDim2.new(0.05, 0, 0.2, 0)
categoria1.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
categoria1.TextColor3 = Color3.fromRGB(0, 0, 0)
categoria1.Font = Enum.Font.Gotham
categoria1.TextSize = 14
categoria1.Text = "Scripts Padrões"
Instance.new("UICorner", categoria1).CornerRadius = UDim.new(0, 8)

local categoria2 = Instance.new("TextButton", painel)
categoria2.Size = UDim2.new(0.4, 0, 0, 40)
categoria2.Position = UDim2.new(0.55, 0, 0.2, 0)
categoria2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
categoria2.TextColor3 = Color3.fromRGB(0, 0, 0)
categoria2.Font = Enum.Font.Gotham
categoria2.TextSize = 14
categoria2.Text = "Scripts Malvados"
Instance.new("UICorner", categoria2).CornerRadius = UDim.new(0, 8)

-- Frame para exibir scripts (invisível até clicar)
local framePadroes = Instance.new("Frame", painel)
framePadroes.Size = UDim2.new(1, -20, 0, 160)
framePadroes.Position = UDim2.new(0, 10, 0.4, 0)
framePadroes.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
framePadroes.Visible = false
framePadroes.BorderSizePixel = 0
Instance.new("UICorner", framePadroes).CornerRadius = UDim.new(0, 8)

local frameMalvados = framePadroes:Clone()
frameMalvados.Parent = painel
frameMalvados.Visible = false

-- Alternar entre abas
categoria1.MouseButton1Click:Connect(function()
	framePadroes.Visible = true
	frameMalvados.Visible = false
end)

categoria2.MouseButton1Click:Connect(function()
	framePadroes.Visible = false
	frameMalvados.Visible = true
end)

-- Login
-- loginGui fica ativado no começo
loginGui.Enabled = true

-- hub principal começa desativado
screenGui.Enabled = false

entrarBtn.MouseButton1Click:Connect(function()
	if password.Text:lower():gsub("%s+", "") == senhaCorreta then
		loginGui:Destroy()        -- remove tela de login
		screenGui.Enabled = true   -- ativa o hub
		game:GetService("RunService").RenderStepped:Wait()
		acoplarBotao()
	else
		password.Text = ""
		password.PlaceholderText = "Senha incorreta!"
	end
end)
