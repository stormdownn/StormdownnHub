-- Settings.lua - Parte 1: Player

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local function calculateAccountAge(creationDate)
    local currentTime = os.time()
    local diff = currentTime - creationDate
    return math.floor(diff / (24 * 60 * 60))
end

-- Criando frame principal das configurações
local settingsFrame = Instance.new("Frame")
settingsFrame.Size = UDim2.new(0, 400, 0, 350)
settingsFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
settingsFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
settingsFrame.BorderSizePixel = 0
settingsFrame.Active = true
settingsFrame.Draggable = true
settingsFrame.Name = "SettingsFrame"
settingsFrame.Parent = script.Parent -- Ajuste conforme o pai da UI

local corner = Instance.new("UICorner", settingsFrame)
corner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", settingsFrame)
title.Text = "Configurações"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(30, 30, 30)
title.Name = "Title"

-- Container para a aba Player
local playerTab = Instance.new("Frame", settingsFrame)
playerTab.Size = UDim2.new(1, -40, 1, -90)
playerTab.Position = UDim2.new(0, 20, 0, 50)
playerTab.BackgroundTransparency = 1
playerTab.Name = "PlayerTab"

-- Welcome + Nome de usuário + Avatar
local welcomeText = Instance.new("TextLabel", playerTab)
welcomeText.Text = "Welcome, " .. player.Name
welcomeText.Font = Enum.Font.GothamBold
welcomeText.TextSize = 20
welcomeText.Size = UDim2.new(1, -110, 0, 50)
welcomeText.Position = UDim2.new(0, 100, 0, 0)
welcomeText.BackgroundTransparency = 1
welcomeText.TextColor3 = Color3.fromRGB(30, 30, 30)
welcomeText.TextXAlignment = Enum.TextXAlignment.Left

local avatar = Instance.new("ImageLabel", playerTab)
avatar.Size = UDim2.new(0, 80, 0, 80)
avatar.Position = UDim2.new(0, 10, 0, 0)
avatar.BackgroundTransparency = 1
avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"

-- Info ID do usuário
local userIdLabel = Instance.new("TextLabel", playerTab)
userIdLabel.Text = "ID do usuário: " .. tostring(player.UserId)
userIdLabel.Font = Enum.Font.Gotham
userIdLabel.TextSize = 16
userIdLabel.Size = UDim2.new(1, 0, 0, 25)
userIdLabel.Position = UDim2.new(0, 0, 0, 90)
userIdLabel.BackgroundTransparency = 1
userIdLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
userIdLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Idade da conta (em dias)
local accountAge = math.floor((os.time() - player.AccountAge*24*60*60) / (24*60*60))
-- OBS: Roblox não fornece data exata de criação pela API, isso é simbólico; se tiver timestamp real, substitua.
local accountAgeLabel = Instance.new("TextLabel", playerTab)
accountAgeLabel.Text = "Idade da conta: " .. tostring(player.AccountAge) .. " dias"
accountAgeLabel.Font = Enum.Font.Gotham
accountAgeLabel.TextSize = 16
accountAgeLabel.Size = UDim2.new(1, 0, 0, 25)
accountAgeLabel.Position = UDim2.new(0, 0, 0, 115)
accountAgeLabel.BackgroundTransparency = 1
accountAgeLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
accountAgeLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Endereço IP e localização - inicializa com "Carregando..."
local ipLabel = Instance.new("TextLabel", playerTab)
ipLabel.Text = "Endereço IP: Carregando..."
ipLabel.Font = Enum.Font.Gotham
ipLabel.TextSize = 16
ipLabel.Size = UDim2.new(1, 0, 0, 25)
ipLabel.Position = UDim2.new(0, 0, 0, 140)
ipLabel.BackgroundTransparency = 1
ipLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
ipLabel.TextXAlignment = Enum.TextXAlignment.Left

local locationLabel = Instance.new("TextLabel", playerTab)
locationLabel.Text = "Localização: Carregando..."
locationLabel.Font = Enum.Font.Gotham
locationLabel.TextSize = 16
locationLabel.Size = UDim2.new(1, 0, 0, 50)
locationLabel.Position = UDim2.new(0, 0, 0, 165)
locationLabel.BackgroundTransparency = 1
locationLabel.TextWrapped = true
locationLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
locationLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Função para buscar dados de IP e localização via API
spawn(function()
    local success, response = pcall(function()
        return HttpService:GetAsync("https://ipapi.co/json/")
    end)
    if success then
        local data = HttpService:JSONDecode(response)
        ipLabel.Text = "Endereço IP: " .. (data.ip or "N/A")
        local locText = string.format(
            "%s (continente %s, província %s, capital %s, cidade %s, CEP %s)",
            data.country_name or "N/A",
            data.continent_code or "N/A",
            data.region or "N/A",
            data.city or "N/A",
            data.city or "N/A",
            data.postal or "N/A"
        )
        locationLabel.Text = "Localização: " .. locText
    else
        ipLabel.Text = "Endereço IP: N/A"
        locationLabel.Text = "Localização: N/A"
    end
end)

-- Settings.lua - Parte 2: Tema

local themeTab = Instance.new("Frame", settingsFrame)
themeTab.Size = UDim2.new(1, 0, 1, -90)
themeTab.Position = UDim2.new(0, 0, 0, 50)
themeTab.BackgroundTransparency = 1
themeTab.Name = "ThemeTab"
themeTab.Visible = false -- Começa oculto

