local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local HUD = {}
HUD.__index = HUD

local State = {
    Username = LocalPlayer.Name,
    Sheckles = 0,

    Pet = "-",
    Price = 0,

    Status = "Initializing...",
    Defender = "-",
    Opponent = "None",

    Bought = 0,
    Hop = "-"
}

local Labels = {}

local ACCENT = Color3.fromRGB(90, 170, 255)
local BG = Color3.fromRGB(24, 24, 28)
local TEXT_DIM = Color3.fromRGB(170, 170, 178)
local TEXT_MAIN = Color3.fromRGB(235, 235, 240)

local COLOR_GOOD = Color3.fromRGB(120, 220, 140)   -- idle/success
local COLOR_BUSY = Color3.fromRGB(255, 200, 90)    -- working
local COLOR_BAD  = Color3.fromRGB(255, 110, 110)   -- error

local function formatNumber(n)
    n = tonumber(n) or 0
    local s = tostring(math.floor(n))
    local formatted = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
    return formatted:gsub("^,", "")
end

local function opponentColor(name)
    if not name
        or name == ""
        or name == "-"
        or name == "None"
    then
        return TEXT_DIM
    end

    return Color3.fromRGB(255,90,90)
end

local function petColor(name)
    if not name
        or name == "-"
    then
        return TEXT_DIM
    end

    return ACCENT
end

local function rgbTag(c)
    return ("rgb(%d,%d,%d)"):format(math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255))
end

local function setRow(label, emoji, key, value, valueColor)
    label.RichText = true
    label.Text = ("%s <font color=\"%s\">%s: </font><font color=\"%s\">%s</font>")
        :format(emoji, rgbTag(TEXT_DIM), key, rgbTag(valueColor or TEXT_MAIN), tostring(value))
end

local function statusColor(status)
    local s = string.lower(status or "")

    if s:find("error") or s:find("fail") then
        return COLOR_BAD

    elseif s:find("attack")
        or s:find("attacking")
        or s:find("combat") then

        return Color3.fromRGB(255,70,70)

    elseif s:find("opponent")
        or s:find("competitor") then

        return Color3.fromRGB(255,120,120)

    elseif s:find("buy")
        or s:find("claim") then

        return Color3.fromRGB(255,210,90)

    elseif s:find("follow")
        or s:find("defend") then

        return Color3.fromRGB(120,220,255)

    elseif s:find("hop") then

        return Color3.fromRGB(160,120,255)

    elseif s:find("scan") then

        return COLOR_GOOD
    end

    return TEXT_MAIN
end

local function defenderColor(mode)
    mode = tostring(mode or "")

    if mode == "Shovel" then
        return Color3.fromRGB(255,190,70)

    elseif mode == "Strawberry Sniper" then
        return Color3.fromRGB(255,110,110)

    elseif mode == "Following" then
        return Color3.fromRGB(120,220,255)
    end

    return TEXT_MAIN
end

local function hopColor(mode)
    mode = tostring(mode or ""):upper()

    if mode == "V1" then
        return Color3.fromRGB(120, 220, 120)
    elseif mode == "V2" then
        return Color3.fromRGB(255, 210, 80)
    elseif mode == "V3" then
        return Color3.fromRGB(180, 120, 255)
    end

    return ACCENT
end

function HUD:Refresh()

    setRow(
        Labels.Username,
        "👤",
        "Username",
        State.Username
    )

    setRow(
        Labels.Sheckles,
        "💰",
        "Sheckles",
        formatNumber(State.Sheckles),
        ACCENT
    )

    setRow(
        Labels.Pet,
        "🐾",
        "Pet",
        State.Pet,
        petColor(State.Pet)
    )

    setRow(
        Labels.Price,
        "💵",
        "Price",
        State.Price > 0 and formatNumber(State.Price) or "-",
        Color3.fromRGB(120, 220, 140)
    )

    setRow(
        Labels.Status,
        "⚙️",
        "Status",
        State.Status,
        statusColor(State.Status)
    )

    setRow(
        Labels.Defender,
        "🛡️",
        "Defender",
        State.Defender,
        defenderColor(State.Defender)
    )

    setRow(
        Labels.Opponent,
        "⚔️",
        "Opponent",
        State.Opponent,
        opponentColor(State.Opponent)
    )

    setRow(
        Labels.Hop,
        "🌐",
        "Hop",
        State.Hop,
        hopColor(State.Hop)
    )

    setRow(
        Labels.Bought,
        "🛒",
        "Bought",
        State.Bought,
        COLOR_GOOD
    )

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

