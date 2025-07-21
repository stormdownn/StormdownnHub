-- main.lua - StormdownnHub V1 (Ajustado cores e animação)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

-- Remove GUIs antigas para evitar duplicação
for _, name in pairs({"StormdownnHub_Login", "StormdownnHub_Main", "StormdownnHub_Toggle", "StormdownnHub_Settings"}) do
    local oldGui = guiParent:FindFirstChild(name)
    if oldGui then oldGui:Destroy() end
end

-- ====== Tela de Login ======
local loginGui = Instance.new("ScreenGui", guiParent)
loginGui.Name = "StormdownnHub_Login"
loginGui.ResetOnSpawn = false

local loginFrame = Instance.new("Frame", loginGui)
loginFrame.Size = UDim2.new(0, 320, 0, 180)
loginFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
loginFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loginFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Fundo preto no login
loginFrame.BorderSizePixel = 0
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 12)

-- ... [se mantém igual, texto branco etc]

-- ====== Hub Principal ======
local mainGui = Instance.new("ScreenGui", guiParent)
mainGui.Name = "StormdownnHub_Main"
mainGui.ResetOnSpawn = false
mainGui.Enabled = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 480, 0, 400)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Fundo branco (cor principal)
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

-- Container secundário preto (cor secundária)
local secondaryFrame = Instance.new("Frame", mainFrame)
secondaryFrame.Size = UDim2.new(1, -20, 1, -20)
secondaryFrame.Position = UDim2.new(0, 10, 0, 10)
secondaryFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Preto
secondaryFrame.BorderSizePixel = 0
Instance.new("UICorner", secondaryFrame).CornerRadius = UDim.new(0, 12)

-- Botão flutuante (centralizado no topo da tela)
local toggleButton = Instance.new("ImageButton", guiParent)
toggleButton.Name = "StormdownnHub_Toggle"
toggleButton.Size = UDim2.new(0, 48, 0, 48)
toggleButton.Position = UDim2.new(0.5, -24, 0, 12)
toggleButton.AnchorPoint = Vector2.new(0.5, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.BackgroundTransparency = 0.3
toggleButton.AutoButtonColor = false
toggleButton.Image = "rbxassetid://15327849226" -- Aizawa
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)
toggleButton.ZIndex = 20

local panelOpen = false

local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function openPanel()
    mainGui.Enabled = true
    panelOpen = true
    mainFrame.Position = UDim2.new(0.5, 0, -1, 0) -- Começa fora da tela (acima)
    mainFrame.Visible = true

    local tween = TweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(0.5, 0, 0.5, 0)})
    tween:Play()
end

local function closePanel()
    panelOpen = false
    local tween = TweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(0.5, 0, -1, 0)})
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

-- Login logic
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
