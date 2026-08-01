local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("AfkChamberUI") then
	playerGui.AfkChamberUI:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AfkChamberUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 9999
screenGui.Parent = playerGui

local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BorderSizePixel = 0
background.ZIndex = 1
background.Parent = screenGui

local container = Instance.new("Frame")
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.Size = UDim2.new(0.85, 0, 0.7, 0)
container.Position = UDim2.new(0.5, 0, 0.5, 0)
container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
container.BackgroundTransparency = 0.1
container.BorderSizePixel = 0
container.ZIndex = 2
container.Parent = background

local containerConstraint = Instance.new("UISizeConstraint")
containerConstraint.MinSize = Vector2.new(280, 380)
containerConstraint.MaxSize = Vector2.new(420, 520)
containerConstraint.Parent = container

local containerCorner = Instance.new("UICorner")
containerCorner.CornerRadius = UDim.new(0, 12)
containerCorner.Parent = container

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -16, 0, 40)
title.Position = UDim2.new(0, 8, 0, 8)
title.BackgroundTransparency = 1
title.Text = "JAY HUB - EREN CUTE"
title.TextColor3 = Color3.fromRGB(255, 200, 60)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextWrapped = true
title.ZIndex = 3
title.Parent = container

local titleSizeConstraint = Instance.new("UITextSizeConstraint")
titleSizeConstraint.MaxTextSize = 20
titleSizeConstraint.Parent = title

local timeLabel = Instance.new("TextLabel")
timeLabel.Name = "TimeLabel"
timeLabel.Size = UDim2.new(1, -16, 0, 30)
timeLabel.Position = UDim2.new(0, 8, 0, 50)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "Elapsed Time: 0s"
timeLabel.TextColor3 = Color3.fromRGB(150, 220, 255)
timeLabel.TextScaled = true
timeLabel.Font = Enum.Font.Gotham
timeLabel.TextWrapped = true
timeLabel.ZIndex = 3
timeLabel.Parent = container

local timeSizeConstraint = Instance.new("UITextSizeConstraint")
timeSizeConstraint.MaxTextSize = 15
timeSizeConstraint.Parent = timeLabel

local usernameLabel = Instance.new("TextLabel")
usernameLabel.Name = "UsernameLabel"
usernameLabel.Size = UDim2.new(1, -16, 0, 26)
usernameLabel.Position = UDim2.new(0, 8, 0, 84)
usernameLabel.BackgroundTransparency = 1
usernameLabel.Text = "@" .. player.Name
usernameLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
usernameLabel.TextScaled = true
usernameLabel.Font = Enum.Font.Gotham
usernameLabel.TextWrapped = true
usernameLabel.ZIndex = 3
usernameLabel.Parent = container

local usernameSizeConstraint = Instance.new("UITextSizeConstraint")
usernameSizeConstraint.MaxTextSize = 14
usernameSizeConstraint.Parent = usernameLabel

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(1, -16, 0, 30)
statusLabel.Position = UDim2.new(0, 8, 0, 116)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Sheckles: 0"
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextWrapped = true
statusLabel.ZIndex = 3
statusLabel.Parent = container

local statusSizeConstraint = Instance.new("UITextSizeConstraint")
statusSizeConstraint.MaxTextSize = 16
statusSizeConstraint.Parent = statusLabel

local rewardTitle = Instance.new("TextLabel")
rewardTitle.Name = "RewardTitle"
rewardTitle.Size = UDim2.new(1, -16, 0, 26)
rewardTitle.Position = UDim2.new(0, 8, 0, 150)
rewardTitle.BackgroundTransparency = 1
rewardTitle.Text = "Bought List"
rewardTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
rewardTitle.TextScaled = true
rewardTitle.Font = Enum.Font.GothamBold
rewardTitle.TextXAlignment = Enum.TextXAlignment.Left
rewardTitle.TextWrapped = true
rewardTitle.ZIndex = 3
rewardTitle.Parent = container

local rewardTitleSizeConstraint = Instance.new("UITextSizeConstraint")
rewardTitleSizeConstraint.MaxTextSize = 16
rewardTitleSizeConstraint.Parent = rewardTitle

local rewardScroll = Instance.new("ScrollingFrame")
rewardScroll.Name = "RewardScroll"
rewardScroll.Size = UDim2.new(1, -16, 1, -190)
rewardScroll.Position = UDim2.new(0, 8, 0, 184)
rewardScroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
rewardScroll.BackgroundTransparency = 0.2
rewardScroll.BorderSizePixel = 0
rewardScroll.ScrollBarThickness = 6
rewardScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
rewardScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
rewardScroll.ZIndex = 3
rewardScroll.Parent = container

local rewardScrollCorner = Instance.new("UICorner")
rewardScrollCorner.CornerRadius = UDim.new(0, 8)
rewardScrollCorner.Parent = rewardScroll

local rewardListLayout = Instance.new("UIListLayout")
rewardListLayout.SortOrder = Enum.SortOrder.LayoutOrder
rewardListLayout.Padding = UDim.new(0, 4)
rewardListLayout.Parent = rewardScroll

local rewardPadding = Instance.new("UIPadding")
rewardPadding.PaddingTop = UDim.new(0, 6)
rewardPadding.PaddingBottom = UDim.new(0, 6)
rewardPadding.PaddingLeft = UDim.new(0, 8)
rewardPadding.PaddingRight = UDim.new(0, 8)
rewardPadding.Parent = rewardScroll

local function EditStatus(text)
	statusLabel.Text = tostring(text)
end

_G.EditStatus = EditStatus

local startTime = os.time()

