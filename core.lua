-- StormdownnHub V1 - Core.lua (base para repo)

local Players = game:GetService("Players")
local Lighting = game:GetServic-- StormdownnHub V1 - Core.lua (base para repo)

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local password = "stormdownn"
local darkMode = true

-- Remove GUIs antigas pra evitar duplicatas
local function cleanOldGui()
	for _, guiName in ipairs({"StormdownnHub_Login", "StormdownnHub_Main", "StormdownnHub_Settings", "StormdownnHub_Readme"}) do
		local gui = playerGui:FindFirstChild(guiName)
		if gui then gui:Destroy() end
	end
end

-- Tela de Login
local function loadLogin()
	cleanOldGui()

	local loginGui = Instance.new("ScreenGui", playerGui)
	loginGui.Name = "StormdownnHub_Login"
	loginGui.ResetOnSpawn = false

	local frame = Instance.new("Frame", loginGui)
	frame.Size = UDim2.new(0, 320, 0, 220)
	frame.Position = UDim2.new(0.5, -160, 0.5, -110)
	frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	frame.Active = true
	frame.Draggable = true
	frame.BorderSizePixel = 0
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

	local title = Instance.new("TextLabel", frame)
	title.Text = "StormdownnHub Login"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 24
	title.Size = UDim2.new(1, 0, 0, 50)
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.new(1,1,1)

	local input = Instance.new("TextBox", frame)
	input.PlaceholderText = "Digite a senha..."
	input.Font = Enum.Font.Gotham
	input.TextSize = 18
	input.Size = UDim2.new(0.85, 0, 0, 45)
	input.Position = UDim2.new(0.075, 0, 0.45, 0)
	input.TextColor3 = Color3.new(1,1,1)
	input.BackgroundColor3 = Color3.fromRGB(40,40,40)
	input.BorderSizePixel = 0
	Instance.new("UICorner", input).CornerRadius = UDim.new(0, 10)

	local button = Instance.new("TextButton", frame)
	button.Text = "Entrar"
	button.Font = Enum.Font.GothamBold
	button.TextSize = 18
	button.Size = UDim2.new(0.5, 0, 0, 40)
	button.Position = UDim2.new(0.25, 0, 0.75, 0)
	button.BackgroundColor3 = Color3.fromRGB(60,60,60)
	button.TextColor3 = Color3.new(1,1,1)
	button.BorderSizePixel = 0
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 10)

	button.MouseButton1Click:Connect(function()
		if input.Text == password then
			loginGui:Destroy()
			loadMainHub()
		else
			button.Text = "Senha incorreta!"
			wait(1.2)
			button.Text = "Entrar"
		end
	end)
end

-- Função para criar botão toggle com texto e callback
local function createToggleButton(parent, name, callback)
	local button = Instance.new("TextButton", parent)
	button.Name = name .. "_Button"
	button.Size = UDim2.new(0.95, 0, 0, 40)
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Text = name .. ": OFF"
	button.Font = Enum.Font.Gotham
	button.TextSize = 17
	button.BorderSizePixel = 0
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

	local active = false
	button.MouseButton1Click:Connect(function()
		active = not active
		button.Text = name .. ": " .. (active and "ON" or "OFF")
		if callback then
			callback(active)
		end
	end)
	return button
end

