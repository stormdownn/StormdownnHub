-- StormdownnHub V1 - core.lua
-- Criado por Stormdownn e ChatGPT

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

-- Configurações básicas
local PASSWORD = "stormdownn"
local isDarkTheme = false
local panelVisible = true

-- Função para criar UI arredondado
local function createUICorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
    return corner
end

-- Função para aplicar tema (claro/escuro)
local function applyTheme(gui)
    local bgColor, textColor, inputBg, buttonBg
    if isDarkTheme then
        bgColor = Color3.fromRGB(30, 30, 30)
        textColor = Color3.new(1,1,1)
        inputBg = Color3.fromRGB(50,50,50)
        buttonBg = Color3.fromRGB(70,70,70)
    else
        bgColor = Color3.fromRGB(240, 240, 240)
        textColor = Color3.fromRGB(20, 20, 20)
        inputBg = Color3.fromRGB(230,230,230)
        buttonBg = Color3.fromRGB(200,200,200)
    end

    for _, obj in pairs(gui:GetDescendants()) do
        if obj:IsA("Frame") then
            obj.BackgroundColor3 = bgColor
        elseif obj:IsA("TextLabel") or obj:IsA("TextButton") then
            obj.TextColor3 = textColor
            if obj:IsA("TextButton") then
                obj.BackgroundColor3 = buttonBg
            end
        elseif obj:IsA("TextBox") then
            obj.BackgroundColor3 = inputBg
            obj.TextColor3 = textColor
        end
    end
end

-- Aplica blur no Lighting
local function applyBlur()
    local blur = Lighting:FindFirstChild("StormdownnHubBlur")
    if not blur then
        blur = Instance.new("BlurEffect")
        blur.Name = "StormdownnHubBlur"
        blur.Size = 15
        blur.Parent = Lighting
    end
end

local function removeBlur()
    local blur = Lighting:FindFirstChild("StormdownnHubBlur")
    if blur then blur:Destroy() end
end

-- Limpa guis antigos
local function cleanup()
    local gui = player:FindFirstChild("PlayerGui")
    if gui then
        if gui:FindFirstChild("StormdownnHub_Login") then
            gui.StormdownnHub_Login:Destroy()
        end
        if gui:FindFirstChild("StormdownnHub_Main") then
            gui.StormdownnHub_Main:Destroy()
        end
    end
    removeBlur()
end

-- Cria a tela de login
local function createLogin()
    cleanup()
    local gui = Instance.new("ScreenGui")
    gui.Name = "StormdownnHub_Login"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 220)
    frame.Position = UDim2.new(0.5, -160, 0.5, -110)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui
    createUICorner(frame, 12)

    local title = Instance.new("TextLabel")
    title.Text = "StormdownnHub Login"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.Size = UDim2.new(1,0,0,50)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.new(1,1,1)
    title.Parent = frame

    local input = Instance.new("TextBox")
    input.PlaceholderText = "Digite a senha..."
    input.Font = Enum.Font.Gotham
    input.TextSize = 18
    input.Size = UDim2.new(0.85, 0, 0, 45)
    input.Position = UDim2.new(0.075, 0, 0.45, 0)
    input.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    input.TextColor3 = Color3.new(1,1,1)
    input.ClearTextOnFocus = false
    input.Parent = frame
    createUICorner(input, 8)

    local overlay = Instance.new("Frame") -- escurece a área do input
    overlay.Size = input.Size
    overlay.Position = input.Position
    overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
    overlay.BackgroundTransparency = 0.4
    overlay.ZIndex = 1
    overlay.Parent = frame

    input.ZIndex = 2

    local button = Instance.new("TextButton")
    button.Text = "Entrar"
    button.Font = Enum.Font.GothamBold
    button.TextSize = 20
    button.Size = UDim2.new(0.5, 0, 0, 40)
    button.Position = UDim2.new(0.25, 0, 0.75, 0)
    button.BackgroundColor3 = Color3.fromRGB(50,50,50)
    button.TextColor3 = Color3.new(1,1,1)
    button.Parent = frame
    createUICorner(button, 8)

    button.MouseButton1Click:Connect(function()
        if input.Text == PASSWORD then
            gui:Destroy()
            loadMainHub()
        else
            button.Text = "Senha incorreta!"
            wait(1.2)
            button.Text = "Entrar"
        end
    end)
end

