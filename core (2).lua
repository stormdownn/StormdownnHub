
-- StormdownnHub V1 - Versão Completa com Tema Claro, Configurações e Botão Flutuante

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- UI Principal
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "StormdownnHubV1"
screenGui.ResetOnSpawn = false

-- Tema (claro por padrão)
local isDarkTheme = false
local function getBackgroundColor()
    return isDarkTheme and Color3.fromRGB(25,25,25) or Color3.fromRGB(245,245,245)
end

-- Função para alternar tema
local function toggleTheme()
    isDarkTheme = not isDarkTheme
    panel.BackgroundColor3 = getBackgroundColor()
    for _, button in pairs(scriptFrame:GetChildren()) do
        if button:IsA("TextButton") then
            button.BackgroundColor3 = getBackgroundColor()
        end
    end
end

-- Fundo do Hub
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

-- Imagem de fundo (Aizawa)
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

-- Área de Scripts com Scroll
local scroll = Instance.new("ScrollingFrame", panel)
scroll.Size = UDim2.new(1, -20, 0.6, 0)
scroll.Position = UDim2.new(0, 10, 0.1, 0)
scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1
scroll.Name = "scriptFrame"

-- Exemplo de botão de script
local function createScriptButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Text = name
    btn.Parent = scroll
    btn.BackgroundColor3 = getBackgroundColor()
    btn.TextColor3 = isDarkTheme and Color3.new(1,1,1) or Color3.new(0,0,0)
    btn.BorderSizePixel = 0
    btn.MouseButton1Click:Connect(callback)
end

-- Botões de exemplo
createScriptButton("RingParts", function() print("RingParts") end)
createScriptButton("Magnet", function() print("Magnet") end)
createScriptButton("LagOthers", function() print("LagOthers") end)
createScriptButton("Kill Players", function() print("Kill Players") end)
createScriptButton("WalkFling", function() print("WalkFling") end)
createScriptButton("Puxar Player", function() print("Puxar Player") end)
createScriptButton("Telekinesis", function() print("Telekinesis") end)
createScriptButton("ESP", function() print("ESP") end)
createScriptButton("Fly", function() print("Fly") end)
createScriptButton("No-Clip", function() print("No-Clip") end)

-- Botão de Configurações
local configBtn = Instance.new("TextButton", panel)
configBtn.Size = UDim2.new(0, 40, 0, 40)
configBtn.Position = UDim2.new(1, -50, 0, 10)
configBtn.Text = "⚙️"
configBtn.BackgroundTransparency = 0.2
configBtn.BorderSizePixel = 0
configBtn.TextScaled = true

-- Tela de Configurações
local configFrame = Instance.new("Frame", panel)
configFrame.Size = UDim2.new(1, -20, 0.6, 0)
configFrame.Position = scroll.Position
configFrame.Visible = false
configFrame.BackgroundColor3 = getBackgroundColor()
configFrame.BackgroundTransparency = 0.2

local toggleThemeBtn = Instance.new("TextButton", configFrame)
toggleThemeBtn.Size = UDim2.new(1, -20, 0, 30)
toggleThemeBtn.Position = UDim2.new(0, 10, 0, 10)
toggleThemeBtn.Text = "Alternar Tema Claro/Escuro"
toggleThemeBtn.MouseButton1Click:Connect(function()
    toggleTheme()
end)

-- Alternância entre scripts e configurações
configBtn.MouseButton1Click:Connect(function()
    local visible = not configFrame.Visible
    configFrame.Visible = visible
    scroll.Visible = not visible
end)

-- Tela de Login
local loginFrame = Instance.new("Frame", screenGui)
loginFrame.Size = UDim2.new(0, 250, 0, 150)
loginFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
loginFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
loginFrame.BorderSizePixel = 0

local passwordBox = Instance.new("TextBox", loginFrame)
passwordBox.Size = UDim2.new(1, -20, 0, 30)
passwordBox.Position = UDim2.new(0, 10, 0.4, 0)
passwordBox.PlaceholderText = "Digite a senha..."
passwordBox.BackgroundColor3 = Color3.fromRGB(210,210,210)
passwordBox.ClearTextOnFocus = false

local enterButton = Instance.new("TextButton", loginFrame)
enterButton.Size = UDim2.new(1, -20, 0, 30)
enterButton.Position = UDim2.new(0, 10, 0.7, 0)
enterButton.Text = "Entrar"
enterButton.BackgroundColor3 = Color3.fromRGB(180,180,180)

enterButton.MouseButton1Click:Connect(function()
    if passwordBox.Text == "stormdownn" then
        loginFrame.Visible = false
        panel.Visible = true
    else
        passwordBox.Text = ""
        passwordBox.PlaceholderText = "Senha incorreta!"
    end
end)

panel.Visible = false