-- Função para carregar a interface principal do hub
function loadMainHub()
	cleanOldGui()

	-- Aplica blur no fundo
	if not Lighting:FindFirstChild("StormdownnBlur") then
		local blur = Instance.new("BlurEffect", Lighting)
		blur.Name = "StormdownnBlur"
		blur.Size = 18
	end

	local mainGui = Instance.new("ScreenGui", playerGui)
	mainGui.Name = "StormdownnHub_Main"
	mainGui.ResetOnSpawn = false

	-- Fundo com imagem do Aizawa
	local bg = Instance.new("ImageLabel", mainGui)
	bg.Name = "Background"
	bg.Size = UDim2.new(1, 0, 1, 0)
	bg.Position = UDim2.new(0, 0, 0, 0)
	bg.Image = "rbxassetid://15327849226" -- Imagem Aizawa
	bg.ImageTransparency = 0.55
	bg.ScaleType = Enum.ScaleType.Crop
	bg.ZIndex = 0
	bg.BackgroundColor3 = Color3.new(0, 0, 0)
	bg.BackgroundTransparency = 0.4

	-- Painel principal
	local frame = Instance.new("Frame", mainGui)
	frame.Name = "MainFrame"
	frame.Size = UDim2.new(0, 410, 0, 380)
	frame.Position = UDim2.new(0.5, -205, 0.5, -190)
	frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	frame.BackgroundTransparency = 0.1
	frame.Active = true
	frame.Draggable = true
	frame.BorderSizePixel = 0
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

	-- Título do Hub
	local title = Instance.new("TextLabel", frame)
	title.Text = "StormdownnHub V1"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 26
	title.Size = UDim2.new(1, 0, 0, 50)
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.new(1, 1, 1)

	-- Container com scroll para os botões de script
	local scrollFrame = Instance.new("ScrollingFrame", frame)
	scrollFrame.Size = UDim2.new(0.95, 0, 1, -110)
	scrollFrame.Position = UDim2.new(0.025, 0, 0, 70)
	scrollFrame.CanvasSize = UDim2.new(0, 0, 2, 0) -- Ajusta se necessário
	scrollFrame.ScrollBarThickness = 8
	scrollFrame.BackgroundTransparency = 1

	local layout = Instance.new("UIListLayout", scrollFrame)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 10)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	-- Lista das features com callbacks (print só para exemplo)
	local features = {
		{ name = "Fly", callback = function(active) print("Fly:", active) end },
		{ name = "NoClip", callback = function(active) print("NoClip:", active) end },
		{ name = "ESP", callback = function(active) print("ESP:", active) end },
		{ name = "KillPlayers", callback = function(active) print("KillPlayers:", active) end },
		{ name = "WalkFling", callback = function(active) print("WalkFling:", active) end },
		{ name = "PuxarPlayer", callback = function(active) print("PuxarPlayer:", active) end },
		{ name = "EmotesR6", callback = function(active) print("EmotesR6:", active) end },
		{ name = "EmotesR15", callback = function(active) print("EmotesR15:", active) end },
		{ name = "RingParts", callback = function(active) print("RingParts:", active) end },
		{ name = "Magnet", callback = function(active) print("Magnet:", active) end },
		{ name = "LagOthers", callback = function(active) print("LagOthers:", active) end },
		{ name = "Telekinesis", callback = function(active) print("Telekinesis:", active) end },
	}

	for _, feature in ipairs(features) do
		createToggleButton(scrollFrame, feature.name, feature.callback)
	end

	-- Botão para abrir configurações
	local settingsBtn = Instance.new("TextButton", frame)
	settingsBtn.Size = UDim2.new(0, 50, 0, 50)
	settingsBtn.Position = UDim2.new(1, -60, 0, 10)
	settingsBtn.Text = "⚙️"
	settingsBtn.Font = Enum.Font.GothamBold
	settingsBtn.TextSize = 28
	settingsBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	settingsBtn.TextColor3 = Color3.new(1, 1, 1)
	settingsBtn.BorderSizePixel = 0
	settingsBtn.ZIndex = 10
	Instance.new("UICorner", settingsBtn).CornerRadius = UDim.new(1, 0)

	settingsBtn.MouseButton1Click:Connect(function()
		loadSettings()
	end)

	-- Botão flutuante para abrir/fechar o hub
	local toggleBtn = Instance.new("ImageButton", playerGui)
	toggleBtn.Name = "StormdownnHub_Toggle"
	toggleBtn.Size = UDim2.new(0, 50, 0, 50)
	toggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
	toggleBtn.BackgroundTransparency = 1
	toggleBtn.ZIndex = 15
	toggleBtn.Image = "rbxassetid://9699023831" -- Ícone tech (ou seu ícone personalizado)

	local open = true
	toggleBtn.MouseButton1Click:Connect(function()
		open = not open
		frame.Visible = open
	end)
end