local function formatElapsed(seconds)
	local days = math.floor(seconds / 86400)
	local hours = math.floor((seconds % 86400) / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	local secs = seconds % 60

	if days > 0 then
		return string.format("Elapsed Time: %dd %dh %dm %ds", days, hours, minutes, secs)
	elseif hours > 0 then
		return string.format("Elapsed Time: %dh %dm %ds", hours, minutes, secs)
	elseif minutes > 0 then
		return string.format("Elapsed Time: %dm %ds", minutes, secs)
	else
		return string.format("Elapsed Time: %ds", secs)
	end
end

RunService.Heartbeat:Connect(function()
	local elapsed = os.time() - startTime
	timeLabel.Text = formatElapsed(elapsed)
end)

local function formatNumber(n)
	local formatted = tostring(math.floor(n))
	local k
	repeat
		formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
	until k == 0
	return formatted
end

local CATEGORY_ORDER = { "Seeds", "Gears", "Crates" }
local CATEGORY_COLORS = {
	Seeds = Color3.fromRGB(120, 220, 120),
	Gears = Color3.fromRGB(120, 180, 255),
	Crates = Color3.fromRGB(230, 180, 90),
}

local function clearRewardList()
	for _, child in ipairs(rewardScroll:GetChildren()) do
		if child:IsA("TextLabel") or child:IsA("Frame") then
			child:Destroy()
		end
	end
end

local function addCategoryHeader(categoryName, order)
	local header = Instance.new("TextLabel")
	header.Name = categoryName .. "_Header"
	header.Size = UDim2.new(1, 0, 0, 24)
	header.BackgroundTransparency = 1
	header.Text = categoryName
	header.TextColor3 = CATEGORY_COLORS[categoryName] or Color3.fromRGB(255, 255, 255)
	header.Font = Enum.Font.GothamBold
	header.TextSize = 16
	header.TextXAlignment = Enum.TextXAlignment.Left
	header.LayoutOrder = order
	header.ZIndex = 4
	header.Parent = rewardScroll
	return header
end

local function addRewardRow(itemName, amount, order)
	local row = Instance.new("TextLabel")
	row.Name = "Row_" .. itemName
	row.Size = UDim2.new(1, 0, 0, 20)
	row.BackgroundTransparency = 1
	row.Text = string.format("  %s: %s", itemName, formatNumber(amount))
	row.TextColor3 = Color3.fromRGB(220, 220, 220)
	row.Font = Enum.Font.Gotham
	row.TextSize = 14
	row.TextXAlignment = Enum.TextXAlignment.Left
	row.LayoutOrder = order
	row.ZIndex = 4
	row.Parent = rewardScroll
	return row
end

local function renderRewards(rewardAfk)
	clearRewardList()

	if not rewardAfk then
		local empty = Instance.new("TextLabel")
		empty.Size = UDim2.new(1, 0, 0, 24)
		empty.BackgroundTransparency = 1
		empty.Text = "No bought yet"
		empty.TextColor3 = Color3.fromRGB(150, 150, 150)
		empty.Font = Enum.Font.Gotham
		empty.TextSize = 14
		empty.TextXAlignment = Enum.TextXAlignment.Left
		empty.ZIndex = 4
		empty.Parent = rewardScroll
		return
	end

	local order = 0
	for _, categoryName in ipairs(CATEGORY_ORDER) do
		local categoryData = rewardAfk[categoryName]
		if categoryData and next(categoryData) ~= nil then
			order += 1
			addCategoryHeader(categoryName, order)

			local keys = {}
			for itemName in pairs(categoryData) do
				table.insert(keys, itemName)
			end
			table.sort(keys)

			for _, itemName in ipairs(keys) do
				order += 1
				addRewardRow(itemName, categoryData[itemName], order)
			end
		end
	end

	if order == 0 then
		local empty = Instance.new("TextLabel")
		empty.Size = UDim2.new(1, 0, 0, 24)
		empty.BackgroundTransparency = 1
		empty.Text = "No bought yet"
		empty.TextColor3 = Color3.fromRGB(150, 150, 150)
		empty.Font = Enum.Font.Gotham
		empty.TextSize = 14
		empty.TextXAlignment = Enum.TextXAlignment.Left
		empty.ZIndex = 4
		empty.Parent = rewardScroll
	end
end

task.spawn(function()
	local ok, PlayerStateClient = pcall(function()
		return require(ReplicatedStorage.ClientModules.PlayerStateClient)
	end)

	if not ok or not PlayerStateClient then
		warn("AfkChamberUI: Could not require PlayerStateClient, skipping auto-update")
		renderRewards(nil)
		return
	end

	local Replica = PlayerStateClient:WaitForLocalReplica(30)

	local function GetMoney()
		return (Replica and Replica.Data and Replica.Data.Sheckles) or 0
	end

	local function GetRewardAfk()
		return Replica and Replica.Data and Replica.Data.RewardAfk
	end

	local function CheckMoney()
		EditStatus("Sheckles: " .. formatNumber(GetMoney()))
	end

	local function CheckRewards()
		renderRewards(GetRewardAfk())
	end

	CheckMoney()
	CheckRewards()

	Replica:OnChange(function(_, path)
		if path[1] == "Sheckles" then
			CheckMoney()
		elseif path[1] == "RewardAfk" then
			CheckRewards()
		end
	end)
end)

pcall(function()
	settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

local Lighting = game:GetService("Lighting")
Lighting.GlobalShadows = false
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0

for _, v in ipairs(workspace:GetDescendants()) do
	if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
		v.Enabled = false
	end
end
