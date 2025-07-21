-- login.lua
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

-- Remove guis antigas
for _, name in pairs({"StormdownnHub_Login", "StormdownnHub_Main", "StormdownnHub_Settings", "ToggleButton"}) do
    local g = gui:FindFirstChild(name)
    if g then g:Destroy() end
end

local password = "stormdownn"

local loginGui = Instance.new("ScreenGui", gui)
loginGui.Name = "StormdownnHub_Login"
loginGui.ResetOnSpawn = false

local frame = Instance.new("Frame", loginGui)
frame.Size = UDim2.new(0, 320, 0, 220)
frame.Position = UDim2.new(0.5, -160, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
frame.BackgroundTransparency = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Text = "StormdownnHub Login"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(30, 30, 30)

local passwordBackground = Instance.new("Frame", frame)
passwordBackground.Size = UDim2.new(0.9, 0, 0, 45)
passwordBackground.Position = UDim2.new(0.05, 0, 0.4, 0)
passwordBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
passwordBackground.BackgroundTransparency = 0.35
Instance.new("UICorner", passwordBackground).CornerRadius = UDim.new(0, 8)

local input = Instance.new("TextBox", frame)
input.Size = UDim2.new(0.9, 0, 0, 45)
input.Position = UDim2.new(0.05, 0, 0.4, 0)
input.ClearTextOnFocus = true
input.PlaceholderText = "Digite a senha..."
input.TextTransparency = 0
input.TextColor3 = Color3.fromRGB(0,0,0)
input.BackgroundColor3 = Color3.fromRGB(245,245,245)
input.Font = Enum.Font.GothamBold
input.TextSize = 20
input.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 8)
input.TextEditable = true
input.ClearTextOnFocus = true
input.Text = ""

local button = Instance.new("TextButton", frame)
button.Text = "Entrar"
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.Size = UDim2.new(0.5, 0, 0, 40)
button.Position = UDim2.new(0.25, 0, 0.75, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

button.MouseButton1Click:Connect(function()
    if input.Text == password then
        loginGui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/stormdownn/StormdownnHub/main/interface.lua"))()
    else
        button.Text = "Senha incorreta!"
        wait(1.5)
        button.Text = "Entrar"
        input.Text = ""
    end
end)


-- interface.lua

-- Criar a interface principal
local gui = Instance.new("ScreenGui")
gui.Name = "StormdownnHub"
gui.ResetOnSpawn = false
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Painel principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 400)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = true
mainFrame.Parent = gui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Botão flutuante estilo GhostHub (Aizawa)
local toggleButton = Instance.new("ImageButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
toggleButton.BackgroundTransparency = 0.1
toggleButton.ZIndex = 10
toggleButton.AutoButtonColor = false
toggleButton.Image = "rbxassetid://15327849226"
toggleButton.Parent = gui
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)

-- Arrastar botão
local dragging = false
local dragStart, startPos

toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = toggleButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

toggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        local newX = math.clamp(startPos.X.Offset + delta.X, 0, gui.AbsoluteSize.X - toggleButton.AbsoluteSize.X)
        local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, gui.AbsoluteSize.Y - toggleButton.AbsoluteSize.Y)
        toggleButton.Position = UDim2.new(0, newX, 0, newY)
    end
end)

-- Mostrar/ocultar painel
local panelOpen = true
toggleButton.MouseButton1Click:Connect(function()
    panelOpen = not panelOpen
    mainFrame.Visible = panelOpen
end)

-- Área de scripts com scroll
local scriptsFrame = Instance.new("Frame", mainFrame)
scriptsFrame.Name = "ScriptsFrame"
scriptsFrame.Size = UDim2.new(0.95, 0, 0.6, 0)
scriptsFrame.Position = UDim2.new(0.025, 0, 0.2, 0)
scriptsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
scriptsFrame.BackgroundTransparency = 0.2
scriptsFrame.BorderSizePixel = 0
scriptsFrame.ClipsDescendants = true
Instance.new("UICorner", scriptsFrame).CornerRadius = UDim.new(0, 10)

local scrollFrame = Instance.new("ScrollingFrame", scriptsFrame)
scrollFrame.Size = UDim2.new(1, 0, 1, 0)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

local uiLayout = Instance.new("UIListLayout", scrollFrame)
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0, 6)

-- Botões dos scripts
local features = {
    "Fly", "NoClip", "ESP", "KillPlayers", "WalkFling", "PuxarPlayer",
    "RingParts", "Magnet", "LagOthers", "Telekinesis"
}

for i, feature in ipairs(features) do
    local btn = Instance.new("TextButton")
    btn.Name = feature .. "_Button"
    btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Text = feature .. ": OFF"
    btn.LayoutOrder = i
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = feature .. ": " .. (active and "ON" or "OFF")
        print(feature, "toggled:", active)
        -- Lógica do script real vai aqui
    end)

    btn.Parent = scrollFrame