-- Tela de Configurações
function loadSettings()
	local existing = playerGui:FindFirstChild("StormdownnHub_Settings")
	if existing then existing:Destroy() end

	local settingsGui = Instance.new("ScreenGui", playerGui)
	settingsGui.Name = "StormdownnHub_Settings"
	settingsGui.ResetOnSpawn = false
	settingsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local frame = Instance.new("Frame", settingsGui)
	frame.Size = UDim2.new(0, 350, 0, 320)
	frame.Position = UDim2.new(0.5, -175, 0.5, -160)
	frame.BackgroundColor3 = darkMode and Color3.fromRGB(25, 25, 25) or Color3.fromRGB(230, 230, 230)
	frame.Active = true
	frame.Draggable = true
	frame.BorderSizePixel = 0
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

	local title = Instance.new("TextLabel", frame)
	title.Text = "Configurações"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 24
	title.Size = UDim2.new(1, 0, 0, 50)
	title.BackgroundTransparency = 1
	title.TextColor3 = darkMode and Color3.new(1,1,1) or Color3.fromRGB(25,25,25)

	-- Imagem Criador Stormdownn
	local creatorStorm = Instance.new("ImageLabel", frame)
	creatorStorm.Size = UDim2.new(0, 60, 0, 60)
	creatorStorm.Position = UDim2.new(0, 20, 0, 70)
	creatorStorm.Image = "rbxassetid://17423995385" -- Troque para o ID da sua imagem
	creatorStorm.BackgroundTransparency = 1
	Instance.new("UICorner", creatorStorm).CornerRadius = UDim.new(0, 14)

	-- Imagem Criador ChatGPT
	local creatorChat = Instance.new("ImageLabel", frame)
	creatorChat.Size = UDim2.new(0, 60, 0, 60)
	creatorChat.Position = UDim2.new(0, 100, 0, 70)
	creatorChat.Image = "rbxassetid://17423995410" -- Troque para o ID da imagem do ChatGPT
	creatorChat.BackgroundTransparency = 1
	Instance.new("UICorner", creatorChat).CornerRadius = UDim.new(0, 14)

	-- Texto Criadores
	local creatorsText = Instance.new("TextLabel", frame)
	creatorsText.Text = "Criadores: STORMDOWNN, CHATGPT"
	creatorsText.Font = Enum.Font.Gotham
	creatorsText.TextSize = 18
	creatorsText.Position = UDim2.new(0, 20, 0, 140)
	creatorsText.Size = UDim2.new(1, -40, 0, 30)
	creatorsText.TextColor3 = darkMode and Color3.new(1,1,1) or Color3.fromRGB(25,25,25)
	creatorsText.BackgroundTransparency = 1

	-- Nome do Usuário
	local userNameLabel = Instance.new("TextLabel", frame)
	userNameLabel.Text = "Usuário: " .. player.Name
	userNameLabel.Font = Enum.Font.Gotham
	userNameLabel.TextSize = 18
	userNameLabel.Position = UDim2.new(0, 20, 0, 180)
	userNameLabel.Size = UDim2.new(1, -40, 0, 30)
	userNameLabel.TextColor3 = darkMode and Color3.new(1,1,1) or Color3.fromRGB(25,25,25)
	userNameLabel.BackgroundTransparency = 1

	-- Localização (fake)
	local locationLabel = Instance.new("TextLabel", frame)
	locationLabel.Text = "Localização: StormNet v1 (Wi-Fi Detectado)"
	locationLabel.Font = Enum.Font.Gotham
	locationLabel.TextSize = 18
	locationLabel.Position = UDim2.new(0, 20, 0, 220)
	locationLabel.Size = UDim2.new(1, -40, 0, 30)
	locationLabel.TextColor3 = darkMode and Color3.new(1,1,1) or Color3.fromRGB(25,25,25)
	locationLabel.BackgroundTransparency = 1

	-- Botão de Tema Claro/Escuro
	local themeBtn = Instance.new("TextButton", frame)
	themeBtn.Size = UDim2.new(0.8, 0, 0, 40)
	themeBtn.Position = UDim2.new(0.1, 0, 1, -60)
	themeBtn.Text = darkMode and "Modo Tema: Claro" or "Modo Tema: Escuro"
	themeBtn.Font = Enum.Font.Gotham
	themeBtn.TextSize = 18
	themeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	themeBtn.TextColor3 = Color3.new(1,1,1)
	themeBtn.BorderSizePixel = 0
	Instance.new("UICorner", themeBtn).CornerRadius = UDim.new(0, 10)

	themeBtn.MouseButton1Click:Connect(function()
		darkMode = not darkMode
		loadSettings()
		-- Poderia atualizar também a interface principal se quiser
	end)
end