local themeTitle = Instance.new("TextLabel", themeTab)
themeTitle.Text = "Troca de Tema"
themeTitle.Font = Enum.Font.GothamBold
themeTitle.TextSize = 20
themeTitle.Size = UDim2.new(1, 0, 0, 30)
themeTitle.Position = UDim2.new(0, 0, 0, 0)
themeTitle.BackgroundTransparency = 1
themeTitle.TextColor3 = Color3.fromRGB(30, 30, 30)

local toggleThemeButton = Instance.new("TextButton", themeTab)
toggleThemeButton.Text = "Mudar para modo escuro"
toggleThemeButton.Font = Enum.Font.GothamBold
toggleThemeButton.TextSize = 18
toggleThemeButton.Size = UDim2.new(0, 200, 0, 40)
toggleThemeButton.Position = UDim2.new(0, 10, 0, 50)
toggleThemeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleThemeButton.TextColor3 = Color3.new(1, 1, 1)
local btnCorner = Instance.new("UICorner", toggleThemeButton)
btnCorner.CornerRadius = UDim.new(0, 8)

local darkMode = false

local function applyTheme(dark)
    if dark then
        settingsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        for _, obj in pairs(settingsFrame:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                obj.TextColor3 = Color3.new(1, 1, 1)
                if obj:IsA("TextButton") then
                    obj.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                end
            elseif obj:IsA("Frame") and obj ~= settingsFrame then
                obj.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            end
        end
    else
        settingsFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
        for _, obj in pairs(settingsFrame:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                obj.TextColor3 = Color3.fromRGB(30, 30, 30)
                if obj:IsA("TextButton") then
                    obj.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                end
            elseif obj:IsA("Frame") and obj ~= settingsFrame then
                obj.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
            end
        end
    end
end

toggleThemeButton.MouseButton1Click:Connect(function()
    darkMode = not darkMode
    if darkMode then
        toggleThemeButton.Text = "Mudar para modo claro"
    else
        toggleThemeButton.Text = "Mudar para modo escuro"
    end
    applyTheme(darkMode)
end)

applyTheme(darkMode)

-- Settings.lua - Parte 3: Desenvolvedores

local developersTab = Instance.new("Frame", settingsFrame)
developersTab.Size = UDim2.new(1, 0, 1, -90)
developersTab.Position = UDim2.new(0, 0, 0, 50)
developersTab.BackgroundTransparency = 1
developersTab.Name = "DevelopersTab"
developersTab.Visible = false -- Começa oculto

local devTitle = Instance.new("TextLabel", developersTab)
devTitle.Text = "Desenvolvedores"
devTitle.Font = Enum.Font.GothamBold
devTitle.TextSize = 20
devTitle.Size = UDim2.new(1, 0, 0, 30)
devTitle.Position = UDim2.new(0, 0, 0, 0)
devTitle.BackgroundTransparency = 1
devTitle.TextColor3 = Color3.fromRGB(30, 30, 30)

local devs = {
    {name = "Stormdownn", image = "rbxassetid://b02875c2a22d0da9f49f4b72cd1b573e"},
    {name = "ChatGPT", image = "rbxassetid://6b579ee7678f8746520decbfcc602815"}
}

for i, dev in ipairs(devs) do
    local devFrame = Instance.new("Frame", developersTab)
    devFrame.Size = UDim2.new(1, 0, 0, 70)
    devFrame.Position = UDim2.new(0, 0, 0, 30 + (i - 1) * 75)
    devFrame.BackgroundTransparency = 1

    local devImage = Instance.new("ImageLabel", devFrame)
    devImage.Size = UDim2.new(0, 60, 0, 60)
    devImage.Position = UDim2.new(0, 10, 0, 5)
    devImage.BackgroundTransparency = 1
    devImage.Image = dev.image

    local devName = Instance.new("TextLabel", devFrame)
    devName.Size = UDim2.new(1, -80, 1, 0)
    devName.Position = UDim2.new(0, 80, 0, 0)
    devName.Text = dev.name
    devName.Font = Enum.Font.GothamBold
    devName.TextSize = 20
    devName.BackgroundTransparency = 1
    devName.TextColor3 = Color3.fromRGB(30, 30, 30)
    devName.TextXAlignment = Enum.TextXAlignment.Left
end

-- Função para mostrar a aba correta e esconder as outras
local function showTab(tabName)
    playerTab.Visible = false
    themeTab.Visible = false
    developersTab.Visible = false

    if tabName == "Player" then
        playerTab.Visible = true
    elseif tabName == "Tema" then
        themeTab.Visible = true
    elseif tabName == "Desenvolvedores" then
        developersTab.Visible = true
    end
end

-- Criar botões para mudar as abas
local tabButtonsFrame = Instance.new("Frame", settingsFrame)
tabButtonsFrame.Size = UDim2.new(1, 0, 0, 40)
tabButtonsFrame.Position = UDim2.new(0, 0, 0, 45)
tabButtonsFrame.BackgroundTransparency = 1

local tabNames = {"Player", "Tema", "Desenvolvedores"}

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton", tabButtonsFrame)
    btn.Size = UDim2.new(1/#tabNames, -10, 1, 0)
    btn.Position = UDim2.new((i-1)/#tabNames, 5, 0, 0)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 8)
    btn.TextColor3 = Color3.fromRGB(30, 30, 30)

    btn.MouseButton1Click:Connect(function()
        showTab(name)
    end)
end

-- Mostrar a aba Player por padrão
showTab("Player")
