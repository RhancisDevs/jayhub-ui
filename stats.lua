local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local HUD = {}
HUD.__index = HUD

local State = {
    Guild = "-",
    GuildPoints = 0,
    MyPoints = 0,

    Status = "Initializing...",
    Bought = 0,
    Waiting = 0,
    Hop = "-"
}

local Labels = {}

local function formatNumber(n)
    n = tonumber(n) or 0

    local s = tostring(math.floor(n))

    repeat
        s = s:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
    until s:gsub("^(-?%d+)(%d%d%d)", "%1,%2") == s

    return s
end

function HUD:Refresh()
    Labels.Guild.Text = ("Guild: %s"):format(State.Guild)
    Labels.GuildPoints.Text = ("Guild Points: %s"):format(formatNumber(State.GuildPoints))
    Labels.MyPoints.Text = ("My Points: %s"):format(formatNumber(State.MyPoints))

    Labels.Status.Text = ("Status: %s"):format(State.Status)
    Labels.Bought.Text = ("Bought: %d"):format(State.Bought)
    Labels.Waiting.Text = ("Waiting: %d"):format(State.Waiting)
    Labels.Hop.Text = ("Hop: %s"):format(State.Hop)
end

local function createLabel(parent, y)
    local label = Instance.new("TextLabel")

    label.Size = UDim2.new(1, -16, 0, 18)
    label.Position = UDim2.new(0, 8, 0, y)

    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)

    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Code
    label.TextSize = 15

    label.Parent = parent

    return label
end

function HUD:Init()

    local old = CoreGui:FindFirstChild("JayHubHUD")

    if old then
        old:Destroy()
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "JayHubHUD"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = CoreGui

    local frame = Instance.new("Frame")
    frame.Name = "Main"
    frame.Size = UDim2.fromOffset(250,170)
    frame.Position = UDim2.new(0,20,0.5,-85)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,8)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(70,70,70)
    stroke.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,0,24)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextColor3 = Color3.new(1,1,1)
    title.Text = "🐾 Jay Hub"
    title.Parent = frame

    local line1 = Instance.new("Frame")
    line1.Size = UDim2.new(1,-10,0,1)
    line1.Position = UDim2.new(0,5,0,26)
    line1.BorderSizePixel = 0
    line1.BackgroundColor3 = Color3.fromRGB(80,80,80)
    line1.Parent = frame

    Labels.Guild = createLabel(frame,30)
    Labels.GuildPoints = createLabel(frame,50)
    Labels.MyPoints = createLabel(frame,70)

    local line2 = line1:Clone()
    line2.Position = UDim2.new(0,5,0,92)
    line2.Parent = frame

    Labels.Status = createLabel(frame,96)
    Labels.Bought = createLabel(frame,116)
    Labels.Waiting = createLabel(frame,136)
    Labels.Hop = createLabel(frame,156)

    self:Refresh()
end

function HUD:SetGuild(name)
    State.Guild = name or "-"
    self:Refresh()
end

function HUD:SetGuildPoints(points)
    State.GuildPoints = points or 0
    self:Refresh()
end

function HUD:SetMyPoints(points)
    State.MyPoints = points or 0
    self:Refresh()
end

function HUD:SetStatus(status)
    State.Status = status or "-"
    self:Refresh()
end

function HUD:SetBought(count)
    State.Bought = count or 0
    self:Refresh()
end

function HUD:SetWaiting(count)
    State.Waiting = count or 0
    self:Refresh()
end

function HUD:SetHop(method)
    State.Hop = method or "-"
    self:Refresh()
end

return setmetatable({}, HUD)
