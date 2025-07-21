-- StormdownnHub V1 - Core.lua atualizado com correções

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local isLightTheme = true

-- Função para tornar frames arrastáveis
local function makeDraggable(frame)
    local dragToggle, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragToggle = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragToggle then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Aplica tema claro ou escuro nos elementos dentro do frame
local function applyTheme(frame)
    if isLightTheme then
        frame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
        for _, child in pairs(frame:GetChildren()) do
            if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                child.TextColor3 = Color3.fromRGB(30,30,30)
                if child:IsA("TextButton") or child:IsA("TextBox") then
                    child.BackgroundColor3 = Color3.fromRGB(230,230,230)
                    child.BorderSizePixel = 0
                end
            elseif child:IsA("Frame") then
                applyTheme(child)
            end
        end
    else
        frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        for _, child in pairs(frame:GetChildren()) do
            if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                child.TextColor3 = Color3.fromRGB(230,230,230)
                if child:IsA("TextButton") or child:IsA("TextBox") then
                    child.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    child.BorderSizePixel = 0
                end
            elseif child:IsA("Frame") then
                applyTheme(child)
            end
        end
    end
end

-- TELA DE LOGIN --
local loginGui = Instance.new("ScreenGui", playerGui)
loginGui.Name = "StormLogin"
loginGui.ResetOnSpawn = false

local loginFrame = Instance.new("Frame", loginGui)
loginFrame.Size = UDim2.new(0, 300, 0, 180)
loginFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
loginFrame.BackgroundTransparency = 0.1
makeDraggable(loginFrame)

local bgImage = Instance.new("ImageLabel", loginFrame)
bgImage.Size = UDim2.new(1, 0, 1, 0)
bgImage.Position = UDim2.new(0, 0, 0, 0)
bgImage.Image = "rbxassetid://15327849226"
bgImage.ImageTransparency = 0.7
bgImage.BackgroundTransparency = 1

local title = Instance.new("TextLabel", loginFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "StormdownnHub - Login"
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local input = Instance.new("TextBox", loginFrame)
input.Size = UDim2.new(0.8, 0, 0, 40)
input.Position = UDim2.new(0.1, 0, 0.5, -20)
input.PlaceholderText = "Senha..."
input.Text = ""
input.ClearTextOnFocus = false
input.Font = Enum.Font.Gotham
input.TextSize = 18
input.BackgroundTransparency = 0.1
input.BorderSizePixel = 0

local enterBtn = Instance.new("TextButton", loginFrame)
enterBtn.Size = UDim2.new(0.5, 0, 0, 35)
enterBtn.Position = UDim2.new(0.25, 0, 0.75, 0)
enterBtn.Text = "Entrar"
enterBtn.Font = Enum.Font.GothamBold
enterBtn.TextSize = 18
enterBtn.BackgroundTransparency = 0.1
enterBtn.BorderSizePixel = 0

applyTheme(loginFrame)

-- HUB PRINCIPAL --
local hubGui = Instance.new("ScreenGui", playerGui)
hubGui.Name = "StormHub"
hubGui.Enabled = false

local hubFrame = Instance.new("Frame", hubGui)
hubFrame.Size = UDim2.new(0, 520, 0, 360)
hubFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
hubFrame.BackgroundTransparency = 0.1
hubFrame.BorderSizePixel = 0
hubFrame.ClipsDescendants = true
makeDraggable(hubFrame)

local hubBg = Instance.new("ImageLabel", hubFrame)
hubBg.Size = UDim2.new(1, 0, 1, 0)
hubBg.Position = UDim2.new(0, 0, 0, 0)
hubBg.Image = "rbxassetid://15327849226"
hubBg.ImageTransparency = 0.85
hubBg.BackgroundTransparency = 1

local scroll = Instance.new("ScrollingFrame", hubFrame)
scroll.Size = UDim2.new(0.9, 0, 0.85, 0)
scroll.Position = UDim2.new(0.05, 0, 0.1, 0)
scroll.CanvasSize = UDim2.new(0, 0, 4, 0)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)

