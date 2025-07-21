-- StormdownnHub V1 - Parte 1: Tela de Login e Botão Flutuante

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local password = "stormdownn"

local gui = player:WaitForChild("PlayerGui")

-- Remove GUIs antigas se existirem
for _, name in pairs({"StormdownnHub_Login", "StormdownnHub_Main", "StormdownnHub_Settings", "ToggleButton"}) do
    local oldGui = gui:FindFirstChild(name)
    if oldGui then oldGui:Destroy() end
end

-- Variáveis globais
local mainGui, settingsGui, toggleButton
local darkMode = false

-- Função para aplicar tema (claro/escuro)
local function applyTheme(guiFrame)
    if darkMode then
        guiFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        for _, obj in pairs(guiFrame:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                obj.TextColor3 = Color3.new(1, 1, 1)
                if obj:IsA("TextBox") then
                    obj.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                end
            elseif obj:IsA("Frame") and obj ~= guiFrame then
                obj.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            end
        end
    else
        guiFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
        for _, obj in pairs(guiFrame:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                obj.TextColor3 = Color3.fromRGB(30, 30, 30)
                if obj:IsA("TextBox") then
                    obj.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
                end
            elseif obj:IsA("Frame") and obj ~= guiFrame then
                obj.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
            end
        end
    end
end

-- Função para criar o botão flutuante (alfinete) arrastável
local function createToggleButton(mainFrame)
    toggleButton = Instance.new("ImageButton", gui)
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 40, 0, 40)
    toggleButton.Position = UDim2.new(0, 10, 0, 10) -- canto superior esquerdo inicial
    toggleButton.BackgroundTransparency = 0.1
    toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    toggleButton.ZIndex = 10
    toggleButton.AutoButtonColor = false
    toggleButton.Image = "rbxassetid://15327849226" -- Ícone do Hub (Aizawa)
    local corner = Instance.new("UICorner", toggleButton)
    corner.CornerRadius = UDim.new(1, 0)

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

    local open = true
    toggleButton.MouseButton1Click:Connect(function()
        if open then
            mainFrame.Visible = false
        else
            mainFrame.Visible = true
            -- Opcional: voltar para canto superior esquerdo ao abrir
            toggleButton.Position = UDim2.new(0, 10, 0, 10)
        end
        open = not open
    end)
end

-- Função para criar a tela de login
local function createLogin()
    local loginGui = Instance.new("ScreenGui", gui)
    loginGui.Name = "StormdownnHub_Login"
    loginGui.ResetOnSpawn = false

    local frame = Instance.new("Frame", loginGui)
    frame.Size = UDim2.new(0, 320, 0, 220)
    frame.Position = UDim2.new(0.5, -160, 0.5, -110)
    frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    frame.BackgroundTransparency = 0.15
    frame.Active = true
    frame.Draggable = true
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 12)

    local title = Instance.new("TextLabel", frame)
    title.Text = "StormdownnHub Login"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.Size = UDim2.new(1, 0, 0, 45)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(40, 40, 40)

    local input = Instance.new("TextBox", frame)
    input.PlaceholderText = "Digite a senha..."
    input.Font = Enum.Font.GothamBold
    input.TextSize = 18
    input.Size = UDim2.new(0.9, 0, 0, 45)
    input.Position = UDim2.new(0.05, 0, 0.4, 0)
    input.TextColor3 = Color3.new(0, 0, 0)
    input.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    local inputCorner = Instance.new("UICorner", input)
    inputCorner.CornerRadius = UDim.new(0, 8)
    input.ClearTextOnFocus = true
    input.TextTransparency = 0

    -- Escurecer a área do input para melhor visualização
    local passwordBackground = Instance.new("Frame", frame)
    passwordBackground.Size = input.Size
    passwordBackground.Position = input.Position
    passwordBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    passwordBackground.BackgroundTransparency = 0.35
    passwordBackground.ZIndex = input.ZIndex - 1
    local passwordCorner = Instance.new("UICorner", passwordBackground)
    passwordCorner.CornerRadius = UDim.new(0, 8)

    local button = Instance.new("TextButton", frame)
    button.Text = "Entrar"
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.Size = UDim2.new(0.5, 0, 0, 40)
    button.Position = UDim2.new(0.25, 0, 0.75, 0)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    local buttonCorner = Instance.new("UICorner", button)
    buttonCorner.CornerRadius = UDim.new(0, 8)

    button.MouseButton1Click:Connect(function()
        if input.Text == password then
            loginGui:Destroy()
            loadMainHub()
        else
            button.Text = "Senha incorreta!"
            wait(1.2)
            button.Text = "Entrar"
            input.Text = ""
        end
    end)
end

-- Chama o login para começar
createLogin()
