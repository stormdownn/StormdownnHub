-- StormdownnHub V1 completo e corrigido

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "StormdownnHubV1"
screenGui.ResetOnSpawn = false

-- Tema e cores
local isDarkTheme = false
local function getBackgroundColor()
    return isDarkTheme and Color3.fromRGB(25,25,25) or Color3.fromRGB(245,245,245)
end
local function getTextColor()
    return isDarkTheme and Color3.new(1,1,1) or Color3.new(0,0,0)
end
local function getButtonColor()
    return isDarkTheme and Color3.fromRGB(50,50,50) or Color3.fromRGB(220,220,220)
end

-- Painel principal
local panel = Instance.new("Frame")
panel.Name = "MainPanel"
panel.Parent = screenGui
panel.Size = UDim2.new(0, 400, 0, 350)
panel.Position = UDim2.new(0.5, -200, 0.5, -175)
panel.BackgroundColor3 = getBackgroundColor()
panel.BorderSizePixel = 0
panel.BackgroundTransparency = 0.1
panel.Active = true
panel.Draggable = true

-- Fundo Aizawa
local bgImage = Instance.new("ImageLabel", panel)
bgImage.Size = UDim2.new(1, 0, 1, 0)
bgImage.Position = UDim2.new(0, 0, 0, 0)
bgImage.Image = "rbxassetid://15327849226"
bgImage.BackgroundTransparency = 1
bgImage.ImageTransparency = 0.6

-- Botão flutuante (ícone do hub)
local floatButton = Instance.new("ImageButton", screenGui)
floatButton.Size = UDim2.new(0, 50, 0, 50)
floatButton.Position = UDim2.new(0, 10, 0.5, -25)
floatButton.Image = "rbxassetid://15327849226"
floatButton.BackgroundTransparency = 1
floatButton.Draggable = true

local panelOpen = true
floatButton.MouseButton1Click:Connect(function()
    panelOpen = not panelOpen
    panel.Visible = panelOpen
end)

-- Scroll para scripts
local scroll = Instance.new("ScrollingFrame", panel)
scroll.Size = UDim2.new(1, -20, 0.6, 0)
scroll.Position = UDim2.new(0, 10, 0.1, 0)
scroll.CanvasSize = UDim2.new(0, 0, 0, 400)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1
scroll.Name = "scriptFrame"

local function createScriptButton(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Text = name .. ": OFF"
    btn.Parent = scroll
    btn.BackgroundColor3 = getButtonColor()
    btn.TextColor3 = getTextColor()
    btn.BorderSizePixel = 0
    btn.Active = true

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = name .. ": " .. (active and "ON" or "OFF")
        -- Aqui você pode adicionar a função real do script que o botão controla
        print(name .. " toggled:", active)
    end)
end

local features = {
    "RingParts", "Magnet", "LagOthers", "Kill Players", "WalkFling",
    "Puxar Player", "Telekinesis", "ESP", "Fly", "No-Clip"
}

for _, feature in ipairs(features) do
    createScriptButton(feature)
end

-- Botão de configurações
local configBtn = Instance.new("TextButton", panel)
configBtn.Size = UDim2.new(0, 40, 0, 40)
configBtn.Position = UDim2.new(1, -50, 0, 10)
configBtn.Text = "⚙️"
configBtn.BackgroundTransparency = 0.2
configBtn.BorderSizePixel = 0
configBtn.TextScaled = true

-- Frame configurações
local configFrame = Instance.new("Frame", panel)
configFrame.Size = UDim2.new(1, -20, 0.6, 0)
configFrame.Position = scroll.Position
configFrame.Visible = false
configFrame.BackgroundColor3 = getBackgroundColor()
configFrame.BackgroundTransparency = 0.2

-- Criadores e usuário
local creatorStorm = Instance.new("ImageLabel", configFrame)
creatorStorm.Size = UDim2.new(0, 50, 0, 50)
creatorStorm.Position = UDim2.new(0, 20, 0, 10)
creatorStorm.BackgroundTransparency = 1
creatorStorm.Image = "rbxassetid://15327849226" -- sua foto

local creatorChatGPT = Instance.new("ImageLabel", configFrame)
creatorChatGPT.Size = UDim2.new(0, 50, 0, 50)
creatorChatGPT.Position = UDim2.new(0, 90, 0, 10)
creatorChatGPT.BackgroundTransparency = 1
creatorChatGPT.Image = "rbxassetid://17423995385" -- chatgpt

local textCreators = Instance.new("TextLabel", configFrame)
textCreators.Text = "Criadores: STORMDOWNN, CHATGPT"
textCreators.Font = Enum.Font.Gotham
textCreators.TextSize = 16
textCreators.Position = UDim2.new(0, 20, 0, 70)
textCreators.Size = UDim2.new(1, -40, 0, 25)
textCreators.TextColor3 = getTextColor()
textCreators.BackgroundTransparency = 1

