local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local StatusUI = {}

local gui
local frame
local statusLabel

local function makeDraggable(frame)
    local dragging = false
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart

        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            update(input)
        end
    end)
end

function StatusUI:Init()
    self:Destroy()

    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

    gui = Instance.new("ScreenGui")
    gui.Name = "JayHubStatusUI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 999999
    gui.Parent = playerGui

    frame = Instance.new("Frame")
    frame.Name = "Main"
    frame.Size = UDim2.fromOffset(280, 95)
    frame.Position = UDim2.fromOffset(20, 20)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 170, 255)
    stroke.Thickness = 1
    stroke.Parent = frame

    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Font = Enum.Font.GothamBold
    title.Text = "Jay Hub"
    title.TextSize = 18
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Parent = frame

    local divider = Instance.new("Frame")
    divider.AnchorPoint = Vector2.new(0.5, 0)
    divider.Position = UDim2.new(0.5, 0, 0, 30)
    divider.Size = UDim2.new(1, -20, 0, 1)
    divider.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    divider.BorderSizePixel = 0
    divider.Parent = frame

    local statusTitle = Instance.new("TextLabel")
    statusTitle.BackgroundTransparency = 1
    statusTitle.Position = UDim2.fromOffset(10, 38)
    statusTitle.Size = UDim2.new(1, -20, 0, 18)
    statusTitle.Font = Enum.Font.GothamBold
    statusTitle.Text = "Status"
    statusTitle.TextSize = 13
    statusTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    statusTitle.TextXAlignment = Enum.TextXAlignment.Left
    statusTitle.Parent = frame

    statusLabel = Instance.new("TextLabel")
    statusLabel.BackgroundTransparency = 1
    statusLabel.Position = UDim2.fromOffset(10, 58)
    statusLabel.Size = UDim2.new(1, -20, 0, 24)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Text = "Idle"
    statusLabel.TextSize = 16
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = frame

    makeDraggable(frame)
end

function StatusUI:SetStatus(text)
    if statusLabel then
        statusLabel.Text = text
    end
end

function StatusUI:Destroy()
    if gui then
        gui:Destroy()
        gui = nil
        frame = nil
        statusLabel = nil
    end
end

return StatusUI