-- Aba para mostrar README
local function showReadme()
	local colors = (darkMode and {
		bg = Color3.fromRGB(15,15,15),
		text = Color3.new(1,1,1)
	} or {
		bg = Color3.fromRGB(230,230,230),
		text = Color3.fromRGB(30,30,30)
	})

	local existing = playerGui:FindFirstChild("StormdownnHub_Readme")
	if existing then existing:Destroy() end

	local readmeGui = Instance.new("ScreenGui", playerGui)
	readmeGui.Name = "StormdownnHub_Readme"
	readmeGui.ResetOnSpawn = false

	local frame = Instance.new("Frame", readmeGui)
	frame.Size = UDim2.new(0, 480, 0, 420)
	frame.Position = UDim2.new(0.5, -240, 0.5, -210)
	frame.BackgroundColor3 = colors.bg
	frame.Active = true
	frame.Draggable = true
	frame.BorderSizePixel = 0
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

	local title = Instance.new("TextLabel", frame)
	title.Text = "README - StormdownnHub V1"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 24
	title.Size = UDim2.new(1, 0, 0, 50)
	title.BackgroundTransparency = 1
	title.TextColor3 = colors.text

	local closeBtn = Instance.new("TextButton", frame)
	closeBtn.Text = "Fechar"
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.TextSize = 18
	closeBtn.Size = UDim2.new(0, 75, 0, 35)
	closeBtn.Position = UDim2.new(1, -90, 0, 10)
	closeBtn.BackgroundColor3 = Color3.fromRGB(170, 40, 40)
	closeBtn.TextColor3 = Color3.new(1,1,1)
	closeBtn.BorderSizePixel = 0
	closeBtn.AutoButtonColor = true
	closeBtn.ZIndex = 10
	Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 10)

	closeBtn.MouseButton1Click:Connect(function()
		readmeGui:Destroy()
        end
e("Lighting")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local password = "stormdownn"
local darkMode = true

-- Remove GUIs antigas pra evitar duplicatas
local function cleanOldGui()
	for _, guiName in ipairs({"StormdownnHub_Login", "StormdownnHub_Main", "StormdownnHub_Settings", "StormdownnHub_Readme"}) do
		local gui = playerGui:FindFirstChild(guiName)
		if gui then gui:Destroy() end
	end
end

-- Tela de Login
local function loadLogin()
	cleanOldGui()

	local loginGui = Instance.new("ScreenGui", playerGui)
	loginGui.Name = "StormdownnHub_Login"
	loginGui.ResetOnSpawn = false

	local frame = Instance.new("Frame", loginGui)
	frame.Size = UDim2.new(0, 320, 0, 220)
	frame.Position = UDim2.new(0.5, -160, 0.5, -110)
	frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	frame.Active = true
	frame.Draggable = true
	frame.BorderSizePixel = 0
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

	local title = Instance.new("TextLabel", frame)
	title.Text = "StormdownnHub Login"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 24
	title.Size = UDim2.new(1, 0, 0, 50)
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.new(1,1,1)

	local input = Instance.new("TextBox", frame)
	input.PlaceholderText = "Digite a senha..."
	input.Font = Enum.Font.Gotham
	input.TextSize = 18
	input.Size = UDim2.new(0.85, 0, 0, 45)
	input.Position = UDim2.new(0.075, 0, 0.45, 0)
	input.TextColor3 = Color3.new(1,1,1)
	input.BackgroundColor3 = Color3.fromRGB(40,40,40)
	input.BorderSizePixel = 0
	Instance.new("UICorner", input).CornerRadius = UDim.new(0, 10)

	local button = Instance.new("TextButton", frame)
	button.Text = "Entrar"
	button.Font = Enum.Font.GothamBold
	button.TextSize = 18
	button.Size = UDim2.new(0.5, 0, 0, 40)
	button.Position = UDim2.new(0.25, 0, 0.75, 0)
	button.BackgroundColor3 = Color3.fromRGB(60,60,60)
	button.TextColor3 = Color3.new(1,1,1)
	button.BorderSizePixel = 0
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 10)

	button.MouseButton1Click:Connect(function()
		if input.Text == password then
			loginGui:Destroy()
			loadMainHub()
		else
			button.Text = "Senha incorreta!"
			wait(1.2)
			button.Text = "Entrar"
		end
	end)
end

-- Função para criar botão toggle com texto e callback
local function createToggleButton(parent, name, callback)
	local button = Instance.new("TextButton", parent)
	button.Name = name .. "_Button"
	button.Size = UDim2.new(0.95, 0, 0, 40)
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Text = name .. ": OFF"
	button.Font = Enum.Font.Gotham
	button.TextSize = 17
	button.BorderSizePixel = 0
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

	local active = false
	button.MouseButton1Click:Connect(function()
		active = not active
		button.Text = name .. ": " .. (active and "ON" or "OFF")
		if callback then
			callback(active)
		end
	end)
	return button
end

