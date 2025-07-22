-- StormdownnHub_V1

-- =======
-- INÍCIO/SENHA
-- =======

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")

-- Remove GUIs antigas
for _, name in pairs({"StormdownnHub_Login", "StormdownnHub_Main"}) do
    local oldGui = guiParent:FindFirstChild(name)
    if oldGui then oldGui:Destroy() end
end

-- Criar ScreenGui de Login
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
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextSize = 24

local passwordBox = Instance.new("TextBox", loginFrame)
passwordBox.Size = UDim2.new(0.9, 0, 0, 50)
passwordBox.Position = UDim2.new(0.05, 0, 0, 70)
passwordBox.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
passwordBox.ClearTextOnFocus = true
passwordBox.Font = Enum.Font.GothamBold
passwordBox.TextColor3 = Color3.fromRGB(0, 0, 0)
passwordBox.TextSize = 22
passwordBox.PlaceholderText = "Digite a senha..."
passwordBox.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", passwordBox).CornerRadius = UDim.new(0, 8)

local loginButton = Instance.new("TextButton", loginFrame)
loginButton.Size = UDim2.new(0.9, 0, 0, 40)
loginButton.Position = UDim2.new(0.05, 0, 0, 130)
loginButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
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

-- =======
-- HUB PRINCIPAL
-- =======

-- Criar ScreenGui principal (inicialmente desativado)
local mainGui = Instance.new("ScreenGui", guiParent)
mainGui.Name = "StormdownnHub_Main"
mainGui.ResetOnSpawn = false
mainGui.Enabled = false

-- Frame principal (menor e branco)
local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 300)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BackgroundTransparency = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

-- Cabeçalho com texto preto
local headerLabel = Instance.new("TextLabel", mainFrame)
headerLabel.Size = UDim2.new(1, 0, 0, 50)
headerLabel.Position = UDim2.new(0, 0, 0, 0)
headerLabel.BackgroundTransparency = 1
headerLabel.Text = "🌩️ StormdawnnHub_V1 🌩️"
headerLabel.Font = Enum.Font.GothamBold
headerLabel.TextSize = 28
headerLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
headerLabel.TextXAlignment = Enum.TextXAlignment.Center
headerLabel.TextYAlignment = Enum.TextYAlignment.Center

-- Frame para os scripts (dentro do painel, ocupa o espaço abaixo do cabeçalho)
local scriptsFrame = Instance.new("ScrollingFrame", mainFrame)
scriptsFrame.Size = UDim2.new(1, -20, 1, -60)
scriptsFrame.Position = UDim2.new(0, 10, 0, 50)
scriptsFrame.BackgroundTransparency = 1
scriptsFrame.BorderSizePixel = 0
scriptsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scriptsFrame.ScrollBarThickness = 6
scriptsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scriptsFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

local uiLayout = Instance.new("UIListLayout", scriptsFrame)
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0, 8)

-- Lista de scripts exemplo (botões brancos com texto preto)
local features = {
    "Fly", "NoClip", "ESP", "KillPlayers", "WalkFling", "PuxarPlayer",
    "SuperRingParts", "Sledgehammer", "Magnet", "LagOthers", "Telekinesis"
}

for i, feature in ipairs(features) do
    local btn = Instance.new("TextButton")
    btn.Name = feature .. "_Button"
    btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(240, 240, 240) -- branco clarinho
    btn.TextColor3 = Color3.fromRGB(0, 0, 0) -- texto preto
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.Text = feature .. ": OFF"
    btn.LayoutOrder = i
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = feature .. ": " .. (active and "ON" or "OFF")
        print("[StormdownnHub] Feature toggled:", feature, active)
        -- Aqui vai a lógica do script
    end)

    btn.Parent = scriptsFrame
end

-- Botão flutuante preto no topo central para abrir/fechar painel

-- Criar botão flutuante
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.5, -25, 0, 10) -- topo central
toggleButton.AnchorPoint = Vector2.new(0, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "Abrir"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 18
toggleButton.AutoButtonColor = false
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)
toggleButton.ZIndex = 100
toggleButton.Parent = guiParent
toggleButton.Visible = false

-- Tornar botão arrastável
local dragging = false
local dragInput, mousePos, framePos

local function updatePosition(input)
    local delta = input.Position - mousePos
    local newPos = UDim2.new(
        0,
        math.clamp(framePos.X.Offset + delta.X, 0, guiParent.AbsoluteSize.X - toggleButton.AbsoluteSize.X),
        0,
        math.clamp(framePos.Y.Offset + delta.Y, 0, guiParent.AbsoluteSize.Y - toggleButton.AbsoluteSize.Y)
    )
    toggleButton.Position = newPos
end

toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = toggleButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

toggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updatePosition(input)
    end
end)

-- Função para abrir/fechar o painel

local TweenService = game:GetService("TweenService")

local panelOpen = false -- começa fechado

toggleButton.MouseButton1Click:Connect(function()
    panelOpen = not panelOpen

    if panelOpen then
        toggleButton.Text = "Fechar"
        mainGui.Enabled = true
        mainFrame.Visible = true
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 0})
        tween:Play()
    else
        toggleButton.Text = "Abrir"
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})
        tween:Play()
        tween.Completed:Wait()
        mainGui.Enabled = false
    end
end)

-- LOGIN (continuação da Parte 1)

loginButton.MouseButton1Click:Connect(function()
    local typed = passwordBox.Text
    if typed == HUB_PASSWORD then
    incorrectLabel.Text = ""
    loginGui:Destroy()
    toggleButton.Visible = true -- mostrar botão após login
    mainGui.Enabled = true
    else
        incorrectLabel.Text = "Senha incorreta!"
        wait(1.5)
        incorrectLabel.Text = ""
        passwordBox.Text = ""
    end
end)
