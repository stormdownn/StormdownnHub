-- main.lua - StormdownnHub V1

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")

local HttpService = game:GetService("HttpService")

-- Remove GUIs antigas para evitar duplicação
for _, name in pairs({"StormdownnHub_Login", "StormdownnHub_Main", "StormdownnHub_Toggle", "StormdownnHub_Settings"}) do
    local oldGui = guiParent:FindFirstChild(name)
    if oldGui then oldGui:Destroy() end
end

-- =========
-- TELA DE LOGIN
-- =========
local loginGui = Instance.new("ScreenGui", guiParent)
loginGui.Name = "StormdownnHub_Login"
loginGui.ResetOnSpawn = false

local loginFrame = Instance.new("Frame", loginGui)
loginFrame.Size = UDim2.new(0, 320, 0, 180)
loginFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
loginFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
loginFrame.BorderSizePixel = 0
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", loginFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Stormdownn Hub Login"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 22

local passwordBackground = Instance.new("Frame", loginFrame)
passwordBackground.Size = UDim2.new(0.9, 0, 0, 50)
passwordBackground.Position = UDim2.new(0.05, 0, 0.4, 0)
passwordBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
passwordBackground.BackgroundTransparency = 0.3
Instance.new("UICorner", passwordBackground).CornerRadius = UDim.new(0, 10)

local passwordBox = Instance.new("TextBox", loginFrame)
passwordBox.Size = UDim2.new(0.9, 0, 0, 50)
passwordBox.Position = UDim2.new(0.05, 0, 0.4, 0)
passwordBox.PlaceholderText = "Digite a senha..."
passwordBox.ClearTextOnFocus = false
passwordBox.Font = Enum.Font.GothamBold
passwordBox.TextColor3 = Color3.new(1,1,1)
passwordBox.TextSize = 22
passwordBox.BackgroundTransparency = 1
passwordBox.TextXAlignment = Enum.TextXAlignment.Left
passwordBox.Text = ""
passwordBox.TextEditable = true
passwordBox.ClearTextOnFocus = true
passwordBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
passwordBox.TextTransparency = 0

local loginButton = Instance.new("TextButton", loginFrame)
loginButton.Size = UDim2.new(0.9, 0, 0, 40)
loginButton.Position = UDim2.new(0.05, 0, 0.75, 0)
loginButton.Text = "Entrar"
loginButton.Font = Enum.Font.GothamBold
loginButton.TextSize = 20
loginButton.TextColor3 = Color3.new(1,1,1)
loginButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
loginButton.BorderSizePixel = 0
Instance.new("UICorner", loginButton).CornerRadius = UDim.new(0, 10)

local incorrectLabel = Instance.new("TextLabel", loginFrame)
incorrectLabel.Size = UDim2.new(1, 0, 0, 24)
incorrectLabel.Position = UDim2.new(0, 0, 1, -24)
incorrectLabel.BackgroundTransparency = 1
incorrectLabel.Text = ""
incorrectLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
incorrectLabel.Font = Enum.Font.Gotham
incorrectLabel.TextSize = 16

local HUB_PASSWORD = "stormdownn"

-- =========
-- HUB PRINCIPAL (inicialmente invisível)
-- =========
local mainGui = Instance.new("ScreenGui", guiParent)
mainGui.Name = "StormdownnHub_Main"
mainGui.ResetOnSpawn = false
mainGui.Enabled = false

-- Main frame
local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 480, 0, 400)
mainFrame.Position = UDim2.new(0.5, -240, 0.5, -200)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.1
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

-- Blur image do Aizawa como wallpaper com transparência
local blurImg = Instance.new("ImageLabel", mainFrame)
blurImg.Size = UDim2.new(1, 0, 1, 0)
blurImg.Position = UDim2.new(0, 0, 0, 0)
blurImg.BackgroundTransparency = 1
blurImg.Image = "rbxassetid://15327849226" -- Aizawa
blurImg.ImageTransparency = 0.8
blurImg.ScaleType = Enum.ScaleType.Crop
blurImg.ZIndex = 0

-- Scripts frame com scroll
local scriptsFrame = Instance.new("Frame", mainFrame)
scriptsFrame.Name = "ScriptsFrame"
scriptsFrame.Size = UDim2.new(0.95, 0, 0.6, 0)
scriptsFrame.Position = UDim2.new(0.025, 0, 0.22, 0)
scriptsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
scriptsFrame.BackgroundTransparency = 0.3
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
    btn.Size = UDim2.new(0.95, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Text = feature .. ": OFF"
    btn.LayoutOrder = i
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = feature .. ": " .. (active and "ON" or "OFF")
        print("[StormdownnHub] Feature toggled:", feature, active)
        -- Aqui entra a lógica real do script
    end)

    btn.Parent = scrollFrame
end

