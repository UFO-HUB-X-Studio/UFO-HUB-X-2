--========================================================
-- UFO HUB X — Alien Splash (Glass + Glow + Particles + Smooth %)
-- ใส่เป็น "อันที่ 2" ต่อจาก Key | เรียก UI หลักอัตโนมัติเมื่อครบ 100%
--========================================================
local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService   = game:GetService("RunService")
local lp           = Players.LocalPlayer
local pg           = lp:WaitForChild("PlayerGui")

-- ===== Theme =====
local ALIEN     = Color3.fromRGB(22,247,123)
local ALIEN_SOFT= Color3.fromRGB(120,255,195)
local BG_DARK   = Color3.fromRGB(10,12,14)
local CARD_DARK = Color3.fromRGB(18,20,24)
local BAR_BG    = Color3.fromRGB(40,44,52)
local TXT_MAIN  = Color3.fromRGB(230,238,245)
local WHITE     = Color3.fromRGB(255,255,255)

local ICON_ID   = "rbxassetid://106029438403666" -- โลโก้ UFO (เปลี่ยนได้)

-- ป้องกันซ้ำ
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

-- ===== Backdrop (ดำบาง ๆ) =====
local dim = Instance.new("Frame", screen)
dim.BackgroundColor3 = BG_DARK
dim.BackgroundTransparency = 0.35
dim.Size = UDim2.fromScale(1,1)

-- ===== Glass Card =====
local card = Instance.new("Frame", screen)
card.AnchorPoint = Vector2.new(0.5,0.5)
card.Position    = UDim2.fromScale(0.5,0.5)
card.Size        = UDim2.fromOffset(520, 240)
card.BackgroundColor3 = CARD_DARK
card.BackgroundTransparency = 0.08
card.BorderSizePixel = 0
Instance.new("UICorner", card).CornerRadius = UDim.new(0,18)

-- ภาพแก้ว: UIGradient + Stroke เรืองแสง
local glass = Instance.new("UIGradient", card)
glass.Rotation = 20
glass.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(26,28,34)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(23,25,30)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(26,28,34)),
})

local ring = Instance.new("UIStroke", card)
ring.Thickness = 2
ring.Color = ALIEN
ring.Transparency = 0.55

-- Glow outer
local glow = Instance.new("ImageLabel", card)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://5028857472" -- blur 圈
glow.ImageColor3 = ALIEN_SOFT
glow.ImageTransparency = 0.35
glow.Size = UDim2.fromScale(1.6,1.6)
glow.Position = UDim2.fromScale(0.5,0.5)
glow.AnchorPoint = Vector2.new(0.5,0.5)
glow.ZIndex = 0

-- ===== Header =====
local icon = Instance.new("ImageLabel", card)
icon.BackgroundTransparency = 1
icon.Image = ICON_ID
icon.Size = UDim2.fromOffset(42,42)
icon.Position = UDim2.fromOffset(24,18)

local title = Instance.new("TextLabel", card)
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(74,16)
title.Size = UDim2.new(1,-94,0,46)
title.RichText = true
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = '<font color="#16F77B">UFO</font> HUB X — Initializing'
title.TextColor3 = TXT_MAIN

-- หมุนไอคอนช้า ๆ
task.spawn(function()
	while card.Parent do
		for i=0,1,0.01 do
			icon.Rotation = math.sin(os.clock()*2.0)*6
			task.wait(0.02)
		end
	end
end)

-- ===== Progress Bar =====
local barBG = Instance.new("Frame", card)
barBG.Size = UDim2.new(1,-48,0,28)
barBG.Position = UDim2.new(0,24,0,110)
barBG.BackgroundColor3 = BAR_BG
barBG.BorderSizePixel = 0
Instance.new("UICorner", barBG).CornerRadius = UDim.new(0,12)

local barFill = Instance.new("Frame", barBG)
barFill.BackgroundColor3 = ALIEN
barFill.BorderSizePixel = 0
barFill.Size = UDim2.new(0,0,1,0)
Instance.new("UICorner", barFill).CornerRadius = UDim.new(0,12)

-- เส้นไฮไลต์ด้านบนของแถบ
local shine = Instance.new("Frame", barFill)
shine.BackgroundColor3 = ALIEN_SOFT
shine.BackgroundTransparency = 0.35
shine.BorderSizePixel = 0
shine.Size = UDim2.new(1,0,0,2)
shine.Position = UDim2.new(0,0,0,0)

