-- StormdownnHub V1 - Parte 2: Interface Principal + Scripts + Tema

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local gui = Players.LocalPlayer:WaitForChild("PlayerGui")

local darkMode = false
local mainGui

-- Função para criar os botões de script com scroll interno
local function createScriptsFrame(parent)
    local scriptsFrame = Instance.new("Frame", parent)
    scriptsFrame.Name = "ScriptsFrame"
    scriptsFrame.Size = UDim2.new(0.95, 0, 0.6, 0)
    scriptsFrame.Position = UDim2.new(0.025, 0, 0.2, 0)
    scriptsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    scriptsFrame.BackgroundTransparency = 0.2
    scriptsFrame.BorderSizePixel = 0
    scriptsFrame.ClipsDescendants = true
    local corner = Instance.new("UICorner", scriptsFrame)
    corner.CornerRadius = UDim.new(0, 10)

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
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 18
        btn.Text = feature .. ": OFF"
        btn.AnchorPoint = Vector2.new(0, 0)
        btn.LayoutOrder = i

        local btnCorner = Instance.new("UICorner", btn)
        btnCorner.CornerRadius = UDim.new(0, 6)

        local active = false
        btn.MouseButton1Click:Connect(function()
            active = not active
            btn.Text = feature .. ": " .. (active and "ON" or "OFF")
            -- Aqui você pode colocar a lógica para ativar/desativar a função
            print(feature, "toggled:", active)
        end)

        btn.Parent = scrollFrame
    end

    return scriptsFrame
end

function loadMainHub()
    if mainGui then mainGui:Destroy() end

    mainGui = Instance.new("ScreenGui", gui)
    mainGui.Name = "StormdownnHub_Main"
    mainGui.ResetOnSpawn = false

    -- Fundo com a imagem do Aizawa e blur
    local bg = Instance.new("ImageLabel", mainGui)
    bg.Name = "Background"
    bg.Size = UDim2.new(1,0,1,0)
    bg.Position = UDim2.new(0,0,0,0)
    bg.Image = "rbxassetid://15327849226"
    bg.ImageTransparency = 0.5
    bg.ScaleType = Enum.ScaleType.Crop
    bg.ZIndex = 0

    local blur = Instance.new("BlurEffect", Lighting)
    blur.Size = 12

    local mainFrame = Instance.new("Frame", mainGui)
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 420, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -210, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    local corner = Instance.new("UICorner", mainFrame)
    corner.CornerRadius = UDim.new(0, 16)

    local title = Instance.new("TextLabel", mainFrame)
    title.Text = "StormdownnHub V1"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.Size = UDim2.new(1, 0, 0, 45)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(30, 30, 30)

    local settingsBtn = Instance.new("TextButton", mainFrame)
    settingsBtn.Name = "SettingsButton"
    settingsBtn.Text = "⚙️"
    settingsBtn.Font = Enum.Font.GothamBold
    settingsBtn.TextSize = 26
    settingsBtn.Size = UDim2.new(0, 40, 0, 40)
    settingsBtn.Position = UDim2.new(1, -50, 0, 10)
    settingsBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    local btnCorner = Instance.new("UICorner", settingsBtn)
    btnCorner.CornerRadius = UDim.new(1, 0)

    local scriptsFrame = createScriptsFrame(mainFrame)

    settingsBtn.MouseButton1Click:Connect(function()
        if settingsGui then
            settingsGui:Destroy()
            settingsGui = nil
            mainFrame.Visible = true
        else
            mainFrame.Visible = false
            loadSettings()
        end
    end)

    applyTheme(mainFrame)
    createToggleButton(mainFrame)
end