-- Botão para abrir configurações no painel principal
local settingsButton = Instance.new("TextButton", mainFrame)
settingsButton.Name = "SettingsButton"
settingsButton.Size = UDim2.new(0.25, 0, 0, 38)
settingsButton.Position = UDim2.new(0.7, 0, 0.85, 0)
settingsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
settingsButton.TextColor3 = Color3.new(1, 1, 1)
settingsButton.Font = Enum.Font.GothamBold
settingsButton.TextSize = 18
settingsButton.Text = "Configurações"
Instance.new("UICorner", settingsButton).CornerRadius = UDim.new(0, 8)

settingsButton.MouseButton1Click:Connect(function()
    mainGui.Enabled = false
    settingsGui.Enabled = true
end)

-- Botão flutuante estilo GhostHub (Aizawa)
local toggleButton = Instance.new("ImageButton", guiParent)
toggleButton.Name = "StormdownnHub_Toggle"
toggleButton.Size = UDim2.new(0, 42, 0, 42)
toggleButton.Position = UDim2.new(0, 12, 0, 12)
toggleButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
toggleButton.BackgroundTransparency = 0.15
toggleButton.AutoButtonColor = false
toggleButton.Image = "rbxassetid://15327849226"
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)
toggleButton.ZIndex = 20

-- Dragging logic para o botão flutuante
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
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        local newX = math.clamp(startPos.X.Offset + delta.X, 0, guiParent.AbsoluteSize.X - toggleButton.AbsoluteSize.X)
        local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, guiParent.AbsoluteSize.Y - toggleButton.AbsoluteSize.Y)
        toggleButton.Position = UDim2.new(0, newX, 0, newY)
    end
end)

-- Alterna mostrar/ocultar painel principal
local panelOpen = true
toggleButton.MouseButton1Click:Connect(function()
    panelOpen = not panelOpen
    mainFrame.Visible = panelOpen
end)

-- =======
-- TELA DE CONFIGURAÇÕES
-- =======
local settingsGui = Instance.new("ScreenGui", guiParent)
settingsGui.Name = "StormdownnHub_Settings"
settingsGui.ResetOnSpawn = false
settingsGui.Enabled = false

local settingsFrame = Instance.new("Frame", settingsGui)
settingsFrame.Size = UDim2.new(0, 480, 0, 400)
settingsFrame.Position = UDim2.new(0.5, -240, 0.5, -200)
settingsFrame.AnchorPoint = Vector2.new(0.5, 0.5)
settingsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
settingsFrame.BackgroundTransparency = 0.1
Instance.new("UICorner", settingsFrame).CornerRadius = UDim.new(0, 14)
-- Abas container
local tabsFrame = Instance.new("Frame", settingsFrame)
tabsFrame.Size = UDim2.new(1, 0, 0, 40)
tabsFrame.Position = UDim2.new(0, 0, 0, 36)
tabsFrame.BackgroundTransparency = 1

-- Botões das abas
local tabNames = {"Player", "Tema", "Desenvolvedores"}
local tabButtons = {}

local selectedColor = Color3.fromRGB(80, 80, 80)
local defaultColor = Color3.fromRGB(40, 40, 40)

local function selectTab(tabName)
    for name, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = (name == tabName) and selectedColor or defaultColor
        tabsFrames[name].Visible = (name == tabName)
    end
end

-- Criar frames das abas para o conteúdo
local tabsFrames = {}

