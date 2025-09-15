--========================================================
-- UFO HUB X — Splash (Black+Green, centered, rocket lead)
--========================================================
local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local lp           = Players.LocalPlayer
local pg           = lp:WaitForChild("PlayerGui")

if _G.__UFOX_SPLASH then return end
_G.__UFOX_SPLASH = true

-- THEME
local ALIEN  = Color3.fromRGB(22,247,123)
local WHITE  = Color3.fromRGB(255,255,255)
local DARK20 = Color3.fromRGB(20,20,20)
local DARK50 = Color3.fromRGB(50,50,50)

-- SCREEN
local screen = Instance.new("ScreenGui")
screen.Name = "UFOX_SPLASH"
screen.IgnoreGuiInset = true
screen.ResetOnSpawn = false
screen.DisplayOrder = 3000
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screen.Parent = pg

-- FULL BLACK BACKDROP
local bg = Instance.new("Frame")
bg.Size = UDim2.fromScale(1,1)
bg.BackgroundColor3 = Color3.new(0,0,0)
bg.Parent = screen

-- CARD
local card = Instance.new("Frame")
card.AnchorPoint = Vector2.new(0.5,0.5)
card.Position    = UDim2.fromScale(0.5,0.5)
card.Size        = UDim2.fromOffset(560, 300)
card.BackgroundColor3 = DARK20
card.BorderSizePixel = 0
card.Parent = bg
Instance.new("UICorner", card).CornerRadius = UDim.new(0,18)

-- GREEN BORDER รอบ UI
local cardStroke = Instance.new("UIStroke", card)
cardStroke.Color = ALIEN
cardStroke.Thickness = 2
cardStroke.Transparency = 0.25

-- LOGO (ใหญ่ขึ้น)
local logo = Instance.new("ImageLabel")
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://106029438403666"
logo.Size = UDim2.fromOffset(96,96)
logo.AnchorPoint = Vector2.new(0.5,0)
logo.Position = UDim2.new(0.5,0,0,14)
logo.Parent = card

-- TITLE (อยู่กลางจริง ๆ)
local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Size = UDim2.new(1,0,0,42)
title.Position = UDim2.new(0,0,0,120)
title.Font = Enum.Font.GothamBold
title.TextSize = 30
title.TextXAlignment = Enum.TextXAlignment.Center
title.RichText = true
title.Text = '<font color="#16F77B">UFO</font> <font color="#FFFFFF">HUB X</font>'
title.TextColor3 = WHITE
title.Parent = card

-- PROGRESS BAR BG + ขอบสีขาว
local barBG = Instance.new("Frame")
barBG.Size = UDim2.new(1,-80,0,30)
barBG.AnchorPoint = Vector2.new(0.5,0)
barBG.Position = UDim2.new(0.5,0,0,175)
barBG.BackgroundColor3 = DARK50
barBG.BorderSizePixel = 0
barBG.Parent = card
Instance.new("UICorner", barBG).CornerRadius = UDim.new(0,12)

local barStroke = Instance.new("UIStroke", barBG)
barStroke.Color = WHITE
barStroke.Thickness = 2
barStroke.Transparency = 0.15

-- FILL
local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0,0,1,0)
barFill.BackgroundColor3 = ALIEN
barFill.BorderSizePixel = 0
barFill.Parent = barBG
Instance.new("UICorner", barFill).CornerRadius = UDim.new(0,12)

-- ROCKET (นำหน้าแถบ)
local rocket = Instance.new("TextLabel")
rocket.BackgroundTransparency = 1
rocket.Size = UDim2.fromOffset(28,28)
rocket.AnchorPoint = Vector2.new(0.5,0.5)
rocket.Text = "🚀"
rocket.TextSize = 22
rocket.Rotation = 0      -- หันหน้าตรงตามแนวหลอด
rocket.Parent = barBG

-- % NUMBER กลางการ์ด
local percent = Instance.new("TextLabel")
percent.BackgroundTransparency = 1
percent.Size = UDim2.new(1,0,0,40)
percent.Position = UDim2.new(0,0,0,215)
percent.Font = Enum.Font.GothamBold
percent.TextSize = 32
percent.TextColor3 = WHITE
percent.TextXAlignment = Enum.TextXAlignment.Center
percent.Text = "0%"
percent.Parent = card

-- INTRO POP
card.Size = UDim2.fromOffset(560*0.92, 300*0.92)
card.BackgroundTransparency = 0.2
TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	{Size=UDim2.fromOffset(560,300), BackgroundTransparency=0}):Play()

-- PROGRESS (ช้าลง ~10 วิ) + จรวดนำหลอด ~10 พิกเซล
local TOTAL_TIME = 10      -- ปรับความช้าตรงนี้
local ROCKET_LEAD = 10     -- ระยะนำหน้า (px)
local start = tick()

local function setProgress(p)
	p = math.clamp(p,0,1)
	-- ปรับขนาด fill
	barFill.Size = UDim2.new(p,0,1,0)
	-- คำนวณตำแหน่งจรวดให้นำหน้าปลายแถบเล็กน้อย
	local bgAbsW = barBG.AbsoluteSize.X
	local px = p * bgAbsW + (-bgAbsW/2) + ROCKET_LEAD
	rocket.Position = UDim2.new(0.5, px, 0.5, 0)
	percent.Text = ("%d%%"):format(math.floor(p*100))
end

task.spawn(function()
	while true do
		local t = math.clamp((tick()-start)/TOTAL_TIME, 0, 1)
		-- ease-out cubic ให้ลื่น
		local eased = 1 - (1 - t)^3
		setProgress(eased)
		if t >= 1 then break end
		task.wait()
	end
	task.wait(0.3)
	-- OUT
	local fade = TweenService:Create(card, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{BackgroundTransparency = 1})
	fade:Play()
	TweenService:Create(bg, TweenInfo.new(0.45), {BackgroundTransparency = 1}):Play()
	fade.Completed:Wait()
	screen:Destroy()
	_G.__UFOX_SPLASH = nil
	-- โชว์ UI หลักถ้ามี
	if _G.__UFOX_UI_OBJ and _G.__UFOX_UI_OBJ.api then
		_G.__UFOX_UI_OBJ.api.show()
	end
end)
