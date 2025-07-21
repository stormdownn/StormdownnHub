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

-- Remove GUI antiga
local oldGui = guiParent:FindFirstChild("StormdownnHub_Main")
if oldGui then oldGui:Destroy() end

-- Criar ScreenGui principal
local mainGui = Instance.new("ScreenGui", guiParent)
mainGui.Name = "StormdownnHub_Main"
mainGui.ResetOnSpawn = false
mainGui.Enabled = true

-- Frame principal (cor branco)
local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 480, 0, 400)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BackgroundTransparency = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

-- Frame secundário preto (exemplo container para conteúdo)
local blackFrame = Instance.new("Frame", mainFrame)
blackFrame.Size = UDim2.new(0.95, 0, 0.7, 0)
blackFrame.Position = UDim2.new(0.025, 0, 0.15, 0)
blackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
blackFrame.BackgroundTransparency = 0
Instance.new("UICorner", blackFrame).CornerRadius = UDim.new(0, 10)

-- Texto de exemplo no container preto
local exampleText = Instance.new("TextLabel", blackFrame)
exampleText.Size = UDim2.new(1, 0, 0, 40)
exampleText.Position = UDim2.new(0, 0, 0, 10)
exampleText.BackgroundTransparency = 1
exampleText.Text = "Painel principal do StormdownnHub"
exampleText.Font = Enum.Font.GothamBold
exampleText.TextSize = 22
exampleText.TextColor3 = Color3.new(1,1,1)
exampleText.TextXAlignment = Enum.TextXAlignment.Center

-- Botão flutuante preto (centralizado no topo)
local toggleButton = Instance.new("TextButton", mainGui)
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.5, -25, 0, 10) -- Centralizado topo
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.Text = "Fechar"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 18
toggleButton.AutoButtonColor = false
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)
toggleButton.ZIndex = 50

local TweenService = game:GetService("TweenService")

local panelOpen = true

toggleButton.MouseButton1Click:Connect(function()
    panelOpen = not panelOpen

    if panelOpen then
        toggleButton.Text = "Fechar"
        -- Animação para abrir
        mainFrame.Visible = true
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 0})
        tween:Play()
        tween.Completed:Wait()
    else
        toggleButton.Text = "Abrir"
        -- Animação para fechar (deixar transparente)
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})
        tween:Play()
        tween.Completed:Wait()
        mainFrame.Visible = false
    end
end)