local playerNameLabel = Instance.new("TextLabel", configFrame)
playerNameLabel.Text = "Usuário: " .. player.Name
playerNameLabel.Font = Enum.Font.Gotham
playerNameLabel.TextSize = 16
playerNameLabel.Position = UDim2.new(0, 20, 0, 105)
playerNameLabel.Size = UDim2.new(1, -40, 0, 25)
playerNameLabel.TextColor3 = getTextColor()
playerNameLabel.BackgroundTransparency = 1

local locationLabel = Instance.new("TextLabel", configFrame)
locationLabel.Text = "Localização: StormNet v1 (Wi-Fi Detectado)"
locationLabel.Font = Enum.Font.Gotham
locationLabel.TextSize = 16
locationLabel.Position = UDim2.new(0, 20, 0, 140)
locationLabel.Size = UDim2.new(1, -40, 0, 25)
locationLabel.TextColor3 = getTextColor()
locationLabel.BackgroundTransparency = 1

-- Botão alternar tema
local toggleThemeBtn = Instance.new("TextButton", configFrame)
toggleThemeBtn.Size = UDim2.new(1, -20, 0, 35)
toggleThemeBtn.Position = UDim2.new(0, 10, 0, 180)
toggleThemeBtn.Text = "Alternar Tema Claro/Escuro"
toggleThemeBtn.BackgroundColor3 = getButtonColor()
toggleThemeBtn.TextColor3 = getTextColor()
toggleThemeBtn.BorderSizePixel = 0
toggleThemeBtn.MouseButton1Click:Connect(function()
    isDarkTheme = not isDarkTheme
    -- Atualiza cores
    panel.BackgroundColor3 = getBackgroundColor()
    bgImage.ImageTransparency = isDarkTheme and 0.7 or 0.6
    scroll.BackgroundColor3 = getBackgroundColor()
    configFrame.BackgroundColor3 = getBackgroundColor()
    toggleThemeBtn.BackgroundColor3 = getButtonColor()
    toggleThemeBtn.TextColor3 = getTextColor()
    configBtn.BackgroundTransparency = isDarkTheme and 0 or 0.2
    for _, btn in pairs(scroll:GetChildren()) do
        if btn:IsA("TextButton") then
            btn.BackgroundColor3 = getButtonColor()
            btn.TextColor3 = getTextColor()
        end
    end
    -- Atualiza textos
    textCreators.TextColor3 = getTextColor()
    playerNameLabel.TextColor3 = getTextColor()
    locationLabel.TextColor3 = getTextColor()
end)

-- Mostrar/ocultar configurações e scripts
configBtn.MouseButton1Click:Connect(function()
    local visible = not configFrame.Visible
    configFrame.Visible = visible
    scroll.Visible = not visible
end)

-- Tela de Login
local loginFrame = Instance.new("Frame", screenGui)
loginFrame.Size = UDim2.new(0, 300, 0, 170)
loginFrame.Position = UDim2.new(0.5, -150, 0.5, -85)
loginFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
loginFrame.BorderSizePixel = 0
loginFrame.Active = true
loginFrame.Draggable = true

local loginTitle = Instance.new("TextLabel", loginFrame)
loginTitle.Text = "StormdownnHub Login"
loginTitle.Font = Enum.Font.GothamBold
loginTitle.TextSize = 24
loginTitle.Size = UDim2.new(1, 0, 0, 40)
loginTitle.TextColor3 = Color3.new(0, 0, 0)
loginTitle.BackgroundTransparency = 1

local passwordBox = Instance.new("TextBox", loginFrame)
passwordBox.Size = UDim2.new(0.9, 0, 0, 40)
passwordBox.Position = UDim2.new(0.05, 0, 0.4, 0)
passwordBox.PlaceholderText = "Digite a senha..."
passwordBox.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
passwordBox.ClearTextOnFocus = false
passwordBox.Text = ""
passwordBox.TextColor3 = Color3.new(0, 0, 0)
passwordBox.Font = Enum.Font.Gotham
passwordBox.TextSize = 20
passwordBox.ClipsDescendants = true
passwordBox.TextTransparency = 0

local enterButton = Instance.new("TextButton", loginFrame)
enterButton.Size = UDim2.new(0.5, 0, 0, 40)
enterButton.Position = UDim2.new(0.25, 0, 0.75, 0)
enterButton.Text = "Entrar"
enterButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
enterButton.TextColor3 = Color3.new(0, 0, 0)
enterButton.Font = Enum.Font.GothamBold
enterButton.TextSize = 18
enterButton.AutoButtonColor = true

enterButton.MouseButton1Click:Connect(function()
    if passwordBox.Text == "stormdownn" then
        loginFrame:Destroy()
        panel.Visible = true
        floatButton.Visible = true
    else
        passwordBox.Text = ""
        passwordBox.PlaceholderText = "Senha incorreta!"
        enterButton.Text = "Tente novamente"
        wait(1.5)
        enterButton.Text = "Entrar"
        passwordBox.PlaceholderText = "Digite a senha..."
    end
end)

panel.Visible = false
floatButton.Visible = false