-- Função para carregar a interface principal do hub
function loadMainHub()
	cleanOldGui()

	-- Aplica blur no fundo
	if not Lighting:FindFirstChild("StormdownnBlur") then
		local blur = Instance.new("BlurEffect", Lighting)
		blur.Name = "StormdownnBlur"
		blur.Size = 18
	end

	local mainGui = Instance.new("ScreenGui", playerGui)
	mainGui.Name = "StormdownnHub_Main"
	mainGui.ResetOnSpawn = false

	-- Fundo com imagem do Aizawa
	local bg = Instance.new("ImageLabel", mainGui)
	bg.Name = "Background"
	bg.Size = UDim2.new(1, 0, 1, 0)
	bg.Position = UDim2.new(0, 0, 0, 0)
	bg.Image = "rbxassetid://15327849226" -- Imagem Aizawa
	bg.ImageTransparency = 0.55
	bg.ScaleType = Enum.ScaleType.Crop
	bg.ZIndex = 0
	bg.BackgroundColor3 = Color3.new(0, 0, 0)
	bg.BackgroundTransparency = 0.4

	-- Painel principal
	local frame = Instance.new("Frame", mainGui)
	frame.Name = "MainFrame"
	frame.Size = UDim2.new(0, 410, 0, 380)
	frame.Position = UDim2.new(0.5, -205, 0.5, -190)
	frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	frame.BackgroundTransparency = 0.1
	frame.Active = true
	frame.Draggable = true
	frame.BorderSizePixel = 0
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

	-- Título do Hub
	local title = Instance.new("TextLabel", frame)
	title.Text = "StormdownnHub V1"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 26
	title.Size = UDim2.new(1, 0, 0, 50)
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.new(1, 1, 1)

	-- Container com scroll para os botões de script
	local scrollFrame = Instance.new("ScrollingFrame", frame)
	scrollFrame.Size = UDim2.new(0.95, 0, 1, -110)
	scrollFrame.Position = UDim2.new(0.025, 0, 0, 70)
	scrollFrame.CanvasSize = UDim2.new(0, 0, 2, 0) -- Ajusta se necessário
	scrollFrame.ScrollBarThickness = 8
	scrollFrame.BackgroundTransparency = 1

	local layout = Instance.new("UIListLayout", scrollFrame)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 10)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	-- Lista das features com callbacks (print só para exemplo)
	local features = {
		{ name = "Fly", callback = function(active) print("Fly:", active) end },
		{ name = "NoClip", callback = function(active) print("NoClip:", active) end },
		{ name = "ESP", callback = function(active) print("ESP:", active) end },
		{ name = "KillPlayers", callback = function(active) print("KillPlayers:", active) end },
		{ name = "WalkFling", callback = function(active) print("WalkFling:", active) end },
		{ name = "PuxarPlayer", callback = function(active) print("PuxarPlayer:", active) end },
		{ name = "EmotesR6", callback = function(active) print("EmotesR6:", active) end },
		{ name = "EmotesR15", callback = function(active) print("EmotesR15:", active) end },
		{ name = "RingParts", callback = function(active) print("RingParts:", active) end },
		{ name = "Magnet", callback = function(active) print("Magnet:", active) end },
		{ name = "LagOthers", callback = function(active) print("LagOthers:", active) end },
		{ name = "Telekinesis", callback = function(active) print("Telekinesis:", active) end },
	}

	for _, feature in ipairs(features) do
		createToggleButton(scrollFrame, feature.name, feature.callback)
	end

	-- Botão para abrir configurações
	local settingsBtn = Instance.new("TextButton", frame)
	settingsBtn.Size = UDim2.new(0, 50, 0, 50)
	settingsBtn.Position = UDim2.new(1, -60, 0, 10)
	settingsBtn.Text = "⚙️"
	settingsBtn.Font = Enum.Font.GothamBold
	settingsBtn.TextSize = 28
	settingsBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	settingsBtn.TextColor3 = Color3.new(1, 1, 1)
	settingsBtn.BorderSizePixel = 0
	settingsBtn.ZIndex = 10
	Instance.new("UICorner", settingsBtn).CornerRadius = UDim.new(1, 0)

	settingsBtn.MouseButton1Click:Connect(function()
		loadSettings()
	end)

	-- Botão flutuante para abrir/fechar o hub
	local toggleBtn = Instance.new("ImageButton", playerGui)
	toggleBtn.Name = "StormdownnHub_Toggle"
	toggleBtn.Size = UDim2.new(0, 50, 0, 50)
	toggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
	toggleBtn.BackgroundTransparency = 1
	toggleBtn.ZIndex = 15
	toggleBtn.Image = "rbxassetid://9699023831" -- Ícone tech (ou seu ícone personalizad
