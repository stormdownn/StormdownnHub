-- Parte 3: Configurações
local Players = game:GetService("Players")
local user = Players.LocalPlayer

local screen = Instance.new("ScreenGui", game.CoreGui)
screen.Name = "StormdownnSettings"

local frame = Instance.new("Frame", screen)
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
frame.Active = true
frame.Draggable = true

local tabs = {"Player", "Tema", "Desenvolvedores"}
for i, name in pairs(tabs) do
	local tab = Instance.new("TextButton", frame)
	tab.Size = UDim2.new(0, 120, 0, 30)
	tab.Position = UDim2.new(0, (i - 1) * 130, 0, 0)
	tab.Text = name
	tab.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	tab.Font = Enum.Font.GothamBold
	tab.TextSize = 14
	tab.TextColor3 = Color3.fromRGB(0, 0, 0)
end

local info = Instance.new("TextLabel", frame)
info.Size = UDim2.new(1, -20, 1, -50)
info.Position = UDim2.new(0, 10, 0, 40)
info.TextWrapped = true
info.TextYAlignment = Enum.TextYAlignment.Top
info.TextXAlignment = Enum.TextXAlignment.Left
info.Font = Enum.Font.Gotham
info.TextSize = 14
info.TextColor3 = Color3.fromRGB(0, 0, 0)
info.BackgroundTransparency = 1

info.Text = "Welcome, " .. user.Name .. "\n"
	.. "ID do usuário: " .. user.UserId .. "\n"
	.. "Idade da conta: 693 dias\n"
	.. "Endereço IP: 27.145.215.176\n"
	.. "Localização: Tailândia (continente asiático, província de Nakhon Ratchasima, capital Bangkok, cidade Pak Chong District, CEP 30130)"