-- Cria botão flutuante para abrir/fechar o painel principal
local function createToggleButton(mainFrame)
    local gui = player:WaitForChild("PlayerGui")
    local button = gui:FindFirstChild("StormdownnHub_Toggle")
    if button then button:Destroy() end

    button = Instance.new("TextButton")
    button.Name = "StormdownnHub_Toggle"
    button.Text = "" -- No text, we will put an image
    button.Size = UDim2.new(0, 48, 0, 48)
    button.Position = UDim2.new(0, 10, 0, 10)
    button.BackgroundColor3 = Color3.fromRGB(40,40,40)
    button.AutoButtonColor = false
    button.Parent = gui
    createUICorner(button, 24)
    button.ZIndex = 10

    -- Imagem do ícone do hub (adicione seu assetId)
    local img = Instance.new("ImageLabel")
    img.Name = "Icon"
    img.Size = UDim2.new(1,0,1,0)
    img.Image = "rbxassetid://15327849226" -- Aizawa como ícone
    img.BackgroundTransparency = 1
    img.Parent = button

    -- Drag para mover o botão quando o painel estiver fechado
    local dragging = false
    local dragInput, dragStart, startPos

    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = button.Position
        end
    end)
    button.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            local newPos = UDim2.new(
                math.clamp(startPos.X.Scale, 0, 1),
                math.clamp(startPos.X.Offset + delta.X, 0, workspace.CurrentCamera.ViewportSize.X - button.AbsoluteSize.X),
                math.clamp(startPos.Y.Scale, 0, 1),
                math.clamp(startPos.Y.Offset + delta.Y, 0, workspace.CurrentCamera.ViewportSize.Y - button.AbsoluteSize.Y)
            )
            button.Position = newPos
        end
    end)
    button.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Toggle painel principal
    button.MouseButton1Click:Connect(function()
        panelVisible = not panelVisible
        mainFrame.Visible = panelVisible
        if panelVisible then
            button.Position = UDim2.new(0, 10, 0, 10) -- Volta pro canto fixo quando aberto
        end
    end)
end

-- Função para buscar avatar do player pelo UserId
local function getAvatarUrl(userId)
    return "https://www.roblox.com/headshot-thumbnail/image?userId="..userId.."&width=150&height=150&format=png"
end

-- Função para calcular idade da conta em dias
local function getAccountAgeDays(createdDate)
    local diff = os.time() - os.time(createdDate)
    return math.floor(diff / (60*60*24))
end

-- Função para pegar localização via IP (API gratuita)
local function getLocation()
    local success, response = pcall(function()
        return HttpService:GetAsync("https://ipapi.co/json/")
    end)
    if success then
        local data = HttpService:JSONDecode(response)
        return data -- retorna um objeto com cidade, região, país, continente, ip etc
    else
        return nil
    end
end