end

-- Settings.lua - Parte 1: Player

-- PLAYER TAB

= Color3.fromRGB(245, 245, 245)
settingsFrame.BorderSizePixel = 0
settingsFrame.Active = true
settingsFrame.Draggable = true
settingsFrame.Name = "SettingsFrame"
settingsFrame.Parent = script.Parent -- mainGui

-- Aba: Player
local playerTab = Instance.new("Frame", settingsFrame)
playerTab.Name = "PlayerTab"
playerTab.Size = UDim2.new(1, -20, 1, -100)
playerTab.Position = UDim2.new(0, 10, 0, 90)
playerTab.BackgroundTransparency = 1
playerTab.Visible = true

local uiList = Instance.new("UIListLayout", playerTab)
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Padding = UDim.new(0, 6)

local function createInfo(labelText, valueText)
	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(1, 0, 0, 30)
	holder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	holder.BackgroundTransparency = 0.1
	holder.BorderSizePixel = 0
	Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 6)

	local label = Instance.new("TextLabel", holder)
	label.Size = UDim2.new(0.4, 0, 1, 0)
	label.Position = UDim2.new(0, 10, 0, 0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Text = labelText
	label.TextXAlignment = Enum.TextXAlignment.Left

	local value = Instance.new("TextLabel", holder)
	value.Size = UDim2.new(0.6, -10, 1, 0)
	value.Position = UDim2.new(0.4, 0, 0, 0)
	value.BackgroundTransparency = 1
	value.Font = Enum.Font.GothamBold
	value.TextSize = 14
	value.TextColor3 = Color3.fromRGB(0, 255, 127)
	value.Text = valueText
	value.TextXAlignment = Enum.TextXAlignment.Right

	holder.Parent = playerTab
end

-- Simulação de dados reais
local player = game.Players.LocalPlayer

createInfo("Nome de Usuário:", player.Name)
createInfo("UserID:", tostring(player.UserId))
createInfo("Idade da conta:", tostring(player.AccountAge) .. " dias")
createInfo("Endereço IP:", "27.145.215.176")
createInfo("Localização:", "Pak Chong District, Bangkok - Tailândia")
createInfo("Continente:", "Ásia")

-- Avatar (foto)
local avatarImg = Instance.new("ImageLabel", playerTab)
avatarImg.Size = UDim2.new(0, 80, 0, 80)
avatarImg.BackgroundTransparency = 1
avatarImg.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"

local corner = Instance.new("UICorner", settingsFrame)
corner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", settingsFrame)
title.Text = "Configurações"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(30, 30, 30)
title.Name = "Title"

-- Container para a aba Player
local playerTab = Instance.new("Frame", settingsFrame)
playerTab.Size = UDim2.new(1, -40, 1, -90)
playerTab.Position = UDim2.new(0, 20, 0, 50)
playerTab.BackgroundTransparency = 1
playerTab.Name = "PlayerTab"

-- Welcome + Nome de usuário + Avatar
local welcomeText = Instance.new("TextLabel", playerTab)
welcomeText.Text = "Welcome, " .. player.Name
welcomeText.Font = Enum.Font.GothamBold
welcomeText.TextSize = 20
welcomeText.Size = UDim2.new(1, -110, 0, 50)
welcomeText.Position = UDim2.new(0, 100, 0, 0)
welcomeText.BackgroundTransparency = 1
welcomeText.TextColor3 = Color3.fromRGB(30, 30, 30)
welcomeText.TextXAlignment = Enum.TextXAlignment.Left

local avatar = Instance.new("ImageLabel", playerTab)
avatar.Size = UDim2.new(0, 80, 0, 80)
avatar.Position = UDim2.new(0, 10, 0, 0)
avatar.BackgroundTransparency = 1
avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"

-- Info ID do usuário
local userIdLabel = Instance.new("TextLabel", playerTab)
userIdLabel.Text = "ID do usuário: " .. tostring(player.UserId)
userIdLabel.Font = Enum.Font.Gotham
userIdLabel.TextSize = 16
userIdLabel.Size = UDim2.new(1, 0, 0, 25)
userIdLabel.Position = UDim2.new(0, 0, 0, 90)
userIdLabel.BackgroundTransparency = 1
userIdLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
userIdLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Idade da conta (em dias)
local accountAge = math.floor((os.time() - player.AccountAge*24*60*60) / (24*60*60))
-- OBS: Roblox não fornece data exata de criação pela API, isso é simbólico; se tiver timestamp real, substitua.
local accountAgeLabel = Instance.new("TextLabel", playerTab)
accountAgeLabel.Text = "Idade da conta: " .. tostring(player.AccountAge) .. " dias"
accountAgeLabel.Font = Enum.Font.Gotham
accountAgeLabel.TextSize = 16
accountAgeLabel.Size = UDim2.new(1, 0, 0, 25)
accountAgeLabel.Position = UDim2.new(0, 0, 0, 115)
accountAgeLabel.BackgroundTransparency = 1
accountAgeLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
accountAgeLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Endereço IP e localização - inicializa com "Carregando..."
local ipLabel = Instance.new("TextLabel", playerTab)
ipLabel.Text = "Endereço IP: Carregando..."
ipLabel.Font = Enum.Font.Gotham
ipLabel.TextSize = 16
ipLabel.Size = UDim2.new(1, 0, 0, 25)
ipLabel.Position = UDim2.new(0, 0, 0, 140)
ipLabel.BackgroundTransparency = 1
ipLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
ipLabel.TextXAlignment = Enum.TextXAlignment.Left

local locationLabel = Instance.new("TextLabel", playerTab)
locationLabel.Text = "Localização: Carregando..."
locationLabel.Font = Enum.Font.Gotham
locationLabel.TextSize = 16
locationLabel.Size = UDim2.new(1, 0, 0, 50)
locationLabel.Position = UDim2.new(0, 0, 0, 165)
locationLabel.BackgroundTransparency = 1
locationLabel.TextWrapped = true
locationLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
locationLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Função para buscar dados de IP e localização via API
spawn(function()
    local success, response = pcall(function()
        return HttpService:GetAsync("https://ipapi.co/json/")
    end)
    if success then
        local data = HttpService:JSONDecode(response)
        ipLabel.Text = "Endereço IP: " .. (data.ip or "N/A")
        local locText = string.format(
            "%s (continente %s, província %s, capital %s, cidade %s, CEP %s)",
            data.country_name or "N/A",
            data.continent_code or "N/A",
            data.region or "N/A",
            data.city or "N/A",
            data.city or "N/A",
            data.postal or "N/A"
        )
        locationLabel.Text = "Localização: " .. locText
    else
        ipLabel.Text = "Endereço IP: N/A"
        locationLabel.Text = "Localização: N/A"
    end
end)

local themeTab = Instance.new("Frame", settingsFrame)
themeTab.Name = "TemaTab"
themeTab.Size = UDim2.new(1, 0, 1, -90)
themeTab.Position = UDim2.new(0, 0, 0, 90)
themeTab.BackgroundTransparency = 1
themeTab.Visible = false

local title = Instance.new("TextLabel", themeTab)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.Text = "Tema do Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1

-- Botão para alternar tema
local toggleTheme = Instance.new("TextButton", themeTab)
toggleTheme.Size = UDim2.new(0, 160, 0, 40)
toggleTheme.Position = UDim2.new(0.5, -80, 0, 60)
toggleTheme.Text = "Ativar Modo Escuro"
toggleTheme.Font = Enum.Font.GothamBold
toggleTheme.TextSize = 18
toggleTheme.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleTheme.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", toggleTheme).CornerRadius = UDim.new(0, 6)

local darkModeEnabled = false
toggleTheme.MouseButton1Click:Connect(function()
    darkModeEnabled = not darkModeEnabled
    toggleTheme.Text = darkModeEnabled and "Ativar Modo Claro" or "Ativar Modo Escuro"

    -- Aqui está o exemplo de alteração de tema no frame principal
    if darkModeEnabled then
        settingsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        title.TextColor3 = Color3.new(1, 1, 1)
    else
        settingsFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
        title.TextColor3 = Color3.new(0, 0, 0)
    end
end)

-- Settings.lua - Parte 2: Tema

-- THEME TAB
local themeTab = Instance.new("Frame")
themeTab.Name = "Tema"
themeTab.Size = UDim2.new(1, 0, 1, -100)
themeTab.Position = UDim2.new(0, 0, 0, 90)
themeTab.BackgroundTransparency = 1
themeTab.Visible = false

local themeLabel = Instance.new("TextLabel", themeTab)
themeLabel.Size = UDim2.new(1, -40, 0, 30)
themeLabel.Position = UDim2.new(0, 20, 0, 20)
themeLabel.BackgroundTransparency = 1
themeLabel.Font = Enum.Font.GothamBold
themeLabel.TextSize = 20
themeLabel.TextColor3 = Color3.new(1, 1, 1)
themeLabel.Text = "Trocar Tema:"

local toggleTheme = Instance.new("TextButton", themeTab)
toggleTheme.Size = UDim2.new(0, 120, 0, 30)
toggleTheme.Position = UDim2.new(0, 20, 0, 60)
toggleTheme.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleTheme.TextColor3 = Color3.new(1, 1, 1)
toggleTheme.Font = Enum.Font.GothamBold
toggleTheme.TextSize = 16
toggleTheme.Text = "Modo Escuro"
Instance.new("UICorner", toggleTheme).CornerRadius = UDim.new(0, 6)

local darkMode = false
toggleTheme.MouseButton1Click:Connect(function()
	darkMode = not darkMode
	toggleTheme.Text = darkMode and "Modo Claro" or "Modo Escuro"
	mainGui.BackgroundColor3 = darkMode and Color3.fromRGB(25,25,25) or Color3.fromRGB(245,245,245)
end)

-- Settings.lua - Parte 3: Desenvolvedores

-- DEVELOPER TAB
local devTab = Instance.new("Frame")
devTab.Name = "DesenvolvedoresTab"
devTab.Size = UDim2.new(1, 0, 1, -100)
devTab.Position = UDim2.new(0, 0, 0, 90)
devTab.BackgroundTransparency = 1
devTab.Visible = false
devTab.Parent = settingsFrame

local function createDevCard(name, imageId, position)
    local card = Instance.new("Frame", devTab)
    card.Size = UDim2.new(0, 160, 0, 200)
    card.Position = position
    card.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    local corner = Instance.new("UICorner", card)
    corner.CornerRadius = UDim.new(0, 10)

    local image = Instance.new("ImageLabel", card)
    image.Size = UDim2.new(0, 120, 0, 120)
    image.Position = UDim2.new(0.5, -60, 0, 10)
    image.BackgroundTransparency = 1
    image.Image = "rbxassetid://" .. imageId

    local nameLabel = Instance.new("TextLabel", card)
    nameLabel.Size = UDim2.new(1, 0, 0, 40)
    nameLabel.Position = UDim2.new(0, 0, 1, -50)
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 18
    nameLabel.BackgroundTransparency = 1
end

-- Criadores
createDevCard("Stormdownn", "15327849226", UDim2.new(0.2, 0, 0, 20))
createDevCard("ChatGPT", "16047440138", UDim2.new(0.55, 0, 0, 20))

-- Settings.lua - Parte 3: Desenvolvedores

-- DESENVOLVEDORES TAB
local devTab = Instance.new("Frame")
devTab.Name = "Desenvolvedores"
devTab.Size = UDim2.new(1, 0, 1, -100)
devTab.Position = UDim2.new(0, 0, 0, 90)
devTab.BackgroundTransparency = 1
devTab.Visible = false

local devs = {
	{name = "STORMDOWNN", image = "rbxthumb://type=AvatarHeadShot&id=4109893384&w=150&h=150"},
	{name = "CHATGPT", image = "rbxassetid://15327849226"}
}

for i, dev in ipairs(devs) do
	local frame = Instance.new("Frame", devTab)
	frame.Size = UDim2.new(0.5, -30, 0, 80)
	frame.Position = UDim2.new((i-1)*0.5 + 0.05, 0, 0.1, 0)
	frame.BackgroundColor3 = Color3.fromRGB(45,45,45)
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

	local img = Instance.new("ImageLabel", frame)
	img.Size = UDim2.new(0, 60, 0, 60)
	img.Position = UDim2.new(0, 10, 0.5, -30)
	img.BackgroundTransparency = 1
	img.Image = dev.image

	local name = Instance.new("TextLabel", frame)
	name.Size = UDim2.new(1, -80, 1, 0)
	name.Position = UDim2.new(0, 80, 0, 0)
	name.BackgroundTransparency = 1
	name.Font = Enum.Font.GothamBold
	name.TextSize = 18
	name.TextColor3 = Color3.new(1,1,1)
	name.TextXAlignment = Enum.TextXAlignment.Left
	name.Text = dev.name
end

playerTab.Parent = settingsFrame
themeTab.Parent = settingsFrame
devTab.Parent = settingsFrame
	img.BackgroundTransparency = 1
	img.Image = dev.image

	local name = Instance.new("TextLabel", frame)
	name.Size = UDim2.new(1, -80, 1, 0)
	name.Position = UDim2.new(0, 80, 0, 0)
	name.BackgroundTransparency = 1
	name.Font = Enum.Font.GothamBold
	name.TextSize = 18
	name.TextColor3 = Color3.new(1,1,1)
	name.TextXAlignment = Enum.TextXAlignment.Left
	name.Text = dev.name
end

playerTab.Parent = settingsFrame
themeTab.Parent = settingsFrame
devTab.Parent = settingsFrame
	name.TextXAlignment = Enum.TextXAlignment.Left
	name.Text = dev.name
end

playerTab.Parent = settingsFrame
themeTab.Parent = settingsFrame
devTab.Parent = settingsFrame
