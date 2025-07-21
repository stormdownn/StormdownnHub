-- interface.lua
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")

-- Remove guis antigas
local mainGui = gui:FindFirstChild("StormdownnHub_Main")
if mainGui then mainGui:Destroy() end

local settingsGui = gui:FindFirstChild("StormdownnHub_Settings")
if settingsGui then settingsGui:Destroy() end

-- Tema padrão claro
local darkMode = false

local mainGui = Instance.new("ScreenGui", gui)
mainGui.Name = "StormdownnHub_Main"
mainGui.ResetOnSpawn = false

-- Fundo com imagem do Aizawa e blur
local bg = Instance.new("ImageLabel", mainGui)
bg.Name = "Background"
bg.Size = UDim2.new(1,0,1,0)
bg.Position = UDim2.new(0,0,0,0)
bg.Image = "rbxassetid://15327849226"
bg.ImageTransparency = 0.6
bg.ScaleType = Enum.ScaleType.Crop
bg.ZIndex = 0

local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 12

-- Frame principal
local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 420, 0, 400)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel", mainFrame)
title.Text = "StormdownnHub V1"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(30, 30, 30)

-- Função para aplicar tema claro ou escuro
local function applyTheme(guiFrame)
    if darkMode then
        guiFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
        for _, obj in pairs(guiFrame:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                obj.TextColor3 = Color3.fromRGB(230,230,230)
                if obj:IsA("TextBox") then
                    obj.BackgroundColor3 = Color3.fromRGB(30,30,30)
                end
            elseif obj:IsA("Frame") and obj ~= guiFrame then
                obj.BackgroundColor3 = Color3.fromRGB(35,35,35)
            end
        end
    else
        guiFrame.BackgroundColor3 = Color3.fromRGB(245,245,245)
        for _, obj in pairs(guiFrame:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                obj.TextColor3 = Color3.fromRGB(30,30,30)
                if obj:IsA("TextBox") then
                    obj.BackgroundColor3 = Color3.fromRGB(220,220,220)
                end
            elseif obj:IsA("Frame") and obj ~= guiFrame then
                obj.BackgroundColor3 = Color3.fromRGB(230,230,230)
            end
        end
    end
end

applyTheme(mainFrame)

-- Criar o botão flutuante (alfinete) que abre/fecha o painel principal
local toggleButton = Instance.new("ImageButton", gui)
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0, 10) -- canto superior esquerdo inicial
toggleButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
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
    if panelOpen then
        mainFrame.Visible = false
        panelOpen = false
    else
        mainFrame.Visible = true
        toggleButton.Position = UDim2.new(0, 10, 0, 10) -- volta para o canto inicial ao abrir
        panelOpen = true
    end
end)

-- Criar área de scripts com barra de rolagem
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

-- Lista de scripts (botões)
local features = {
    "Fly", "NoClip", "ESP", "KillPlayers", "WalkFling", "PuxarPlayer",
    "RingParts", "Magnet", "LagOthers", "Telekinesis"
}

for i, feature in ipairs(features) do
    local btn = Instance.new("TextButton")
    btn.Name = feature .. "_Button"
    btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1,1,1)
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
        -- Aqui vai a lógica real de ativar/desativar o script
    end)

    btn.Parent = scrollFrame
end
