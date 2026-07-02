-- ================================================================
--  ★★★ 配置区（开发者在这里修改） ★★★
-- ================================================================
local CONFIG = {
    -- ★★★ 这里填写你的固定卡密（只有输入这个才能通过） ★★★
    VALID_KEY = "e7e49c0a-0609-459f-acd5-9e0318d17592",
    
    -- ★★★ 这里已填好你的付费脚本地址 ★★★
    MAIN_SCRIPT_URL = "https://raw.githubusercontent.com/aaaaa-arch/shiny-broccoli/refs/heads/main/XY%E8%84%9A%E6%9C%AC%F0%9F%A4%94%E4%BB%98%E8%B4%B9%E7%89%88.lua",
    
    -- UI 文字
    Title = "✨ 尊享验证",
    Subtitle = "请输入您的卡密以解锁全部功能",
    Placeholder = "在此输入卡密...",
    ButtonText = "🚀 立即激活",
    CloseText = "✕",
}

-- ================================================================
--  以下代码不用改，直接复制即可
-- ================================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PremiumKeySystem"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
screenGui.IgnoreGuiInset = true
screenGui.Parent = PlayerGui

-- 遮罩
local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.5
overlay.BorderSizePixel = 0
overlay.Parent = screenGui

-- 主框架（毛玻璃）
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 440, 0, 280)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BackgroundTransparency = 0.12
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1.5
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Transparency = 0.6
stroke.Parent = frame

local blur = Instance.new("BlurEffect")
blur.Size = 18
blur.Parent = frame

local glow = Instance.new("Frame")
glow.Size = UDim2.new(0, 200, 0, 200)
glow.Position = UDim2.new(0, -60, 0, -60)
glow.BackgroundColor3 = Color3.fromRGB(150, 200, 255)
glow.BackgroundTransparency = 0.6
glow.BorderSizePixel = 0
glow.Parent = frame
local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(1, 0)
glowCorner.Parent = glow

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 36, 0, 36)
closeBtn.Position = UDim2.new(1, -46, 0, 12)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = CONFIG.CloseText
closeBtn.TextColor3 = Color3.fromRGB(220, 220, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.Parent = frame

-- 标题
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.Position = UDim2.new(0, 0, 0, 15)
title.BackgroundTransparency = 1
title.Text = CONFIG.Title
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = frame

-- 副标题
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -40, 0, 30)
subtitle.Position = UDim2.new(0, 20, 0, 75)
subtitle.BackgroundTransparency = 1
subtitle.Text = CONFIG.Subtitle
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 15
subtitle.TextColor3 = Color3.fromRGB(220, 220, 255)
subtitle.TextXAlignment = Enum.TextXAlignment.Center
subtitle.TextWrapped = true
subtitle.Parent = frame

-- 输入框
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0.8, 0, 0, 48)
inputBox.Position = UDim2.new(0.1, 0, 0, 118)
inputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
inputBox.BackgroundTransparency = 0.15
inputBox.BorderSizePixel = 0
inputBox.PlaceholderText = CONFIG.Placeholder
inputBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 200)
inputBox.Text = ""
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 18
inputBox.ClearTextOnFocus = false
inputBox.Parent = frame
local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 12)
inputCorner.Parent = inputBox
local inputStroke = Instance.new("UIStroke")
inputStroke.Thickness = 1
inputStroke.Color = Color3.fromRGB(255, 255, 255)
inputStroke.Transparency = 0.3
inputStroke.Parent = inputBox

-- 提交按钮
local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.8, 0, 0, 52)
submitBtn.Position = UDim2.new(0.1, 0, 0, 188)
submitBtn.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
submitBtn.BackgroundTransparency = 0.2
submitBtn.BorderSizePixel = 0
submitBtn.Text = CONFIG.ButtonText
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 19
submitBtn.Parent = frame
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = submitBtn
local btnStroke = Instance.new("UIStroke")
btnStroke.Thickness = 1.5
btnStroke.Color = Color3.fromRGB(255, 255, 255)
btnStroke.Transparency = 0.4
btnStroke.Parent = submitBtn