local function createButton(text, callback)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.BackgroundTransparency = 0.1
    btn.BorderSizePixel = 0
    btn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    btn.TextColor3 = Color3.fromRGB(30, 30, 30)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Text = text
    btn.AnchorPoint = Vector2.new(0.5, 0)
    btn.Position = UDim2.new(0.5, 0, 0, (#scroll:GetChildren() - 1) * 45)
    btn.AutoButtonColor = true
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local scripts = {
    {name = "RingParts", url = "https://pastebin.com/raw/xxxxxxxx"},
    {name = "Magnet", url = "https://pastebin.com/raw/yyyyyyyy"},
    {name = "LagOthers", url = "https://pastebin.com/raw/zzzzzzzz"},
    {name = "Telekinesis", url = "https://pastebin.com/raw/wwwwwwww"},
    {name = "Fly", url = "https://pastebin.com/raw/aaaaaa"},
    {name = "NoClip", url = "https://pastebin.com/raw/bbbbbb"},
    {name = "ESP", url = "https://pastebin.com/raw/cccccc"},
    {name = "KillPlayers", url = "https://pastebin.com/raw/dddddd"},
    {name = "WalkFling", url = "https://pastebin.com/raw/eeeeee"},
    {name = "PuxarPlayer", url = "https://pastebin.com/raw/ffffff"},
}

for _, v in ipairs(scripts) do
    createButton(v.name, function()
        loadstring(game:HttpGet(v.url))()
    end)
end

-- Botão configurações (após loadSettings)
local function loadSettings()
    local existingSettings = playerGui:FindFirstChild("StormSettings")
    if existingSettings then
        existingSettings:Destroy()
    end

    local settingsGui = Instance.new("ScreenGui", playerGui)
    settingsGui.Name = "StormSettings"
    settingsGui.ResetOnSpawn = false

    local frame = Instance.new("Frame", settingsGui)
    frame.Size = UDim2.new(0, 400, 0, 320)
    frame.Position = UDim2.new(0.5, -200, 0.5, -160)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    makeDraggable(frame)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "Configurações"
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true

    local stormImg = Instance.new("ImageLabel", frame)
    stormImg.Size = UDim2.new(0, 70, 0, 70)
    stormImg.Position = UDim2.new(0.1, 0, 0.3, 0)
    stormImg.BackgroundTransparency = 1
    stormImg.Image = "rbxassetid://15327849226"

    local chatgptImg = Instance.new("ImageLabel", frame)
    chatgptImg.Size = UDim2.new(0, 70, 0, 70)
    chatgptImg.Position = UDim2.new(0.4, 0, 0.3, 0)
    chatgptImg.BackgroundTransparency = 1
    chatgptImg.Image = "rbxassetid://17423995385"

    local creators = Instance.new("TextLabel", frame)
    creators.Size = UDim2.new(1, -40, 0, 40)
    creators.Position = UDim2.new(0, 20, 0, 110)
    creators.BackgroundTransparency = 1
    creators.Text = "Criadores: Stormdownn, ChatGPT"
    creators.Font = Enum.Font.Gotham
    creators.TextSize = 18
    creators.TextColor3 = isLightTheme and Color3.fromRGB(30,30,30) or Color3.fromRGB(230,230,230)

    local userName = Instance.new("TextLabel", frame)
    userName.Size = UDim2.new(1, -40, 0, 30)
    userName.Position = UDim2.new(0, 20, 0, 150)
    userName.BackgroundTransparency = 1
    userName.Text = "Usuário: "..player.Name
    userName.Font = Enum.Font.Gotham
    userName.TextSize = 16
    userName.TextColor3 = isLightTheme and Color3.fromRGB(30,30,30) or Color3.fromRGB(230,230,230)

    local location = Instance.new("TextLabel", frame)
    location.Size = UDim2.new(1, -40, 0, 30)
    location.Position = UDim2.new(0, 20, 0, 185)
    location.BackgroundTransparency = 1
    location.Text = "Localização: StormNet v1 (Wi-Fi Detectado)"
    location.Font = Enum.Font.Gotham
    location.TextSize = 16
    location.TextColor3 = isLightTheme and Color3.fromRGB(30,30,30) or Color3.fromRGB(230,230,230)

    local themeBtn = Instance.new("TextButton", frame)
    themeBtn.Size = UDim2.new(0.8, 0, 0, 40)
    themeBtn.Position = UDim2.new(0.1, 0, 0.85, 0)
    themeBtn.BackgroundTransparency = 0.1
    themeBtn.BorderSizePixel = 0
    themeBtn.Font = Enum.Font.GothamBold
    themeBtn.TextSize = 16
    themeBtn.Text = "Modo Tema: Claro"
    themeBtn.TextColor3 = Color3.fromRGB(30,30,30)

    applyTheme(frame)

    themeBtn.MouseButton1Click:Connect(function()
        isLightTheme = not isLightTheme
        if isLightTheme then
            themeBtn.Text = "Modo Tema: Claro"
        else
            themeBtn.Text = "Modo Tema: Escuro"
        end
        applyTheme(frame)
        applyTheme(hubFrame)
        applyTheme(loginFrame)
    end)
end

local settingsBtn = Instance.new("TextButton", hubGui)
settingsBtn.Size = UDim2.new(0, 40, 0, 40)
settingsBtn.Position = UDim2.new(1, -50, 1, -50)
settingsBtn.BackgroundTransparency = 0.1
settingsBtn.BorderSizePixel = 0
settingsBtn.Font = Enum.Font.GothamBold
settingsBtn.TextSize = 22
settingsBtn.Text = "⚙️"
settingsBtn.TextColor3 = isLightTheme and Color3.fromRGB(30,30,30) or Color3.fromRGB(230,230,230)
settingsBtn.AutoButtonColor = true
settingsBtn.MouseButton1Click:Connect(function()
    loadSettings()
end)

-- Botão flutuante abrir/fechar hub
local toggleBtn = Instance.new("ImageButton", hubGui)
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 10, 0.5, -25)
toggleBtn.BackgroundTransparency = 1
toggleBtn.Image = "rbxassetid://15327849226"
toggleBtn.AutoButtonColor = true

local opened = true
toggleBtn.MouseButton1Click:Connect(function()
    opened = not opened
    hubFrame.Visible = opened
end)

hubFrame.Visible = true
hubGui.Enabled = false

-- LOGIN BOTÃO
enterBtn.MouseButton1Click:Connect(function()
    if input.Text == "stormdownn" then
        loginGui:Destroy()
        hubGui.Enabled = true
        applyTheme(hubFrame)
    else
        enterBtn.Text = "Senha incorreta"
        wait(1.5)
        enterBtn.Text = "Entrar"
    end
end)
