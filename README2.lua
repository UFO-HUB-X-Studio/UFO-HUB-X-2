--[[  UFO HUB X — Splash Module (README2.lua)
     exports:
       show({seconds, logoId, title}) | start | run
     features:
       - min display time (default 3.8s)
       - smooth progress (natural easing)
       - easy theme edit (ALIEN_GREEN)
]]

local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService   = game:GetService("RunService")
local UIS          = game:GetService("UserInputService")

local lp   = Players.LocalPlayer
local pgui = lp:WaitForChild("PlayerGui")

-- ========= THEME =========
local ALIEN_GREEN  = Color3.fromRGB(22,247,123)
local BG_DARK      = Color3.fromRGB(10,12,14)
local CARD_DARK    = Color3.fromRGB(18,22,25)
local TEXT_MAIN    = Color3.fromRGB(228,235,240)
local TEXT_SOFT    = Color3.fromRGB(160,168,176)
local WHITE        = Color3.fromRGB(255,255,255)

-- ========= HELPERS =========
local function corner(i, r) local c=Instance.new("UICorner", i); c.CornerRadius=UDim.new(0,r or 16); return c end
local function stroke(i, th, col, tr)
    local s=Instance.new("UIStroke", i); s.Thickness=th or 1.5; s.Color=col or WHITE; s.Transparency=tr or 0.85; return s
end
local function easeOutExpo(t) return (t==1) and 1 or 1 - 2^( -10 * t ) end
local function clamp(n,a,b) return math.max(a, math.min(b,n)) end

-- ========= SINGLETON GUARD =========
local ENV = (getgenv and getgenv()) or _G
if ENV.__UFOX_SPLASH_ALIVE then
    -- หากมีอยู่แล้ว ไม่สร้างซ้ำ
    return { show=function() end, start=function() end, run=function() end }
end
ENV.__UFOX_SPLASH_ALIVE = true