local function createSectionHeader(parent, y, emoji, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -24, 0, 14)
    label.Position = UDim2.new(0, 12, 0, y)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 11
    label.TextColor3 = ACCENT
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = ("%s  %s"):format(emoji, text:upper())
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
    frame.Size = UDim2.fromOffset(300, 308)
    frame.Position = UDim2.new(0, 20, 0.5, -154)
    frame.BackgroundColor3 = BG
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.4
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.ZIndex = 0
    shadow.Parent = frame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(55, 55, 62)
    stroke.Thickness = 1
    stroke.Parent = frame

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
    title.Text = "🐾  Jay Hub Pet Sniper"
    title.Parent = titleBar

    createSectionHeader(frame, 40, "📋", "Information")

    Labels.Username = createLabel(frame, 56)
    Labels.Sheckles = createLabel(frame, 76)

    local divider1 = Instance.new("Frame")
    divider1.Size = UDim2.new(1, -24, 0, 1)
    divider1.Position = UDim2.new(0, 12, 0, 102)
    divider1.BorderSizePixel = 0
    divider1.BackgroundColor3 = Color3.fromRGB(50, 50, 56)
    divider1.Parent = frame

    createSectionHeader(frame, 112, "🐾", "Current Target")

    Labels.Pet = createLabel(frame, 128)
    Labels.Price = createLabel(frame, 148)
    Labels.Status = createLabel(frame, 168)
    Labels.Defender = createLabel(frame, 188)
    Labels.Opponent = createLabel(frame, 208)

    local divider2 = Instance.new("Frame")
    divider2.Size = UDim2.new(1, -24, 0, 1)
    divider2.Position = UDim2.new(0, 12, 0, 234)
    divider2.BorderSizePixel = 0
    divider2.BackgroundColor3 = Color3.fromRGB(50, 50, 56)
    divider2.Parent = frame

    createSectionHeader(frame, 244, "📊", "Statistics")

    Labels.Hop = createLabel(frame, 260)
    Labels.Bought = createLabel(frame, 280)

    self:Refresh()
end

function HUD:SetUsername(name)
    State.Username = name or LocalPlayer.Name
    self:Refresh()
end

function HUD:SetTarget(petName, price)
    State.Pet = petName or "-"
    State.Price = tonumber(price) or 0
    State.Status = "Target Pet Found!"
    State.Defender = "-"
    State.Opponent = "None"
    self:Refresh()
end

function HUD:ResetTarget()
    State.Pet = "-"
    State.Price = 0
    State.Status = "Scanning..."
    State.Defender = "-"
    State.Opponent = "None"
    self:Refresh()
end

function HUD:SetFollowing()
    State.Status = "Following Pet"
    State.Defender = "Following"
    self:Refresh()
end

function HUD:SetAttacking(playerName, mode)
    State.Status = "Attacking!"
    State.Opponent = playerName or "Unknown"
    State.Defender = mode or "-"
    self:Refresh()
end

function HUD:SetCompetitor(playerName)
    State.Status = "Opponent Found!"
    State.Opponent = playerName or "Unknown"
    self:Refresh()
end

function HUD:SetScanning()
    State.Status = "Scanning..."
    State.Pet = "-"
    State.Defender = "-"
    State.Opponent = "None"
    self:Refresh()
end

function HUD:SetBuying(petName, price)
    State.Pet = petName or "-"
    State.Price = tonumber(price) or 0
    State.Status = "Buying..."
    State.Defender = "-"
    State.Opponent = "None"
    self:Refresh()
end

function HUD:SetPet(name)
    State.Pet = name or "-"

    if State.Pet == "-" then
        State.Price = 0
    end

    self:Refresh()
end

function HUD:SetDefender(mode)
    State.Defender = mode or "-"
    self:Refresh()
end

function HUD:SetOpponent(name)
    State.Opponent = name or "None"
    self:Refresh()
end

function HUD:SetBought(count)
    State.Bought = count or 0
    self:Refresh()
end

function HUD:SetHop(method)
    State.Hop = method or "-"
    self:Refresh()
end

function HUD:SetStatus(status)
    State.Status = status or "-"
    self:Refresh()
end

function HUD:SetPrice(price)
    State.Price = tonumber(price) or 0
    self:Refresh()
end

function HUD:AddBought(amount)
    State.Bought += amount or 1
    self:Refresh()
end

return setmetatable({}, HUD)
