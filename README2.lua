--========================================================
-- UFO HUB X — Custom Splash Screen (Black + Green Theme)
--========================================================
local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local lp           = Players.LocalPlayer
local pg           = lp:WaitForChild("PlayerGui")

if _G.__UFOX_SPLASH then return end
_G.__UFOX_SPLASH = true

-- ===== Screen =====
local screen = Instance.new("ScreenGui")
screen.Name = "UFOX_SPLASH"
screen.IgnoreGuiInset = true
screen.ResetOnSpawn = false
screen.DisplayOrder = 3000
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screen.Parent = pg

-- ===== Black Background =====
local bg = Instance.new("Frame", screen)
bg.Size = UDim2.fromScale(1,1)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)

-- ===== Card =====
local card = Instance.new("Frame", bg)
card.AnchorPoint = Vector2.new(0.5,0.5)
card.Position    = UDim2.fromScale(0.5,0.5)
card.Size        = UDim2.fromOffset(520, 260)
card.BackgroundColor3 = Color3.fromRGB(20,20,20)
card.BorderSizePixel = 0
Instance.new("UICorner", card).CornerRadius = UDim.new(0,16)

-- ===== Logo =====
local logo = Instance.new("ImageLabel", card)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://106029438403666" -- โลโก้ UFO
logo.Size = UDim2.fromOffset(64,64)
logo.Position = UDim2.new(0.5,0,0,10)
logo.AnchorPoint = Vector2.new(0.5,0)

-- ===== Title =====
local title = Instance.new("TextLabel", card)
title.BackgroundTransparency = 1
title.Position = UDim2.new(0.5,0,0,90)
title.Size = UDim2.new(1,0,0,40)
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.RichText = true
title.Text = '<font color="#16F77B">UFO</font> <font color="#FFFFFF">HUB X</font>'
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Center

-- ===== Progress Bar =====
local barBG = Instance.new("Frame", card)
barBG.Size = UDim2.new(1,-60,0,28)
barBG.Position = UDim2.new(0.5,0,0,150)
barBG.AnchorPoint = Vector2.new(0.5,0)
barBG.BackgroundColor3 = Color3.fromRGB(50,50,50)
barBG.BorderSizePixel = 0
Instance.new("UICorner", barBG).CornerRadius = UDim.new(0,12)

local barFill = Instance.new("Frame", barBG)
barFill.BackgroundColor3 = Color3.fromRGB(22,247,123)
barFill.BorderSizePixel = 0
barFill.Size = UDim2.new(0,0,1,0)
Instance.new("UICorner", barFill).CornerRadius = UDim.new(0,12)

-- ===== Rocket =====
local rocket = Instance.new("TextLabel", barFill)
rocket.BackgroundTransparency = 1
rocket.Size = UDim2.fromOffset(28,28)
rocket.AnchorPoint = Vector2.new(0.5,0.5)
rocket.Position = UDim2.new(0,0,0.5,0)
rocket.Text = "🚀"
rocket.TextSize = 22

-- ===== % Number =====
local percent = Instance.new("TextLabel", card)
percent.BackgroundTransparency = 1
percent.Size = UDim2.new(1,0,0,40)
percent.Position = UDim2.new(0.5,0,0,190)
percent.AnchorPoint = Vector2.new(0.5,0)
percent.Font = Enum.Font.GothamBold
percent.TextSize = 30
percent.TextColor3 = Color3.fromRGB(255,255,255)
percent.Text = "0%"

-- ===== Progress Logic =====
local function setProgress(p)
	p = math.clamp(p,0,1)
	barFill.Size = UDim2.new(p,0,1,0)
	rocket.Position = UDim2.new(p,0,0.5,0)
	percent.Text = ("%d%%"):format(math.floor(p*100))
end

task.spawn(function()
	for i=1,100 do
		setProgress(i/100)
		task.wait(0.05) -- ความเร็วในการโหลด (0.05 = 5 วินาทีโดยประมาณ)
	end
	task.wait(0.5)
	screen:Destroy()
	_G.__UFOX_SPLASH = nil
	-- เรียก UI หลัก (ถ้ามี)
	if _G.__UFOX_UI_OBJ and _G.__UFOX_UI_OBJ.api then
		_G.__UFOX_UI_OBJ.api.show()
	end
end)