-- Spark วิ่ง
local spark = Instance.new("ImageLabel", barFill)
spark.BackgroundTransparency = 1
spark.Image = "rbxassetid://2790390993" -- flare
spark.ImageColor3 = WHITE
spark.ImageTransparency = 0.2
spark.Size = UDim2.fromOffset(26,26)
spark.Position = UDim2.new(0, -13, 0.5, -13)

-- % Label
local percent = Instance.new("TextLabel", card)
percent.BackgroundTransparency = 1
percent.Size = UDim2.new(1,0,0,36)
percent.Position = UDim2.new(0,0,0,152)
percent.Font = Enum.Font.GothamBold
percent.TextSize = 28
percent.Text = "0%"
percent.TextColor3 = TXT_MAIN

-- Hint
local hint = Instance.new("TextLabel", card)
hint.BackgroundTransparency = 1
hint.Size = UDim2.new(1,-48,0,20)
hint.Position = UDim2.new(0,24,1,-34)
hint.Font = Enum.Font.Gotham
hint.TextSize = 14
hint.TextColor3 = Color3.fromRGB(170,180,190)
hint.TextTransparency = 0.15
hint.Text = "กำลังเตรียมระบบ • โมดูล • อินเทอร์เฟซ"

-- ===== Particle dots (แบบง่าย) =====
for i=1,18 do
	local dot = Instance.new("Frame", card)
	dot.BackgroundColor3 = ALIEN
	dot.BorderSizePixel = 0
	dot.Size = UDim2.fromOffset(2,2)
	dot.BackgroundTransparency = 0.25
	dot.Position = UDim2.fromScale(math.random(), math.random())
	dot.ZIndex = 0
	task.spawn(function()
		while dot.Parent do
			local p = UDim2.fromScale(math.random(), math.random())
			local a = TweenService:Create(dot, TweenInfo.new(1.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position=p, BackgroundTransparency=0.5})
			a:Play(); a.Completed:Wait()
		end
	end)
end

-- ===== Intro pop (ซูมเข้า + เฟด) =====
card.Size = UDim2.fromOffset(520*0.92, 240*0.92)
card.BackgroundTransparency = 0.25
TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	{Size=UDim2.fromOffset(520,240), BackgroundTransparency=0.08}):Play()

-- ===== Progress logic (ช้าลงอย่างมีจังหวะ) =====
local phases = {
	{pct=0.35, t=2.2, text="กำลังโหลดแกนระบบ…"},
	{pct=0.72, t=2.0, text="กำลังเตรียม UI & สกิน…"},
	{pct=0.90, t=1.5, text="กำลังเชื่อมต่อบริการ…"},
	{pct=1.00, t=1.3, text="พร้อมใช้งาน"},
}
local cur = 0

local function setProgress(p)
	p = math.clamp(p,0,1)
	cur = p
	barFill.Size = UDim2.new(p,0,1,0)
	percent.Text = ("%d%%"):format(math.floor(p*100))
	-- สปาร์ควิ่งหัวแถบ
	spark.Position = UDim2.new(p, -13, 0.5, -13)
end

task.spawn(function()
	for _,ph in ipairs(phases) do
		local from = cur
		local to   = ph.pct
		hint.Text  = ph.text
		local tt   = ph.t
		local st   = tick()
		while tick()-st < tt do
			local x = (tick()-st)/tt
			-- easeOutCubic
			local eased = 1 - (1-x)^3
			setProgress(from + (to-from)*eased)
			task.wait()
		end
		setProgress(to)
	end

	-- เสร็จ: pulse เล็ก ๆ แล้วเฟดออก
	local pulse = TweenService:Create(card, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{Size = UDim2.fromOffset(520*1.02,240*1.02)})
	pulse:Play(); pulse.Completed:Wait()

	local fade = TweenService:Create(card, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{BackgroundTransparency = 1})
	fade:Play()
	TweenService:Create(dim, TweenInfo.new(0.45), {BackgroundTransparency=1}):Play()
	task.delay(0.46, function()
		screen:Destroy()
		_G.__UFOX_SPLASH = nil
		-- เปิด UI หลักถ้ามี
		if _G.__UFOX_UI_OBJ and _G.__UFOX_UI_OBJ.api then
			_G.__UFOX_UI_OBJ.api.show()
		end
	end)
end)