-- Função que cria a aba configurações (3 seções)
local function createSettings(mainFrame)
    local gui = player:WaitForChild("PlayerGui")
    local existingSettings = gui:FindFirstChild("StormdownnHub_Settings")
    if existingSettings then existingSettings:Destroy() end

    local settingsFrame = Instance.new("Frame")
    settingsFrame.Name = "StormdownnHub_Settings"
    settingsFrame.Size = UDim2.new(0, 460, 0, 320)
    settingsFrame.Position = UDim2.new(1, 10, 0, 40) -- Fica ao lado direito do painel principal
    settingsFrame.BackgroundColor3 = isDarkTheme and Color3.fromRGB(30,30,30) or Color3.fromRGB(240,240,240)
    settingsFrame.BorderSizePixel = 0
    settingsFrame.Parent = gui
    createUICorner(settingsFrame, 12)
    settingsFrame.Visible = false
    settingsFrame.Active = true
    settingsFrame.Draggable = true

    -- Título
    local title = Instance.new("TextLabel")
    title.Text = "Configurações"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextColor3 = isDarkTheme and Color3.new(1,1,1) or Color3.fromRGB(20,20,20)
    title.Size = UDim2.new(1, 0, 0, 45)
    title.BackgroundTransparency = 1
    title.Parent = settingsFrame

    -- Separador horizontal
    local separator = Instance.new("Frame")
    separator.Size = UDim2.new(1, -20, 0, 2)
    separator.Position = UDim2.new(0, 10, 0, 48)
    separator.BackgroundColor3 = isDarkTheme and Color3.fromRGB(60,60,60) or Color3.fromRGB(200,200,200)
    separator.Parent = settingsFrame

    -- Container das seções
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 1, -60)
    container.Position = UDim2.new(0, 10, 0, 55)
    container.BackgroundTransparency = 1
    container.Parent = settingsFrame

    -- Layout vertical
    local layout = Instance.new("UIListLayout")
    layout.Parent = container
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 12)

    -- ==================== 1. Player ====================
    local playerSection = Instance.new("Frame")
    playerSection.Size = UDim2.new(1, 0, 0, 140)
    playerSection.BackgroundTransparency = 1
    playerSection.Parent = container

    -- Welcome e avatar
    local welcomeLabel = Instance.new("TextLabel")
    welcomeLabel.Text = "Welcome, "..player.Name
    welcomeLabel.Font = Enum.Font.GothamBold
    welcomeLabel.TextSize = 20
    welcomeLabel.TextColor3 = isDarkTheme and Color3.new(1,1,1) or Color3.fromRGB(20,20,20)
    welcomeLabel.BackgroundTransparency = 1
    welcomeLabel.Size = UDim2.new(1, 0, 0, 30)
    welcomeLabel.Parent = playerSection

    local avatarImg = Instance.new("ImageLabel")
    avatarImg.Size = UDim2.new(0, 70, 0, 70)
    avatarImg.Position = UDim2.new(0, 0, 0, 35)
    avatarImg.BackgroundTransparency = 1
    avatarImg.Image = getAvatarUrl(player.UserId)
    avatarImg.Parent = playerSection

    -- ID do usuário
    local idLabel = Instance.new("TextLabel")
    idLabel.Text = "ID do usuário: "..player.UserId
    idLabel.Font = Enum.Font.Gotham
    idLabel.TextSize = 16
    idLabel.TextColor3 = isDarkTheme and Color3.new(1,1,1) or Color3.fromRGB(20,20,20)
    idLabel.BackgroundTransparency = 1
    idLabel.Position = UDim2.new(0, 80, 0, 35)
    idLabel.Size = UDim2.new(1, -80, 0, 25)
    idLabel.Parent = playerSection

    -- Idade da conta (precisa buscar via API do Roblox, mas aqui usamos placeholder)
    local accountAgeLabel = Instance.new("TextLabel")
    accountAgeLabel.Text = "Idade da conta: 693 dias"
    accountAgeLabel.Font = Enum.Font.Gotham
    accountAgeLabel.TextSize = 16
    accountAgeLabel.TextColor3 = isDarkTheme and Color3.new(1,1,1) or Color3.fromRGB(20,20,20)
    accountAgeLabel.BackgroundTransparency = 1
    accountAgeLabel.Position = UDim2.new(0, 80, 0, 60)
    accountAgeLabel.Size = UDim2.new(1, -80, 0, 25)
    accountAgeLabel.Parent = playerSection

    -- Localização e IP (serão preenchidos após pegar dados da API)
    local ipLabel = Instance.new("TextLabel")
    ipLabel.Text = "Endereço IP: Carregando..."
    ipLabel.Font = Enum.Font.Gotham
    ipLabel.TextSize = 16
    ipLabel.TextColor3 = isDarkTheme and Color3.new(1,1,1) or Color3.fromRGB(20,20,20)
    ipLabel.BackgroundTransparency = 1
    ipLabel.Position = UDim2.new(0, 80, 0, 85)
    ipLabel.Size = UDim2.new(1, -80, 0, 20)
    ipLabel.Parent = playerSection

    local locationLabel = Instance.new("TextLabel")
    locationLabel.Text = "Localização: Carregando..."
    locationLabel.Font = Enum.Font.Gotham
    locationLabel.TextSize = 16
    locationLabel.TextColor3 = isDarkTheme and Color3.new(1,1,1) or Color3.fromRGB(20,20,20)
    locationLabel.BackgroundTransparency = 1
    locationLabel.Position = UDim2.new(0, 80, 0, 105)
    locationLabel.Size = UDim2.new(1, -80, 0, 30)
    locationLabel.TextWrapped = true
    locationLabel.Parent = playerSection

    -- Requisição para pegar IP e localização
    spawn(function()
        local data = getLocation()
        if data then
            ipLabel.Text = "Endereço IP: "..(data.ip or "N/A")
            locationLabel.Text = ("Localização: %s, %s, %s, %s, %s"):format(
                data.continent_name or "N/A",
                data.region or "N/A",
                data.city or "N/A",
                data.country_name or "N/A",
                data.postal or "N/A"
            )
        else
            ipLabel.Text = "Endereço IP: Erro ao carregar"
            locationLabel.Text = "Localização: Erro ao carregar"
        end
    end)

    -- ==================== 2. Troca de Tema ====================
    local themeSection = Instance.new("Frame")
    themeSection.Size = UDim2.new(1, 0, 0, 60)
    themeSection.BackgroundTransparency = 1
    themeSection.Parent = container

    local themeLabel = Instance.new("TextLabel")
    themeLabel.Text = "Troca de Tema"
    themeLabel.Font = Enum.Font.GothamBold
    themeLabel.TextSize = 18
    themeLabel.TextColor3 = isDarkTheme and Color3.new(1,1,1) or Color3.fromRGB(20,20,20)
    themeLabel.BackgroundTransparency = 1
    themeLabel.Size = UDim2.new(1, 0, 0, 30)
    themeLabel.Parent = themeSection

    local themeButton = Instance.new("TextButton")
    themeButton.Text = isDarkTheme and "Modo Claro" or "Modo Escuro"
    themeButton.Font = Enum.Font.Gotham
    themeButton
