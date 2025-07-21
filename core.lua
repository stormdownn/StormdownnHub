-- main.lua - StormdownnHub V1

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")

local HttpService = game:GetService("HttpService")

-- Remove GUIs antigas para evitar duplicação
for _, name in pairs({"StormdownnHub_Login", "StormdownnHub_Main", "StormdownnHub_Toggle"}) do
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