-- Abas
for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton", tabsFrame)
    btn.Size = UDim2.new(1/#tabNames, -4, 1, -4)
    btn.Position = UDim2.new((i-1)/#tabNames, 2, 0, 2)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = defaultColor
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    tabButtons[name] = btn

    local tabFrame = Instance.new("Frame", settingsFrame)
    tabFrame.Size = UDim2.new(1, -20, 1, -90)
    tabFrame.Position = UDim2.new(0, 10, 0, 80)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = false
    tabsFrames[name] = tabFrame

    btn.MouseButton1Click:Connect(function()
        selectTab(name)
    end)
end

-- === Conteúdo das abas ===

-- Player
do
    local frame = tabsFrames["Player"]
    -- Exemplo: nome do usuário
    local usernameLabel = Instance.new("TextLabel", frame)
    usernameLabel.Size = UDim2.new(1, 0, 0, 30)
    usernameLabel.Position = UDim2.new(0, 0, 0, 0)
    usernameLabel.BackgroundTransparency = 1
    usernameLabel.Text = "Nome do usuário: " .. player.Name
    usernameLabel.Font = Enum.Font.Gotham
    usernameLabel.TextSize = 18
    usernameLabel.TextColor3 = Color3.new(1,1,1)
    usernameLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Id do usuário
    local idLabel = Instance.new("TextLabel", frame)
    idLabel.Size = UDim2.new(1, 0, 0, 30)
    idLabel.Position = UDim2.new(0, 0, 0, 35)
    idLabel.BackgroundTransparency = 1
    idLabel.Text = "User ID: " .. tostring(player.UserId)
    idLabel.Font = Enum.Font.Gotham
    idLabel.TextSize = 18
    idLabel.TextColor3 = Color3.new(1,1,1)
    idLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Aqui você pode colocar mais info do player, IP, localização, etc.
end

-- Tema
do
    local frame = tabsFrames["Tema"]

    local themeLabel = Instance.new("TextLabel", frame)
    themeLabel.Size = UDim2.new(1, 0, 0, 30)
    themeLabel.Position = UDim2.new(0, 0, 0, 0)
    themeLabel.BackgroundTransparency = 1
    themeLabel.Text = "Escolha o tema:"
    themeLabel.Font = Enum.Font.Gotham
    themeLabel.TextSize = 18
    themeLabel.TextColor3 = Color3.new(1,1,1)
    themeLabel.TextXAlignment = Enum.TextXAlignment.Left

    local themeOptions = {"Claro", "Escuro"}
    local currentTheme = "Claro"

    for i, option in ipairs(themeOptions) do
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0.3, 0, 0, 35)
        btn.Position = UDim2.new(0.05 + (i-1)*0.35, 0, 0, 40)
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 18
        btn.Text = option
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        btn.MouseButton1Click:Connect(function()
            currentTheme = option
            print("Tema alterado para:", currentTheme)
            -- Aqui você troca o tema da interface (exemplo)
            -- Poderia aplicar mudanças nas cores do mainGui e settingsGui
        end)
    end
end

-- Desenvolvedores
do
    local frame = tabsFrames["Desenvolvedores"]

    local devLabel = Instance.new("TextLabel", frame)
    devLabel.Size = UDim2.new(1, 0, 0, 30)
    devLabel.Position = UDim2.new(0, 0, 0, 0)
    devLabel.BackgroundTransparency = 1
    devLabel.Text = "Criadores:"
    devLabel.Font = Enum.Font.GothamBold
    devLabel.TextSize = 20
    devLabel.TextColor3 = Color3.new(1,1,1)
    devLabel.TextXAlignment = Enum.TextXAlignment.Left

    local devs = {
        {name = "STORMDOWNN", image = "rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=150&h=150"},
        {name = "CHATGPT", image = "rbxassetid://7742711501"} -- exemplo imagem de bot
    }

    for i, dev in ipairs(devs) do
        local container = Instance.new("Frame", frame)
        container.Size = UDim2.new(0.45, 0, 0, 80)
        container.Position = UDim2.new(0, (i-1)*250, 0, 40)
        container.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        container.BorderSizePixel = 0
        Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)

        local img = Instance.new("ImageLabel", container)
        img.Size = UDim2.new(0, 70, 0, 70)
        img.Position = UDim2.new(0, 5, 0, 5)
        img.BackgroundTransparency = 1
        img.Image = dev.image
        img.ScaleType = Enum.ScaleType.Fit
        Instance.new("UICorner", img).CornerRadius = UDim.new(1, 0)

        local label = Instance.new("TextLabel", container)
        label.Size = UDim2.new(1, -80, 1, 0)
        label.Position = UDim2.new(0, 80, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = dev.name
        label.Font = Enum.Font.GothamBold
        label.TextSize = 20
        label.TextColor3 = Color3.new(1,1,1)
        label.TextXAlignment = Enum.TextXAlignment.Left
    end
end

-- Selecionar a aba Player inicialmente
selectTab("Player")

local settingsTitle = Instance.new("TextLabel", settingsFrame)
settingsTitle.Size = UDim2.new(1, 0, 0, 36)
settingsTitle.Position = UDim2.new(0, 0, 0, 0)
settingsTitle.BackgroundTransparency = 1
settingsTitle.Text = "Configurações"
settingsTitle.Font = Enum.Font.GothamBold
settingsTitle.TextSize = 24
settingsTitle.TextColor3 = Color3.new(1, 1, 1)

-- Botão voltar
local closeButton = Instance.new("TextButton", settingsFrame)
closeButton.Size = UDim2.new(0.2, 0, 0, 32)
closeButton.Position = UDim2.new(0.03, 0, 0.9, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeButton.Text = "Voltar"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.BorderSizePixel = 0
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 8)

closeButton.MouseButton1Click:Connect(function()
    settingsGui.Enabled = false
    mainGui.Enabled = true
end)

-- (Aqui você adiciona as abas clicáveis e conteúdo de configurações...)

-- =======
-- LÓGICA LOGIN
-- =======
loginButton.MouseButton1Click:Connect(function()
    local typed = passwordBox.Text
    if typed == HUB_PASSWORD then
        incorrectLabel.Text = ""
        loginGui:Destroy()
        mainGui.Enabled = true
    else
        incorrectLabel.Text = "Senha incorreta!"
        wait(1.5)
        incorrectLabel.Text = ""
        passwordBox.Text = ""
    end
end)
