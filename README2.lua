-- UFO HUB X - SPLASH (README2.lua)
-- API: show(opts) / start(opts) / run(opts)
local M = {}
local function show(opts)
  opts = opts or {}
  local sec  = opts.seconds or 3.5
  local logo = opts.logoId or 106029438403666
  local title= opts.title  or "UFO HUB X"

  local g = Instance.new("ScreenGui")
  g.Name="UFOX_SPLASH"; g.ResetOnSpawn=false; g.IgnoreGuiInset=true; g.DisplayOrder=9000
  g.Parent = game:GetService("Players").LocalPlayer.PlayerGui

  local bg = Instance.new("Frame", g)
  bg.Size = UDim2.fromScale(1,1); bg.BackgroundColor3 = Color3.fromRGB(5,7,9); bg.BackgroundTransparency=0.1

  local box = Instance.new("Frame", g)
  box.Size = UDim2.fromOffset(420, 240); box.Position=UDim2.fromScale(0.5,0.5); box.AnchorPoint=Vector2.new(0.5,0.5)
  box.BackgroundColor3 = Color3.fromRGB(18,21,24)
  local c=Instance.new("UICorner", box); c.CornerRadius=UDim.new(0,16)
  local s=Instance.new("UIStroke", box); s.Thickness=2; s.Color=Color3.fromRGB(255,255,255); s.Transparency=0.75

  local img = Instance.new("ImageLabel", box)
  img.BackgroundTransparency=1; img.Size=UDim2.fromOffset(80,80); img.Position=UDim2.new(0.5,-40,0,18)
  img.Image="rbxthumb://type=Asset&id="..tostring(logo).."&w=150&h=150"

  local t = Instance.new("TextLabel", box)
  t.BackgroundTransparency=1; t.Position=UDim2.new(0,0,0,110); t.Size=UDim2.new(1,0,0,28)
  t.Font=Enum.Font.GothamBlack; t.TextSize=22; t.RichText=true
  t.Text = ('<font color="#16F77B">UFO</font> HUB X'); t.TextColor3=Color3.fromRGB(230,238,245)

  local bar = Instance.new("Frame", box)
  bar.Size=UDim2.new(1,-40,0,14); bar.Position=UDim2.new(0,20,1,-40)
  bar.BackgroundColor3=Color3.fromRGB(25,29,33)
  local cb=Instance.new("UICorner",bar); cb.CornerRadius=UDim.new(0,7)

  local fill=Instance.new("Frame", bar)
  fill.BackgroundColor3=Color3.fromRGB(22,247,123); fill.Size=UDim2.new(0,0,1,0)
  local cf=Instance.new("UICorner",fill); cf.CornerRadius=UDim.new(0,7)

  -- progress
  local steps=30
  for i=1,steps do
    fill.Size=UDim2.new(i/steps,0,1,0)
    task.wait(sec/steps)
  end

  g:Destroy()
end
M.show=show; M.start=show; M.run=show; return M
