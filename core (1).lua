
-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Criar ScreenGui
local hubGui = Instance.new("ScreenGui")
hubGui.Name = "StormdownnHub"
hubGui.ResetOnSpawn = false
hubGui.Parent = playerGui

-- Função para arrastar qualquer UI
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Painel principal
local hubFrame = Instance.new("Frame")
hubFrame.Size = UDim2.new(0, 400, 0, 300)
hubFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
hubFrame.AnchorPoint = Vector2.new(0.5, 0.5)
hubFrame.BackgroundColor3 = Color3.new(1, 1, 1)
hubFrame.BackgroundTransparency = 0
hubFrame.BorderSizePixel = 0
hubFrame.Name = "MainPanel"
hubFrame.Parent = hubGui

-- Estilo moderno (UICorner e sombra)
local corner = Instance.new("UICorner", hubFrame)
corner.CornerRadius = UDim.new(0, 12)

local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.ZIndex = 0
shadow.Parent = hubFrame

-- Botão "alfinete" (ícone no topo do painel)
local pinButton = Instance.new("ImageButton")
pinButton.Size = UDim2.new(0, 40, 0, 40)
pinButton.Position = UDim2.new(0.5, -20, 0, -20)
pinButton.BackgroundTransparency = 1
pinButton.Image = "rbxassetid://15327849226"
pinButton.ZIndex = 10
pinButton.Name = "PinButton"
pinButton.Parent = hubFrame

-- Torna o painel arrastável
makeDraggable(hubFrame)

-- Alternar visibilidade do painel com botão flutuante
local isOpen = true

pinButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    hubFrame.Visible = isOpen
    pinButton.Parent = isOpen and hubFrame or hubGui
end)

-- Quando o painel estiver fechado, o botão também pode ser arrastado
makeDraggable(pinButton)