-- ========= BUILD =========
local function build(opts)
    opts = opts or {}
    local minSeconds = tonumber(opts.seconds) or 3.8
    if minSeconds < 2.2 then minSeconds = 2.2 end
    local logoId     = opts.logoId or (ENV.UFOX and ENV.UFOX.logoId) or 106029438403666
    local titleText  = opts.title  or (ENV.UFOX and ENV.UFOX.title)  or "UFO HUB X"

    local gui = Instance.new("ScreenGui")
    gui.Name = "UFOX_SPLASH"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 9e6
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = pgui

    -- Block input (overlay รับคลิก)
    local blocker = Instance.new("TextButton")
    blocker.Text = ""
    blocker.AutoButtonColor = false
    blocker.BackgroundColor3 = BG_DARK
    blocker.BackgroundTransparency = 0
    blocker.Size = UDim2.fromScale(1,1)
    blocker.Parent = gui

    -- Starfield (เบา ๆ)
    local starFrame = Instance.new("Frame", blocker)
    starFrame.BackgroundTransparency = 1
    starFrame.Size = UDim2.fromScale(1,1)
    local stars = {}
    for i=1,28 do
        local d = Instance.new("Frame", starFrame)
        d.BackgroundColor3 = WHITE
        d.BackgroundTransparency = 0.2 + math.random()*0.6
        d.Size = UDim2.fromOffset(2,2)
        d.Position = UDim2.fromScale(math.random(), math.random())
        corner(d,1)
        d.ZIndex = 1
        stars[i] = d
    end

    -- Glass card center
    local card = Instance.new("Frame", blocker)
    card.AnchorPoint = Vector2.new(0.5,0.5)
    card.Position = UDim2.fromScale(0.5,0.5)
    card.Size = UDim2.new(0, 520, 0, 260)
    card.BackgroundColor3 = CARD_DARK
    card.BackgroundTransparency = 0.08
    corner(card,18); stroke(card,2,WHITE,0.88)

    -- subtle shadow
    local sh = Instance.new("ImageLabel", card)
    sh.BackgroundTransparency = 1
    sh.Image = "rbxassetid://5028857084"
    sh.ImageTransparency = 0.7
    sh.ImageColor3 = Color3.fromRGB(0,0,0)
    sh.ScaleType = Enum.ScaleType.Slice
    sh.SliceCenter = Rect.new(24,24,276,276)
    sh.Size = UDim2.new(1,40,1,40)
    sh.Position = UDim2.new(0,-20,0,-20)

    -- Logo
    local logo = Instance.new("ImageLabel", card)
    logo.BackgroundTransparency = 1
    logo.Size = UDim2.fromOffset(64,64)
    logo.Position = UDim2.new(0, 28, 0, 22)
    logo.Image = "rbxthumb://type=Asset&id="..tostring(logoId).."&w=150&h=150"
    logo.ScaleType = Enum.ScaleType.Fit

    -- Title
    local title = Instance.new("TextLabel", card)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 28
    title.RichText = true
    title.Text = ('<font color="#%02X%02X%02X">UFO</font> HUB X'):format(ALIEN_GREEN.R*255, ALIEN_GREEN.G*255, ALIEN_GREEN.B*255)
    title.TextColor3 = TEXT_MAIN
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Position = UDim2.new(0, 110, 0, 28)
    title.Size = UDim2.new(1, -140, 0, 34)

    local sub = Instance.new("TextLabel", card)
    sub.BackgroundTransparency = 1
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 14
    sub.TextColor3 = TEXT_SOFT
    sub.TextXAlignment = Enum.TextXAlignment.Left
    sub.Text = "กำลังเตรียมระบบเอเลี่ยน…"
    sub.Position = UDim2.new(0, 110, 0, 62)
    sub.Size = UDim2.new(1, -140, 0, 20)

    -- Progress bar + %
    local bar = Instance.new("Frame", card)
    bar.BackgroundColor3 = Color3.fromRGB(30,36,40)
    bar.Position = UDim2.new(0, 24, 0, 124)
    bar.Size = UDim2.new(1, -48, 0, 12)
    corner(bar, 8); stroke(bar, 1, WHITE, 0.85)

    local fill = Instance.new("Frame", bar)
    fill.BackgroundColor3 = ALIEN_GREEN
    fill.Size = UDim2.fromScale(0,1)
    corner(fill, 8)

    local pct = Instance.new("TextLabel", card)
    pct.BackgroundTransparency = 1
    pct.Font = Enum.Font.GothamSemibold
    pct.TextSize = 16
    pct.TextColor3 = TEXT_MAIN
    pct.TextXAlignment = Enum.TextXAlignment.Right
    pct.Position = UDim2.new(0, 24, 0, 146)
    pct.Size = UDim2.new(1, -48, 0, 20)
    pct.Text = "0%"

    -- Footer
    local foot = Instance.new("TextLabel", card)
    foot.BackgroundTransparency = 1
    foot.Font = Enum.Font.Gotham
    foot.TextSize = 13
    foot.TextColor3 = TEXT_SOFT
    foot.TextXAlignment = Enum.TextXAlignment.Center
    foot.Text = "© UFO HUB X • Initializing modules"
    foot.Position = UDim2.new(0, 0, 1, -28)
    foot.Size = UDim2.new(1, 0, 0, 18)

    -- Intro fade
    blocker.BackgroundTransparency = 1
    card.BackgroundTransparency     = 1
    card.Position = UDim2.new(0.5,0,0.5, 18)

    TweenService:Create(blocker, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.15}):Play()
    TweenService:Create(card, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.08, Position = UDim2.fromScale(0.5,0.5)}):Play()

    -- Star twinkle (เบามาก)
    local starConn = RunService.RenderStepped:Connect(function(dt)
        for i=1,#stars do
            local d = stars[i]
            local a = math.sin(tick()* (0.5 + (i%7)/6 )) * 0.25 + 0.35
            d.BackgroundTransparency = 1 - a
        end
    end)

    -- Progress animation (ไม่ไวเกิน)
    local startTime = tick()
    local progress  = 0
    local tgt       = 0
    local done      = false

    local progressConn
    progressConn = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - startTime

        -- สร้างเป้าหมายแบบ “ขึ้นเป็นคลื่น” (ดูสมจริง)
        local t = clamp(elapsed / minSeconds, 0, 1)
        tgt = easeOutExpo(t) * 100

        -- ไล่ตามเป้าหมายแบบเนียน
        progress = progress + (tgt - progress) * 0.12
        if (tgt - progress) < 0.2 then progress = tgt end

        -- อัปเดต UI
        pct.Text = ("%d%%"):format(math.floor(progress+0.5))
        fill.Size = UDim2.fromScale(clamp(progress/100,0,1), 1)

        if t >= 1 and not done then
            done = true
            -- Outro
            TweenService:Create(card, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {BackgroundTransparency = 1, Position = UDim2.new(0.5,0,0.5, 16)}):Play()
            TweenService:Create(blocker, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {BackgroundTransparency = 1}):Play()
            task.delay(0.2, function()
                if starConn then starConn:Disconnect() end
                if progressConn then progressConn:Disconnect() end
                gui:Destroy()
                ENV.__UFOX_SPLASH_ALIVE = false
            end)
        end
    end)

    return gui
end

-- ========= PUBLIC API =========
local M = {}
function M.show(opts) return build(opts) end
function M.start(opts) return build(opts) end
function M.run(opts)   return build(opts) end
return M
