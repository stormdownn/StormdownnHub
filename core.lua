-- StormdownnHub_V1

-- =======
-- INÍCIO/SENHA
-- =======

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")

-- Remove GUIs antigas
for _, name in pairs({"StormdownnHub_Login"}) do
    local oldGui = guiParent:FindFirstChild(name)
    if oldGui then oldGui:Destroy() end
end

local loginGui = Instance.new("ScreenGui", guiParent)
loginGui.Name = "StormdownnHub_Login"
loginGui.ResetOnSpawn = false

local loginFrame = Instance.new("Frame", loginGui)
loginFrame.Size = UDim2.new(0, 320, 0, 180)
loginFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loginFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
loginFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
loginFrame.BorderSizePixel = 0
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", loginFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Stormdownn Hub Login"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(0, 0, 0) -- preto
title.TextSize = 24
title.TextStrokeTransparency = 0.7

local passwordBox = Instance.new("TextBox", loginFrame)
passwordBox.Size = UDim2.new(0.9, 0, 0, 50)
passwordBox.Position = UDim2.new(0.05, 0, 0, 70)
passwordBox.BackgroundColor3 = Color3.fromRGB(230, 230, 230) -- cinza claro
passwordBox.ClearTextOnFocus = false
passwordBox.Font = Enum.Font.GothamBold
passwordBox.TextColor3 = Color3.fromRGB(0, 0, 0) -- preto
passwordBox.TextSize = 22
passwordBox.PlaceholderText = "Digite a senha..."
passwordBox.TextXAlignment = Enum.TextXAlignment.Left
passwordBox.ClearTextOnFocus = true
passwordBox.Text = ""
Instance.new("UICorner", passwordBox).CornerRadius = UDim.new(0, 8)

local loginButton = Instance.new("TextButton", loginFrame)
loginButton.Size = UDim2.new(0.9, 0, 0, 40)
loginButton.Position = UDim2.new(0.05, 0, 0, 130)
loginButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- preto
loginButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- branco
loginButton.Font = Enum.Font.GothamBold
loginButton.TextSize = 20
loginButton.Text = "Entrar"
Instance.new("UICorner", loginButton).CornerRadius = UDim.new(0, 8)

local incorrectLabel = Instance.new("TextLabel", loginFrame)
incorrectLabel.Size = UDim2.new(1, 0, 0, 24)
incorrectLabel.Position = UDim2.new(0, 0, 1, -24)
incorrectLabel.BackgroundTransparency = 1
incorrectLabel.Text = ""
incorrectLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
incorrectLabel.Font = Enum.Font.Gotham
incorrectLabel.TextSize = 16

local HUB_PASSWORD = "stormdownn"

loginButton.MouseButton1Click:Connect(function()
    local typed = passwordBox.Text
    if typed == HUB_PASSWORD then
        incorrectLabel.Text = ""
        loginGui:Destroy()
        -- Aqui você pode ativar o GUI principal
    else
        incorrectLabel.Text = "Senha incorreta!"
        wait(1.5)
        incorrectLabel.Text = ""
        passwordBox.Text = ""
    end
end)

-- =======
-- HUB PRINCIPAL
-- =======

-- Main frame do Hub

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")

-- Criar GUI principal
local mainGui = Instance.new("ScreenGui", guiParent)
mainGui.Name = "StormdownnHub_Main"
mainGui.ResetOnSpawn = false
mainGui.Enabled = false

-- Frame principal (hub)
local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 480, 0, 400)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0) -- centralizado
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- branco
mainFrame.BackgroundTransparency = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

-- Container dos scripts
local scriptsFrame = Instance.new("Frame", mainFrame)
scriptsFrame.Name = "ScriptsFrame"
scriptsFrame.Size = UDim2.new(0.95, 0, 0.6, 0)
scriptsFrame.Position = UDim2.new(0.025, 0, 0.22, 0)
scriptsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- lacuna escura para destaque
scriptsFrame.BackgroundTransparency = 0.6
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

local features = {
    "Fly", "NoClip", "ESP", "KillPlayers", "WalkFling",
    "PuxarPlayer", "RingParts", "Magnet", "LagOthers", "Telekinesis"
}

for i, feature in ipairs(features) do
    local btn = Instance.new("TextButton")
    btn.Name = feature .. "_Button"
    btn.Size = UDim2.new(0.95, 0, 0, 38)
    btn.Position = UDim2.new(0, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35) -- fundo mais escuro pra botão
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

-- Botão flutuante (centralizado no topo do mainFrame)
local toggleButton = Instance.new("ImageButton", guiParent)
toggleButton.Name = "StormdownnHub_Toggle"
toggleButton.Size = UDim2.new(0, 42, 0, 42)
toggleButton.AnchorPoint = Vector2.new(0.5, 0)
toggleButton.Position = UDim2.new(0.5, 0, 0, 12) -- topo e centralizado horizontalmente na tela
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.BackgroundTransparency = 0.2
toggleButton.AutoButtonColor = false
toggleButton.Image = "rbxassetid://15327849226" -- Aizawa
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)
toggleButton.ZIndex = 20

local TweenService = game:GetService("TweenService")

local panelOpen = false

local function togglePanel()
    panelOpen = not panelOpen
    if panelOpen then
        mainGui.Enabled = true
        -- Animação abrir
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 0})
        tween:Play()
    else
        -- Animação fechar
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, 0, -1, 0), BackgroundTransparency = 1})
        tween:Play()
        tween.Completed:Wait()
        mainGui.Enabled = false
    end
end

toggleButton.MouseButton1Click:Connect(togglePanel)

-- Começa com painel fechado e só botão visível
mainGui.Enabled = false
mainFrame.Position = UDim2.new(0.5, 0, -1, 0) -- fora da tela no topo
mainFrame.BackgroundTransparency = 1
