-- login.lua
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

-- Remove guis antigas
for _, name in pairs({"StormdownnHub_Login", "StormdownnHub_Main", "StormdownnHub_Settings", "ToggleButton"}) do
    local g = gui:FindFirstChild(name)
    if g then g:Destroy() end
end

local password = "stormdownn"

local loginGui = Instance.new("ScreenGui", gui)
loginGui.Name = "StormdownnHub_Login"
loginGui.ResetOnSpawn = false

local frame = Instance.new("Frame", loginGui)
frame.Size = UDim2.new(0, 320, 0, 220)
frame.Position = UDim2.new(0.5, -160, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
frame.BackgroundTransparency = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Text = "StormdownnHub Login"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(30, 30, 30)

local passwordBackground = Instance.new("Frame", frame)
passwordBackground.Size = UDim2.new(0.9, 0, 0, 45)
passwordBackground.Position = UDim2.new(0.05, 0, 0.4, 0)
passwordBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
passwordBackground.BackgroundTransparency = 0.35
Instance.new("UICorner", passwordBackground).CornerRadius = UDim.new(0, 8)

local input = Instance.new("TextBox", frame)
input.Size = UDim2.new(0.9, 0, 0, 45)
input.Position = UDim2.new(0.05, 0, 0.4, 0)
input.ClearTextOnFocus = true
input.PlaceholderText = "Digite a senha..."
input.TextTransparency = 0
input.TextColor3 = Color3.fromRGB(0,0,0)
input.BackgroundColor3 = Color3.fromRGB(245,245,245)
input.Font = Enum.Font.GothamBold
input.TextSize = 20
input.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 8)
input.TextEditable = true
input.ClearTextOnFocus = true
input.Text = ""

local button = Instance.new("TextButton", frame)
button.Text = "Entrar"
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.Size = UDim2.new(0.5, 0, 0, 40)
button.Position = UDim2.new(0.25, 0, 0.75, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

button.MouseButton1Click:Connect(function()
    if input.Text == password then
        loginGui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/stormdownn/StormdownnHub/main/interface.lua"))()
    else
        button.Text = "Senha incorreta!"
        wait(1.5)
        button.Text = "Entrar"
        input.Text = ""
    end
end)
