-- returns table with show(opts)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer
local pgui = lp:WaitForChild("PlayerGui")

local M = {}
function M.show(opts)
    opts = opts or {}
    local sec = opts.seconds or 1.0
    local logoId = opts.logoId or 106029438403666

    local gui = Instance.new("ScreenGui")
    gui.Name = "UFOX_SPLASH"
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 2000
    gui.ResetOnSpawn = false
    gui.Parent = pgui

    local bg = Instance.new("Frame", gui)
    bg.Size = UDim2.fromScale(1,1)
    bg.BackgroundColor3 = Color3.fromRGB(8,10,12)

    local box = Instance.new("Frame", bg)
    box.AnchorPoint = Vector2.new(0.5,0.5)
    box.Position = UDim2.fromScale(0.5,0.5)
    box.Size = UDim2.new(0,320,0,220)
    box.BackgroundColor3 = Color3.fromRGB(20,24,27)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,14)

    local logo = Instance.new("ImageLabel", box)
    logo.BackgroundTransparency = 1
    logo.Image = "rbxassetid://"..logoId
    logo.ImageColor3 = Color3.fromRGB(22,247,123)
    logo.Size = UDim2.new(0,72,0,72)
    logo.Position = UDim2.new(0.5,-36,0,16)

    local ttl = Instance.new("TextLabel", box)
    ttl.BackgroundTransparency = 1
    ttl.Font = Enum.Font.GothamBold
    ttl.TextSize = 22
    ttl.TextColor3 = Color3.fromRGB(221,228,234)
    ttl.RichText = true
    ttl.Text = '<font color="#16F77B">UFO</font> HUB X'
    ttl.Size = UDim2.new(1,0,0,34)
    ttl.Position = UDim2.new(0,0,0,96)

    local bar = Instance.new("Frame", box)
    bar.Size = UDim2.new(1,-40,0,10)
    bar.Position = UDim2.new(0,20,1,-38)
    bar.BackgroundColor3 = Color3.fromRGB(27,32,36)
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0,8)

    local fill = Instance.new("Frame", bar)
    fill.BackgroundColor3 = Color3.fromRGB(22,247,123)
    fill.Size = UDim2.new(0,0,1,0)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0,8)

    local pct = Instance.new("TextLabel", box)
    pct.BackgroundTransparency = 1
    pct.Font = Enum.Font.Gotham
    pct.TextSize = 14
    pct.TextColor3 = Color3.fromRGB(166,173,179)
    pct.Text = "กำลังโหลด 0%"
    pct.Size = UDim2.new(1,0,0,20)
    pct.Position = UDim2.new(0,0,1,-62)

    local steps, dt = 60, (sec/60)
    for i=1,steps do
        local p=i/steps
        fill.Size = UDim2.new(p,0,1,0)
        pct.Text = ("กำลังโหลด %d%%"):format(math.floor(p*100))
        task.wait(dt)
    end

    gui:Destroy()
end
return M
