-- up
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

local ACCENT = Color3.fromRGB(90, 170, 255)
local BG = Color3.fromRGB(24, 24, 28)
local BG_SECTION = Color3.fromRGB(32, 32, 38)
local TEXT_DIM = Color3.fromRGB(170, 170, 178)
local TEXT_MAIN = Color3.fromRGB(235, 235, 240)

local function formatNumber(n)
    n = tonumber(n) or 0
    local s = tostring(math.floor(n))
    local formatted = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
    return formatted:gsub("^,", "")
end

-- Builds a "Label: Value" row where the label is dim and the value pops
local function setRow(label, key, value)
    label.Text = ("%s: "):format(key)
    label.RichText = true
    label.Text = ("<font color=\"rgb(170,170,178)\">%s: </font><font color=\"rgb(235,235,240)\">%s</font>")
        :format(key, tostring(value))
end

function HUD:Refresh()
    setRow(Labels.Guild, "Guild", State.Guild)
    setRow(Labels.GuildPoints, "Guild Points", formatNumber(State.GuildPoints))
    setRow(Labels.MyPoints, "My Points", formatNumber(State.MyPoints))

    setRow(Labels.Status, "Status", State.Status)
    setRow(Labels.Bought, "Bought", State.Bought)
    setRow(Labels.Waiting, "Waiting", State.Waiting)
    setRow(Labels.Hop, "Hop", State.Hop)
end

local function createLabel(parent, y, size)
    local label = Instance.new("TextLabel")

    label.Size = UDim2.new(1, -24, 0, 18)
    label.Position = UDim2.new(0, 12, 0, y)

    label.BackgroundTransparency = 1
    label.TextColor3 = TEXT_MAIN

    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Code
    label.TextSize = size or 14

    label.Parent = parent

    return label
end

local function createSectionHeader(parent, y, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -24, 0, 14)
    label.Position = UDim2.new(0, 12, 0, y)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 11
    label.TextColor3 = ACCENT
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = text:upper()
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

    -- Outer shadow wrapper for depth
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217" -- soft drop shadow
    shadow.ImageColor3 = Color3.new(0,0,0)
    shadow.ImageTransparency = 0.4
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10,10,118,118)
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.ZIndex = 0

    local frame = Instance.new("Frame")
    frame.Name = "Main"
    frame.Size = UDim2.fromOffset(260, 214)
    frame.Position = UDim2.new(0, 20, 0.5, -107)
    frame.BackgroundColor3 = BG
    frame.BorderSizePixel = 0
    frame.Parent = gui

    shadow.Parent = frame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(55, 55, 62)
    stroke.Thickness = 1
    stroke.Parent = frame

    -- Title bar with accent strip
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 32)
    titleBar.BackgroundTransparency = 1
    titleBar.Parent = frame

    local accentStrip = Instance.new("Frame")
    accentStrip.Size = UDim2.new(0, 4, 1, -12)
    accentStrip.Position = UDim2.new(0, 0, 0, 6)
    accentStrip.BackgroundColor3 = ACCENT
    accentStrip.BorderSizePixel = 0
    accentStrip.Parent = titleBar

    local accentCorner = Instance.new("UICorner")
    accentCorner.CornerRadius = UDim.new(1, 0)
    accentCorner.Parent = accentStrip

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 1, 0)
    title.Position = UDim2.new(0, 14, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextColor3 = TEXT_MAIN
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = "🐾  Jay Hub"
    title.Parent = titleBar

    -- Guild section
    createSectionHeader(frame, 40, "Guild")
    Labels.Guild = createLabel(frame, 56)
    Labels.GuildPoints = createLabel(frame, 76)
    Labels.MyPoints = createLabel(frame, 96)

    local divider = Instance.new("Frame")
    divider.Size = UDim2.new(1, -24, 0, 1)
    divider.Position = UDim2.new(0, 12, 0, 122)
    divider.BorderSizePixel = 0
    divider.BackgroundColor3 = Color3.fromRGB(50, 50, 56)
    divider.Parent = frame

    -- Activity section
    createSectionHeader(frame, 132, "Activity")
    Labels.Status = createLabel(frame, 148)
    Labels.Bought = createLabel(frame, 168)
    Labels.Waiting = createLabel(frame, 188)
    Labels.Hop = createLabel(frame, 188) -- placeholder, repositioned below

    -- Recompute layout to fit Hop under Waiting cleanly
    frame.Size = UDim2.fromOffset(260, 232)
    Labels.Hop.Position = UDim2.new(0, 12, 0, 208)

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
