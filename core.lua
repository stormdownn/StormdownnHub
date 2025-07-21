local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Interface principal (será ativada só após login)
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "StormdownnHub"
gui.ResetOnSpawn = false
gui.Enabled = false -- só ativa depois do login

-- Tela de Login
local loginGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
loginGui.Name = "LoginGui"
loginGui.ResetOnSpawn = false

local loginFrame = Instance.new("Frame", loginGui)
loginFrame.Size = UDim2.new(0, 300, 0, 180)
loginFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
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
title.TextSize = 20

local passwordBox = Instance.new("TextBox", loginFrame)
passwordBox.PlaceholderText = "Senha..."
passwordBox.Size = UDim2.new(0.9, 0, 0, 40)
passwordBox.Position = UDim2.new(0.05, 0, 0.45, 0)
passwordBox.Text = ""
passwordBox.ClearTextOnFocus = false
passwordBox.Font = Enum.Font.Gotham
passwordBox.TextColor3 = Color3.new(1,1,1)
passwordBox.TextSize = 18
passwordBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
passwordBox.BorderSizePixel = 0
Instance.new("UICorner", passwordBox).CornerRadius = UDim.new(0, 8)

local loginButton = Instance.new("TextButton", loginFrame)
loginButton.Size = UDim2.new(0.9, 0, 0, 35)
loginButton.Position = UDim2.new(0.05, 0, 0.75, 0)
loginButton.Text = "Entrar"
loginButton.Font = Enum.Font.GothamBold
loginButton.TextSize = 18
loginButton.TextColor3 = Color3.new(1,1,1)
loginButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
loginButton.BorderSizePixel = 0
Instance.new("UICorner", loginButton).CornerRadius = UDim.new(0, 8)

local incorrectLabel = Instance.new("TextLabel", loginFrame)
incorrectLabel.Size = UDim2.new(1, 0, 0, 20)
incorrectLabel.Position = UDim2.new(0, 0, 1, -20)
incorrectLabel.BackgroundTransparency = 1
incorrectLabel.Text = ""
incorrectLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
incorrectLabel.Font = Enum.Font.Gotham
incorrectLabel.TextSize = 14

-- Lógica do login
loginButton.MouseButton1Click:Connect(function()
    local senha = passwordBox.Text
    if senha == "stormdownn" then
        loginGui:Destroy()
        gui.Enabled = true -- ativa o hub principal
    else
        incorrectLabel.Text = "Senha incorreta!"
    end
end)

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "StormdownnHub"
gui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", gui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
mainFrame.Active = true
mainFrame.Draggable = true

local blur = Instance.new("ImageLabel", mainFrame)
blur.Size = UDim2.new(1, 0, 1, 0)
blur.Position = UDim2.new(0, 0, 0, 0)
blur.BackgroundTransparency = 1
blur.Image = "rbxassetid://15327849226"
blur.ImageTransparency = 0.75
blur.ScaleType = Enum.ScaleType.Crop
blur.ZIndex = 0

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local toggleButton = Instance.new("ImageButton", gui)
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.BackgroundTransparency = 0.1
toggleButton.ZIndex = 10
toggleButton.AutoButtonColor = false
toggleButton.Image = "rbxassetid://15327849226"
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)

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
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        local newX = math.clamp(startPos.X.Offset + delta.X, 0, gui.AbsoluteSize.X - toggleButton.AbsoluteSize.X)
        local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, gui.AbsoluteSize.Y - toggleButton.AbsoluteSize.Y)
        toggleButton.Position = UDim2.new(0, newX, 0, newY)
    end
end)

local panelOpen = true
toggleButton.MouseButton1Click:Connect(function()
    panelOpen = not panelOpen
    mainFrame.Visible = panelOpen
end)

local scriptsFrame = Instance.new("Frame", mainFrame)
scriptsFrame.Name = "ScriptsFrame"
scriptsFrame.Size = UDim2.new(0.95, 0, 0.6, 0)
scriptsFrame.Position = UDim2.new(0.025, 0, 0.2, 0)
scriptsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
scriptsFrame.BackgroundTransparency = 0.2
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
    "Fly", "NoClip", "ESP", "KillPlayers", "WalkFling", "PuxarPlayer",
    "RingParts", "Magnet", "LagOthers", "Telekinesis"
}

for i, feature in ipairs(features) do
    local btn = Instance.new("TextButton")
    btn.Name = feature .. "_Button"
    btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
        print(feature, "toggled:", active)
        -- Lógica real vai aqui
    end)

    btn.Parent = scrollFrame
end
