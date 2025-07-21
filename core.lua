-- core.lua - StormdownnHub V1
-- Criado por Stormdownn e ChatGPT
-- Estrutura modular para futuras versões como StormdownnHub_V2

-- Serviços necessários
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

-- Configuração
local PASSWORD = "stormdownn"
local HUB_IMAGE_ID = "rbxassetid://15327849226"
local CREATOR_IMAGE_ID = "rbxassetid://17423995385"

-- Função para criar cantos arredondados
local function roundify(obj, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = obj
end

-- Tela de login
local function createLogin()
    local gui = player:WaitForChild("PlayerGui")
    gui:ClearAllChildren()

    local loginGui = Instance.new("ScreenGui", gui)
    loginGui.Name = "StormdownnHub_Login"
    loginGui.ResetOnSpawn = false

    local frame = Instance.new("Frame", loginGui)
    frame.Size = UDim2.new(0, 300, 0, 200)
    frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.Active = true
    frame.Draggable = true
    roundify(frame, 12)

    local title = Instance.new("TextLabel", frame)
    title.Text = "StormdownnHub Login"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.Size = UDim2.new(1, 0, 0, 40)
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1

    local input = Instance.new("TextBox", frame)
    input.PlaceholderText = "Digite a senha..."
    input.Font = Enum.Font.Gotham
    input.TextSize = 16
    input.Size = UDim2.new(0.9, 0, 0, 40)
    input.Position = UDim2.new(0.05, 0, 0.4, 0)
    input.TextColor3 = Color3.new(1, 1, 1)
    input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    roundify(input, 8)

    local button = Instance.new("TextButton", frame)
    button.Text = "Entrar"
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.Size = UDim2.new(0.5, 0, 0, 35)
    button.Position = UDim2.new(0.25, 0, 0.7, 0)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    roundify(button, 8)

    button.MouseButton1Click:Connect(function()
        if input.Text == PASSWORD then
            loginGui:Destroy()
            loadMainHub()
        else
            button.Text = "Senha incorreta!"
            task.wait(1)
            button.Text = "Entrar"
        end
    end)
end

-- Função para obter localização via IP (simulada, pois HttpGet externo requer autorização)
local function getLocation()
    local success, response = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("http://ip-api.com/json/"))
    end)
    if success and response and response.city then
        return response.city .. ", " .. response.regionName
    else
        return "StormNet (Wi-Fi Detectado)"
    end
end

-- Função para carregar o hub principal
function loadMainHub()
    local gui = player:WaitForChild("PlayerGui")
    local existing = gui:FindFirstChild("StormdownnHub_Main")
    if existing then existing:Destroy() end

    local ScreenGui = Instance.new("ScreenGui", gui)
    ScreenGui.Name = "StormdownnHub_Main"
    ScreenGui.ResetOnSpawn = false

    local Background = Instance.new("ImageLabel", ScreenGui)
    Background.Name = "Background"
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.Position = UDim2.new(0, 0, 0, 0)
    Background.Image = HUB_IMAGE_ID
    Background.ImageTransparency = 0.5
    Background.ScaleType = Enum.ScaleType.Crop
    Background.ZIndex = 0

    local blur = Instance.new("BlurEffect")
    blur.Size = 12
    blur.Parent = Lighting

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 420, 0, 360)
    MainFrame.Position = UDim2.new(0.5, -210, 0.5, -180)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BackgroundTransparency = 0.2
    MainFrame.Active = true
    MainFrame.Draggable = true
    roundify(MainFrame, 12)

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Text = "StormdownnHub V1"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.new(1, 1, 1)

    local Scroll = Instance.new("ScrollingFrame", MainFrame)
    Scroll.Size = UDim2.new(1, -20, 1, -60)
    Scroll.Position = UDim2.new(0, 10, 0, 50)
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
    Scroll.ScrollBarThickness = 6
    Scroll.BackgroundTransparency = 1

    local Layout = Instance.new("UIListLayout", Scroll)
    Layout.Padding = UDim.new(0, 6)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    local features = {
        "Fly", "NoClip", "ESP", "KillPlayers", "WalkFling", "PuxarPlayer",
        "EmotesR6", "EmotesR15", "RingParts", "Magnet", "LagOthers", "Telekinesis"
    }

    for _, name in ipairs(features) do
        local btn = Instance.new("TextButton", Scroll)
        btn.Size = UDim2.new(1, -10, 0, 35)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Text = name .. ": OFF"
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 16
        roundify(btn, 6)
        local state = false
        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.Text = name .. ": " .. (state and "ON" or "OFF")
        end)
    end

    local ToggleButton = Instance.new("ImageButton", ScreenGui)
    ToggleButton.Name = "ToggleHub"
    ToggleButton.Image = HUB_IMAGE_ID
    ToggleButton.Size = UDim2.new(0, 50, 0, 50)
    ToggleButton.Position = UDim2.new(0, 10, 1, -60)
    ToggleButton.BackgroundTransparency = 1

    local visible = true
    ToggleButton.MouseButton1Click:Connect(function()
        visible = not visible
        MainFrame.Visible = visible
    end)
end

-- Iniciar com login
createLogin()
