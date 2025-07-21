-- StormdownnHub V1 - Recriado por ChatGPT com visual tech, blur e scripts completos
-- Última atualização: 2025-07-21

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Util: Função para arrastar GUIs
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

-- Tela de Login
local loginGui = Instance.new("ScreenGui", playerGui)
loginGui.Name = "StormLogin"
loginGui.ResetOnSpawn = false

local loginFrame = Instance.new("Frame", loginGui)
loginFrame.Size = UDim2.new(0, 300, 0, 180)
loginFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
loginFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
loginFrame.BackgroundTransparency = 0.2
loginFrame.BorderSizePixel = 0
loginFrame.ClipsDescendants = true
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
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true

local input = Instance.new("TextBox", loginFrame)
input.Size = UDim2.new(0.8, 0, 0, 40)
input.Position = UDim2.new(0.1, 0, 0.5, -20)
input.PlaceholderText = "Senha..."
input.Text = ""
input.ClearTextOnFocus = false
input.Font = Enum.Font.Gotham
title.TextStrokeTransparency = 0.8
input.TextSize = 18
input.TextColor3 = Color3.fromRGB(255,255,255)
input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
input.BorderSizePixel = 0
input.BackgroundTransparency = 0.2

local enterBtn = Instance.new("TextButton", loginFrame)
enterBtn.Size = UDim2.new(0.5, 0, 0, 35)
enterBtn.Position = UDim2.new(0.25, 0, 0.75, 0)
enterBtn.Text = "Entrar"
enterBtn.Font = Enum.Font.GothamBold
enterBtn.TextSize = 18
enterBtn.TextColor3 = Color3.fromRGB(255,255,255)
enterBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
enterBtn.BackgroundTransparency = 0.2
enterBtn.BorderSizePixel = 0

-- Painel do HUB (invisível até o login)
local hubGui = Instance.new("ScreenGui", playerGui)
hubGui.Name = "StormHub"
hubGui.Enabled = false

local hubFrame = Instance.new("Frame", hubGui)
hubFrame.Size = UDim2.new(0, 500, 0, 350)
hubFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
hubFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
hubFrame.BackgroundTransparency = 0.2
hubFrame.BorderSizePixel = 0
hubFrame.ClipsDescendants = true
makeDraggable(hubFrame)

local hubBg = Instance.new("ImageLabel", hubFrame)
hubBg.Size = UDim2.new(1, 0, 1, 0)
hubBg.Position = UDim2.new(0, 0, 0, 0)
hubBg.Image = "rbxassetid://15327849226"
hubBg.ImageTransparency = 0.8
hubBg.BackgroundTransparency = 1

-- Scroll interno dos botões de script
local scroll = Instance.new("ScrollingFrame", hubFrame)
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.Position = UDim2.new(0, 0, 0, 0)
scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollBarImageColor3 = Color3.fromRGB(100,100,100)

-- Adiciona botões de exemplo (substitua pelos reais depois)
local function createButton(text, scriptUrl)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, #scroll:GetChildren() * 45)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet(scriptUrl))()
    end)
end

-- Exemplo de botões (adicione seus links reais depois)
createButton("RingParts", "https://pastebin.com/raw/xxxxxxxx")
createButton("Magnet", "https://pastebin.com/raw/yyyyyyyy")
-- (continue com os scripts desejados)

-- Botão flutuante para abrir/fechar o painel
local toggleBtn = Instance.new("ImageButton", hubGui)
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 10, 0.5, -25)
toggleBtn.Image = "rbxassetid://15327849226"
toggleBtn.BackgroundTransparency = 1

local opened = true
toggleBtn.MouseButton1Click:Connect(function()
    opened = not opened
    hubFrame.Visible = opened
end)

-- Ação do login
enterBtn.MouseButton1Click:Connect(function()
    if input.Text == "stormdownn" then
        loginGui:Destroy()
        hubGui.Enabled = true
    else
        enterBtn.Text = "Senha incorreta"
        wait(1.5)
        enterBtn.Text = "Entrar"
    end
end)
