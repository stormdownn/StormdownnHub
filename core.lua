-- main.lua - StormdownnHub V1

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

-- Remove GUIs antigas para evitar duplicação
for _, name in pairs({"StormdownnHub_Login", "StormdownnHub_Main", "StormdownnHub_Toggle", "StormdownnHub_Settings"}) do
    local oldGui = guiParent:FindFirstChild(name)
    if oldGui then oldGui:Destroy() end
end

-- ======== TELA DE LOGIN ========
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

-- ======== HUB PRINCIPAL (inicialmente invisível) ========
local mainGui = Instance.new("ScreenGui", guiParent)
mainGui.Name = "StormdownnHub_Main"
mainGui.ResetOnSpawn = false
mainGui.Enabled = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 480, 0, 400)
mainFrame.Position = UDim2.new(0.5, -240, 0.5, -300) -- Começa fora da tela (acima)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Cor principal branca
mainFrame.BackgroundTransparency = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

-- Fundo preto secundário dentro do frame principal (container secundário)
local secondaryFrame = Instance.new("Frame", mainFrame)
secondaryFrame.Size = UDim2.new(1, -20, 1, -20)
secondaryFrame.Position = UDim2.new(0, 10, 0, 10)
secondaryFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- cor secundária preta
secondaryFrame.BackgroundTransparency = 0
Instance.new("UICorner", secondaryFrame).CornerRadius = UDim.new(0, 12)

-- Botão flutuante no topo centralizado (fora do mainGui)
local toggleButton = Instance.new("ImageButton", guiParent)
toggleButton.Name = "StormdownnHub_Toggle"
toggleButton.Size = UDim2.new(0, 48, 0, 48)
toggleButton.Position = UDim2.new(0.5, -24, 0, 12) -- topo, centralizado
toggleButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
toggleButton.BackgroundTransparency = 0.3
toggleButton.AutoButtonColor = false
toggleButton.Image = "rbxassetid://15327849226" -- imagem Aizawa
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)
toggleButton.ZIndex = 20

local panelOpen = false

local function openPanel()
    mainGui.Enabled = true
    panelOpen = true
    mainFrame.Visible = true

    -- Posicionar o frame acima da tela (fora do centro) para animar para o centro
    mainFrame.Position = UDim2.new(0.5, -240, 0.5, -300)

    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(0.5, -240, 0.5, -200)})
    tween:Play()
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

-- Lógica do login
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
