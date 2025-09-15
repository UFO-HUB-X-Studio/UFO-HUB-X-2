--========================================================
-- UFO HUB X — Splash / Download Screen
--========================================================
local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService   = game:GetService("RunService")
local lp           = Players.LocalPlayer
local pg           = lp:WaitForChild("PlayerGui")

-- Theme
local ALIEN    = Color3.fromRGB(22,247,123)
local BG_MAIN  = Color3.fromRGB(15,17,20)
local TXT_MAIN = Color3.fromRGB(230,238,245)

-- Create ScreenGui
local screen = Instance.new("ScreenGui")
screen.Name = "UFOX_SPLASH"
screen.IgnoreGuiInset = true
screen.ResetOnSpawn = false
screen.DisplayOrder = 2000
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screen.Parent = pg

-- Main Frame
local frame = Instance.new("Frame", screen)
frame.Size = UDim2.fromOffset(420, 220)
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.Position = UDim2.fromScale(0.5,0.5)
frame.BackgroundColor3 = BG_MAIN
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

-- Title
local title = Instance.new("TextLabel", frame)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.fromOffset(0,20)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Text = "🚀 Loading UFO HUB X"
title.TextColor3 = ALIEN

-- Progress Bar BG
local barBG = Instance.new("Frame", frame)
barBG.Size = UDim2.new(0.85,0,0,26)
barBG.Position = UDim2.new(0.5,0,0.5,0)
barBG.AnchorPoint = Vector2.new(0.5,0.5)
barBG.BackgroundColor3 = Color3.fromRGB(40,44,52)
barBG.BorderSizePixel = 0
Instance.new("UICorner", barBG).CornerRadius = UDim.new(0,12)

-- Progress Fill
local barFill = Instance.new("Frame", barBG)
barFill.Size = UDim2.new(0,0,1,0)
barFill.BackgroundColor3 = ALIEN
barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill).CornerRadius = UDim.new(0,12)

-- % Label
local percent = Instance.new("TextLabel", frame)
percent.BackgroundTransparency = 1
percent.Size = UDim2.new(1,0,0,40)
percent.Position = UDim2.new(0,0,0.65,0)
percent.Font = Enum.Font.GothamBold
percent.TextSize = 28
percent.Text = "0%"
percent.TextColor3 = TXT_MAIN

-- Animate Progress
local current = 0
local goalTime = 6 -- << โหลดนาน 6 วิ (ปรับได้ เช่น 8 ก็ช้ากว่านี้)
local start = tick()

local conn
conn = RunService.RenderStepped:Connect(function()
	local elapsed = tick() - start
	local progress = math.clamp(elapsed / goalTime, 0, 1)
	current = math.floor(progress * 100)

	barFill.Size = UDim2.new(progress,0,1,0)
	percent.Text = tostring(current).."%"

	if current >= 100 then
		conn:Disconnect()
		wait(0.3)

		-- Fade out splash
		local tw = TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency=1})
		tw.Completed:Connect(function()
			screen:Destroy()
			-- เรียก UI หลักที่เพื่อนมีอยู่
			if _G.__UFOX_UI_OBJ and _G.__UFOX_UI_OBJ.api then
				_G.__UFOX_UI_OBJ.api.show()
			end
		end)
		tw:Play()
	end
end)
