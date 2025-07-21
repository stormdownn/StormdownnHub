-- StormdownnHub V1 - Parte 1

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")

-- Remove GUIs antigas
for _, name in pairs({"StormdownnHub_Login", "StormdownnHub_Main", "StormdownnHub_Toggle"}) do
    local oldGui = guiParent:FindFirstChild(name)
    if oldGui then oldGui:Destroy() end
end

local HUB_PASSWORD = "stormdownn"

-- =============
-- TELA DE LOGIN
-- =============
local loginGui = Instance.new("ScreenGui", guiParent)
loginGui.Name = "StormdownnHub_Login"
loginGui.ResetOnSpawn = false

local loginFrame = Instance.new("Frame", loginGui)
loginFrame.Size = UDim2.new(0, 320, 0, 180)
loginFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
loginFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- branco
loginFrame.BorderSizePixel = 0
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel", loginFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Stormdownn Hub Login"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(0, 0, 0) -- preto
title.TextSize = 24

local passwordBox = Instance.new("TextBox", loginFrame)
passwordBox.Size = UDim2.new(0.9, 0, 0, 50)
passwordBox.Position = UDim2.new(0.05, 0, 0.4, 0)
passwordBox.PlaceholderText = "Digite a senha..."
passwordBox.ClearTextOnFocus = true
passwordBox.Font = Enum.Font.GothamBold
passwordBox.TextColor3 = Color3.fromRGB(0, 0, 0)
passwordBox.TextSize = 22
passwordBox.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
passwordBox.BorderSizePixel = 0
Instance.new("UICorner", passwordBox).CornerRadius = UDim.new(0, 10)
passwordBox.TextXAlignment = Enum.TextXAlignment.Left
passwordBox.TextEditable = true
passwordBox.TextTransparency = 0
passwordBox.BackgroundTransparency = 0

local loginButton = Instance.new("TextButton", loginFrame)
loginButton.Size = UDim2.new(0.9, 0, 0, 40)
loginButton.Position = UDim2.new(0.05, 0, 0.75, 0)
loginButton.Text = "Entrar"
loginButton.Font = Enum.Font.GothamBold
loginButton.TextSize = 20
loginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loginButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loginButton.BorderSizePixel = 0
Instance.new("UICorner", loginButton).CornerRadius = UDim.new(0, 12)

local incorrectLabel = Instance.new("TextLabel", loginFrame)
incorrectLabel.Size = UDim2.new(1, 0, 0, 24)
incorrectLabel.Position = UDim2.new(0, 0, 1, -24)
incorrectLabel.BackgroundTransparency = 1
incorrectLabel.Text = ""
incorrectLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
incorrectLabel.Font = Enum.Font.Gotham
incorrectLabel.TextSize = 16
incorrectLabel.TextXAlignment = Enum.TextXAlignment.Center

-- ===========
-- HUB PRINCIPAL (inicialmente invisível)
-- ===========
local mainGui = Instance.new("ScreenGui", guiParent)
mainGui.Name = "StormdownnHub_Main"
mainGui.ResetOnSpawn = false
mainGui.Enabled = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 480, 0, 400)
mainFrame.Position = UDim2.new(0.5, -240, 0.5, -200)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- branco
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

-- Frame secundário preto (painel interno)
local innerFrame = Instance.new("Frame", mainFrame)
innerFrame.Size = UDim2.new(1, -20, 1, -40)
innerFrame.Position = UDim2.new(0, 10, 0, 10)
innerFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- preto
innerFrame.BorderSizePixel = 0
Instance.new("UICorner", innerFrame).CornerRadius = UDim.new(0, 10)

-- Botões scripts container
local scriptsFrame = Instance.new("ScrollingFrame", innerFrame)
scriptsFrame.Size = UDim2.new(1, 0, 1, 0)
scriptsFrame.BackgroundTransparency = 1
scriptsFrame.BorderSizePixel = 0
scriptsFrame.ScrollBarThickness = 8
scriptsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scriptsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scriptsFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

local uiLayout = Instance.new("UIListLayout", scriptsFrame)
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0, 6)

-- Lista de scripts (incluindo a Merrata)
local features = {
    {name = "Fly"},
    {name = "NoClip"},
    {name = "ESP"},
    {name = "KillPlayers"},
    {name = "WalkFling"},
    {name = "PuxarPlayer"},
    {name = "RingParts"},
    {name = "Magnet"},
    {name = "LagOthers"},
    {name = "Telekinesis"},
    {name = "Merrata (Quebra mapa)"}
}

for i, feature in ipairs(features) do
    local btn = Instance.new("TextButton")
    btn.Name = feature.name .. "_Button"
    btn.Size = UDim2.new(0.95, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Text = feature.name .. ": OFF"
    btn.LayoutOrder = i
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = feature.name .. ": " .. (active and "ON" or "OFF")
        print("[StormdownnHub] Feature toggled:", feature.name, active)

        -- Exemplo de ação para o Merrata:
        if feature.name == "Merrata (Quebra mapa)" and active then
            print("[StormdownnHub] Merrata ativado: quebrou mapa!")
            -- Aqui você colocaria o script real da Merrata para quebrar o mapa
        end
    end)

    btn.Parent = scriptsFrame
end

-- ================
-- BOTÃO FLUTUANTE (centralizado no topo)
-- ================
local toggleButton = Instance.new("ImageButton", guiParent)
toggleButton.Name = "StormdownnHub_Toggle"
toggleButton.Size = UDim2.new(0, 48, 0, 48)
toggleButton.Position = UDim2.new(0.5, -24, 0, 12) -- centralizado horizontalmente no topo
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.BackgroundTransparency = 0.1
toggleButton.AutoButtonColor = false
toggleButton.Image = "rbxassetid://15327849226" -- Aizawa
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)
toggleButton.ZIndex = 20

local TweenService = game:GetService("TweenService")

local panelOpen = false

local function openPanel()
    mainGui.Enabled = true
    panelOpen = true
    -- Anima a entrada
    mainFrame.Position = UDim2.new(0.5, -240, 0.5, -300)
    mainFrame.Visible = true
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(0.5, -240, 0.5, -200)}):Play()
end

local function closePanel()
    panelOpen = false
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local tween = TweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(0.5, -240, 0.5, -300)})
    tween:Play()
    tween.Completed:Connect(function()
        mainGui.Enabled = false
    end)
end

toggleButton.MouseButton1Click:Connect(function()
    if panelOpen then
        closePanel()
    else
        openPanel()
    end
end)

-- ==============
-- LÓGICA LOGIN
-- ==============
loginButton.MouseButton1Click:Connect(function()
    local typed = passwordBox.Text
    if typed == HUB_PASSWORD then
        incorrectLabel.Text = ""
        loginGui:Destroy()
        openPanel()
    else
        incorrectLabel.Text = "Senha incorreta!"
        wait(1.5)
        incorrectLabel.Text = ""
        passwordBox.Text = ""
    end
end)
