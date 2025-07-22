-- StormdownnHub_V1

-- =======
-- INÍCIO/SENHA
-- =======

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")

-- Remove GUIs antigas
for _, name in pairs({"StormdownnHub_Login", "StormdownnHub_Main"}) do
    local oldGui = guiParent:FindFirstChild(name)
    if oldGui then oldGui:Destroy() end
end

-- Criar ScreenGui de Login
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
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextSize = 24

local passwordBox = Instance.new("TextBox", loginFrame)
passwordBox.Size = UDim2.new(0.9, 0, 0, 50)
passwordBox.Position = UDim2.new(0.05, 0, 0, 70)
passwordBox.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
passwordBox.ClearTextOnFocus = true
passwordBox.Font = Enum.Font.GothamBold
passwordBox.TextColor3 = Color3.fromRGB(0, 0, 0)
passwordBox.TextSize = 22
passwordBox.PlaceholderText = "Digite a senha..."
passwordBox.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", passwordBox).CornerRadius = UDim.new(0, 8)

local loginButton = Instance.new("TextButton", loginFrame)
loginButton.Size = UDim2.new(0.9, 0, 0, 40)
loginButton.Position = UDim2.new(0.05, 0, 0, 130)
loginButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
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

-- =======
-- HUB PRINCIPAL
-- =======

-- Criar ScreenGui principal (inicialmente desativado)
local mainGui = Instance.new("ScreenGui", guiParent)
mainGui.Name = "StormdownnHub_Main"
mainGui.ResetOnSpawn = false
mainGui.Enabled = false

-- Frame principal (menor e branco)
local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 300)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BackgroundTransparency = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)
-- Tornar o painel principal arrastável (mouse e touch)
local UIS = game:GetService("UserInputService")
local draggingMain = false
local dragInputMain, dragStartMain, startPosMain

local function updateMain(input)
	local delta = input.Position - dragStartMain
	mainFrame.Position = UDim2.new(
		mainFrame.Position.X.Scale,
		startPosMain.X.Offset + delta.X,
		mainFrame.Position.Y.Scale,
		startPosMain.Y.Offset + delta.Y
	)
end

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		draggingMain = true
		dragStartMain = input.Position
		startPosMain = mainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				draggingMain = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInputMain = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInputMain and draggingMain then
		updateMain(input)
	end
end)

-- Cabeçalho com texto preto
local headerLabel = Instance.new("TextLabel", mainFrame)
headerLabel.Size = UDim2.new(1, 0, 0, 50)
headerLabel.Position = UDim2.new(0, 0, 0, 0)
headerLabel.BackgroundTransparency = 1
headerLabel.Text = "🌩️ StormdawnnHub_V1 🌩️"
headerLabel.Font = Enum.Font.GothamBold
headerLabel.TextSize = 28
headerLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
headerLabel.TextXAlignment = Enum.TextXAlignment.Center
headerLabel.TextYAlignment = Enum.TextYAlignment.Center

-- Frame para os scripts (dentro do painel, ocupa o espaço abaixo do cabeçalho)
local scriptsFrame = Instance.new("ScrollingFrame", mainFrame)
scriptsFrame.Size = UDim2.new(1, -20, 1, -60)
scriptsFrame.Position = UDim2.new(0, 10, 0, 50)
scriptsFrame.BackgroundTransparency = 1
scriptsFrame.BorderSizePixel = 0
scriptsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scriptsFrame.ScrollBarThickness = 6
scriptsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scriptsFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

local uiLayout = Instance.new("UIListLayout", scriptsFrame)
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0, 8)

-- Lista de scripts exemplo (botões brancos com texto preto)
local features = {
    "Fly", "NoClip", "ESP", "KillPlayers", "WalkFling", "PuxarPlayer",
    "SuperRingParts", "Sledgehammer", "Magnet", "LagOthers", "Telekinesis"
}

for i, feature in ipairs(features) do
    local btn = Instance.new("TextButton")
    btn.Name = feature .. "_Button"
    btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(240, 240, 240) -- branco clarinho
    btn.TextColor3 = Color3.fromRGB(0, 0, 0) -- texto preto
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.Text = feature .. ": OFF"
    btn.LayoutOrder = i
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = feature .. ": " .. (active and "ON" or "OFF")
        print("[StormdownnHub] Feature toggled:", feature, active)
        -- Aqui vai a lógica do script
    end)

    btn.Parent = scriptsFrame
end

-- Botão flutuante preto no topo central para abrir/fechar painel

-- Criação do botão flutuante
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.5, -25, 0, -30) -- topo central do mainFrame
toggleButton.AnchorPoint = Vector2.new(0.5, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "✦"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 22
toggleButton.AutoButtonColor = false
toggleButton.ZIndex = 100
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)

toggleButton.Parent = mainFrame -- começa preso ao painel

-- Drag system para quando estiver solto
local UserInputService = game:GetService("UserInputService")
local dragging = false
local dragInput, dragStart, startPos

local function enableDragging(button)
	button.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = button.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			button.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

enableDragging(toggleButton) -- já deixa a função pronta (ativa só se estiver solto)

-- Controle de abrir e fechar
local isOpen = true

toggleButton.MouseButton1Click:Connect(function()
	if isOpen then
		mainGui.Enabled = false
		toggleButton.Text = "Abrir"
		toggleButton.Parent = guiParent
		toggleButton.Position = UDim2.new(0.5, -25, 0, 10) -- posição livre
	else
		mainGui.Enabled = true
		toggleButton.Text = "Fechar"
		toggleButton.Parent = mainFrame
		toggleButton.Position = UDim2.new(0.5, -25, 0, -30) -- volta pro topo
	end
	isOpen = not isOpen
end)

-- LOGIN (continuação da Parte 1)

loginButton.MouseButton1Click:Connect(function()
    local typed = passwordBox.Text
    if typed == HUB_PASSWORD then
    incorrectLabel.Text = ""
    loginGui:Destroy()
    toggleButton.Visible = true
    print("✅ Login bem-sucedido.")
    -- mostrar botão após login
    mainGui.Enabled = true
    else
        incorrectLabel.Text = "Senha incorreta!"
        wait(1.5)
        incorrectLabel.Text = ""
        passwordBox.Text = ""
    end
end)