-- 入场动画
frame.BackgroundTransparency = 1
frame.Size = UDim2.new(0, 0, 0, 0)
task.wait(0.05)
local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local sizeTween = TweenService:Create(frame, tweenInfo, { Size = UDim2.new(0, 440, 0, 280) })
local fadeTween = TweenService:Create(frame, TweenInfo.new(0.3), { BackgroundTransparency = 0.12 })
sizeTween:Play()
fadeTween:Play()

-- ================================================================
--  ★★★ 本地验证函数（直接比对卡密） ★★★
-- ================================================================
local function validateKeyLocally(inputKey)
    return inputKey == CONFIG.VALID_KEY
end

-- ================================================================
--  ★★★ 加载主脚本（你的付费脚本） ★★★
-- ================================================================
local function loadMainScript()
    local url = CONFIG.MAIN_SCRIPT_URL
    if url == "" or url == "https://example.com/your-main-script.lua" then
        warn("[系统] ⚠️ 请先在 CONFIG.MAIN_SCRIPT_URL 中填写你要加载的脚本地址！")
        subtitle.Text = "⚠️ 请配置 MAIN_SCRIPT_URL"
        subtitle.TextColor3 = Color3.fromRGB(255, 200, 100)
        return
    end
    
    print("[系统] 正在加载主脚本: " .. url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success and result then
        local loadSuccess, err = pcall(function()
            loadstring(result)()
        end)
        if loadSuccess then
            print("[系统] ✅ 主脚本加载成功！")
            local closeTween = TweenService:Create(frame, TweenInfo.new(0.3), {
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 0, 0, 0)
            })
            closeTween:Play()
            closeTween.Completed:Wait()
            screenGui:Destroy()
        else
            warn("[系统] ❌ 主脚本执行失败:", err)
            subtitle.Text = "❌ 脚本加载失败，请联系管理员"
            subtitle.TextColor3 = Color3.fromRGB(255, 150, 150)
        end
    else
        warn("[系统] ❌ 获取主脚本失败:", result)
        subtitle.Text = "❌ 无法获取脚本，请检查 URL"
        subtitle.TextColor3 = Color3.fromRGB(255, 150, 150)
    end
end

-- ================================================================
--  处理验证结果
-- ================================================================
local function handleKeyValidation(isValid)
    if isValid then
        print("[系统] ✅ 卡密正确！正在加载主脚本...")
        submitBtn.Text = "⏳ 加载中..."
        submitBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
        submitBtn.Active = false
        task.spawn(function()
            loadMainScript()
        end)
    else
        print("[系统] ❌ 卡密无效")
        inputBox.Text = ""
        inputBox.PlaceholderText = "❌ 卡密无效，请重试"
        task.wait(1.5)
        inputBox.PlaceholderText = CONFIG.Placeholder
    end
end

local function startValidation()
    local inputKey = inputBox.Text
    if inputKey == "" then
        inputBox.PlaceholderText = "⚠️ 请输入卡密"
        task.wait(1)
        inputBox.PlaceholderText = CONFIG.Placeholder
        return
    end

    submitBtn.Text = "⏳ 验证中..."
    submitBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    submitBtn.Active = false

    task.spawn(function()
        local isValid = validateKeyLocally(inputKey)
        submitBtn.Text = CONFIG.ButtonText
        submitBtn.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
        submitBtn.Active = true
        handleKeyValidation(isValid)
    end)
end

-- 绑定事件
submitBtn.MouseButton1Click:Connect(startValidation)
inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then startValidation() end
end)

closeBtn.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(frame, TweenInfo.new(0.3), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 0, 0)
    })
    closeTween:Play()
    closeTween.Completed:Wait()
    screenGui:Destroy()
end)

overlay.MouseButton1Click:Connect(function()
    closeBtn.MouseButton1Click:Fire()
end)

print("[系统] 本地卡密验证系统已加载")
print("[系统] 有效卡密: " .. CONFIG.VALID_KEY)