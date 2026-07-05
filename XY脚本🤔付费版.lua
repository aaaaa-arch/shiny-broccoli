local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/WuMing-YYDS/Script-UI/refs/heads/main/Wind%20UI.LUA"))()

-- ================================================================
--  ★★★ 云端卡密验证模块（修复卡验证中问题） ★★★
-- ================================================================

local API_URL = "http://xykey.cc.cd/verify_key.php"

print("[卡密验证] 脚本加载中...")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local CACHE_KEY = "StellarKeyCache"

local function getCache()
    if getgenv and getgenv()[CACHE_KEY] then
        return getgenv()[CACHE_KEY]
    end
    return nil
end

local function setCache(data)
    if getgenv then
        getgenv()[CACHE_KEY] = data
        print("[卡密验证] 缓存已保存")
    end
end

local function clearCache()
    if getgenv then
        getgenv()[CACHE_KEY] = nil
        print("[卡密验证] 缓存已清除")
    end
end

local function checkCache()
    local cache = getCache()
    if not cache then
        print("[卡密验证] 无缓存")
        return false
    end
    local now = os.time()
    if cache.expires_at and now < cache.expires_at then
        print("[卡密验证] ✅ 缓存有效，直接放行！")
        return true
    else
        print("[卡密验证] ❌ 缓存已过期，清除中...")
        clearCache()
        return false
    end
end

-- ★★★ 主脚本执行函数 ★★★
local function executeMainScript()
    print("[卡密验证] 开始执行主脚本！")
    -- ════════════════════════════════════════════════════════════
    --  ★★★ 把你的主脚本源代码放在下面 ★★★
    -- ════════════════════════════════════════════════════════════

do
    local ok, err = pcall(function()
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        local RunService = game:GetService("RunService")
        local CoreGui = game:GetService("CoreGui")
        local LocalPlayer = Players.LocalPlayer

        local function getGuiParent()
            local s, p = pcall(function()
                if gethui then return gethui() end
                return CoreGui
            end)
            if s and p then return p end
            return LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
        end

        local old = getGuiParent():FindFirstChild("GridCollapseBootAnimation")
        if old then old:Destroy() end

        local gui = Instance.new("ScreenGui")
        gui.Name = "GridCollapseBootAnimation"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.DisplayOrder = 9999999999999
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.Parent = getGuiParent()

        local function tw(obj, props, dur, style, dir)
            style = style or Enum.EasingStyle.Quad
            dir = dir or Enum.EasingDirection.Out
            return TweenService:Create(obj, TweenInfo.new(dur, style, dir), props)
        end
        local function play(t) t:Play() end

        -- 创建音效
        local function createSound(soundId, volume, pitch)
            local sound = Instance.new("Sound")
            sound.SoundId = soundId
            sound.Volume = volume or 0.5
            sound.Pitch = pitch or 1
            sound.Parent = gui
            return sound
        end

        local bgMusic = createSound("rbxassetid://1841228593", 0.3, 1.2)
        local typeSound = createSound("rbxassetid://12221967", 0.15, 1)
        local completeSound = createSound("rbxassetid://1084605307", 0.5, 1.1)
        local collapseSound = createSound("rbxassetid://1566511635", 0.2, 1.3)

        -- 全屏黑色背景
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        bg.BackgroundTransparency = 0
        bg.ZIndex = 1
        bg.Parent = gui

        -- 网格背景容器
        local gridContainer = Instance.new("Frame")
        gridContainer.Size = UDim2.new(1, 0, 1, 0)
        gridContainer.BackgroundTransparency = 1
        gridContainer.ZIndex = 2
        gridContainer.Parent = bg

        -- 创建网格正方形
        local gridSize = 60 -- 格子大小
        local gridColor1 = Color3.fromRGB(0, 100, 60) -- 绿色
        local gridColor2 = Color3.fromRGB(0, 150, 100) -- 亮绿色
        local grids = {}

        local screenWidth = 1920
        local screenHeight = 1080
        local gridCountX = math.ceil(screenWidth / gridSize)
        local gridCountY = math.ceil(screenHeight / gridSize)

        for y = 0, gridCountY - 1 do
            for x = 0, gridCountX - 1 do
                local gridSquare = Instance.new("Frame")
                gridSquare.Size = UDim2.new(0, gridSize, 0, gridSize)
                gridSquare.Position = UDim2.new(0, x * gridSize, 0, y * gridSize)
                
                -- 交替颜色
                if (x + y) % 2 == 0 then
                    gridSquare.BackgroundColor3 = gridColor1
                else
                    gridSquare.BackgroundColor3 = gridColor2
                end
                
                gridSquare.BackgroundTransparency = 0.75
                gridSquare.BorderSizePixel = 1
                gridSquare.BorderColor3 = Color3.fromRGB(0, 150, 80)
                gridSquare.ZIndex = 2
                gridSquare.Parent = gridContainer
                
                table.insert(grids, {square = gridSquare, x = x, y = y})
            end
        end

        -- 中央进度框
        local centerBox = Instance.new("Frame")
        centerBox.Size = UDim2.new(0, 420, 0, 300)
        centerBox.Position = UDim2.new(0.5, -210, 0.5, -150)
        centerBox.BackgroundColor3 = Color3.fromRGB(0, 10, 5)
        centerBox.BackgroundTransparency = 0.2
        centerBox.BorderSizePixel = 0
        centerBox.ZIndex = 10
        centerBox.Parent = bg
        Instance.new("UICorner", centerBox).CornerRadius = UDim.new(0, 12)

        local centerStroke = Instance.new("UIStroke", centerBox)
        centerStroke.Color = Color3.fromRGB(0, 255, 100)
        centerStroke.Thickness = 2

        -- 标题
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 50)
        title.Position = UDim2.new(0, 0, 0, 15)
        title.BackgroundTransparency = 1
        title.Text = "▌XY脚本正在加载 ▌"
        title.TextColor3 = Color3.fromRGB(0, 255, 100)
        title.TextTransparency = 1
        title.TextSize = 20
        title.Font = Enum.Font.Code
        title.TextXAlignment = Enum.TextXAlignment.Center
        title.ZIndex = 11
        title.Parent = centerBox

        -- 进度条背景
        local progressBg = Instance.new("Frame")
        progressBg.Size = UDim2.new(0, 350, 0, 8)
        progressBg.Position = UDim2.new(0, 35, 0, 80)
        progressBg.BackgroundColor3 = Color3.fromRGB(20, 30, 20)
        progressBg.BorderSizePixel = 0
        progressBg.ZIndex = 11
        progressBg.Parent = centerBox
        Instance.new("UICorner", progressBg).CornerRadius = UDim.new(0, 4)

        local progressStroke = Instance.new("UIStroke", progressBg)
        progressStroke.Color = Color3.fromRGB(0, 255, 100)
        progressStroke.Thickness = 1

        -- 进度条填充
        local progressFill = Instance.new("Frame")
        progressFill.Size = UDim2.new(0, 0, 1, 0)
        progressFill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        progressFill.BorderSizePixel = 0
        progressFill.ZIndex = 12
        progressFill.Parent = progressBg
        Instance.new("UICorner", progressFill).CornerRadius = UDim.new(0, 4)

        local fillGradient = Instance.new("UIGradient", progressFill)
        fillGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 100)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 150)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 100)),
        })

        -- 百分比文本
        local percentText = Instance.new("TextLabel")
        percentText.Size = UDim2.new(0, 80, 0, 25)
        percentText.Position = UDim2.new(0, 35, 0, 105)
        percentText.BackgroundTransparency = 1
        percentText.Text = "0%"
        percentText.TextColor3 = Color3.fromRGB(0, 255, 100)
        percentText.TextTransparency = 1
        percentText.TextSize = 18
        percentText.Font = Enum.Font.Code
        percentText.TextXAlignment = Enum.TextXAlignment.Left
        percentText.ZIndex = 11
        percentText.Parent = centerBox

        -- 状态信息
        local statusInfo = Instance.new("TextLabel")
        statusInfo.Size = UDim2.new(1, -70, 0, 60)
        statusInfo.Position = UDim2.new(0, 35, 0, 150)
        statusInfo.BackgroundTransparency = 1
        statusInfo.Text = "> 初始化网格系统\n> 加载数据矩阵\n> 准备完毕"
        statusInfo.TextColor3 = Color3.fromRGB(0, 200, 120)
        statusInfo.TextTransparency = 1
        statusInfo.TextSize = 13
        statusInfo.Font = Enum.Font.Code
        statusInfo.TextXAlignment = Enum.TextXAlignment.Left
        statusInfo.TextYAlignment = Enum.TextYAlignment.Top
        statusInfo.ZIndex = 11
        statusInfo.Parent = centerBox

        -- ===== 执行动画（8秒总时长） =====

        -- 1. 淡入背景
        bg.BackgroundTransparency = 1
        play(tw(bg, {BackgroundTransparency = 0}, 0.5))
        bgMusic:Play()
        task.wait(0.3)

        -- 2. 淡入网格
        for _, gridData in ipairs(grids) do
            play(tw(gridData.square, {BackgroundTransparency = 0.6}, 0.6))
        end
        task.wait(0.4)

        -- 3. 淡入中央框
        play(tw(centerBox, {BackgroundTransparency = 0.2}, 0.5))
        play(tw(centerStroke, {Transparency = 0}, 0.5))
        play(tw(title, {TextTransparency = 0}, 0.5))
        play(tw(statusInfo, {TextTransparency = 0}, 0.5))
        play(tw(percentText, {TextTransparency = 0}, 0.5))
        
        typeSound:Play()
        task.wait(0.5)

        -- 4. 网格崩坏动画（从中心向外扩散）
        task.spawn(function()
            local centerX = gridCountX / 2
            local centerY = gridCountY / 2
            local maxDistance = math.sqrt(centerX^2 + centerY^2)
            
            for wave = 1, 3 do
                task.wait(1.5)
                
                for _, gridData in ipairs(grids) do
                    local distX = gridData.x - centerX
                    local distY = gridData.y - centerY
                    local distance = math.sqrt(distX^2 + distY^2)
                    
                    -- 根据波浪周期崩坏
                    local waveStart = (wave - 1) * 2
                    local waveEnd = wave * 2
                    
                    if distance >= waveStart and distance <= waveEnd then
                        task.spawn(function()
                            collapseSound:Play()
                            
                            -- 崩坏效果：旋转 + 透明度变化
                            play(tw(gridData.square, {
                                BackgroundTransparency = 1,
                                Rotation = 45
                            }, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In))
                            
                            task.wait(0.4)
                            
                            -- 重新恢复
                            gridData.square.Rotation = 0
                            gridData.square.BackgroundTransparency = 0.6
                        end)
                    end
                end
            end
        end)

        -- 5. 网格闪烁效果
        task.spawn(function()
            local startTime = tick()
            while tick() - startTime < 6 do
                for i = 1, #grids, 10 do
                    local gridData = grids[i]
                    if gridData then
                        play(tw(gridData.square, {BackgroundTransparency = 0.3}, 0.2, Enum.EasingStyle.Sine))
                    end
                end
                task.wait(0.3)
                for i = 1, #grids, 10 do
                    local gridData = grids[i]
                    if gridData then
                        play(tw(gridData.square, {BackgroundTransparency = 0.6}, 0.2, Enum.EasingStyle.Sine))
                    end
                end
                task.wait(0.3)
            end
        end)

        -- 6. 进度条加载 - 8秒内完成
        task.spawn(function()
            local startTime = tick()
            local duration = 7.0
            
            while true do
                local elapsed = tick() - startTime
                local progress = math.min(elapsed / duration, 1.0)
                
                play(tw(progressFill, {Size = UDim2.new(progress, 0, 1, 0)}, 0.1, Enum.EasingStyle.Linear))
                percentText.Text = math.floor(progress * 100) .. "%"
                
                if math.floor(progress * 100) % 25 == 0 then
                    typeSound:Play()
                end
                
                if progress >= 1.0 then
                    percentText.Text = "100%"
                    break
                end
                
                task.wait(0.05)
            end
        end)

        -- 等待8秒
        task.wait(8)

        -- 7. 完成动画 - 所有网格消失
        completeSound:Play()
        
        play(tw(centerBox, {BackgroundTransparency = 1}, 0.5))
        play(tw(centerStroke, {Transparency = 1}, 0.5))
        play(tw(title, {TextTransparency = 1}, 0.5))
        play(tw(statusInfo, {TextTransparency = 1}, 0.5))
        play(tw(percentText, {TextTransparency = 1}, 0.5))
        
        for _, gridData in ipairs(grids) do
            play(tw(gridData.square, {BackgroundTransparency = 1}, 0.6))
        end
        
        play(tw(bg, {BackgroundTransparency = 1}, 0.8))
        play(tw(bgMusic, {Volume = 0}, 0.5))

        task.wait(0.8)
        if gui then gui:Destroy() end
    end)

    if not ok then
        warn("网格崩坏动画加载失败：" .. tostring(err))
    end
end

WindUI:Popup({
    Title = "提示",
    Icon = "info",
    Content = "是否加载最新版本 3.78《最新》",
    Buttons = {
        {
            Title = "取消",
            Callback = function() end,
            Variant = "Tertiary",
        },
        {
            Title = "确定",
            Icon = "arrow-right",
            Callback = function() end,
            Variant = "Primary",
        }
    }
})

WindUI:Notify({
    Title = "紧急通知：XY脚本可能会停更",
    Content = "Notification Content example!",
    Duration = 3, -- 3 seconds
    Icon = "bird",
})

WindUI:Notify({
    Title = "欢迎使用",
    Content = "XY脚本",
    Duration = 3,
    Position = "Left"
})

WindUI:Notify({
    Title = "XY脚本",
    Content = "不跑路",
    Duration = 11,
})

WindUI:Notify({
    Title = "欢迎使用",
    Content = "XY脚本",
    Duration = 10,
})

WindUI:Notify({
    Title = "Q 群",
    Content = "1013013485",
    Duration = 10,
})

WindUI:Popup({
    Title = "欢迎用户进入 XY脚本",
    Icon = "info",
    Content = "欢迎你游玩我们的 XY脚本😋",
    Buttons = {
        {
            Title = "我不知道",
            Callback = function() end,
            Variant = "Tertiary",
        },
        {
            Title = "我知道的",
            Icon = "arrow-right",
            Callback = function() end,
            Variant = "Primary",
        }
    }
})

WindUI:Popup({
    Title = "公告",
    Icon = "info",
    Content = "该脚本禁止倒卖作者：小夜作者 QQ 号 2725892250该脚本转为付费",
    Buttons = {
        {
            Title = "我不知道",
            Callback = function() end,
            Variant = "Tertiary",
        },
        {
            Title = "我知道的",
            Icon = "arrow-right",
            Callback = function() end,
            Variant = "Primary",
        }
    }
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local Main = WindUI:CreateWindow({
    Title = "<font color='#ff007f'>XY脚本</font>-<font color='#00ffff'>通用</font>",
    Author = "<font color='#00ffff'>by</font> <font color='#ff007f'>小夜</font>",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(300, 400),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    Background = "video:https://raw.githubusercontent.com/xiaoxi9008/shipin/refs/heads/main/Video_1782398609786_80.mp4",
    IconThemed = true,
    ScrollBarEnabled = true,
    HideSearchBar = true,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function() end
    }
})

Main:EditOpenButton({
    Title = "<font color='#ff007f'>XY</font><font color='#00ffff'>脚本 付费版</font>",
    Icon = "rbxassetid://127418118514722",
    CornerRadius = UDim.new(0, 8),
    StrokeThickness = 2,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("#ff007f")),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex("#00ffff")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("#ff007f"))
    })
})

Main:Tag({
    Title = "XY脚本",
    Color = Color3.fromHex("#00ffff")
})

Main:Tag({
    Title = "付费",
    Color = Color3.fromHex("#ff007f")
})

local TimeTag = Main:Tag({
    Title = "当前时间: 00:00:00",
    Color = Color3.fromHex("#00ffff")
})

Main:Tag({
    Title = "脚本创建的6天",
    Color = Color3.fromHex("#ff007f")
})

local hue = 0
local running = true

task.spawn(function()
    while running do
        local now = os.date("*t")
        local hours = string.format("%02d", now.hour)
        local minutes = string.format("%02d", now.min)
        local seconds = string.format("%02d", now.sec)
        local timeString = string.format("当前时间: %s:%s:%s", hours, minutes, seconds)
        hue = (hue + 0.01) % 1
        local color = Color3.fromHSV(hue, 1, 1)
        TimeTag:SetTitle(timeString)
        TimeTag:SetColor(color)
        task.wait(0.06)
    end
end)

local TimeTag2 = Main:Tag({
    Title = "新年倒计时: --",
    Color = Color3.fromHex("#f57c00")
})

local function getNextNewYear()
    local now = os.date("*t")
    local newYear = {
        year = now.year,
        month = 1,
        day = 1,
        hour = 0,
        min = 0,
        sec = 0
    }
    if now.month > 1 or (now.month == 1 and now.day > 1) then
        newYear.year = newYear.year + 1
    end
    return os.time(newYear)
end

task.spawn(function()
    local nextNewYear = getNextNewYear()
    while true do
        local now = os.time()
        local remaining = nextNewYear - now
        if remaining <= 0 then
            nextNewYear = getNextNewYear()
            remaining = nextNewYear - now
        end
        local days = math.floor(remaining / 86400)
        remaining = remaining % 86400
        local hours = math.floor(remaining / 3600)
        remaining = remaining % 3600
        local minutes = math.floor(remaining / 60)
        local seconds = remaining % 60
        local displayText
        if days > 0 then
            displayText = string.format("新年倒计时: %d天%02d:%02d:%02d", days, hours, minutes, seconds)
        else
            displayText = string.format("新年倒计时: %02d:%02d:%02d", hours, minutes, seconds)
        end
        TimeTag2:SetTitle(displayText)
        hue = (hue + 0.01) % 1
        TimeTag2:SetColor(Color3.fromHSV(hue, 1, 1))
        task.wait(1)
    end
end)

local function ApplyNeonBorder(Window, Speed)
    Speed = Speed or 60
    local MainFrame = Window.UIElements and Window.UIElements.Main
    if not MainFrame then
        local Attempts = 0
        while not MainFrame and Attempts < 50 do
            task.wait(0.1)
            MainFrame = Window.UIElements and Window.UIElements.Main
            Attempts = Attempts + 1
        end
        if not MainFrame then return end
    end
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = MainFrame
    local Border = Instance.new("UIStroke")
    Border.Name = "NeonBorder"
    Border.Thickness = 2
    Border.Color = Color3.new(1, 1, 1)
    Border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Border.LineJoinMode = Enum.LineJoinMode.Round
    Border.Parent = MainFrame
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("#00FFFF")),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex("#FF00FF")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("#00FFFF"))
    })
    Gradient.Rotation = 0
    Gradient.Parent = Border
    local Connection
    Connection = game:GetService("RunService").Heartbeat:Connect(function()
        if not Border or Border.Parent == nil then
            if Connection then Connection:Disconnect() end
            return
        end
        local Time = tick()
        Gradient.Rotation = (Time * Speed) % 360
    end)
    local OrigOnClose = Window.OnClose
    Window.OnClose = function(...)
        if Connection then Connection:Disconnect() end
        if OrigOnClose then OrigOnClose(...) end
    end
end

ApplyNeonBorder(Window, 60)

local Tab = Window:Tab({
    Title = "通用",
    Icon = "bird", -- optional
    Locked = false,
})
local Section = Tab:Section({
    Title = "通用功能《如果执行不了 请换加速器》",
    Opened = true
})
Section:Button({
    Title = "飞踢",
    Callback = function()
    
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fe-DropKick-Script-165813"))()    
      end
})
Section:Button({
    Title = "无敌",
    Callback = function()
    
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fe-DropKick-Script-165813"))()    
      end
})
Section:Button({
    Title = "VR视角",
    Callback = function()
    
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fe-DropKick-Script-165813"))()    
      end
})
Section:Button({
    Title = "无限罗宝😱",
    Callback = function()
    
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fe-DropKick-Script-165813"))()    
      end
})
Section:Button({
    Title = "增加FPS",
    Callback = function()
    
loadstring(game:HttpGet("https://pastefy.app/IYUAoy7a/raw"))()
   
      end
})
Section:Button({
    Title = "飞行",
    Callback = function()
    
loadstring(game:HttpGet("https://raw.githubusercontent.com/rodan-demirali/RobloxUI/refs/heads/main/flyUIscript"))    
      end
})
Section:Button({
    Title = "无敌少侠飞行脚本",
    Callback = function()
    
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
      end
})

local Section = Tab:Section({
    Title = "信息",
    Opened = true
})
Section:Button({
    Title = "作者 QQ 3108792043",
    Callback = function()
    
loadstring(game:HttpGet("https://raw.githubusercontent.com/giobolqvi1/homelander-by-GioBolqv1/refs/heads/main/homelander.lua"))()
      end
})
Section:Button({
    Title = "你的注入器：忍者注入器",
    Callback = function()
    
loadstring(game:HttpGet("https://raw.githubusercontent.com/giobolqvi1/homelander-by-GioBolqv1/refs/heads/main/homelander.lua"))()
      end
})
Section:Button({
    Title = "该脚本不圈钱也不会跑路良心脚本",
    Callback = function()
    
loadstring(game:HttpGet("https://raw.githubusercontent.com/giobolqvi1/homelander-by-GioBolqv1/refs/heads/main/homelander.lua"))()
      end
})

local Tab = Window:Tab({
    Title = "脚本中心",
    Icon = "bird", -- optional
    Locked = false,
})
local Section = Tab:Section({
    Title = "脚本",
    Opened = true
})
Section:Button({
    Title = "音乐脚本",
    Callback = function()
    
loadstring(game:HttpGet("https://raw.githubusercontent.com/fningna51-stack/-/main/AF%20%E9%9F%B3%E4%B9%90%E8%84%9A%E6%9C%AC"))()
      end
})
Section:Button({
    Title = "XK Hub",
    Callback = function()
    
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-XK-Hub-76803"))()
      end
})
Section:Button({
    Title = "河北唐县",
    Callback = function()
    
loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8642/science/ok/T%20ang%20County"))()
      end
})
Section:Button({
    Title = "皮脚本",
    Callback = function()
    
loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
      end
})
Section:Button({
    Title = "祖国人脚本",
    Callback = function()
    
loadstring(game:HttpGet("https://raw.githubusercontent.com/giobolqvi1/homelander-by-GioBolqv1/refs/heads/main/homelander.lua"))()
      end
})
Section:Button({
    Title = "夜脚本",
    Callback = function()
    
loadstring(game:HttpGet("https://raw.githubusercontent.com/giobolqvi1/homelander-by-GioBolqv1/refs/heads/main/homelander.lua"))()
      end
})
Section:Button({
    Title = "该脚本以错误❌无法执行",
    Callback = function()
    
loadstring(game:HttpGet("https://raw.githubusercontent.com/aaaaa-arch/effective-computing-machine/main/%E5%AF%86%E9%92%A5"))()
      end
})
local Section = Tab:Section({
    Title = "XY脚本",
    Opened = true
})
Section:Button({
    Title = "XY脚本-99夜",
    Callback = function()
    
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Confirmed = false

WindUI:Popup({
    Title = "XY脚本",
    IconThemed = true,
    Content = "欢迎尊贵的用户" .. game.Players.LocalPlayer.Name .. "XY脚本 当前版本型号:V2",
    Buttons = {
        {
            Title = "取消",
            Callback = function() end,
            Variant = "Secondary",
        },
        {
            Title = "执行",
            Icon = "arrow-right",
            Callback = function() 
                Confirmed = true
                createUI()
            end,
            Variant = "Primary",
        }
    }
})
function createUI()
    local Window = WindUI:CreateWindow({
        Title = "XY脚本付费版",
        Icon = "palette",
    Author = "尊贵的"..game.Players.localPlayer.Name.."欢迎使用 XY脚本", 
        Folder = "Premium",
        Size = UDim2.fromOffset(550, 320),
        Theme = "Light",
        User = {
            Enabled = true,
            Anonymous = true,
            Callback = function()
            end
        },
        SideBarWidth = 200,
        HideSearchBar = false,  
    })

    Window:Tag({
        Title = "森林中的99夜",
        Color = Color3.fromHex("#00ffff") 
    })

    Window:EditOpenButton({
        Title = "XY脚本付费版V2",
        Icon = "crown",
        CornerRadius = UDim.new(0, 8),
        StrokeThickness = 3,
        Color = ColorSequence.new(
            Color3.fromRGB(255, 255, 0),  
            Color3.fromRGB(255, 165, 0),  
            Color3.fromRGB(255, 0, 0),    
            Color3.fromRGB(139, 0, 0)     
        ),
        Draggable = true,
    })
    
    local Language = Window:Tab({Title = "Language Settings", Icon = "globe"})
local Translations = {
    ["Main"] = "主要",
    ["Biometrics"] = "生体",
    ["Infinite Health"] = "无限血",
    ["Infinite Stamina"] = "无限耐力",
    ["Adapt to all weapons"] = "适应所有的武器",
    ["Attack Method"] = "攻击方式",
    ["Range"] = "范围",
    ["Full Map"] = "全图",
    ["Kill Aura"] = "杀戮光环",
    ["Show Current Weapon"] = "显示当前武器",
    ["Trees"] = "树木",
    ["Chop Range [500 Best]"] = "砍树范围[500最佳]",
    ["Auto Chop Trees"] = "自动砍树",
    ["Children"] = "小孩",
    ["Auto Save All Children"] = "自动救所有小孩",
    ["Auto Equip"] = "自动装备",
    ["Auto Equip Weapons"] = "自动装备武器",
    ["Auto Equip Best Weapon"] = "自动装备最佳武器",
    ["Select Weapon to Equip"] = "选择要装备的武器",
    ["Auto Equip Selected Weapon"] = "自动装备选定武器",
    ["Tool Switching"] = "工具切换",
    ["Random Tool Switching"] = "随机工具切换",
    ["Planting"] = "种植",
    ["Planting Shape"] = "种植形状",
    ["Square"] = "正方形",
    ["Circle"] = "圆形",
    ["Original Position"] = "原地",
    ["Planting Range (meters)"] = "种植范围(米)",
    ["Planting Height"] = "种植高度",
    ["Sapling Spacing (meters)"] = "树苗间隔(米)",
    ["Planting Delay (seconds)"] = "种植延迟(秒)",
    ["Auto Planting"] = "自动种植",
    ["Fun Gameplay"] = "趣味玩法",
    ["Select Pattern"] = "选择图案",
    ["Sphere"] = "球形",
    ["Necklace"] = "项链",
    ["Meteor"] = "流星",
    ["Rotation Speed"] = "旋转速度",
    ["Pattern Size"] = "图案大小",
    ["Auto Form Pattern"] = "自动形成图案",
    ["Prank Friends"] = "恶搞朋友",
    ["Select Attack Player"] = "选择攻击玩家",
    ["None"] = "无",
    ["Auto Bear Trap Attack"] = "自动捕兽夹攻击",
    ["Hitbox"] = "打击盒",
    ["Show Hitbox"] = "显示打击盒",
    ["Wolf Hitbox"] = "狼打击盒",
    ["Bunny Hitbox"] = "兔子打击盒",
    ["Cultist Hitbox"] = "邪教徒打击盒",
    ["Everything Hitbox"] = "所有东西打击盒",
    ["Range Size"] = "范围大小",
    ["Slide to adjust"] = "滑动调整",
    ["Food"] = "食物",
    ["Collect Food"] = "收集食物",
    ["Select food to collect (multiple)"] = "选择要收集的食物（多选）",
    ["Raw Meat Chunk"] = "生肉块",
    ["Raw Steak"] = "生牛排",
    ["Cooked Meat Chunk"] = "熟肉块",
    ["Cooked Steak"] = "熟牛排",
    ["Select Position"] = "选择位置",
    ["Campfire"] = "火堆",
    ["Auto Throw Selected Food"] = "自动扔选择的食物",
    ["Remote Cooking"] = "远程烤肉",
    ["Select meats (multiple)"] = "选择肉类 (多选)",
    ["Meat Chunk"] = "肉块",
    ["Steak"] = "牛排",
    ["Remote Cook Selected Meat"] = "远程烤选择的肉",
    ["Auto Cook Food"] = "自动烹饪食物",
    ["Select Cooking Food"] = "选择烹饪食物",
    ["Ribs"] = "肋骨",
    ["Salmon"] = "三文鱼",
    ["Mackerel"] = "鲭鱼",
    ["Auto Cook Food"] = "自动烹饪食物",
    ["Eat Food"] = "吃食物",
    ["Select Food"] = "选择食物",
    ["Select food to auto eat"] = "选择要自动食用的食物",
    ["Hunger Threshold"] = "饥饿阈值",
    ["Auto Feed"] = "自动进食",
    ["Safety"] = "防鹿",
    ["Auto Stun Deer"] = "自动眩晕鹿",
    ["Requires flashlight"] = "需要手电筒",
    ["Fishing"] = "钓鱼",
    ["Auto Fishing"] = "自动钓鱼",
    ["No Delay Fishing"] = "无延迟钓鱼",
    ["Instant Fishing"] = "秒钓鱼",
    ["Workbench"] = "工作台",
    ["Steel"] = "钢材",
    ["Select steel items to collect (multiple)"] = "选择要收集的钢铁类物品（多选）",
    ["Bolt"] = "螺栓",
    ["Broken Fan"] = "破风扇",
    ["Broken Microwave"] = "坏微波炉",
    ["Old Radio"] = "旧收音机",
    ["Washing Machine"] = "洗衣机",
    ["Old Car Engine"] = "旧汽车引擎",
    ["Tire"] = "轮胎",
    ["Sheet Metal"] = "金属板",
    ["Workbench"] = "工作台",
    ["Auto Throw Selected Steel"] = "自动扔选择的钢铁",
    ["Auto Upgrade Workbench"] = "自动升级工作台",
    ["Auto Craft"] = "自动制作",
    ["Craft Item Name"] = "制作物品名称",
    ["Enter item name to craft"] = "输入要制作的物品名称",
    ["Craft Interval (seconds)"] = "制作间隔(秒)",
    ["Set crafting interval time"] = "设置每次制作的间隔时间",
    ["Craft Once"] = "制作一次",
    ["Auto Craft"] = "自动制作",
    ["Chest Functions"] = "宝箱功能",
    ["Auto Open All Chests"] = "自动开全部宝箱",
    ["Chest Aura"] = "宝箱光环",
    ["Chest Aura Range"] = "宝箱光环范围",
    ["Teleport to Nearest Chest"] = "传送到最近宝箱",
    
    ["Campfire"] = "火堆",
    ["Fuel Items"] = "燃料类",
    ["Select items to collect (multiple)"] = "选择要收集的物品（多选）",
    ["Wood"] = "木头",
    ["Coal"] = "煤",
    ["Fuel Canister"] = "油桶",
    ["Chair"] = "椅子",
    ["Biofuel"] = "生物燃料",
    ["Auto Throw Selected Fuel"] = "自动扔选择的燃料",
    ["Teleport Back to Campfire"] = "传送回火旁",
    
    ["Teleport Functions"] = "传送功能",
    ["Basic Teleport Points"] = "基础传送点",
    ["Teleport to Campfire"] = "传送到营火",
    ["Teleport to Stronghold"] = "传送到要塞",
    ["Teleport to Safe Zone"] = "传送到安全区",
    ["Teleport to Merchant"] = "传送到商人",
    ["Teleport to Random Tree"] = "传送到随机树",
    ["Chest Teleport"] = "宝箱传送",
    ["Select Chest"] = "选择宝箱",
    ["Refresh Chest List"] = "刷新宝箱列表",
    ["Teleport to Chest"] = "传送到宝箱",
    ["Child Teleport"] = "儿童传送",
    ["Select Child"] = "选择儿童",
    ["Refresh Child List"] = "刷新儿童列表",
    ["Teleport to Child"] = "传送到儿童",
    
  
    ["Bring"] = "带来",
    ["Auto Teleport Items"] = "自动传送物品",
    ["Auto Teleport Wood"] = "自动传送木头",
    ["Auto Teleport Fuel Canisters"] = "自动传送燃料罐",
    ["Auto Teleport Oil Barrels"] = "自动传送油桶",
    ["Auto Teleport All Scrap"] = "自动传送所有废料",
    ["Auto Teleport Coal"] = "自动传送煤炭",
    ["Auto Teleport Meat"] = "自动传送肉类",
    
    ["Collection"] = "收集",
    ["Select items to collect (multiple)"] = "选择要收集的物品（多选）",
    ["Auto Collect Selected Items"] = "自动收集选择的物品",
    ["Player Functions"] = "玩家功能",
    ["Speed (On/Off)"] = "速度 (开/关)",
    ["Speed Settings"] = "速度设置",
    ["Invisibility"] = "隐身",
    ["Instant Interaction"] = "秒互动",
    ["Infinite Jump"] = "无限跳",
    ["Language Settings"] = "语言设置",
    ["Current Language"] = "当前语言",
    ["Chinese"] = "中文",
    ["English"] = "英文",
    ["Apply Language"] = "应用语言",
    ["Restart script to take effect"] = "重启脚本生效"
}
local currentLanguage = "English"
local languageChanged = false
Language:Dropdown({
    Title = "Current Language",
    Values = {"English", "中文"},
    Value = "English",
    Callback = function(option)
        if option == "中文" then
            currentLanguage = "Chinese"
        else
            currentLanguage = "English"
        end
        languageChanged = true
    end
})
Language:Button({
    Title = "Apply Language",
    Callback = function()
        if languageChanged then
            WindUI:Notify({
                Title = "Language Change",
                Content = "Please restart the script for changes to take effect",
                Duration = 5,
                Icon = "info"
            })
            languageChanged = false
        else
            WindUI:Notify({
                Title = "Language",
                Content = "Language is already set to " .. currentLanguage,
                Duration = 3,
                Icon = "info"
            })
        end
    end
})
local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    
    if currentLanguage == "Chinese" then
        return Translations[text] or text
    else
        for en, cn in pairs(Translations) do
            if text == cn then
                return en
            end
        end
        return text
    end
end
local function translateGUI(gui)
    if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) then
        pcall(function()
            local text = gui.Text
            if text and text ~= "" then
                local translatedText = translateText(text)
                if translatedText ~= text then
                    gui.Text = translatedText
                end
            end
        end)
    end
end
local function scanAndTranslate()
    for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
        translateGUI(gui)
    end
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
            translateGUI(gui)
        end
    end
end
local function setupDescendantListener(parent)
    parent.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
            task.wait(0.1)
            translateGUI(descendant)
        end
    end)
end
local function setupTranslationEngine()
    pcall(setupDescendantListener, game:GetService("CoreGui"))
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        pcall(setupDescendantListener, player.PlayerGui)
    end
    scanAndTranslate()
    while true do
        scanAndTranslate()
        task.wait(3)
    end
end
task.spawn(function()
    task.wait(2)
    setupTranslationEngine()
end)
    
local Main = Window:Tab({Title = "主要", Icon = "user"})
Main:Section({Title = "生体"})

Main:Button({
    Title = "无限血",
    Callback = function()
        local args = {
    [1] = -math.huge  
}

game:GetService("ReplicatedStorage").RemoteEvents.DamagePlayer:FireServer(unpack(args))
    end
})

Main:Button({
    Title = "无限耐力",
    Callback = function()
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            hum.WalkSpeed = 20
        end)
        hum.WalkSpeed = 20
    end
    end
})

Main:Section({Title = "适应所有的武器"})
local killAuraEnabled = false
local attackMethod = "范围" 

Main:Dropdown({
    Title = "攻击方式",
    Values = {"范围", "全图"},
    Value = "范围",
    Callback = function(option)
        attackMethod = option
    end
})

Main:Toggle({
    Title = "杀戮光环",
    Value = false,
    Callback = function(value)
        killAuraEnabled = value
        if value then
            spawn(function()
                while killAuraEnabled do
                    local currentTool = nil
                    
              
                    if game.Players.LocalPlayer.Character then
                        for _, item in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                            if item:IsA("Tool") then
                                currentTool = item
                                break
                            end
                        end
                        
                        if not currentTool and game.Players.LocalPlayer.Character:FindFirstChild("ToolHandle") then
                            local toolHandle = game.Players.LocalPlayer.Character.ToolHandle
                            if toolHandle:FindFirstChild("OriginalItem") and toolHandle.OriginalItem.Value then
                                currentTool = toolHandle.OriginalItem.Value
                            end
                        end
                    end
                    
                    if not currentTool then
                        for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if item:IsA("Tool") then
                                currentTool = item
                                break
                            end
                        end
                    end
                    
                
                    if currentTool then
                        for _, enemy in next, workspace.Characters:GetChildren() do
                            if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("HitRegisters") then
                                if enemy ~= game.Players.LocalPlayer.Character then
                                    local shouldAttack = false
                                    
                                    if attackMethod == "范围" then
                                   
                                        local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                                        if distance <= 35 then
                                            shouldAttack = true
                                        end
                                    else
                                   
                                        shouldAttack = true
                                    end
                                    
                                    if shouldAttack then
                                        pcall(function()
                                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(
                                                enemy, 
                                                currentTool, 
                                                true, 
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                            )
                                        end)
                                    end
                                end
                            end
                        end
                    end
                    
                    wait(0)
                end
            end)
        end
    end
})

local function ShowCurrentWeapon()
    local currentTool = nil
    local toolName = "无"
    
   
    if game.Players.LocalPlayer.Character then
        for _, item in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if item:IsA("Tool") then
                currentTool = item
                break
            end
        end
        
       
        if not currentTool and game.Players.LocalPlayer.Character:FindFirstChild("ToolHandle") then
            local toolHandle = game.Players.LocalPlayer.Character.ToolHandle
            if toolHandle:FindFirstChild("OriginalItem") and toolHandle.OriginalItem.Value then
                currentTool = toolHandle.OriginalItem.Value
            end
        end
    end
    
    
    if not currentTool then
        for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if item:IsA("Tool") then
                currentTool = item
                break
            end
        end
    end
    
    
    if currentTool then
        toolName = currentTool.Name
    end
    
    WindUI:Notify({
        Title = "在森林中的99夜",
        Content = "当前武器: " .. toolName,
        Duration = 5,
    })
    
    return currentTool
end
Main:Button({
    Title = "显示当前武器",
    Callback = function()
        ShowCurrentWeapon()
    end
})

Main:Section({Title = "树木"})

local DefaultChopTreeDistance = 500
local DefaultKillAuraDistance = 20
if not DistanceForAutoChopTree then
    DistanceForAutoChopTree = DefaultChopTreeDistance
end
if not DistanceForKillAura then
    DistanceForKillAura = DefaultKillAuraDistance
end

Main:Input({
    Title = "砍树范围[500最佳]",
    Value = tostring(DefaultChopTreeDistance),
    Callback = function(value)
        local numValue = tonumber(value)
        if numValue then
            DistanceForAutoChopTree = numValue
        else
            warn("请输入有效的数字！")
        end
    end
})

Main:Toggle({
    Title = "自动砍树",
    Description = "",
    Default = false,
    Callback = function(Value)
        ActiveAutoChopTree = Value
        task.spawn(function()
            while ActiveAutoChopTree do
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local hrp = character:WaitForChild("HumanoidRootPart")
                
               
                local weapon = nil
                for _, item in pairs(player.Inventory:GetChildren()) do
                    if item:IsA("Tool") then
                        weapon = item
                        break
                    end
                end
                
           
                if not weapon then
                    weapon = (player.Inventory:FindFirstChild("Old Axe") or player.Inventory:FindFirstChild("Good Axe") or player.Inventory:FindFirstChild("Strong Axe") or player.Inventory:FindFirstChild("Chainsaw"))
                end

                task.spawn(function()
                    for _, tree in pairs(workspace.Map.Foliage:GetChildren()) do
                        if tree:IsA("Model") and (tree.Name == "Small Tree" or tree.Name == "TreeBig1" or tree.Name == "TreeBig2") and tree.PrimaryPart then
                            local distance = (tree.PrimaryPart.Position - hrp.Position).Magnitude
                            if distance <= DistanceForAutoChopTree and weapon then
                                game:GetService("ReplicatedStorage").RemoteEvents.ToolDamageObject:InvokeServer(tree, weapon, 999, hrp.CFrame)
                            end
                        end
                    end
                end)
                
                task.spawn(function()
                    for _, tree in pairs(workspace.Map.Landmarks:GetChildren()) do
                        if tree:IsA("Model") and (tree.Name == "Small Tree" or tree.Name == "TreeBig1" or tree.Name == "TreeBig2") and tree.PrimaryPart then
                            local distance = (tree.PrimaryPart.Position - hrp.Position).Magnitude
                            if distance <= DistanceForAutoChopTree and weapon then
                                game:GetService("ReplicatedStorage").RemoteEvents.ToolDamageObject:InvokeServer(tree, weapon, 999, hrp.CFrame)
                            end
                        end
                    end
                end)
                
                task.wait(0.1)
            end
        end)
    end
})
Main:Section({Title = "小孩"})

local LocalPlayer = game:GetService("Players").LocalPlayer

local originalPositions = {}
local teleportingEnabled = false
local teleportationThread = nil

Main:Toggle({
    Title = "自动救所有小孩",
    Value = false,
    Callback = function(value)
        teleportingEnabled = value
        
        if value then
          
            for _, kid in pairs(workspace:GetDescendants()) do
                if kid:IsA("Model") and kid.Name:lower():find("kid") then
                    originalPositions[kid] = kid:GetPivot()
                end
            end
            
            
            teleportationThread = task.spawn(function()
                while teleportingEnabled and task.wait(1) do
                    for _, kid in pairs(workspace:GetDescendants()) do
                        if not teleportingEnabled then break end
                        
                        if kid:IsA("Model") and kid.Name:lower():find("kid") then
                            LocalPlayer.Character:PivotTo(kid:GetPivot())
                            task.wait(20) 
                        end
                    end
                end
            end)
        else
         
            if teleportationThread then
                task.cancel(teleportationThread)
                teleportationThread = nil
            end
        end
    end
})



local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local AutoEquip = Window:Tab({Title = "自动装备", Icon = "user"})

local toolsDamageIDs = {
    ["Old Axe"] = "3_7367831688",
    ["Good Axe"] = "112_7367831688",
    ["Strong Axe"] = "116_7367831688",
    ["Chainsaw"] = "647_8992824875",
    ["Infernal Sword"] = "2_4340578793",
    ["Spear"] = "196_8999010016"
}

local function getAnyToolWithDamageID(isChopAura)
    for toolName, damageID in pairs(toolsDamageIDs) do
        if isChopAura and toolName ~= "Old Axe" and toolName ~= "Good Axe" and toolName ~= "Strong Axe" then
            continue
        end
        local tool = LocalPlayer:FindFirstChild("Inventory") and LocalPlayer.Inventory:FindFirstChild(toolName)
        if tool then
            return tool, damageID
        end
    end
    return nil, nil
end
local function equipTool(tool)
    if tool then
        ReplicatedStorage:WaitForChild("RemoteEvents").EquipItemHandle:FireServer("FireAllClients", tool)
    end
end

local function unequipTool(tool)
    if tool then
        ReplicatedStorage:WaitForChild("RemoteEvents").UnequipItemHandle:FireServer("FireAllClients", tool)
    end
end

AutoEquip:Section({ Title = "自动装备武器", Icon = "user" })

local autoEquipWeapon = false
local weaponEquipConnection

AutoEquip:Toggle({
    Title = "自动装备最佳武器",
    Value = false,
    Callback = function(state)
        autoEquipWeapon = state
        if weaponEquipConnection then
            weaponEquipConnection:Disconnect()
            weaponEquipConnection = nil
        end
        
        if state then
            weaponEquipConnection = RunService.Heartbeat:Connect(function()
                local character = LocalPlayer.Character
                if not character then return end
                
             
                local bestTool = nil
                local bestDamage = 0
                
                for toolName, damageID in pairs(toolsDamageIDs) do
                    local tool = LocalPlayer:FindFirstChild("Inventory") and LocalPlayer.Inventory:FindFirstChild(toolName)
                    if tool then
                   
                        local damage = tonumber(damageID:match("^(%d+)_")) or 0
                        if damage > bestDamage then
                            bestDamage = damage
                            bestTool = tool
                        end
                    end
                end
                
              
                if bestTool then
                    equipTool(bestTool)
                end
            end)
        else
           
            local tool, _ = getAnyToolWithDamageID(false)
            unequipTool(tool)
        end
    end
})

local selectedWeapon = "Strong Axe"

AutoEquip:Dropdown({
    Title = "选择要装备的武器",
    Values = {"Old Axe", "Good Axe", "Strong Axe", "Chainsaw", "Infernal Sword", "Spear"},
    Value = "Strong Axe",
    Callback = function(option)
        selectedWeapon = option
    end
})

local autoEquipSpecific = false
local specificEquipConnection

AutoEquip:Toggle({
    Title = "自动装备选定武器",
    Value = false,
    Callback = function(state)
        autoEquipSpecific = state
        if specificEquipConnection then
            specificEquipConnection:Disconnect()
            specificEquipConnection = nil
        end
        
        if state then
            specificEquipConnection = RunService.Heartbeat:Connect(function()
                local character = LocalPlayer.Character
                if not character then return end
                
                local tool = LocalPlayer:FindFirstChild("Inventory") and LocalPlayer.Inventory:FindFirstChild(selectedWeapon)
                if tool then
                    equipTool(tool)
                else
                    WindUI:Notify({
                        Title = "武器未找到",
                        Content = selectedWeapon .. " 不在背包中",
                        Duration = 3,
                        Icon = "alert-circle"
                    })
                    autoEquipSpecific = false
                    AutoEquip:Find("自动装备选定武器"):SetValue(false)
                end
            end)
        else
            local tool = LocalPlayer:FindFirstChild("Inventory") and LocalPlayer.Inventory:FindFirstChild(selectedWeapon)
            unequipTool(tool)
        end
    end
})
AutoEquip:Section({ Title = "工具切换", Icon = "refresh-cw" })

local autoToolSwitch = false
local toolSwitchConnection

AutoEquip:Toggle({
    Title = "随机工具切换",
    Value = false,
    Callback = function(state)
        autoToolSwitch = state
        if toolSwitchConnection then
            toolSwitchConnection:Disconnect()
            toolSwitchConnection = nil
        end
        
        if state then
            toolSwitchConnection = RunService.Heartbeat:Connect(function()
                local character = LocalPlayer.Character
                if not character then return end
                
                local hrp = character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                
              
                local hasEnemyNearby = false
                for _, mob in ipairs(Workspace.Characters:GetChildren()) do
                    if mob:IsA("Model") then
                        local part = mob:FindFirstChildWhichIsA("BasePart")
                        if part and (part.Position - hrp.Position).Magnitude <= 50 then
                            hasEnemyNearby = true
                            break
                        end
                    end
                end
                
             
                local hasTreeNearby = false
                local map = Workspace:FindFirstChild("Map")
                if map then
                    local trees = {}
                    if map:FindFirstChild("Foliage") then
                        for _, obj in ipairs(map.Foliage:GetChildren()) do
                            if obj:IsA("Model") and (obj.Name == "Small Tree" or obj.Name == "Snowy Small Tree") then
                                table.insert(trees, obj)
                            end
                        end
                    end
                    if map:FindFirstChild("Landmarks") then
                        for _, obj in ipairs(map.Landmarks:GetChildren()) do
                            if obj:IsA("Model") and obj.Name == "Small Tree" then
                                table.insert(trees, obj)
                            end
                        end
                    end
                    
                    for _, tree in ipairs(trees) do
                        local trunk = tree:FindFirstChild("Trunk")
                        if trunk and trunk:IsA("BasePart") and (trunk.Position - hrp.Position).Magnitude <= 50 then
                            hasTreeNearby = true
                            break
                        end
                    end
                end
                
            
                if hasEnemyNearby then
                   
                    local combatTools = {"Infernal Sword", "Spear", "Chainsaw", "Strong Axe", "Good Axe"}
                    for _, toolName in ipairs(combatTools) do
                        local tool = LocalPlayer:FindFirstChild("Inventory") and LocalPlayer.Inventory:FindFirstChild(toolName)
                        if tool then
                            equipTool(tool)
                            break
                        end
                    end
                elseif hasTreeNearby then
                
                    local loggingTools = {"Chainsaw", "Strong Axe", "Good Axe", "Old Axe"}
                    for _, toolName in ipairs(loggingTools) do
                        local tool = LocalPlayer:FindFirstChild("Inventory") and LocalPlayer.Inventory:FindFirstChild(toolName)
                        if tool then
                            equipTool(tool)
                            break
                        end
                    end
                else
                  
                    local bestTool = nil
                    local bestDamage = 0
                    
                    for toolName, damageID in pairs(toolsDamageIDs) do
                        local tool = LocalPlayer:FindFirstChild("Inventory") and LocalPlayer.Inventory:FindFirstChild(toolName)
                        if tool then
                            local damage = tonumber(damageID:match("^(%d+)_")) or 0
                            if damage > bestDamage then
                                bestDamage = damage
                                bestTool = tool
                            end
                        end
                    end
                    
                    if bestTool then
                        equipTool(bestTool)
                    end
                end
            end)
        else
          
            local tool, _ = getAnyToolWithDamageID(false)
            unequipTool(tool)
        end
    end
})

local Main = Window:Tab({Title = "种植", Icon = "user"})

local plantingConfig = {
    shape = "square",  
    size = 80,        
    height = 3,     
    spacing = 1,       
    delay = 1          
}

local shapeOptions = {
    ["正方形"] = "square",
    ["圆形"] = "circle",
    ["原地"] = "original"
}
local function generatePlantPositions()
    local positions = {}
    local halfSize = plantingConfig.size / 2
    local playerPosition = Vector3.new(0.6491832137107849, plantingConfig.height, -3.8000376224517822)
    
    if plantingConfig.shape == "square" then
     
        positions = {}
        
       
        
        for x = -halfSize, halfSize, plantingConfig.spacing do
            table.insert(positions, Vector3.new(playerPosition.X + x, playerPosition.Y, playerPosition.Z + halfSize))
        end
        
      
        for z = halfSize, -halfSize, -plantingConfig.spacing do
            table.insert(positions, Vector3.new(playerPosition.X + halfSize, playerPosition.Y, playerPosition.Z + z))
        end
        
        
        for x = halfSize, -halfSize, -plantingConfig.spacing do
            table.insert(positions, Vector3.new(playerPosition.X + x, playerPosition.Y, playerPosition.Z - halfSize))
        end
        
  
        for z = -halfSize, halfSize, plantingConfig.spacing do
            table.insert(positions, Vector3.new(playerPosition.X - halfSize, playerPosition.Y, playerPosition.Z + z))
        end
    elseif plantingConfig.shape == "circle" then
       
        positions = {}
        
    
        local radius = halfSize
        local circumference = 2 * math.pi * radius
        local pointCount = math.floor(circumference / plantingConfig.spacing)
        
        for i = 1, pointCount do
            local angle = (i / pointCount) * 2 * math.pi
            local x = radius * math.cos(angle)
            local z = radius * math.sin(angle)
            table.insert(positions, Vector3.new(playerPosition.X + x, playerPosition.Y, playerPosition.Z + z))
        end
    else
     
        positions = {}
        
      
        table.insert(positions, Vector3.new(playerPosition.X, playerPosition.Y, playerPosition.Z))
    end
    
    return positions
end

local saplingPositions = generatePlantPositions()
local currentSaplingIndex = 1
local isPlanting = false

local function plantSapling()
    if isPlanting then return false end
    isPlanting = true
    
    local success = false
    local remoteEvents = game:GetService("ReplicatedStorage").RemoteEvents
    local tempStorage = game:GetService("ReplicatedStorage").TempStorage
    
    local sapling = tempStorage:FindFirstChild("Sapling")
    if not sapling then
        sapling = workspace.Items:FindFirstChild("Sapling")
    end
    
    if sapling then
        local plantPosition = saplingPositions[currentSaplingIndex]
        
        pcall(function()
            remoteEvents.StopDraggingItem:FireServer(sapling)
            task.wait(0.1)
            remoteEvents.RequestPlantItem:InvokeServer(sapling, plantPosition)
            success = true
        end)
        
        currentSaplingIndex = currentSaplingIndex + 1
        if currentSaplingIndex > #saplingPositions then
            currentSaplingIndex = 1
        end
    end
    
    isPlanting = false
    return success
end

Main:Dropdown({
    Title = "种植形状",
    Values = {"正方形", "圆形", "原地"},
    Value = "正方形",
    Callback = function(option)
        plantingConfig.shape = shapeOptions[option]
        saplingPositions = generatePlantPositions()
        currentSaplingIndex = 1
    end
})

Main:Input({
    Title = "种植范围(米)",
    Desc = "设置种植范围大小",
    Value = tostring(plantingConfig.size),
    Placeholder = "输入范围大小",
    Callback = function(input)
        local num = tonumber(input)
        if num and num > 0 then
            plantingConfig.size = num
            saplingPositions = generatePlantPositions()
            currentSaplingIndex = 1
        end
    end
})

Main:Input({
    Title = "种植高度",
    Desc = "设置种植高度",
    Value = tostring(plantingConfig.height),
    Placeholder = "输入高度",
    Callback = function(input)
        local num = tonumber(input)
        if num then
            plantingConfig.height = num
            saplingPositions = generatePlantPositions()
            currentSaplingIndex = 1
        end
    end
})

Main:Input({
    Title = "树苗间隔(米)",
    Desc = "设置树苗之间的间隔[推荐2.5]",
    Value = tostring(plantingConfig.spacing),
    Placeholder = "输入间隔距离",
    Callback = function(input)
        local num = tonumber(input)
        if num and num > 0 then
            plantingConfig.spacing = num
            saplingPositions = generatePlantPositions()
            currentSaplingIndex = 1
        end
    end
})

Main:Input({
    Title = "种植延迟(秒)",
    Desc = "设置每次种植的延迟时间",
    Value = tostring(plantingConfig.delay),
    Placeholder = "输入延迟时间",
    Callback = function(input)
        local num = tonumber(input)
        if num and num > 0 then
            plantingConfig.delay = num
        end
    end
})

local plantLoop = nil

Main:Toggle({
    Title = "自动种植",
    Default = false,
    Callback = function(state)
        if plantLoop then
            plantLoop:Disconnect()
            plantLoop = nil
        end
        
        if state then
            plantLoop = game:GetService("RunService").Heartbeat:Connect(function()
                local planted = plantSapling()
                if not planted then
                    task.wait(1)
                else
                    task.wait(plantingConfig.delay)
                end
            end)
        end
    end
})

local Main = Window:Tab({Title = "趣味玩法", Icon = "user"})
local teleportConfig = {
    pattern = "sphere",  
    speed = 5,        
    radius = 75,       
    height = 100       
}

local patternOptions = {
    ["球形"] = "sphere",
    ["项链"] = "star",
    ["流星"] = "meteor"
}

local centerPosition = Vector3.new(0.6491832137107849, teleportConfig.height, -3.8000376224517822)
local rotationAngle = 0
local teleporting = false
local function generatePatternPositions(itemCount)
    local positions = {}
    rotationAngle = rotationAngle + teleportConfig.speed * 0.01
    
    if teleportConfig.pattern == "sphere" then
      
        for i = 1, itemCount do
            local phi = math.acos(-1 + (2 * i - 1) / itemCount)
            local theta = math.sqrt(itemCount * math.pi) * phi
            
            local x = teleportConfig.radius * math.cos(theta + rotationAngle) * math.sin(phi)
            local y = teleportConfig.radius * math.sin(theta + rotationAngle) * math.sin(phi)
            local z = teleportConfig.radius * math.cos(phi)
            
            table.insert(positions, centerPosition + Vector3.new(x, y, z))
        end
    elseif teleportConfig.pattern == "star" then
       
        local points = 5
        for i = 1, itemCount do
            local angle = (i / itemCount) * math.pi * 2 * points + rotationAngle
            local radius = teleportConfig.radius * (i % 2 == 0 and 0.5 or 1)
            
            local x = radius * math.cos(angle)
            local z = radius * math.sin(angle)
            
            table.insert(positions, centerPosition + Vector3.new(x, 0, z))
        end
    elseif teleportConfig.pattern == "meteor" then
       
        for i = 1, itemCount do
            local angle = (i / itemCount) * math.pi * 2 + rotationAngle
            local x = teleportConfig.radius * math.cos(angle)
            local z = teleportConfig.radius * math.sin(angle)
            local y = teleportConfig.radius * 0.5 * math.sin(angle * 2)
            
            table.insert(positions, centerPosition + Vector3.new(x, y, z))
        end
    end
    
    return positions
end

local function teleportLogs()
    if teleporting then return end
    teleporting = true
    
    local logs = {}
    for _, item in pairs(workspace.Items:GetChildren()) do
        if item.Name:lower():find("log") and item:IsA("Model") then
            table.insert(logs, item)
        end
    end
    
    if #logs > 0 then
        local positions = generatePatternPositions(#logs)
        
        for i, log in ipairs(logs) do
            local main = log:FindFirstChildWhichIsA("BasePart")
            if main then
                local targetPos = positions[i] or positions[1]
                main.CFrame = CFrame.new(targetPos)
                main.AssemblyLinearVelocity = Vector3.new(0, 0, 0)  
            end
        end
    end
    
    teleporting = false
end

Main:Dropdown({
    Title = "选择图案",
    Values = {"球形", "项链", "流星"},
    Value = "球形",
    Callback = function(option)
        teleportConfig.pattern = patternOptions[option]
    end
})

Main:Input({
    Title = "旋转速度",
    Desc = "设置旋转速度",
    Value = tostring(teleportConfig.speed),
    Placeholder = "输入旋转速度",
    Callback = function(input)
        local num = tonumber(input)
        if num and num >= 1 and num <= 10 then
            teleportConfig.speed = num
        end
    end
})

Main:Input({
    Title = "图案大小",
    Desc = "设置图案大小",
    Value = tostring(teleportConfig.radius),
    Placeholder = "输入图案大小",
    Callback = function(input)
        local num = tonumber(input)
        if num and num >= 10 and num <= 50 then
            teleportConfig.radius = num
        end
    end
})

local teleportLoop = nil

Main:Toggle({
    Title = "自动形成图案",
    Default = false,
    Callback = function(state)
        if teleportLoop then
            teleportLoop:Disconnect()
            teleportLoop = nil
        end
        
        if state then
            teleportLoop = game:GetService("RunService").Heartbeat:Connect(function()
                teleportLogs()
            end)
        end
    end
})

local Main = Window:Tab({Title = "恶搞朋友", Icon = "user"})
local autoUseBearTrap = false
local selectedTrapPlayer = "无"
local trapPlayerList = {"无"}
local trapDropdownRef = nil

local function updateTrapPlayerList()
    local currentPlayers = game.Players:GetPlayers()
    local newPlayerList = {"无"}
    
    for _, player in ipairs(currentPlayers) do
        if player ~= game.Players.LocalPlayer then
            table.insert(newPlayerList, player.Name)
        end
    end
    
    trapPlayerList = newPlayerList
    
    if trapDropdownRef then
        trapDropdownRef:Refresh(trapPlayerList, true)
    end
    
    if selectedTrapPlayer and selectedTrapPlayer ~= "无" and not table.find(trapPlayerList, selectedTrapPlayer) then
        WindUI:Notify({
            Title = "NE提示",
            Content = "目标玩家："..selectedTrapPlayer.." 已退出服务器",
            Duration = 5,
        })
        selectedTrapPlayer = "无"
        if trapDropdownRef then
            trapDropdownRef:Set("无")
        end
    end
end

game.Players.PlayerAdded:Connect(updateTrapPlayerList)
game.Players.PlayerRemoving:Connect(function(player)
    if selectedTrapPlayer and selectedTrapPlayer ~= "无" and player.Name == selectedTrapPlayer then
        WindUI:Notify({
            Title = "NE提示",
            Content = "目标玩家："..selectedTrapPlayer.." 已退出服务器",
            Duration = 5,
        })
    end
    updateTrapPlayerList()
end)

updateTrapPlayerList()

trapDropdownRef = Main:Dropdown({
    Title = "选择攻击玩家",
    Values = trapPlayerList,
    Value = "无",
    Callback = function(option)
        selectedTrapPlayer = option
    end
})

Main:Toggle({
    Title = "自动捕兽夹攻击",
    Default = false,
    Callback = function(Value)
        autoUseBearTrap = Value
        task.spawn(function()
            while autoUseBearTrap and task.wait() do
                if selectedTrapPlayer == "无" then
                    WindUI:Notify({
                        Title = "捕提示",
                        Content = "请先选择要的玩家",
                        Duration = 3,
                    })
                    autoUseBearTrap = false
                    break
                end
                
                local targetPlayer = game.Players:FindFirstChild(selectedTrapPlayer)
                if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    continue
                end
                
                local targetHRP = targetPlayer.Character.HumanoidRootPart
                local targetPosition = targetHRP.Position + Vector3.new(0, 1, 0)
                
                local bearTraps = {}
                
                for _, structure in pairs(workspace.Structures:GetChildren()) do
                    if structure.Name:find("Bear Trap") and structure:IsA("Model") then
                        table.insert(bearTraps, structure)
                    end
                end
                
                for _, item in pairs(workspace.Items:GetChildren()) do
                    if item.Name:find("Bear Trap") and item:IsA("Model") then
                        table.insert(bearTraps, item)
                    end
                end
                
                if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Entities") then
                    for _, entity in pairs(workspace.Game.Entities:GetChildren()) do
                        if entity.Name:find("Bear Trap") and entity:IsA("Model") then
                            table.insert(bearTraps, entity)
                        end
                    end
                end
                
                if #bearTraps > 0 then
                    for _, bearTrap in pairs(bearTraps) do
                        if not autoUseBearTrap then break end
                        
                        if not bearTrap.PrimaryPart then
                            for _, part in pairs(bearTrap:GetChildren()) do
                                if part:IsA("BasePart") then
                                    bearTrap.PrimaryPart = part
                                    break
                                end
                            end
                        end
                        
                        if bearTrap.PrimaryPart then
                            pcall(function()
                                local args = {[1] = bearTrap}
                                game:GetService("ReplicatedStorage").RemoteEvents.RequestStartDraggingItem:FireServer(unpack(args))
                                bearTrap:SetPrimaryPartCFrame(CFrame.new(targetPosition))
                                game:GetService("ReplicatedStorage").RemoteEvents.StopDraggingItem:FireServer(bearTrap)
                                local setArgs = {[1] = bearTrap}
                                game:GetService("ReplicatedStorage").RemoteEvents.RequestSetTrap:FireServer(unpack(setArgs))
                            end)
                        end
                    end
                end
            end
        end)
    end
})


local Hitbox = Window:Tab({Title = "打击盒", Icon = "user"})
local hitboxSettings = {
    Wolf = false,
    Bunny = false,
    Cultist = false,
    All = false,
    Show = false,
    Size = 10
}
local originalSizes = {}

local function updateHitboxForModel(model)
    local root = model:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local name = model.Name:lower()
    if not originalSizes[model] then
        originalSizes[model] = root.Size
    end

    local shouldResize = hitboxSettings.All or
        (hitboxSettings.Wolf and (name:find("wolf") or name:find("alpha"))) or
        (hitboxSettings.Bunny and name:find("bunny")) or
        (hitboxSettings.Cultist and (name:find("cultist") or name:find("cross")))

    if shouldResize and hitboxSettings.Show then
        root.Size = Vector3.new(hitboxSettings.Size, hitboxSettings.Size, hitboxSettings.Size)
        root.Transparency = 0.5
        root.Color = Color3.fromRGB(255, 255, 255)
        root.Material = Enum.Material.Neon
        root.CanCollide = false
    else
        if originalSizes[model] then
            root.Size = originalSizes[model]
        end
        root.Transparency = 1
        root.Material = Enum.Material.Plastic
        root.CanCollide = true
    end
end
workspace.DescendantRemoving:Connect(function(descendant)
    if descendant:IsA("Model") and originalSizes[descendant] then
        originalSizes[descendant] = nil
    end
end)

task.spawn(function()
    while true do
        for _, model in ipairs(workspace:GetDescendants()) do
            if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") then
                updateHitboxForModel(model)
            end
        end
        task.wait(1) 
    end
end)

Hitbox:Toggle({
    Title = "显示打击盒",
    Default = false,
    Callback = function(v)
        hitboxSettings.Show = v
    end
})

Hitbox:Toggle({
    Title = "狼打击盒",
    Default = false,
    Callback = function(v)
        hitboxSettings.Wolf = v
    end
})

Hitbox:Toggle({
    Title = "兔子打击盒",
    Default = false,
    Callback = function(v)
        hitboxSettings.Bunny = v
    end
})

Hitbox:Toggle({
    Title = "邪教徒打击盒",
    Default = false,
    Callback = function(v)
        hitboxSettings.Cultist = v
    end
})

Hitbox:Toggle({
    Title = "所有东西打击盒",
    Default = false,
    Callback = function(v)
        hitboxSettings.All = v
    end
})

Hitbox:Slider({
    Title = "范围大小",
    Desc = "滑动调整",
    Value = {
        Min = 2,
        Max = 250,
        Default = 10,
    },
    Callback = function(Value)
        hitboxSettings.Size = Value
    end
})


local Main = Window:Tab({Title = "食物", Icon = "user"})
Main:Section({Title = "收集食物"})
local foodItems = {
    ["生肉块"]   = "Morsel",
    ["生牛排"]   = "Steak",
    ["熟肉块"]   = "Cooked Morsel",
    ["熟牛排"]   = "Cooked Steak"
}

local selectedItems = {}

Main:Dropdown({
    Title  = "选择要收集的食物（多选）",
    Values = {"生肉块", "生牛排", "熟肉块", "熟牛排"},
    Value  = {},
    Multi  = true,
    Callback = function(options)
        selectedItems = {}
        for _, option in ipairs(options) do
            selectedItems[foodItems[option]] = true
        end
    end
})

local autoCollectAndDropLogs = false
local collectDelay = 0.01

local positionOptions = {
    ["原地"] = nil, 
    ["火堆"] = Vector3.new(1.4, 25.9, -0.9)
}

local selectedPosition = positionOptions["火堆"]

Main:Dropdown({
    Title = "选择位置",
    Values = {"原地", "火堆"},
    Value = "火堆",
    Callback = function(option)
        selectedPosition = positionOptions[option]
    end
})

local function fixPlayerPosition()
    local player = game:GetService("Players").LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition
        if selectedPosition then
            targetPosition = selectedPosition
        else
     
            targetPosition = player.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
        end
        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
        player.Character.HumanoidRootPart.Anchored = true
    end
end

local function CollectAndDropLogs()
    if not autoCollectAndDropLogs then return end
    if not next(selectedItems) then return end
    
    local player = game:GetService("Players").LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    fixPlayerPosition()
    local hrp = player.Character.HumanoidRootPart
    
    local items = {}
    for _, item in pairs(workspace.Items:GetChildren()) do
        if selectedItems[item.Name] and item:IsA("Model") then
            table.insert(items, item)
        end
    end

    table.sort(items, function(a, b)
        local aPart = a.PrimaryPart or a:FindFirstChildWhichIsA("BasePart")
        local bPart = b.PrimaryPart or b:FindFirstChildWhichIsA("BasePart")
        if not aPart or not bPart then return false end
        return (hrp.Position - aPart.Position).Magnitude < (hrp.Position - bPart.Position).Magnitude
    end)

    for _, item in ipairs(items) do
        if not autoCollectAndDropLogs then break end
        
        local itemPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
        if not itemPart then continue end
        
        itemPart.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 0, 2))
        task.wait(0.05)
        
        game:GetService("ReplicatedStorage").RemoteEvents.RequestStartDraggingItem:FireServer(item)
        task.wait(0.05)
        
        game:GetService("ReplicatedStorage").RemoteEvents.ReplicateSound:FireServer(
            "FireAllClients",
            "BagGet",
            {
                ["Instance"] = player.Character.Head,
                ["Volume"] = 0.25
            }
        )
        
        game:GetService("ReplicatedStorage").RemoteEvents.StopDraggingItem:FireServer(item)
        
        task.wait(collectDelay)
    end
end

Main:Toggle({
    Title = "自动扔选择的食物",
    Value = false,
    Callback = function(value)
        autoCollectAndDropLogs = value
        if value then
            fixPlayerPosition()
            spawn(function()
                while autoCollectAndDropLogs do
                    CollectAndDropLogs()
                    task.wait(0.1)
                end
            end)
        else
            local player = game:GetService("Players").LocalPlayer
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.Anchored = false
            end
        end
    end
})


Main:Section({Title = "远程烤肉"})

local function getNil(name, class)
    for _, v in pairs(getnilinstances()) do
        if v.ClassName == class and v.Name == name then
            return v
        end
    end
end

local autoCook = false
local selectedMeats = {} 

local function cookItem(itemName)
    local fire = workspace.Map.Campground.MainFire
    local item = workspace.Items:FindFirstChild(itemName) or getNil(itemName, "Model")
    
    if fire and item then
        local args = {fire, item}
        game:GetService("ReplicatedStorage").RemoteEvents.RequestCookItem:FireServer(unpack(args))
        return true
    end
    return false
end

local function CookItems()
    if not autoCook then return end
    
  
    for meatName, selected in pairs(selectedMeats) do
        if selected then
            cookItem(meatName)
        end
    end
end

local meatOptions = {
    ["肉块"] = "Morsel",
    ["牛排"] = "Steak"
   
}

Main:Dropdown({
    Title = "选择肉类 (多选)",
    Values = {"肉块", "牛排"},
    Value = {}, 
    Multi = true, 
    Callback = function(selectedOptions)
        selectedMeats = {}
        for _, optionName in pairs(selectedOptions) do
            local meatKey = meatOptions[optionName]
            if meatKey then
                selectedMeats[meatKey] = true
            end
        end
    end
})

Main:Toggle({
    Title = "远程烤选择的肉",
    Value = false,
    Callback = function(value)
        autoCook = value
        if value then
            spawn(function()
                while autoCook do
                    CookItems()
                    task.wait() 
                end
            end)
        end
    end
})
local autocookItems = {"Morsel", "Steak", "Ribs", "Salmon", "Mackerel"}
local autocookItemsDisplay = {"肉块", "牛排", "肋骨", "三文鱼", "鲭鱼"} 
local autoCookEnabledItems = {}
local autoCookEnabled = false
local cookItemMapping = {
    ["肉块"] = "Morsel",
    ["牛排"] = "Steak", 
    ["肋骨"] = "Ribs",
    ["三文鱼"] = "Salmon",
    ["鲭鱼"] = "Mackerel"
}

Main:Section({ Title = "自动烹饪食物", Icon = "user" })

Main:Dropdown({
    Title = "选择烹饪食物",
    Values = autocookItemsDisplay, 
    Multi = true,
    AllowNone = true,
    Callback = function(options)
        for itemName, _ in pairs(autoCookEnabledItems) do
            autoCookEnabledItems[itemName] = false
        end
        for _, chineseName in ipairs(options) do
            local englishName = cookItemMapping[chineseName]
            if englishName then
                autoCookEnabledItems[englishName] = true
            end
        end
    end
})

Main:Toggle({
    Title = "自动烹饪食物",
    Value = false,
    Callback = function(state)
        autoCookEnabled = state
        if state then
            WindUI:Notify({
                Title = "自动烹饪已开启",
                Content = "开始自动烹饪选择的食物",
                Duration = 2,
                Icon = "flame"
            })
        else
            WindUI:Notify({
                Title = "自动烹饪已关闭", 
                Content = "停止自动烹饪食物",
                Duration = 2,
                Icon = "flame"
            })
        end
    end
})
coroutine.wrap(function()
    while true do
        if autoCookEnabled then
            for itemName, enabled in pairs(autoCookEnabledItems) do
                if enabled then
                    for _, item in ipairs(Workspace:WaitForChild("Items"):GetChildren()) do
                        if item.Name == itemName then
                            moveItemToPos(item, campfireDropPos)
                        end
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)()


Main:Section({Title = "吃食物"})

local alimentos = {
    "Apple", "Berry", "Carrot", "Cake", "Chili", 
    "Cooked Ribs", "Cooked Mackerel", "Cooked Salmon", 
    "Cooked Morsel", "Cooked Steak"
}
local selectedFood = {}
local hungerThreshold = 75
local autoFeedToggle = false

Main:Dropdown({
    Title = "选择食物",
    Desc = "选择要自动食用的食物",
    Values = alimentos,
    Value = selectedFood,
    Multi = true,
    Callback = function(value)
        selectedFood = value
    end
})

Main:Input({
    Title = "饥饿阈值",
    Desc = "当饥饿度低于此值时自动进食",
    Value = tostring(hungerThreshold),
    Placeholder = "例如: 50",
    Numeric = true,
    Callback = function(value)
        local n = tonumber(value)
        if n then
            hungerThreshold = math.clamp(n, 0, 100)
        end
    end
})

Main:Toggle({
    Title = "自动进食",
    Value = false,
    Callback = function(state)
        autoFeedToggle = state
        if state then
            task.spawn(function()
                while autoFeedToggle do
                    task.wait(0.1)
                    local function wiki(nome)
                        local c = 0
                        for _, i in ipairs(Workspace.Items:GetChildren()) do
                            if i.Name == nome then
                                c = c + 1
                            end
                        end
                        return c
                    end
                    
                    local function ghn()
                        return math.floor(LocalPlayer.PlayerGui.Interface.StatBars.HungerBar.Bar.Size.X.Scale * 100)
                    end
                    
                    local function feed(nome)
                        for _, item in ipairs(Workspace.Items:GetChildren()) do
                            if item.Name == nome then
                                ReplicatedStorage.RemoteEvents.RequestConsumeItem:InvokeServer(item)
                                break
                            end
                        end
                    end
                    
                    if #selectedFood > 0 then
                        for _, food in ipairs(selectedFood) do
                            if wiki(food) == 0 then
                                autoFeedToggle = false
                                WindUI:Notify({
                                    Title = "自动进食暂停",
                                    Content = food .. " 已耗尽",
                                    Duration = 3
                                })
                                break
                            end
                            if ghn() <= hungerThreshold then
                                feed(food)
                            end
                        end
                    end
                end
            end)
        end
    end
})

local Safety = Window:Tab({Title = "防鹿", Icon = "user"})

Safety:Toggle({
    Title = "自动眩晕鹿",
    Desc = "需要手电筒",
    Value = false,
    Callback = function(state)
        if state then
            local torchLoop = RunService.RenderStepped:Connect(function()
                pcall(function()
                    local remote = ReplicatedStorage:FindFirstChild("RemoteEvents")
                        and ReplicatedStorage.RemoteEvents:FindFirstChild("DeerHitByTorch")
                    local deer = Workspace:FindFirstChild("Characters")
                        and Workspace.Characters:FindFirstChild("Deer")
                    if remote and deer then
                        remote:InvokeServer(deer)
                    end
                end)
                task.wait(0.1)
            end)
        else
            if torchLoop then
                torchLoop:Disconnect()
                torchLoop = nil
            end
        end
    end
})
local Main = Window:Tab({Title = "钓鱼", Icon = "user"})

Main:Toggle({
    Title = "自动钓鱼",
    Value = false,
    Callback = function(value)
        autoFishingEnabled = value
        if value then
            spawn(function()
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local player = Players.LocalPlayer
                local playerGui = player:WaitForChild("PlayerGui")
                
                task.wait(1)
                
                local fishingCatchFrame = playerGui.Interface.FishingCatchFrame
                local timingBar = fishingCatchFrame.TimingBar
                local successArea = timingBar.SuccessArea
                local bar = timingBar.Bar
                local button = playerGui.MobileButtons.Frame.Button3
                local canClick = true
                
                local function checkOverlap(f1, f2)
                    local p1 = f1.AbsolutePosition
                    local s1 = f1.AbsoluteSize
                    local p2 = f2.AbsolutePosition
                    local s2 = f2.AbsoluteSize
                    
                    return not (
                        p1.X + s1.X < p2.X or
                        p2.X + s2.X < p1.X or
                        p1.Y + s1.Y < p2.Y or
                        p2.Y + s2.Y < p1.Y
                    )
                end
                
                local function clickButton()
                    for _, connection in pairs(getconnections(button.MouseButton1Down)) do
                        connection:Fire()
                    end
                end
                
                while autoFishingEnabled do
                    if fishingCatchFrame.Visible and timingBar.Visible then
                        if checkOverlap(successArea, bar) and canClick then
                            canClick = false
                            clickButton()
                            task.wait(0.1)
                            canClick = true
                        end
                    else
                        canClick = true
                    end
                    wait(0)
                end
            end)
        end
    end
})
Main:Toggle({
    Title = "无延迟钓鱼",
    Value = false,
    Callback = function(value)
        noDelayFishing = value
        if value then
            spawn(function()
                local Players = game:GetService("Players")
                local player = Players.LocalPlayer
                local playerGui = player:WaitForChild("PlayerGui")
                
                task.wait(1)
                
                local button = playerGui.MobileButtons.Frame.Button3
                
                local function clickButton()
                    for _, connection in pairs(getconnections(button.MouseButton1Down)) do
                        connection:Fire()
                    end
                end
                
                while noDelayFishing do
             
                    if playerGui.Interface.FishingCatchFrame.Visible then
                        clickButton()
                    end
                    wait(0)
                end
            end)
        end
    end
})
Main:Toggle({
    Title = "秒钓鱼",
    Value = false,
    Callback = function(value)
        instantFishing = value
        if value then
            spawn(function()
                local Players = game:GetService("Players")
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local player = Players.LocalPlayer
                
                while instantFishing do
          
                    pcall(function()
                        local remote = ReplicatedStorage:FindFirstChild("RemoteEvents")
                        if remote then
                            local finishFishing = remote:FindFirstChild("FinishFishing")
                            if finishFishing then
                                finishFishing:FireServer(true) 
                            end
                        end
                    end)
                    wait(0.1) 
                end
            end)
        end
    end
})



local Main = Window:Tab({Title = "工作台", Icon = "user"})

Main:Section({Title = "钢材"})

local steelItems = {
    ["螺栓"]            = "Bolt",
    ["破风扇"]          = "Broken Fan",
    ["坏微波炉"]        = "Broken Microwave",
    ["旧收音机"]        = "Old Radio",
    ["洗衣机"]          = "Washing Machine",
    ["旧汽车引擎"]      = "Old Car Engine",
    ["轮胎"]            = "tyre",
    ["金属板"]          = "Sheet Metal"
}

local dropPositions = {
    ["工作台"] = Vector3.new(21.67, 6.34, -4.05),
    ["火堆"] = Vector3.new(3.04, 11.70, 1.01)
}

local selectedItems = {}
local selectedDropPosition = dropPositions["工作台"] 

Main:Dropdown({
    Title = "选择要收集的钢铁类物品（多选）",
    Values = {"螺栓", "破风扇", "坏微波炉", "旧收音机", "洗衣机", "旧汽车引擎", "轮胎", "金属板"},
    Value = {},
    Multi = true,
    Callback = function(options)
        selectedItems = {}
        for _, option in ipairs(options) do
            selectedItems[steelItems[option]] = true
        end
    end
})

local autoCollectAndDropLogs = false
local collectDelay = 0.01

local positionOptions = {
    ["原地"] = nil, 
    ["工作台"] = Vector3.new(19.4, 15.0, -5.5)
}

local selectedPosition = positionOptions["工作台"]

Main:Dropdown({
    Title = "选择位置",
    Values = {"原地", "工作台"},
    Value = "工作台",
    Callback = function(option)
        selectedPosition = positionOptions[option]
    end
})

local function fixPlayerPosition()
    local player = game:GetService("Players").LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition
        if selectedPosition then
            targetPosition = selectedPosition
        else
         
            targetPosition = player.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
        end
        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
        player.Character.HumanoidRootPart.Anchored = true
    end
end

local function CollectAndDropLogs()
    if not autoCollectAndDropLogs then return end
    if not next(selectedItems) then return end 
    
    local player = game:GetService("Players").LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    fixPlayerPosition()
    local hrp = player.Character.HumanoidRootPart
    
    local items = {}
    for _, item in pairs(workspace.Items:GetChildren()) do
        if selectedItems[item.Name] and item:IsA("Model") then
            table.insert(items, item)
        end
    end

    table.sort(items, function(a, b)
        local aPart = a.PrimaryPart or a:FindFirstChildWhichIsA("BasePart")
        local bPart = b.PrimaryPart or b:FindFirstChildWhichIsA("BasePart")
        if not aPart or not bPart then return false end
        return (hrp.Position - aPart.Position).Magnitude < (hrp.Position - bPart.Position).Magnitude
    end)

    for _, item in ipairs(items) do
        if not autoCollectAndDropLogs then break end
        
        local itemPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
        if not itemPart then continue end
        
        itemPart.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 0, 2))
        task.wait(0.05)
        
        game:GetService("ReplicatedStorage").RemoteEvents.RequestStartDraggingItem:FireServer(item)
        task.wait(0.05)
        
        game:GetService("ReplicatedStorage").RemoteEvents.ReplicateSound:FireServer(
            "FireAllClients",
            "BagGet",
            {
                ["Instance"] = player.Character.Head,
                ["Volume"] = 0.25
            }
        )
        
        game:GetService("ReplicatedStorage").RemoteEvents.StopDraggingItem:FireServer(item)
        
        task.wait(collectDelay)
    end
end

Main:Toggle({
    Title = "自动扔选择的钢铁",
    Value = false,
    Callback = function(value)
        autoCollectAndDropLogs = value
        if value then
            fixPlayerPosition()
            spawn(function()
                while autoCollectAndDropLogs do
                    CollectAndDropLogs()
                    task.wait(0.1)
                end
            end)
        else
            local player = game:GetService("Players").LocalPlayer
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.Anchored = false
            end
        end
    end
})

Main:Toggle({
    Title = "自动升级工作台",
    Value = false,
    Callback = function(value)
        autoCraftEnabled = value
        if value then
            spawn(function()
                while autoCraftEnabled do
                  
                    local craftingBenches = {
                        "Crafting Bench 2",
                        "Crafting Bench 3", 
                        "Crafting Bench 4",
                        "Crafting Bench 5",
                        "Crafting Bench 6",
                        "Crafting Bench 7",
                        "Crafting Bench 8"
                    }
                    
                 
                    for _, benchName in ipairs(craftingBenches) do
                        if not autoCraftEnabled then break end 
                        
                        local args = {
                            [1] = benchName
                        }
                        
                        pcall(function()
                            game:GetService("ReplicatedStorage").RemoteEvents.CraftItem:InvokeServer(unpack(args))
                        end)
                        
                        wait(0.1)
                    end
                    
                    wait(0) 
                end
            end)
        end
    end
})
Main:Section({Title = "自动制作"})

local autoCraftConfig = {
    itemName = "Shelf",  
    interval = 5,     
    craftOnce = false    
}
local autoCraftEnabled = false
local craftLoop = nil
Main:Input({
    Title = "制作物品名称",
    Desc = "输入要制作的物品名称",
    Value = autoCraftConfig.itemName,
    Placeholder = "例如: Shelf",
    Callback = function(input)
        autoCraftConfig.itemName = input
    end
})
Main:Input({
    Title = "制作间隔(秒)",
    Desc = "设置每次制作的间隔时间",
    Value = tostring(autoCraftConfig.interval),
    Placeholder = "例如: 5",
    Numeric = true,
    Callback = function(input)
        local num = tonumber(input)
        if num and num > 0 then
            autoCraftConfig.interval = num
        end
    end
})
Main:Button({
    Title = "制作一次",
    Callback = function()
        local args = {
            [1] = autoCraftConfig.itemName
        }
        
        pcall(function()
            game:GetService("ReplicatedStorage").RemoteEvents.CraftItem:InvokeServer(unpack(args))
            WindUI:Notify({
                Title = "制作完成",
                Content = "已制作: " .. autoCraftConfig.itemName,
                Duration = 3,
                Icon = "check-circle"
            })
        end)
    end
})
Main:Toggle({
    Title = "自动制作",
    Value = false,
    Callback = function(value)
        autoCraftEnabled = value
        if value then
            spawn(function()
                while autoCraftEnabled do
                    local args = {
                        [1] = autoCraftConfig.itemName
                    }
                    
                    pcall(function()
                        game:GetService("ReplicatedStorage").RemoteEvents.CraftItem:InvokeServer(unpack(args))
                    end)
                    
                
                    for i = 1, autoCraftConfig.interval * 10 do
                        if not autoCraftEnabled then break end
                        wait(0.1)
                    end
                end
            end)
            
            WindUI:Notify({
                Title = "自动制作已开启",
                Content = "正在自动制作: " .. autoCraftConfig.itemName,
                Duration = 3,
                Icon = "settings"
            })
        else
            WindUI:Notify({
                Title = "自动制作已关闭",
                Content = "停止制作: " .. autoCraftConfig.itemName,
                Duration = 3,
                Icon = "settings"
            })
        end
    end
})

local Main = Window:Tab({Title = "宝箱功能", Icon = "box"})
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local chestSettings = {
    autoChestEnabled = false,
    autoChestNearEnabled = false,
    chestRange = 50,
    isRunning = false,
    originalCFrame = nil
}
local function getChests()
    local chests = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and string.find(obj.Name, "Item Chest") then
            table.insert(chests, obj)
        end
    end
    return chests
end
local function getPrompt(model)
    local prompts = {}
    for _, obj in ipairs(model:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            table.insert(prompts, obj)
        end
    end
    return prompts
end
Main:Toggle({
    Title = "自动开全部宝箱",
    Value = false,
    Callback = function(v)
        chestSettings.autoChestEnabled = v
        
        if v then
            if chestSettings.isRunning then return end
            chestSettings.isRunning = true
            
            local player = Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            chestSettings.originalCFrame = humanoidRootPart.CFrame
            
            task.spawn(function()
                while chestSettings.autoChestEnabled and chestSettings.isRunning do
                    local chests = getChests()
                    for _, chest in ipairs(chests) do
                        if not chestSettings.autoChestEnabled then break end
                        local part = chest.PrimaryPart or chest:FindFirstChildWhichIsA("BasePart")
                        if part then
                            humanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 6, 0)
                            local prompts = getPrompt(chest)
                            for _, prompt in ipairs(prompts) do
                                fireproximityprompt(prompt, math.huge)
                            end
                            local t = tick()
                            while chestSettings.autoChestEnabled and tick() - t < 4 do 
                                task.wait() 
                            end
                        end
                    end
                    task.wait(0.1)
                end
                
            
                if chestSettings.originalCFrame then
                    humanoidRootPart.CFrame = chestSettings.originalCFrame
                end
                chestSettings.isRunning = false
            end)
        else
            chestSettings.isRunning = false
        end
    end
})
Main:Toggle({
    Title = "宝箱光环",
    Value = false,
    Callback = function(v)
        chestSettings.autoChestNearEnabled = v
        
        if v then
            task.spawn(function()
                while chestSettings.autoChestNearEnabled do
                    local player = Players.LocalPlayer
                    local character = player.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        local humanoidRootPart = character.HumanoidRootPart
                        
                      
                        for _, obj in ipairs(workspace:GetDescendants()) do
                            if obj:IsA("Model") and string.find(obj.Name, "Item Chest") then
                                local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                                if part then
                                    local dist = (humanoidRootPart.Position - part.Position).Magnitude
                                    if dist <= chestSettings.chestRange then
                                        for _, prompt in ipairs(obj:GetDescendants()) do
                                            if prompt:IsA("ProximityPrompt") then
                                                fireproximityprompt(prompt, math.huge)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

Main:Slider({
    Title = "宝箱光环范围",
    Value = {
        Min = 1,
        Max = 100,
        Default = 50,
    },
    Callback = function(Value)
        chestSettings.chestRange = Value
    end
})
Main:Button({
    Title = "传送到最近宝箱",
    Callback = function()
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        local nearestChest, nearestDist, targetPart
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and string.find(obj.Name, "Item Chest") then
                local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                if part then
                    local dist = (humanoidRootPart.Position - part.Position).Magnitude
                    if not nearestDist or dist < nearestDist then
                        nearestDist = dist
                        nearestChest = obj
                        targetPart = part
                    end
                end
            end
        end

        if targetPart then
            humanoidRootPart.CFrame = targetPart.CFrame + Vector3.new(0, targetPart.Size.Y/2 + 6, 0)
            WindUI:Notify({
                Title = "宝箱传送",
                Content = "已传送到最近宝箱",
                Duration = 3,
            })
        else
            WindUI:Notify({
                Title = "宝箱传送",
                Content = "未找到宝箱",
                Duration = 3,
            })
        end
    end
})

local Main = Window:Tab({Title = "火堆", Icon = "user"})


Main:Section({Title = "燃料类"})

local itemsMap = {
    ["木头"] = "Log",
    ["煤"] = "Coal",
    ["油桶"] = "Fuel Canister",
    ["椅子"] = "Chair",
    ["生物燃料"] = "Biofuel"
}

local dropPositions = {
    ["工作台"] = Vector3.new(21.67, 6.34, -4.05),
    
    ["火堆"] = Vector3.new(3.04, 11.70, 1.01)
}

local selectedItems = {}
local selectedDropPosition = dropPositions["工作台"] 

Main:Dropdown({
    Title = "选择要收集的物品（多选）",
    Values = {"木头", "煤", "油桶", "椅子", "生物燃料"},
    Value = {},
    Multi = true,
    Callback = function(options)
        selectedItems = {}
        for _, option in ipairs(options) do
            selectedItems[itemsMap[option]] = true
        end
    end
})


local autoCollectAndDropLogs = false
local collectDelay = 0.01

local positionOptions = {
    ["原地"] = nil, 
    ["工作台"] = Vector3.new(21.67, 6.34, -4.05),
    ["火堆"] = Vector3.new(1.4, 25.9, -0.9)
}

local selectedPosition = positionOptions["火堆"]

Main:Dropdown({
    Title = "选择位置",
    Values = {"原地","工作台","火堆"},
    Value = "火堆",
    Callback = function(option)
        selectedPosition = positionOptions[option]
    end
})

local function fixPlayerPosition()
    local player = game:GetService("Players").LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition
        if selectedPosition then
            targetPosition = selectedPosition
        else
     
            targetPosition = player.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
        end
        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
        player.Character.HumanoidRootPart.Anchored = true
    end
end

local function CollectAndDropLogs()
    if not autoCollectAndDropLogs then return end
    if not next(selectedItems) then return end 
    
    local player = game:GetService("Players").LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    fixPlayerPosition()
    local hrp = player.Character.HumanoidRootPart
    
    local items = {}
    for _, item in pairs(workspace.Items:GetChildren()) do
        if selectedItems[item.Name] and item:IsA("Model") then
            table.insert(items, item)
        end
    end

    table.sort(items, function(a, b)
        local aPart = a.PrimaryPart or a:FindFirstChildWhichIsA("BasePart")
        local bPart = b.PrimaryPart or b:FindFirstChildWhichIsA("BasePart")
        if not aPart or not bPart then return false end
        return (hrp.Position - aPart.Position).Magnitude < (hrp.Position - bPart.Position).Magnitude
    end)

    for _, item in ipairs(items) do
        if not autoCollectAndDropLogs then break end
        
        local itemPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
        if not itemPart then continue end
        
        itemPart.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 0, 2))
        task.wait(0.05)
        
        game:GetService("ReplicatedStorage").RemoteEvents.RequestStartDraggingItem:FireServer(item)
        task.wait(0.05)
        
        game:GetService("ReplicatedStorage").RemoteEvents.ReplicateSound:FireServer(
            "FireAllClients",
            "BagGet",
            {
                ["Instance"] = player.Character.Head,
                ["Volume"] = 0.25
            }
        )
        
        game:GetService("ReplicatedStorage").RemoteEvents.StopDraggingItem:FireServer(item)
        
        task.wait(collectDelay)
    end
end

Main:Toggle({
    Title = "自动扔选择的燃料",
    Value = false,
    Callback = function(value)
        autoCollectAndDropLogs = value
        if value then
            fixPlayerPosition()
            spawn(function()
                while autoCollectAndDropLogs do
                    CollectAndDropLogs()
                    task.wait(0.1)
                end
            end)
        else
            local player = game:GetService("Players").LocalPlayer
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.Anchored = false
            end
        end
    end
})

Main:Button({
    Title = "传送回火旁",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-0.09672313928604126, 7.937822341918945, -0.1782056838274002)
    end
})

local Teleport = Window:Tab({Title = "传送功能", Icon = "user"})
local function getChests()
    local chests = {}
    local chestNames = {}
    local index = 1
    for _, item in ipairs(Workspace:WaitForChild("Items"):GetChildren()) do
        if item.Name:match("^Item Chest") and not item:GetAttribute("8721081708ed") then
            table.insert(chests, item)
            table.insert(chestNames, "Chest " .. index)
            index = index + 1
        end
    end
    return chests, chestNames
end

local function getMobs()
    local mobs = {}
    local mobNames = {}
    local index = 1
    for _, character in ipairs(Workspace:WaitForChild("Characters"):GetChildren()) do
        if character.Name:match("^Lost Child") and character:GetAttribute("Lost") == true then
            table.insert(mobs, character)
            table.insert(mobNames, character.Name)
            index = index + 1
        end
    end
    return mobs, mobNames
end
local currentChests, currentChestNames = getChests()
local selectedChest = currentChestNames[1] or nil

local currentMobs, currentMobNames = getMobs()
local selectedMob = currentMobNames[1] or nil

Teleport:Section({ Title = "基础传送点", Icon = "map-pin" })

Teleport:Button({
    Title = "传送到营火",
    Callback = function()
        local function tp1()
            (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame =
            CFrame.new(0.43132782, 15.77634621, -1.88620758, -0.270917892, 0.102997094, 0.957076371, 0.639657021, 0.762253821, 0.0990355015, -0.719334781, 0.639031112, -0.272391081)
        end
        tp1()
    end
})

Teleport:Button({
    Title = "传送到要塞",
    Callback = function()
        local function tp2()
            local targetPart = Workspace:FindFirstChild("Map")
                and Workspace.Map:FindFirstChild("Landmarks")
                and Workspace.Map.Landmarks:FindFirstChild("Stronghold")
                and Workspace.Map.Landmarks.Stronghold:FindFirstChild("Functional")
                and Workspace.Map.Landmarks.Stronghold.Functional:FindFirstChild("EntryDoors")
                and Workspace.Map.Landmarks.Stronghold.Functional.EntryDoors:FindFirstChild("DoorRight")
                and Workspace.Map.Landmarks.Stronghold.Functional.EntryDoors.DoorRight:FindFirstChild("Model")
            if targetPart then
                local children = targetPart:GetChildren()
                local destination = children[5]
                if destination and destination:IsA("BasePart") then
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = destination.CFrame + Vector3.new(0, 5, 0)
                    end
                end
            end
        end
        tp2()
    end
})

Teleport:Button({
    Title = "传送到安全区",
    Callback = function()
        if not Workspace:FindFirstChild("SafeZonePart") then
            local createpart = Instance.new("Part")
            createpart.Name = "SafeZonePart"
            createpart.Size = Vector3.new(30, 3, 30)
            createpart.Position = Vector3.new(0, 350, 0)
            createpart.Anchored = true
            createpart.CanCollide = true
            createpart.Transparency = 0.8
            createpart.Color = Color3.fromRGB(255, 0, 0)
            createpart.Parent = Workspace
        end
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        hrp.CFrame = CFrame.new(0, 360, 0)
    end
})

Teleport:Button({
    Title = "传送到商人",
    Callback = function()
        local pos = Vector3.new(-37.08, 3.98, -16.33)
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        hrp.CFrame = CFrame.new(pos)
    end
})

Teleport:Button({
    Title = "传送到随机树",
    Callback = function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = character:FindFirstChild("HumanoidRootPart", 3)
        if not hrp then return end

        local map = Workspace:FindFirstChild("Map")
        if not map then return end

        local foliage = map:FindFirstChild("Foliage") or map:FindFirstChild("Landmarks")
        if not foliage then return end

        local trees = {}
        for _, obj in ipairs(foliage:GetChildren()) do
            if obj.Name == "Small Tree" and obj:IsA("Model") then
                local trunk = obj:FindFirstChild("Trunk") or obj.PrimaryPart
                if trunk then
                    table.insert(trees, trunk)
                end
            end
        end

        if #trees > 0 then
            local trunk = trees[math.random(1, #trees)]
            local treeCFrame = trunk.CFrame
            local rightVector = treeCFrame.RightVector
            local targetPosition = treeCFrame.Position + rightVector * 3
            hrp.CFrame = CFrame.new(targetPosition)
        end
    end
})

Teleport:Section({ Title = "宝箱传送", Icon = "box" })

local ChestDropdown = Teleport:Dropdown({
    Title = "选择宝箱",
    Values = currentChestNames,
    Multi = false,
    AllowNone = true,
    Callback = function(options)
        selectedChest = options[#options] or currentChestNames[1] or nil
    end
})

Teleport:Button({
    Title = "刷新宝箱列表",
    Locked = false,
    Callback = function()
        currentChests, currentChestNames = getChests()
        if #currentChestNames > 0 then
            selectedChest = currentChestNames[1]
            ChestDropdown:Refresh(currentChestNames)
            WindUI:Notify({
                Title = "宝箱列表已刷新",
                Content = "找到 " .. #currentChestNames .. " 个宝箱",
                Duration = 3,
                Icon = "refresh-cw"
            })
        else
            selectedChest = nil
            ChestDropdown:Refresh({ "未找到宝箱" })
            WindUI:Notify({
                Title = "未找到宝箱",
                Content = "地图上没有发现宝箱",
                Duration = 3,
                Icon = "box"
            })
        end
    end
})

Teleport:Button({
    Title = "传送到宝箱",
    Locked = false,
    Callback = function()
        if selectedChest and currentChests then
            local chestIndex = 1
            for i, name in ipairs(currentChestNames) do
                if name == selectedChest then
                    chestIndex = i
                    break
                end
            end
            local targetChest = currentChests[chestIndex]
            if targetChest then
                local part = targetChest.PrimaryPart or targetChest:FindFirstChildWhichIsA("BasePart")
                if part and LocalPlayer.Character then
                    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
                        WindUI:Notify({
                            Title = "传送成功",
                            Content = "已传送到 " .. selectedChest,
                            Duration = 3,
                            Icon = "check-circle"
                        })
                    end
                end
            end
        else
            WindUI:Notify({
                Title = "传送失败",
                Content = "请先选择一个宝箱",
                Duration = 3,
                Icon = "alert-circle"
            })
        end
    end
})

Teleport:Section({ Title = "儿童传送", Icon = "user" })

local MobDropdown = Teleport:Dropdown({
    Title = "选择儿童",
    Values = currentMobNames,
    Multi = false,
    AllowNone = true,
    Callback = function(options)
        selectedMob = options[#options] or currentMobNames[1] or nil
    end
})

Teleport:Button({
    Title = "刷新儿童列表",
    Locked = false,
    Callback = function()
        currentMobs, currentMobNames = getMobs()
        if #currentMobNames > 0 then
            selectedMob = currentMobNames[1]
            MobDropdown:Refresh(currentMobNames)
            WindUI:Notify({
                Title = "儿童列表已刷新",
                Content = "找到 " .. #currentMobNames .. " 个迷失儿童",
                Duration = 3,
                Icon = "refresh-cw"
            })
        else
            selectedMob = nil
            MobDropdown:Refresh({ "未找到迷失儿童" })
            WindUI:Notify({
                Title = "未找到迷失儿童",
                Content = "地图上没有发现迷失儿童",
                Duration = 3,
                Icon = "user"
            })
        end
    end
})

Teleport:Button({
    Title = "传送到儿童",
    Locked = false,
    Callback = function()
        if selectedMob and currentMobs then
            for i, name in ipairs(currentMobNames) do
                if name == selectedMob then
                    local targetMob = currentMobs[i]
                    if targetMob then
                        local part = targetMob.PrimaryPart or targetMob:FindFirstChildWhichIsA("BasePart")
                        if part and LocalPlayer.Character then
                            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
                                WindUI:Notify({
                                    Title = "传送成功",
                                    Content = "已传送到 " .. selectedMob,
                                    Duration = 3,
                                    Icon = "check-circle"
                                })
                            end
                        end
                    end
                    break
                end
            end
        else
            WindUI:Notify({
                Title = "传送失败",
                Content = "请先选择一个迷失儿童",
                Duration = 3,
                Icon = "alert-circle"
            })
        end
    end
})

local AutoSection = Window:Tab({Title = "带来", Icon = "user"})

AutoSection:Toggle({
    Title = "自动传送物品",
    Default = false,
    Callback = function(Value)
        autoBringItems = Value
        task.spawn(function()
            while autoBringItems and task.wait() do
                local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not root then continue end
                for _, item in ipairs(workspace.Items:GetChildren()) do
                    local part = item:FindFirstChildWhichIsA("BasePart") or (item:IsA("BasePart") and item)
                    if part then
                        part.CFrame = root.CFrame + Vector3.new(math.random(-44,44), 0, math.random(-44,44))
                    end
                end
            end
        end)
    end
})

AutoSection:Toggle({
    Title = "自动传送木头",
    Default = false,
    Callback = function(Value)
        autoBringLogs = Value
        task.spawn(function()
            while autoBringLogs and task.wait() do
                local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not root then continue end
                
                for _, item in pairs(workspace.Items:GetChildren()) do
                    if item.Name:lower():find("log") and item:IsA("Model") then
                        local main = item:FindFirstChildWhichIsA("BasePart")
                        if main then
                            main.CFrame = root.CFrame * CFrame.new(math.random(-5,5), 0, math.random(-5,5))
                        end
                    end
                end
            end
        end)
    end
})

AutoSection:Toggle({
    Title = "自动传送燃料罐",
    Default = false,
    Callback = function(Value)
        autoBringFuel = Value
        task.spawn(function()
            while autoBringFuel and task.wait() do
                local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not root then continue end
                
                for _, item in pairs(workspace.Items:GetChildren()) do
                    if item.Name:lower():find("fuel canister") and item:IsA("Model") then
                        local main = item:FindFirstChildWhichIsA("BasePart")
                        if main then
                            main.CFrame = root.CFrame * CFrame.new(math.random(-5,5), 0, math.random(-5,5))
                        end
                    end
                end
            end
        end)
    end
})

AutoSection:Toggle({
    Title = "自动传送油桶",
    Default = false,
    Callback = function(Value)
        autoBringOil = Value
        task.spawn(function()
            while autoBringOil and task.wait() do
                local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not root then continue end
                
                for _, item in pairs(workspace.Items:GetChildren()) do
                    if item.Name:lower():find("oil barrel") and item:IsA("Model") then
                        local main = item:FindFirstChildWhichIsA("BasePart")
                        if main then
                            main.CFrame = root.CFrame * CFrame.new(math.random(-5,5), 0, math.random(-5,5))
                        end
                    end
                end
            end
        end)
    end
})

AutoSection:Toggle({
    Title = "自动传送所有废料",
    Default = false,
    Callback = function(Value)
        autoBringScrap = Value
        task.spawn(function()
            while autoBringScrap and task.wait() do
                local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not root then continue end
                
                local scrapNames = {
                    ["tyre"] = true, 
                    ["sheet metal"] = true, 
                    ["broken fan"] = true, 
                    ["bolt"] = true, 
                    ["old radio"] = true, 
                    ["ufo junk"] = true, 
                    ["ufo scrap"] = true, 
                    ["broken microwave"] = true
                }
                
                for _, item in pairs(workspace.Items:GetChildren()) do
                    if item:IsA("Model") then
                        local itemName = item.Name:lower()
                        for scrapName, _ in pairs(scrapNames) do
                            if itemName:find(scrapName) then
                                local main = item:FindFirstChildWhichIsA("BasePart")
                                if main then
                                    main.CFrame = root.CFrame * CFrame.new(math.random(-5,5), 0, math.random(-5,5))
                                end
                                break
                            end
                        end
                    end
                end
            end
        end)
    end
})

AutoSection:Toggle({
    Title = "自动传送煤炭",
    Default = false,
    Callback = function(Value)
        autoBringCoal = Value
        task.spawn(function()
            while autoBringCoal and task.wait() do
                local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not root then continue end
                
                for _, item in pairs(workspace.Items:GetChildren()) do
                    if item.Name:lower():find("coal") and item:IsA("Model") then
                        local main = item:FindFirstChildWhichIsA("BasePart")
                        if main then
                            main.CFrame = root.CFrame * CFrame.new(math.random(-5,5), 0, math.random(-5,5))
                        end
                    end
                end
            end
        end)
    end
})

AutoSection:Toggle({
    Title = "自动传送肉类",
    Default = false,
    Callback = function(Value)
        autoBringMeat = Value
        task.spawn(function()
            while autoBringMeat and task.wait() do
                local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not root then continue end
                
                for _, item in pairs(workspace.Items:GetChildren()) do
                    local name = item.Name:lower()
                    if (name:find("meat") or name:find("cooked")) and item:IsA("Model") then
                        local main = item:FindFirstChildWhichIsA("BasePart")
                        if main then
                            main.CFrame = root.CFrame * CFrame.new(math.random(-5,5), 0, math.random(-5,5))
                        end
                    end
                end
            end
        end)
    end
})

local Main = Window:Tab({Title = "收集", Icon = "user"})
local itemMaps = {
    ["燃料类物品"] = {
        ["木头"] = "Log",
        ["煤"] = "Coal",
        ["油桶"] = "Fuel Canister",
        ["椅子"] = "Chair",
        ["生物燃料"] = "Biofuel"
    },
    ["钢铁类物品"] = {
        ["螺栓"] = "Bolt",
        ["破风扇"] = "Broken Fan",
        ["坏微波炉"] = "Broken Microwave",
        ["旧收音机"] = "Old Radio",
        ["洗衣机"] = "Washing Machine",
        ["旧汽车引擎"] = "Old Car Engine",
        ["轮胎"] = "Tire",
        ["金属板"] = "Sheet Metal"
    },
    ["食物类物品"] = {
        ["蛋糕"] = "Cake",
        ["牛排"] = "Steak",
        ["肉丁"] = "Morsel",
        ["胡萝卜"] = "Carrot",
        ["苹果"] = "Apple",
        ["浆果"] = "Berry",
        ["辣椒"] = "Chili",
        ["玉米"] = "Corn",
        ["南瓜"] = "Pumpkin"
    },
    ["回血类物品"] = {
        ["绷带"] = "Bandage",
        ["医疗包"] = "Medkit"
    },
    ["武器与装备"] = {
        ["步枪"] = "Rifle",
        ["皮革背心"] = "Leather Body",
        ["左轮弹药"] = "Revolver Ammo",
        ["左轮手枪"] = "Revolver",
        ["步枪弹药"] = "Rifle Ammo",
        ["好的背包"] = "Good Sack",
        ["巨袋"] = "Large Bag",
        ["强力斧头"] = "Strong Axe",
        ["锯齿"] = "Saw Blade",
        ["好的斧头"] = "Good Axe",
        ["长矛"] = "Spear",
        ["强力手电筒"] = "Strong Flashlight",
        ["弓弩"] = "Crossbow",
        ["老鱼杆"] = "Old Rod"
    },
    ["动物与特殊物品"] = {
        ["黄鼠狼皮"] = "Arctic Fox Pelt",
        ["教徒尸体"] = "Cultist",
        ["弓弩教徒尸体"] = "Crossbow Cultist",
        ["教徒宝石"] = "Cultist Gem",
        ["狼尸体"] = "Wolf Corpse",
        ["狼皮"] = "Bunny Foot"
    }
}

local selectedItems = {}
local autoCollect = false
local collectDelay = 0.005  

local function fixPlayerPosition()
    local player = game:GetService("Players").LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = player.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
        player.Character.HumanoidRootPart.Anchored = true
    end
end

local function CollectItems()
    if not autoCollect then return end
    if not next(selectedItems) then return end
    
    local player = game:GetService("Players").LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    fixPlayerPosition()
    local hrp = player.Character.HumanoidRootPart
    
    local allItems = {}
    for _, item in pairs(workspace.Items:GetChildren()) do
        if selectedItems[item.Name] and item:IsA("Model") then
            table.insert(allItems, item)
        end
    end

    table.sort(allItems, function(a, b)
        local aPart = a.PrimaryPart or a:FindFirstChildWhichIsA("BasePart")
        local bPart = b.PrimaryPart or b:FindFirstChildWhichIsA("BasePart")
        if not aPart or not bPart then return false end
        return (hrp.Position - aPart.Position).Magnitude < (hrp.Position - bPart.Position).Magnitude
    end)

    for _, item in ipairs(allItems) do
        if not autoCollect then break end
        
        local itemPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
        if not itemPart then continue end
        
        itemPart.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 0, 2))
        task.wait(0.02)  
        
        game:GetService("ReplicatedStorage").RemoteEvents.RequestStartDraggingItem:FireServer(item)
        task.wait(0.02)  
        
        game:GetService("ReplicatedStorage").RemoteEvents.ReplicateSound:FireServer(
            "FireAllClients",
            "BagGet",
            {
                ["Instance"] = player.Character.Head,
                ["Volume"] = 0.25
            }
        )
        
        game:GetService("ReplicatedStorage").RemoteEvents.StopDraggingItem:FireServer(item)
        task.wait(collectDelay)
    end
end

local allItemValues = {}
local allItemMap = {}

for category, items in pairs(itemMaps) do
    for name, id in pairs(items) do
        table.insert(allItemValues, name)
        allItemMap[name] = id
    end
end

Main:Dropdown({
    Title = "选择要收集的物品（多选）",
    Values = allItemValues,
    Value = {},
    Multi = true,
    Callback = function(options)
        selectedItems = {}
        for _, option in ipairs(options) do
            selectedItems[allItemMap[option]] = true
        end
    end
})

Main:Toggle({
    Title = "自动收集选择的物品",
    Value = false,
    Callback = function(value)
        autoCollect = value
        if value then
            fixPlayerPosition()
            spawn(function()
                while autoCollect do
                    CollectItems()
                    task.wait(0.05)  
                end
            end)
        else
            local player = game:GetService("Players").LocalPlayer
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.Anchored = false
            end
        end
    end
})


local Main = Window:Tab({Title = "玩家功能", Icon = "user"})
Main:Toggle({
    Title = "速度 (开/关)",
    Default = false,
    Callback = function(v)
        if v == true then
            sudu = game:GetService("RunService").Heartbeat:Connect(function()
                if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Humanoid and game:GetService("Players").LocalPlayer.Character.Humanoid.Parent then
                    if game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                        game:GetService("Players").LocalPlayer.Character:TranslateBy(game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection * Speed / 10)
                    end
                end
            end)
        elseif not v and sudu then
            sudu:Disconnect()
            sudu = nil
        end
    end
})

Main:Slider({
    Title = "速度设置",
    Desc = "滑动调整",
    Value = {
        Min = 1,
        Max = 150,
        Default = 1,
    },
    Callback = function(Value)
        Speed = Value
    end
})

Main:Toggle({
    Title = "隐身",
    Default = false,
    Callback = function(Value)
        if invisThread then
            task.cancel(invisThread)
            invisThread = nil
        end

        if Value then
            invisThread = task.spawn(function()
                local Player = game:GetService("Players").LocalPlayer
                RealCharacter = Player.Character or Player.CharacterAdded:Wait()
                RealCharacter.Archivable = true
                FakeCharacter = RealCharacter:Clone()
                Part = Instance.new("Part")
                Part.Anchored = true
                Part.Size = Vector3.new(200, 1, 200)
                Part.CFrame = CFrame.new(0, -500, 0)
                Part.CanCollide = true
                Part.Parent = workspace
                FakeCharacter.Parent = workspace
                FakeCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0)

                for _, v in pairs(RealCharacter:GetChildren()) do
                    if v:IsA("LocalScript") then
                        local clone = v:Clone()
                        clone.Disabled = true
                        clone.Parent = FakeCharacter
                    end
                end

                for _, v in pairs(FakeCharacter:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Transparency = 0.7
                    end
                end

                local function EnableInvisibility()
                    StoredCF = RealCharacter.HumanoidRootPart.CFrame
                    RealCharacter.HumanoidRootPart.CFrame = FakeCharacter.HumanoidRootPart.CFrame
                    FakeCharacter.HumanoidRootPart.CFrame = StoredCF
                    RealCharacter.Humanoid:UnequipTools()
                    Player.Character = FakeCharacter
                    workspace.CurrentCamera.CameraSubject = FakeCharacter.Humanoid
                    RealCharacter.HumanoidRootPart.Anchored = true

                    for _, v in pairs(FakeCharacter:GetChildren()) do
                        if v:IsA("LocalScript") then
                            v.Disabled = false
                        end
                    end
                end

                RealCharacter.Humanoid.Died:Connect(function()
                    if Part then Part:Destroy() end
                    if FakeCharacter then FakeCharacter:Destroy() end
                    Player.Character = RealCharacter
                end)

                EnableInvisibility()

                game:GetService("RunService").RenderStepped:Connect(function()
                    if RealCharacter and RealCharacter:FindFirstChild("HumanoidRootPart") and Part then
                        RealCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0)
                    end
                end)
            end)
        else
            if Part then Part:Destroy() Part = nil end
            if FakeCharacter then FakeCharacter:Destroy() FakeCharacter = nil end
            if RealCharacter then
                RealCharacter.HumanoidRootPart.Anchored = false
                RealCharacter.HumanoidRootPart.CFrame = StoredCF
                game:GetService("Players").LocalPlayer.Character = RealCharacter
                workspace.CurrentCamera.CameraSubject = RealCharacter.Humanoid
            end
        end
    end
})

Main:Toggle({
    Title = "秒互动",
    Value = false,
    Callback = function(value)
        autohlod = value
        if autohlod then
            local function modifyPrompt(prompt)
                prompt.HoldDuration = 0 
            end 
            
            local function isTargetPrompt(prompt)
                local parent = prompt.Parent 
                while parent do 
                    if parent == workspace or parent == workspace.BankRobbery.VaultDoor then 
                        return true 
                    end 
                    parent = parent.Parent 
                end 
                return false 
            end 
            
            for _, prompt in ipairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") and isTargetPrompt(prompt) then
                    modifyPrompt(prompt)
                end
            end 
            
            workspace.DescendantAdded:Connect(function(instance)
                if instance:IsA("ProximityPrompt") and isTargetPrompt(instance) then
                    modifyPrompt(instance)
                end
            end)
        end
    end
})

Main:Toggle({
    Title = "无限跳",
    Default = false,
    Callback = function(Value)
        local jumpConn
        if Value then
            jumpConn = game:GetService("UserInputService").JumpRequest:Connect(function()
                local humanoid = game:GetService("Players").LocalPlayer.Character and
                                 game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            if jumpConn then
                jumpConn:Disconnect()
                jumpConn = nil
            end
        end
    end
})
WindUI:Notify({
                        Title = "大司马",
                        Content = "为你自动切换英文，自己调整",
                        Duration = 3,
                        Icon = "alert-circle"
                    })
                    
                    WindUI:Notify({
                        Title = "大司马脚本",
                        Content = "为你自动切换英文，自己调整",
                        Duration = 3,
                        Icon = "alert-circle"
                    })
                    
                    WindUI:Notify({
                        Title = "小云",
                        Content = "为你自动切换英文，自己调整",
                        Duration = 3,
                        Icon = "alert-circle"
                    })
                    
                    WindUI:Notify({
                        Title = "猫王",
                        Content = "为你自动切换英文，自己调整",
                        Duration = 3,
                        Icon = "alert-circle"
                    })
                    
                    WindUI:Notify({
                        Title = "云脚本",
                        Content = "为你自动切换英文，自己调整",
                        Duration = 3,
                        Icon = "alert-circle"
                    })
end
WindUI:Notify({
                        Title = "猫脚本",
                        Content = "为你自动切换英文，自己调整",
                        Duration = 3,
                        Icon = "alert-circle"
                    })

      end
})
Section:Button({
    Title = "XY 脚本自然灾害",
    Callback = function()
    
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
        Title = "XY脚本-自然灾害<font color='#00FF00'>V2</font>",
        Icon = "rbxassetid://4483362748",
        IconTransparency = 0.5,
        IconThemed = true,
        Author = "作者:小夜",
        Folder = "CloudHub",
        Size = UDim2.fromOffset(400, 300),
        Transparent = true,
        Theme = "Light",
        User = {
            Enabled = true,
            Callback = function() print("clicked") end,
            Anonymous = false
        },
        SideBarWidth = 200,
        ScrollBarEnabled = true,
        Background = "rbxassetid://111122821357551"
    })
    

WindUI:Popup({
    Title = "欢迎使用",
    Icon = "info",
    Content = "欢迎用户使用XY脚本-自然灾害",
    Buttons = {
        {
            Title = "取消",
            Callback = function() end,
            Variant = "Tertiary",
        },
        {
            Title = "确定",
            Icon = "arrow-right",
            Callback = function() end,
            Variant = "Primary",
        }
    }
})

Window:EditOpenButton({
    Title = "XY脚本",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 4,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")),
        ColorSequenceKeypoint.new(0.16, Color3.fromHex("FF7F00")),
        ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00")),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FF00")),
        ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF")),
        ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("9400D3"))
    }),
    Draggable = true,
})
            
Window:Tag({
    Title = "XY脚本",
    Color = Color3.fromHex("#30ff6a")
})

Window:Tag({
        Title = "XY脚本", -- 标签汉化
        Color = Color3.fromHex("#315dff")
    })
    local TimeTag = Window:Tag({
        Title = "自然灾害",
        Color = Color3.fromHex("#000000")
    })

local Tabs = {
    Main = Window:Section({ Title = "XY脚本自然灾害", Opened = true }),
}

local TabHandles = {
    Q = Tabs.Main:Tab({ Title = "功能", Icon = "layout-grid" }),
}

Button = TabHandles.Q:Button({
    Title = "指南针（可以用下面的地方显示不了地图）",
    Desc = "要使用的话就必须买指南针",
    Locked = false,
    Callback = function()
    
local p = game.Players.LocalPlayer
local r, c, h = game.ReplicatedStorage.Remotes.Compass, p.Backpack:WaitForChild("Compass"), p.Character:WaitForChild("Humanoid")
h:EquipTool(c)
task.wait()
r:FireServer("Vote Map", 3)
r:FireServer("Vote Map", 4)
task.wait()
h:UnequipTools()
            
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 1, -- 3 seconds
    Icon = "layout-grid",
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = "黑洞",
    Desc = "点击加载",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Super-ring-Parts-V6-28581"))()
        
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})        
        
    end
})

Button = TabHandles.Q:Button({
    Title = "物理磁铁",
    Desc = "可以把下面的东西吸上来可以踩",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cytj777i/6669178/main/%E5%8D%95%E4%B8%80%E7%89%A9%E4%BD%93%E9%A3%9E%E8%A1%8C%E8%BD%BD%E8%87%AA%E5%B7%B1%E6%9C%80%E7%BB%88%E4%BC%98%E5%8C%96%E7%89%88"))()       
        
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 1, -- 3 seconds
    Icon = "layout-grid",
})                                
    end
})

Button = TabHandles.Q:Button({
    Title = "无敌少侠",
    Desc = "用了它，你就会变成城市超人",
    Locked = false,
    Callback = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 1, -- 3 seconds
    Icon = "layout-grid",
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = "防止摔跤伤害",
    Desc = "就算掉下去了，也毫发无伤，掉到水里面也会死的",
    Locked = false,
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/cytj777i/Fall-injury/main/防止摔落伤害"))()
            
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 1, -- 3 seconds
    Icon = "layout-grid",
})                        
            
 end
})

      end
})
Section:Button({
    Title = "XY脚本-超市里生存",
    Callback = function()
    
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zephyr688/Lua-Script/refs/heads/main/UI"))()

local window = library:new("XY脚本｜在超市生活一周")

local Page = window:Tab("主要功能",'16060333448')

local Section = Page:section("功能",true)

Section:Toggle("自动收集食物", "", false, function(state)
    while state and task.wait() do
        for _,v in next,workspace.Map.Util.Items:GetChildren() do
            if v.ToolStats.ItemType.Value == "Food" then
                game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
            end
        end
    end
end)

Section:Toggle("自动收集手电筒", "", false, function(state)
    while state and task.wait() do
        for _,v in next,workspace.Map.Util.Items:GetChildren() do
            if v.ToolStats.ItemType.Value == "Flashlight" then
                game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
            end
        end
    end
end)

Section:Toggle("自动收集近战武器", "", false, function(state)
    while state and task.wait() do
        for _,v in next,workspace.Map.Util.Items:GetChildren() do
            if v.ToolStats.ItemType.Value == "Melee" then
                game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
            end
        end
    end
end)
Section:Toggle("自动收集枪", "", false, function(state)
    while state and task.wait() do
        for _,v in next,workspace.Map.Util.Items:GetChildren() do
            if v.ToolStats.ItemType.Value == "Gun" then
                game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
            end
        end
    end
end)

Section:Toggle("自动收集药品", "", false, function(state)
    while state and task.wait() do
        for _,v in next,workspace.Map.Util.Items:GetChildren() do
            if v.ToolStats.ItemType.Value == "Health" then
                game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
            end
        end
    end
end)

Section:Toggle("自动装弹", "", false, function(state)
    while state and task.wait() do
        game:GetService("ReplicatedStorage").Remotes.Weapon.GunReloaded:FireServer(v, 1)
    end
end)

Section:Toggle("自动开枪", "", false, function(state)
    while state and task.wait() do
        for _, v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
            if v:FindFirstChild("ToolStats") and v.ToolStats:FindFirstChild("Ammo") then
                for _,e in next,workspace.Enemies:GetChildren() do
                    if e.Humanoid.Health > 0 then
                        local BulletsPerShot = v.ToolStats.BulletsPerShot.Value
                        local DirectionTbl = {}
                        for i = 1, BulletsPerShot do
                            table.insert(DirectionTbl, Vector3.new(e.Head.Position.X, e.Head.Position.Y, e.Head.Position.Z).Unit)
                        end
                        local args = {
                            [1] = {
                                ["FiringPlayer"] = game:GetService("Players").LocalPlayer,
                                ["FiredTime"] = os.time,
                                ["FiringPlayerUserId"] = game.Players.LocalPlayer.UserId,
                                ["Origin"] = Vector3.new(game.Players.LocalPlayer.Character:GetPivot().Position),
                                ["UID"] = game.Players.LocalPlayer.UserId .. "_1",
                                ["WeaponInstance"] = v,
                                ["ThisBulletProperties"] = {
                                    ["BulletSpread"] = v.ToolStats.BulletSpread.Value,
                                    ["BulletsPerShot"] = v.ToolStats.BulletsPerShot.Value,
                                    ["BulletPenetration"] = v.ToolStats.BulletPenetration.Value,
                                    ["BulletSpeed"] = v.ToolStats.BulletSpeed.Value,
                                    ["FireSound"] = v.ToolStats.FireSound.Value,
                                    ["BulletSize"] = v.ToolStats.BulletSize.Value
                                },
                                ["DirectionTbl"] = DirectionTbl
                            }
                        }
                        game:GetService("ReplicatedStorage").Remotes.Weapon.GunFired:FireServer(unpack(args))
                    end
                end
            end
        end
    end
end)

Section:Toggle("修改超级枪", "", false, function(state)
    while state and task.wait() do
        for _,v in next,game.Players.Backpack:GetChildren() do
            if v.ToolStats:FindFirstChild("Ammo") then
                v.ToolStats.ReloadTime.Value = 0
                v.ToolStats.FireDelay.Value = 0
                v.ToolStats.Ammo.Value = math.huge
                v.ToolStats.Damage.Value = math.huge
            end
        end
    end
end)
Section:Toggle("无限体力和饥饿度", "", false, function(state)
    while state and task.wait() do
        game.Players.LocalPlayer.Character.CharacterData.MaxStamina.Value = math.huge
        game.Players.LocalPlayer.Character.CharacterData.MaxEnergy.Value = math.huge
        game.Players.LocalPlayer.Character.CharacterData.Energy.Value = game.Players.LocalPlayer.Character.CharacterData.MaxEnergy.Value
        game.Players.LocalPlayer.Character.CharacterData.Stamina.Value = game.Players.LocalPlayer.Character.CharacterData.MaxStamina.Value
    end
end)

Section:Toggle("夜晚自动躲避", "", false, function(state)
    while state and task.wait() do
        if game:GetService("ReplicatedStorage").GameInfo.TimeOfDay.Value == "Night" then
        oldpos = game.Players.LocalPlayer.Character:GetPivot().Position
        repeat task.wait()
        game.Players.LocalPlayer.Character:PivotTo(CFrame.new(306.18927001953125, 36.67450714111328, -519.2435913085938))
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        until game:GetService("ReplicatedStorage").GameInfo.TimeOfDay.Value ~= "Night"
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
        else
            task.wait()
        end
    end
end)
      end
})
Section:Button({
    Title = "XY脚本-请捐赠",
    Callback = function()
    
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()local Confirmed = false

WindUI:Popup({
    Title = "XY脚本-请捐赠",
    IconThemed = true,
    Content = "欢迎尊贵的用户" .. game.Players.LocalPlayer.Name .. "XY脚本 当前版本型号:V2",
    Buttons = {
        {
            Title = "取消",
            Callback = function() end,
            Variant = "Secondary",
        },
        {
            Title = "执行",
            Icon = "arrow-right",
            Callback = function() 
                Confirmed = true
                createUI()
            end,
            Variant = "Primary",
        }
    }
})
function createUI()
    local Window = WindUI:CreateWindow({
        Title = "XY脚本-请捐赠",
        Icon = "palette",
    Author = "尊贵的"..game.Players.localPlayer.Name.."欢迎使用 XY脚本", 
        Folder = "Premium",
        Size = UDim2.fromOffset(550, 320),
        Theme = "Light",
        User = {
            Enabled = true,
            Anonymous = true,
            Callback = function()
            end
        },
        SideBarWidth = 200,
        HideSearchBar = false,  
    })

    Window:Tag({
        Title = "请捐赠",
        Color = Color3.fromHex("#00ffff") 
    })

    Window:EditOpenButton({
        Title = "XY脚本V2",
        Icon = "crown",
        CornerRadius = UDim.new(0, 8),
        StrokeThickness = 3,
        Color = ColorSequence.new(
            Color3.fromRGB(255, 255, 0),  
            Color3.fromRGB(255, 165, 0),  
            Color3.fromRGB(255, 0, 0),    
            Color3.fromRGB(139, 0, 0)     
        ),
        Draggable = true,
    })
local MainTab = Window:Tab({Title = "摊位管理", Icon = "settings"})
MainTab:Section({Title = "主要功能"})

local autoThanks = false
local thanksMessages = {
    "谢谢爸爸捐赠!",
    "感谢爸爸支持!",
    "谢谢爸爸捐赠!"
}
MainTab:Toggle({
    Title = "捐赠自动感谢",
    Desc = "收到捐赠后自动发送感谢消息",
    Default = false,
    Callback = function(Value)
        autoThanks = Value
        if Value then
            game.Players.LocalPlayer.leaderstats.Raised.Changed:Connect(function()
                if autoThanks then
                    local randomMsg = thanksMessages[math.random(1, #thanksMessages)]
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(randomMsg, "All")
                end
            end)
        end
    end
})
local antiAFK = false
MainTab:Toggle({
    Title = "防止AFK",
    Default = false,
    Callback = function(Value)
        antiAFK = Value
        if Value then
            local VirtualInputManager = game:GetService("VirtualInputManager")
            task.spawn(function()
                while antiAFK do
                    task.wait(30)
                    VirtualInputManager:SendKeyEvent(true, "W", false, game)
                    task.wait(0.1)
                    VirtualInputManager:SendKeyEvent(false, "W", false, game)
                end
            end)
        end
    end
})
local autoTalk = false
local talkInterval = 60 
local talkMessages = {
    "欢迎来到我的摊位!",
    "请支持我",
    "请多多捐赠支持!",
    "我是最好的!",
    "谢谢大家的支持!"
}

MainTab:Toggle({
    Title = "自动说话",
    Desc = "定期自动发送消息",
    Default = false,
    Callback = function(Value)
        autoTalk = Value
        if Value then
            task.spawn(function()
                while autoTalk do
                    for i = 1, 5 do 
                        if not autoTalk then break end
                        local randomMsg = talkMessages[math.random(1, #talkMessages)]
                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(randomMsg, "All")
                        task.wait(1) 
                    end
                    task.wait(talkInterval - 5) 
                end
            end)
        end
    end
})

MainTab:Slider({
    Title = "说话间隔(秒)",
    Desc = "设置自动说话的间隔时间",
    Value = {
        Min = 10,
        Max = 300,
        Default = 60
    },
    Callback = function(Value)
        talkInterval = Value
    end
})

MainTab:Input({
    Title = "自定义说话内容",
    Desc = "输入自定义的说话内容(用逗号分隔)",
    Placeholder = "消息1,消息2,消息3",
    Callback = function(Value)
        if Value and Value ~= "" then
            local newMessages = {}
            for msg in string.gmatch(Value, "([^,]+)") do
                table.insert(newMessages, msg:gsub("^%s*(.-)%s*$", "%1"))
            end
            if #newMessages > 0 then
                talkMessages = newMessages
                WindUI:Notify({
                    Title = "说话内容已更新",
                    Content = "已设置 " .. #newMessages .. " 条自定义消息",
                    Duration = 3
                })
            end
        end
    end
})
end
      end
})
Section:Button({
    Title = "XY脚本-doors",
    Callback = function()
    
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Confirmed = false

WindUI:Popup({
    Title = "❆XY脚本-doors",
    IconThemed = true,
    Content = "尊贵的用户" .. game.Players.LocalPlayer.Name .. "使用 XY脚本",
    Buttons = {
        {
            Title = "取消",
            Callback = function() end,
            Variant = "Secondary",
        },
        {
            Title = "执行",
            Icon = "arrow-right",
            Callback = function() 
                Confirmed = true
                createUI()
            end,
            Variant = "Primary",
        }
    }
})

function createUI()
    local Window = WindUI:CreateWindow({
        Title = "XY脚本",
        Icon = "palette",
        Author = "尊贵的"..game.Players.LocalPlayer.Name.."欢迎使用 XY脚本", 
        Folder = "Premium",
        Size = UDim2.fromOffset(550, 320),
        Theme = "Light",
        User = {
            Enabled = true,
            Anonymous = true,
            Callback = function()
            end
        },
        SideBarWidth = 200,
        HideSearchBar = false,  
    })

    Window:Tag({
        Title = "doors",
        Color = Color3.fromHex("#00ffff") 
    })
    
    Window:Tag({
        Title = "未完善",
        Color = Color3.fromHex("#00ffff") 
    })

    Window:EditOpenButton({
        Title = "XY脚本-doors",
        Icon = "crown",
        CornerRadius = UDim.new(0, 8),
        StrokeThickness = 3,
        Color = ColorSequence.new(
            Color3.fromRGB(255, 255, 0),  
            Color3.fromRGB(255, 165, 0),  
            Color3.fromRGB(255, 0, 0),    
            Color3.fromRGB(139, 0, 0)     
        ),
        Draggable = true,
    })
    
    local MovementTab = Window:Tab({Title = "人物", Icon = "running"})
    MovementTab:Button({
        Title = "禁用反作弊",
        Tooltip = "在电梯中使用，可能会有bug但通常有效",
        Callback = function()
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")

            if currentRoom == 0 then
                if replicatesignal then
                    replicatesignal(LocalPlayer.Kill)
                    WindUI:Notify("反作弊", "反作弊已禁用，你可以飞行穿过一切", 10)
                else
                    WindUI:Notify("错误", "您的执行器不支持replicatesignal功能", 5)
                end
            else
                WindUI:Notify("提示", "你需要在电梯中使用此功能", 5)
            end
        end
    })
    MovementTab:Toggle({
        Title = "反作弊绕过",
        Default = false,
        Callback = function(Value)
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local RemoteFolder = game:GetService("ReplicatedStorage"):FindFirstChild("RemotesFolder")

            if not Value then
                if RemoteFolder and RemoteFolder:FindFirstChild("ClimbLadder") then
                    RemoteFolder.ClimbLadder:FireServer()
                end
            else
                WindUI:Notify("反作弊", "请上梯子以激活绕过", 9)
            end
        end
    })

   
    local LocalPlayer = game:GetService("Players").LocalPlayer
    LocalPlayer.Character:GetAttributeChangedSignal("Climbing"):Connect(function()
        if LocalPlayer.Character:GetAttribute("Climbing") == true then
            task.spawn(function()
                task.wait(0.1)
                LocalPlayer.Character:SetAttribute("Climbing", false)
                WindUI:Notify("反作弊", "已绕过反作弊，攀爬重置", 7)
            end)
        end
    end)

  
    MovementTab:Toggle({
        Title = "反作弊操纵",
        Default = false,
        Callback = function(Value)
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local Camera = workspace.CurrentCamera
            local LocalPlayer = Players.LocalPlayer
            local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
            local UserInputService = game:GetService("UserInputService")
            local savedCamCFrame
            local camLocked = false
            local acmButton
            local acmButtonActive = false

            local BUTTON_SIZE = UDim2.new(0, 70, 0, 35)
            local BUTTON_POSITION = UDim2.new(1, -80, 0.5, -17)
            local BUTTON_COLOR = Color3.fromRGB(45, 45, 45)
            local BUTTON_ACTIVE_COLOR = Color3.fromRGB(90, 90, 90)
            local BUTTON_TEXT_COLOR = Color3.fromRGB(255, 255, 255)

            local function createACMButton()
                if not UserInputService.TouchEnabled or acmButton then
                    return
                end

                local screenGui = Instance.new("ScreenGui")
                screenGui.Name = "ACMGui"
                screenGui.ResetOnSpawn = false
                screenGui.Parent = PlayerGui

                local button = Instance.new("TextButton")
                button.Name = "ACMButton"
                button.Size = BUTTON_SIZE
                button.Position = BUTTON_POSITION
                button.BackgroundColor3 = BUTTON_COLOR
                button.Text = "ACM"
                button.TextColor3 = BUTTON_TEXT_COLOR
                button.Font = Enum.Font.GothamBold
                button.TextSize = 16
                button.BorderSizePixel = 0
                button.Parent = screenGui

                button.MouseButton1Down:Connect(function()
                    acmButtonActive = true
                    button.BackgroundColor3 = BUTTON_ACTIVE_COLOR
                end)

                button.MouseButton1Up:Connect(function()
                    acmButtonActive = false
                    button.BackgroundColor3 = BUTTON_COLOR
                end)

                acmButton = screenGui
            end

            local function removeACMButton()
                if acmButton then
                    acmButton:Destroy()
                    acmButton = nil
                    acmButtonActive = false
                end
            end

            if Value then
                createACMButton()
                
                RunService.RenderStepped:Connect(function()
                    local cam = workspace.CurrentCamera
                    if not cam then return end

                    local active = Value and acmButtonActive
                    local char = LocalPlayer.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")

                    if active and hrp then
                        if not camLocked then
                            savedCamCFrame = cam.CFrame
                            cam.CameraType = Enum.CameraType.Scriptable
                            camLocked = true
                            hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, 10000)
                        end

                        cam.CFrame = savedCamCFrame
                    elseif camLocked then
                        cam.CameraType = Enum.CameraType.Custom
                        camLocked = false
                        savedCamCFrame = nil
                    end
                end)
            else
                removeACMButton()
            end
        end
    })

    MovementTab:Keybind({
        Title = "反作弊操纵按键",
        Default = "T",
        Mode = "Hold",
        Callback = function(Value) end
    })
    
    local SpeedValue = 21
    local SpeedEnabled = false
    local SpeedConnection = nil
    local BypassLabel = nil

    MovementTab:Toggle({
        Title = "开启速度",
        Default = false,
        Tooltip = "将你的行走速度更改为设定值",
        Callback = function(Value)
            SpeedEnabled = Value
            local LocalPlayer = game:GetService("Players").LocalPlayer
            
            if Value then
                SpeedConnection = game:GetService("RunService").Heartbeat:Connect(function()
                    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.WalkSpeed = SpeedValue
                    end
                end)
                WindUI:Notify("移速", "自定义移速已启用: " .. SpeedValue, 3)
            else
                if SpeedConnection then
                    SpeedConnection:Disconnect()
                    SpeedConnection = nil
                end
                WindUI:Notify("移速", "自定义移速已禁用", 3)
            end
        end
    })

    MovementTab:Slider({
        Title = "速度数值",
        Value = {Min = 0, Max = 100, Default = 21},
        Suffix = " 速度",
        Tooltip = "设置你的行走速度",
        Callback = function(Value)
            SpeedValue = Value
            if SpeedEnabled then
                WindUI:Notify("移速", "移速已更新: " .. Value, 2)
            end
        end
    })
    MovementTab:Toggle({
        Title = "即时加速度",
        Default = false,
        Tooltip = "移除改变方向时的减速效果",
        Callback = function(Value)
            local LocalPlayer = game:GetService("Players").LocalPlayer
            local OldAccel = PhysicalProperties.new(0.01, 0.7, 0, 1, 1)
            
            local function updateAcceleration()
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CustomPhysicalProperties = Value and PhysicalProperties.new(100, 0, 0, 0, 0) or OldAccel
                end
            end

            if Value then
                updateAcceleration()
                WindUI:Notify("加速度", "即时加速度已启用", 3)
            else
                updateAcceleration()
                WindUI:Notify("加速度", "即时加速度已禁用", 3)
            end
            LocalPlayer.CharacterAdded:Connect(function()
                task.wait(1.5)
                updateAcceleration()
            end)
        end
    })
    local isFlying = false
    local flyConnections = {}
    local flyKeys = {
        W = false,
        A = false,
        S = false,
        D = false,
        Space = false,
        Shift = false,
    }
    local FlySpeed = 50

    local function startFly()
        local player = game.Players.LocalPlayer
        local character = player.Character

        if not character then
            return
        end

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            return
        end

        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then
            return
        end
        local bv = Instance.new("BodyVelocity")
        bv.Name = "FlyVelocity"
        bv.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = hrp

        local bg = Instance.new("BodyGyro")
        bg.Name = "FlyGyro"
        bg.MaxTorque = Vector3.new(1000000000, 1000000000, 1000000000)
        bg.P = 20000
        bg.D = 1000
        bg.Parent = hrp

        humanoid.AutoRotate = false
        humanoid.PlatformStand = true
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        local inputBegan = game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
            if gpe then return end
            
            if input.KeyCode == Enum.KeyCode.W then
                flyKeys.W = true
            elseif input.KeyCode == Enum.KeyCode.A then
                flyKeys.A = true
            elseif input.KeyCode == Enum.KeyCode.S then
                flyKeys.S = true
            elseif input.KeyCode == Enum.KeyCode.D then
                flyKeys.D = true
            elseif input.KeyCode == Enum.KeyCode.Space then
                flyKeys.Space = true
            elseif input.KeyCode == Enum.KeyCode.LeftShift then
                flyKeys.Shift = true
            end
        end)

        table.insert(flyConnections, inputBegan)

        local inputEnded = game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.W then
                flyKeys.W = false
            elseif input.KeyCode == Enum.KeyCode.A then
                flyKeys.A = false
            elseif input.KeyCode == Enum.KeyCode.S then
                flyKeys.S = false
            elseif input.KeyCode == Enum.KeyCode.D then
                flyKeys.D = false
            elseif input.KeyCode == Enum.KeyCode.Space then
                flyKeys.Space = false
            elseif input.KeyCode == Enum.KeyCode.LeftShift then
                flyKeys.Shift = false
            end
        end)

        table.insert(flyConnections, inputEnded)
        local renderConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local cam = workspace.CurrentCamera

            if not cam or not hrp or not hrp:FindFirstChild("FlyVelocity") or not humanoid or humanoid.Health <= 0 then
                stopFly()
                return
            end

            local move = Vector3.new(0, 0, 0)

            if flyKeys.W then
                move = move + cam.CFrame.LookVector
            end
            if flyKeys.S then
                move = move - cam.CFrame.LookVector
            end
            if flyKeys.A then
                move = move - cam.CFrame.RightVector
            end
            if flyKeys.D then
                move = move + cam.CFrame.RightVector
            end
            if flyKeys.Space then
                move = move + Vector3.new(0, 1, 0)
            end
            if flyKeys.Shift then
                move = move - Vector3.new(0, 1, 0)
            end

            local direction = (move.Magnitude > 0) and (move.Unit * FlySpeed) or Vector3.new(0, 0, 0)
            bv.Velocity = direction
            bg.CFrame = cam.CFrame
        end)

        table.insert(flyConnections, renderConnection)
    end

    local function stopFly()
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local hrp = character and character:FindFirstChild("HumanoidRootPart")

        if hrp then
            local flyVelocity = hrp:FindFirstChild("FlyVelocity")
            if flyVelocity then
                flyVelocity:Destroy()
            end

            local flyGyro = hrp:FindFirstChild("FlyGyro")
            if flyGyro then
                flyGyro:Destroy()
            end
        end

        if humanoid then
            humanoid.AutoRotate = true
            humanoid.PlatformStand = false
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end

        for _, conn in ipairs(flyConnections) do
            conn:Disconnect()
        end

        flyConnections = {}
        flyKeys = {
            W = false,
            A = false,
            S = false,
            D = false,
            Space = false,
            Shift = false,
        }
    end

    MovementTab:Toggle({
        Title = "开启飞行",
        Default = false,
        Callback = function(Value)
            isFlying = Value

            if Value then
                startFly()
                WindUI:Notify("飞行", "飞行模式已启用", 3)
            else
                stopFly()
                WindUI:Notify("飞行", "飞行模式已禁用", 3)
            end
        end
    })

    MovementTab:Keybind({
        Title = "飞行电脑切换键",
        Default = "F",
        Mode = "Toggle",
        Callback = function(Value) end
    })

    MovementTab:Slider({
        Title = "飞行速度",
        Value = {Min = 0, Max = 150, Default = 50},
        Suffix = " 速度",
        Tooltip = "更改飞行速度",
        Callback = function(Value)
            FlySpeed = Value
            if isFlying then
                WindUI:Notify("飞行", "飞行速度已更新: " .. Value, 2)
            end
        end
    })
    local noclipConnection = nil
    local originalGroups = {}

    MovementTab:Toggle({
        Title = "穿墙模式",
        Default = false,
        Tooltip = "让你可以穿过墙壁",
        Callback = function(Value)
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local lp = Players.LocalPlayer

            local function enableNoclip()
                if noclipConnection then
                    return
                end

                noclipConnection = RunService.Stepped:Connect(function()
                    if lp.Character then
                        for _, part in pairs(lp.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                                if not originalGroups[part] then
                                    originalGroups[part] = part.CollisionGroup
                                end
                                part.CollisionGroup = "Default"
                            end
                        end
                    end
                end)
            end

            local function disableNoclip()
                if noclipConnection then
                    noclipConnection:Disconnect()
                    noclipConnection = nil
                end

                local char = lp.Character
                if not char then
                    return
                end

                local collision = char:FindFirstChild("Collision")
                local crouch = collision and collision:FindFirstChild("CollisionCrouch")

                if collision and crouch then
                    local crouching = collision.CollisionGroup == "PlayerCrouching"
                    collision.CanCollide = not crouching
                    crouch.CanCollide = crouching
                end
            end

            if Value then
                enableNoclip()
                WindUI:Notify("穿墙", "穿墙模式已启用", 3)
            else
                disableNoclip()
                WindUI:Notify("穿墙", "穿墙模式已禁用", 3)
            end
        end
    })

    MovementTab:Keybind({
        Title = "穿墙电脑切换键",
        Default = "N",
        Mode = "Toggle",
        Callback = function(Value) end
    })
    local LadderSpeedValue = 20
    local LadderSpeedEnabled = false
    local LadderConnection = nil

    MovementTab:Toggle({
        Title = "更快爬梯",
        Default = false,
        Callback = function(on)
            local LocalPlayer = game.Players.LocalPlayer
            local RunService = game:GetService("RunService")

            if on then
                LadderConnection = RunService.Heartbeat:Connect(function()
                    local char = LocalPlayer.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")

                    if hum and hrp and hum:GetState() == Enum.HumanoidStateType.Climbing then
                        hrp.Velocity = Vector3.new(hrp.Velocity.X, LadderSpeedValue, hrp.Velocity.Z)
                    end
                end)
                WindUI:Notify("爬梯", "梯子加速已启用", 3)
            elseif LadderConnection then
                LadderConnection:Disconnect()
                LadderConnection = nil
                WindUI:Notify("爬梯", "梯子加速已禁用", 3)
            end
        end
    })

    MovementTab:Slider({
        Title = "爬梯速度",
        Value = {Min = 0, Max = 100, Default = 20},
        Suffix = " 速度",
        Tooltip = "爬梯的加速值，过高可能不稳定",
        Callback = function(Value)
            LadderSpeedValue = Value
            if LadderSpeedEnabled then
                WindUI:Notify("爬梯", "爬梯速度已更新: " .. Value, 2)
            end
        end
    })
    MovementTab:Toggle({
        Title = "始终可跳跃",
        Default = false,
        Tooltip = "让你随时可以跳跃",
        Callback = function(Value)
            local LocalPlayer = game.Players.LocalPlayer
            LocalPlayer.Character:SetAttribute("CanJump", Value)
            
            if Value then
                WindUI:Notify("跳跃", "始终跳跃已启用", 3)
            else
                WindUI:Notify("跳跃", "始终跳跃已禁用", 3)
            end
            LocalPlayer.CharacterAdded:Connect(function(newCharacter)
                task.wait(1.5)
                newCharacter:SetAttribute("CanJump", Value)
            end)
        end
    })
    local B = Window:Tab({Title = "自动类", Icon = "puzzle"})
    B:Toggle({
        Title = "自动锚点代码求解",
        Default = false,
        Callback = function(enabled)
            local running = false
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Workspace = game:GetService("Workspace")
            
            if enabled then
                if running then return end
                running = true
                
                task.spawn(function()
                    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
                    
                    local function findFrame()
                        local mainUI = playerGui:FindFirstChild("MainUI")
                        if mainUI and mainUI:FindFirstChild("MainFrame") then
                            local frame = mainUI.MainFrame:FindFirstChild("AnchorHintFrame")
                            if frame then return frame end
                        end

                        local anchorUI = playerGui:FindFirstChild("AnchorHintUI")
                        if anchorUI then
                            local frame = anchorUI:FindFirstChild("AnchorHintFrame")
                            if frame then return frame end
                        end
                        return nil
                    end

                    while running do
                        task.wait(0.9)
                        local frame = findFrame()
                        
                        if frame then
                            local anchorName = (frame:FindFirstChild("AnchorCode") and frame.AnchorCode.Text) or ''
                            local codeText = (frame:FindFirstChild("Code") and frame.Code.Text) or ''
                            
                            if anchorName ~= '' and codeText ~= '' then
                                local anchorObject
                                for _, obj in ipairs(Workspace.CurrentRooms:GetDescendants()) do
                                    if obj.Name == "MinesAnchor" then
                                        local sign = obj:FindFirstChild("Sign")
                                        if sign then
                                            local label = sign:FindFirstChild("TextLabel") or sign:FindFirstChildWhichIsA("TextLabel")
                                            if label and label.Text == anchorName then
                                                anchorObject = obj
                                                break
                                            end
                                        end
                                    end
                                end

                                if anchorObject then
                                    local note = anchorObject:FindFirstChild("Note")
                                    if not note then
                                        WindUI:Notify("锚点代码", "锚点 " .. anchorName .. " 代码是 " .. codeText, 3)
                                    else
                                        local surfaceGui = note:FindFirstChildOfClass("SurfaceGui") or note:FindFirstChild("SurfaceGui")
                                        local noteText = (surfaceGui and surfaceGui:FindFirstChild("TextLabel") and surfaceGui.TextLabel.Text) or '0'
                                        local noteValue = tonumber(noteText) or 0
                                        local solved = ''
                                        
                                        for i = 1, #codeText do
                                            local digit = tonumber(codeText:sub(i, i)) or 0
                                            digit = (digit + noteValue) % 10
                                            solved = solved .. tostring(digit)
                                        end
                                        
                                        WindUI:Notify("锚点代码", "锚点 " .. anchorName .. " 代码是 " .. solved, 5)
                                    end
                                end
                            end
                        else
                            task.wait(0.25)
                        end
                    end
                end)
            else
                running = false
            end
        end
    })
    B:Toggle({
        Title = "自动断路器游戏",
        Default = false,
        Callback = function(Value)
            local Players = game:GetService("Players")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local LocalPlayer = Players.LocalPlayer
            local RemoteFolder = ReplicatedStorage:FindFirstChild("RemotesFolder") or ReplicatedStorage:FindFirstChild("EntityInfo") or ReplicatedStorage:FindFirstChild("Bricks")
            
            while task.wait() and Value do
                if not Value then break end
                
                local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
                if currentRoom ~= 100 then
                    WindUI:Notify("提示", "你需要在100号房间使用此功能", 5)
                    break
                end

                local Breaker = nil
                for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
                    if v.Name == "ElevatorBreaker" then
                        Breaker = v
                        break
                    end
                end

                if Breaker then
                    local solved = true
                    for _, v in ipairs(Breaker:GetChildren()) do
                        if v.Name == "BreakerSwitch" then
                            local codeText = Breaker:WaitForChild("SurfaceGui").Frame.Code.Text
                            if v:GetAttribute("ID") == tonumber(codeText) then
                                if Breaker.SurfaceGui.Frame.Code.Frame.BackgroundTransparency == 0 then
                                    v:SetAttribute("Enabled", true)
                                    if not v.Sound.Playing then
                                        v.Sound.Playing = true
                                    end
                                    v.Material = Enum.Material.Neon
                                    v.Light.Attachment.Spark:Emit(1)
                                    v.PrismaticConstraint.TargetPosition = -0.2
                                else
                                    v:SetAttribute("Enabled", false)
                                    if not v.Sound.Playing then
                                        v.Sound.Playing = true
                                    end
                                    v.PrismaticConstraint.TargetPosition = 0.2
                                    v.Material = Enum.Material.Glass
                                    solved = false
                                end
                            end
                        end
                    end

                    if solved and RemoteFolder then
                        local breakerRemote = RemoteFolder:FindFirstChild("BreakerMinigame")
                        if breakerRemote then
                            breakerRemote:FireServer("Solved")
                        end
                    end
                end
            end
        end
    })
    B:Toggle({
        Title = "自动隐藏[防怪物]",
        Default = false,
        Risky = true,
        Tooltip = "自动为你隐藏",
        Callback = function(Value)
            local EntityDistances = {
                RushMoving = 50,
                BackdoorRush = 50,
                AmbushMoving = 100,
                A60 = 100,
                A120 = 35,
            }
            local Rooms = workspace.CurrentRooms
            local LocalPlayer = game.Players.LocalPlayer
            local Connections = {}

            local function GetHiding()
                local Closest, Prompt
                local currRoom = Rooms and Rooms[LocalPlayer:GetAttribute("CurrentRoom")]
                if not currRoom then return nil end

                local char = LocalPlayer.Character
                if not char then return nil end

                local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Collision") or char.PrimaryPart
                if not hrp then return nil end

                local function distFromPlayer(model)
                    if not model then return math.huge end
                    local part = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
                    if not part then return math.huge end
                    return (part.Position - hrp.Position).Magnitude
                end

                local assets = currRoom:FindFirstChild("Assets")
                if assets then
                    for _, v in pairs(assets:GetChildren()) do
                        if v:IsA("Model") then
                            if ((v.Name == "Locker_Large") or (v.Name == "Wardrobe") or (v.Name == "Toolshed") or (v.Name == "Bed") or (v.Name == "Rooms_Locker") or (v.Name == "Rooms_Locker_Fridge") or (v.Name == "Backdoor_Wardrobe")) and v:FindFirstChild("HidePrompt") and v:FindFirstChild("HiddenPlayer") then
                                if not v.HiddenPlayer.Value and not v:FindFirstChild("HideEntityOnSpot", true) then
                                    if Closest then
                                        if distFromPlayer(v) < distFromPlayer(Closest) then
                                            Closest = v
                                            Prompt = v.HidePrompt
                                        end
                                    else
                                        Closest = v
                                        Prompt = v.HidePrompt
                                    end
                                end
                            elseif v.Name == "Double_Bed" then
                                for _, x in pairs(v:GetChildren()) do
                                    if x.Name == "DoubleBed" and x:FindFirstChild("HidePrompt") and x:FindFirstChild("HiddenPlayer") then
                                        if not x.HiddenPlayer.Value and not x:FindFirstChild("HideEntityOnSpot", true) then
                                            if Closest then
                                                if distFromPlayer(x) < distFromPlayer(Closest) then
                                                    Closest = x
                                                    Prompt = x.HidePrompt
                                                end
                                            else
                                                Closest = x
                                                Prompt = x.HidePrompt
                                            end
                                        end
                                    end
                                end
                            elseif v.Name == "Dumpster" then
                                for _, x in pairs(v:GetChildren()) do
                                    if x:FindFirstChild("HidePrompt") and x:FindFirstChild("HiddenPlayer") then
                                        local dumpsterBaseHasSpot = v:FindFirstChild("DumpsterBase") and v.DumpsterBase:FindFirstChild("HideEntityOnSpot")
                                        if not x.HiddenPlayer.Value and not dumpsterBaseHasSpot then
                                            if Closest then
                                                if distFromPlayer(x) < distFromPlayer(Closest) then
                                                    Closest = x
                                                    Prompt = x.HidePrompt
                                                end
                                            else
                                                Closest = x
                                                Prompt = x.HidePrompt
                                            end
                                        end
                                    end
                                end
                            end
                        elseif v:IsA("Folder") then
                            if v.Name == "Blockage" then
                                for _, x in pairs(v:GetChildren()) do
                                    if x:IsA("Model") and x.Name == "Wardrobe" and x:FindFirstChild("HiddenPlayer") and x:FindFirstChild("HidePrompt") then
                                        if not x.HiddenPlayer.Value then
                                            if Closest then
                                                if distFromPlayer(x) < distFromPlayer(Closest) then
                                                    Closest = x
                                                    Prompt = x.HidePrompt
                                                end
                                            else
                                                Closest = x
                                                Prompt = x.HidePrompt
                                            end
                                        end
                                    end
                                end
                            elseif v.Name == "Vents" then
                                for _, x in pairs(v:GetChildren()) do
                                    if x.Name == "CircularVent" and x:FindFirstChild("Grate") and x.Grate:FindFirstChild("HidePrompt") and x:FindFirstChild("HiddenPlayer") then
                                        if not x.HiddenPlayer.Value and not v:FindFirstChild("HideEntityOnSpot", true) then
                                            if Closest then
                                                if distFromPlayer(x) < distFromPlayer(Closest) then
                                                    Closest = x
                                                    Prompt = x.Grate.HidePrompt
                                                end
                                            else
                                                Closest = x
                                                Prompt = x.Grate.HidePrompt
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

                for _, v in pairs(currRoom:GetChildren()) do
                    if v:IsA("Model") then
                        if v.Name == "CircularVent" and v:FindFirstChild("Grate") and v.Grate:FindFirstChild("HidePrompt") and v:FindFirstChild("HiddenPlayer") then
                            if not v.HiddenPlayer.Value and not v:FindFirstChild("HideEntityOnSpot", true) then
                                if Closest then
                                    if distFromPlayer(v) < distFromPlayer(Closest) then
                                        Closest = v
                                        Prompt = v.Grate.HidePrompt
                                    end
                                else
                                    Closest = v
                                    Prompt = v.Grate.HidePrompt
                                end
                            end
                        end
                    end
                end

                return Prompt
            end

            if Value then
                table.insert(Connections, workspace.ChildAdded:Connect(function(v)
                    if v:IsA("Model") and EntityDistances[v.Name] then
                        task.wait(1)
                        local Part = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart", true)
                        if not Part then return end

                        v:SetAttribute("_Prediction", Part.Position)

                        while task.wait() and v.Parent do
                            task.spawn(function()
                                local LastPosition = Part.Position
                                task.wait(0.3333333333333333)
                                if Part and Part.Parent then
                                    v:SetAttribute("_Prediction", Part.Position - LastPosition)
                                end
                            end)

                            if Value then
                                local IncludeList = {}
                                for _, Room in pairs(Rooms:GetChildren()) do
                                    if Room:FindFirstChild("Assets") then
                                        table.insert(IncludeList, Room.Assets)
                                    end
                                    if Room:FindFirstChild("Parts") then
                                        table.insert(IncludeList, Room.Parts)
                                    end
                                end

                                local RaycastParams = RaycastParams.new()
                                RaycastParams.FilterDescendantsInstances = IncludeList
                                RaycastParams.FilterType = Enum.RaycastFilterType.Include

                                local Count = {0.2, 0.4, 0.6, 0.8, 1}
                                local entityInRange = false

                                for i = 1, #Count do
                                    local Number = 1.5 * Count[i]
                                    local predAttr = v:GetAttribute("_Prediction")
                                    local Prediction = (predAttr and (predAttr * 3)) or Vector3.new(0, 0, 0)
                                    Prediction = Prediction * Number

                                    local char = LocalPlayer.Character
                                    if not char then break end

                                    local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Collision") or char.PrimaryPart
                                    if not hrp then break end

                                    if Vector3.new(Prediction.X, 0, Prediction.Z).Magnitude > 1 then
                                        local PredictionPosition = Part.Position + Prediction
                                        local Raycast
                                        if true then
                                            Raycast = workspace:Raycast(hrp.Position, PredictionPosition - hrp.Position, RaycastParams)
                                        end

                                        local distMultiplier = 1
                                        local mode = "Safety"
                                        local adjust = 0

                                        if mode == "Safety" then
                                            adjust = 20
                                        elseif mode == "Close Call" then
                                            adjust = -20
                                        end

                                        local adjustedDistance = EntityDistances[v.Name] + adjust
                                        local distanceToEntity = (PredictionPosition - hrp.Position).Magnitude

                                        if not Raycast and distanceToEntity <= (adjustedDistance * distMultiplier) then
                                            entityInRange = true
                                            local Prompt = GetHiding()
                                            if Prompt then
                                                pcall(function()
                                                    fireproximityprompt(Prompt)
                                                end)
                                            end
                                            break
                                        end
                                    end
                                end

                                local char = LocalPlayer.Character
                                if char and not entityInRange and char:GetAttribute("Hiding") then
                                    char:SetAttribute("Hiding", false)
                                end
                            end
                        end
                    end
                end))
            else
                for _, conn in ipairs(Connections) do
                    conn:Disconnect()
                end
                Connections = {}
            end
        end
    })

B:Dropdown({
        Title = "自动隐藏模式",
        Values = {"Safety", "Close Call"},
        Default = "Safety",
        Callback = function(Value) end
    })

   B:Slider({
        Title = "预测时间",
        Value = {Min = 0.1, Max = 1.5, Default = 1.5},
        Suffix = "s",
        Callback = function(Value) end
    })

    B:Slider({
        Title = "距离倍数",
        Value = {Min = 1, Max = 1.5, Default = 1},
        Suffix = "x",
        Callback = function(Value) end
    })
    local AutoInteractDistance = 10
    B:Toggle({
        Title = "自动互动",
        Default = false,
        Callback = function(Value)
            if Value then
                local RunService = game:GetService("RunService")
                local LocalPlayer = game.Players.LocalPlayer

                local AutoInteractConnection
                local CachedInteractables = {}
                local PromptSeen = {}
                local InteractableModels = {
                    AlarmClock = true, GlitchCub = true, Aloe = true, BandagePack = true, Battery = true,
                    TimerLever = true, OuterPart = true, BatteryPack = true, Candle = true, LiveBreakerPolePickup = true,
                    Compass = true, Crucifix = true, ElectricalRoomKey = true, Flashlight = true, Glowstick = true,
                    HolyHandGrenade = true, Lantern = true, LaserPointer = true, Lighter = true, Lockpick = true,
                    LotusFlower = true, LotusPetalPickup = true, Multitool = true, NVCS3000 = true, OutdoorsKey = true,
                    Shears = true, SkeletonKey = true, Smoothie = true, SolutionPaper = true, Spotlight = true,
                    StarlightVial = true, StarlightJug = true, StarlightBottle = true, Vitamins = true,
                }

                local function PickRootPart(obj, prompt)
                    if prompt and prompt.Parent and prompt.Parent:IsA("BasePart") then
                        return prompt.Parent
                    end
                    if obj:IsA("Model") then
                        if obj.PrimaryPart and obj.PrimaryPart:IsA("BasePart") then
                            return obj.PrimaryPart
                        end
                        local common = obj:FindFirstChild("Main", true) or obj:FindFirstChild("Handle", true) or obj:FindFirstChild("Door", true)
                        if common and common:IsA("BasePart") then
                            return common
                        end
                    end
                    return obj:FindFirstChildWhichIsA("BasePart", true)
                end

                local function AddPromptsFromObject(obj)
                    for _, desc in ipairs(obj:GetDescendants()) do
                        if desc:IsA("ProximityPrompt") and not PromptSeen[desc] then
                            local root = PickRootPart(obj, desc)
                            if root then
                                PromptSeen[desc] = true
                                table.insert(CachedInteractables, {
                                    prompt = desc,
                                    part = root,
                                    last = 0,
                                })
                            end
                        end
                    end
                end

                local function CollectTargets(folder)
                    for _, v in ipairs(folder:GetChildren()) do
                        if v:IsA("Model") or v:IsA("Folder") then
                            if v.Name == "DrawerContainer" or InteractableModels[v.Name] or v.Name == "RoomsLootItem" or v.Name == "Locker_Small" or v.Name == "Toolbox" or v.Name == "ChestBox" or v.Name == "Toolshed_Small" or v.Name == "CrucifixOnTheWall" then
                                AddPromptsFromObject(v)
                            end
                            CollectTargets(v)
                        end
                    end
                end

                local function RefreshTargets()
                    CachedInteractables = {}
                    PromptSeen = {}
                    local CurrentRoom = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]
                    if not CurrentRoom then return end
                    CollectTargets(CurrentRoom)
                end

                local lastCheck = 0
                local interval = 0.2

                local function AutoInteractStep(dt)
                    lastCheck = lastCheck + dt
                    if lastCheck < interval then return end
                    lastCheck = 0

                    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Collision") then
                        return
                    end

                    local charPos = LocalPlayer.Character.Collision.Position
                    local now = tick()

                    for i = #CachedInteractables, 1, -1 do
                        local entry = CachedInteractables[i]
                        local prompt, part = entry.prompt, entry.part

                        if not prompt or not prompt.Parent or not part or not part:IsDescendantOf(workspace) then
                            table.remove(CachedInteractables, i)
                        else
                            local dist = (part.Position - charPos).Magnitude
                            if dist <= AutoInteractDistance and (now - (entry.last or 0)) >= 0.35 then
                                entry.last = now
                                task.spawn(function()
                                    pcall(function()
                                        fireproximityprompt(prompt)
                                    end)
                                end)
                            end
                        end
                    end
                end

                RefreshTargets()
                AutoInteractConnection = RunService.Heartbeat:Connect(AutoInteractStep)

                local attributeConn
                local roomDescConn

                attributeConn = LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
                    RefreshTargets()
                    if roomDescConn then
                        roomDescConn:Disconnect()
                        roomDescConn = nil
                    end
                    local cr = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]
                    if cr then
                        roomDescConn = cr.DescendantAdded:Connect(function()
                            task.defer(RefreshTargets)
                        end)
                    end
                end)

                local cr = workspace.CurrentRooms[LocalPlayer:GetAttribute("CurrentRoom")]
                if cr then
                    roomDescConn = cr.DescendantAdded:Connect(function()
                        task.defer(RefreshTargets)
                    end)
                end

                _G.StopAutoInteract = function()
                    if AutoInteractConnection then
                        AutoInteractConnection:Disconnect()
                        AutoInteractConnection = nil
                    end
                    if attributeConn then
                        attributeConn:Disconnect()
                        attributeConn = nil
                    end
                    if roomDescConn then
                        roomDescConn:Disconnect()
                        roomDescConn = nil
                    end
                    CachedInteractables, PromptSeen = {}, {}
                end
            elseif _G.StopAutoInteract then
                _G.StopAutoInteract()
                _G.StopAutoInteract = nil
            end
        end
    })

    B:Slider({
        Title = "自动互动距离",
        Value = {Min = 1, Max = 20, Default = 10},
        Suffix = " studs",
        Callback = function(Value)
            AutoInteractDistance = Value
        end
    })
    B:Toggle({
        Title = "自动矿车推动",
        Default = false,
        Callback = function(Value)
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local LocalPlayer = Players.LocalPlayer
            local Workspace = game:GetService("Workspace")
            local Rooms = Workspace:WaitForChild("CurrentRooms")

            if _G.AutoMinecartConn then
                _G.AutoMinecartConn:Disconnect()
                _G.AutoMinecartConn = nil
            end
            if _G.AutoMinecartLoop then
                _G.AutoMinecartLoop:Disconnect()
                _G.AutoMinecartLoop = nil
            end

            if Value then
                local function tryPush(cartModel)
                    local cart = cartModel:FindFirstChild("Cart")
                    if not cart then return end
                    local prompt = cart:FindFirstChild("PushPrompt")
                    if not prompt then return end

                    local character = LocalPlayer.Character
                    local root = character and character:FindFirstChild("HumanoidRootPart")
                    if not root then return end

                    if (root.Position - prompt.Parent.Position).Magnitude <= (prompt.MaxActivationDistance or 10) then
                        fireproximityprompt(prompt)
                    end
                end

                _G.AutoMinecartConn = Rooms.DescendantAdded:Connect(function(obj)
                    if obj.Name == "MinecartMoving" then
                        task.defer(function()
                            tryPush(obj)
                        end)
                    end
                end)

                _G.AutoMinecartLoop = RunService.Heartbeat:Connect(function()
                    local character = LocalPlayer.Character
                    local root = character and character:FindFirstChild("HumanoidRootPart")
                    if not root then return end

                    for _, obj in ipairs(Rooms:GetDescendants()) do
                        if obj.Name == "MinecartMoving" then
                            tryPush(obj)
                        end
                    end
                end)
            else
                if _G.AutoMinecartConn then
                    _G.AutoMinecartConn:Disconnect()
                end
                if _G.AutoMinecartLoop then
                    _G.AutoMinecartLoop:Disconnect()
                end
                _G.AutoMinecartConn = nil
                _G.AutoMinecartLoop = nil
            end
        end
    })
    B:Toggle({
        Title = "自动拾取投掷物",
        Default = false,
        Callback = function(Value)
            local targetProps = {
                "WoodenCrate", "OilBarrel", "GarbageBag", "Trashcan", 
                "CardboardBox_Normal", "Hat_Stand", "CardboardBox_Wide", "Office_Chair"
            }
            local running = true

            if Value then
                task.spawn(function()
                    while running and Value do
                        local bigProps = workspace:FindFirstChild("BigProps")
                        if bigProps then
                            for _, name in ipairs(targetProps) do
                                local prop = bigProps:FindFirstChild(name)
                                if prop then
                                    for _, d in ipairs(prop:GetDescendants()) do
                                        if d:IsA("ProximityPrompt") then
                                            d.MaxActivationDistance = 20
                                            if d.Enabled then
                                                pcall(fireproximityprompt, d)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        task.wait(0.5)
                    end
                end)
            else
                running = false
            end
        end
    })
    B:Toggle({
        Title = "自动破门",
        Default = false,
        Callback = function(Value)
            local connections = {}
            local running = false
            local targetNames = {"DoorPieceBottom", "DoorPieceTop"}

            local function safeDisconnect()
                for _, c in ipairs(connections) do
                    if c and c.Disconnect then
                        pcall(function() c:Disconnect() end)
                    elseif c and c.disconnect then
                        pcall(function() c:disconnect() end)
                    end
                end
                connections = {}
            end

            local function handlePrompt(p)
                pcall(function() p.MaxActivationDistance = 40 end)
                if p.Enabled then
                    pcall(fireproximityprompt, p)
                end
            end

            local function processModel(m)
                for _, n in ipairs(targetNames) do
                    local part = m:FindFirstChild(n, true)
                    if part then
                        for _, d in ipairs(part:GetDescendants()) do
                            if d:IsA("ProximityPrompt") then
                                pcall(handlePrompt, d)
                            end
                        end

                        local con = part.DescendantAdded:Connect(function(desc)
                            if desc:IsA("ProximityPrompt") then
                                pcall(function() task.defer(handlePrompt, desc) end)
                            end
                        end)
                        table.insert(connections, con)
                    end
                end
            end

            local function scanAll()
                local cr = workspace:FindFirstChild("CurrentRooms")
                if not cr then return end

                for _, room in ipairs(cr:GetDescendants()) do
                    if room:IsA("Model") or room:IsA("Folder") then
                        processModel(room)
                    end
                end
            end

            if Value then
                running = true
                safeDisconnect()
                
                task.spawn(function()
                    scanAll()
                    local cr = workspace:FindFirstChild("CurrentRooms")
                    if cr then
                        local con = cr.DescendantAdded:Connect(function(d)
                            if not running then return end
                            local model = d
                            while model and not (model:IsA("Model") or model:IsA("Folder")) do
                                model = model.Parent
                            end
                            if model then
                                task.defer(processModel, model)
                            end
                        end)
                        table.insert(connections, con)
                    end

                    while running and Value do
                        scanAll()
                        task.wait(0.8)
                    end
                end)
            else
                running = false
                safeDisconnect()
            end
        end
    })
    B:Toggle({
        Title = "自动拾取",
        Default = false,
        Callback = function(Value)
            local connections = {}
            local running = false

            local function safeDisconnect()
                for _, c in ipairs(connections) do
                    if c and c.Disconnect then
                        pcall(function() c:Disconnect() end)
                    elseif c and c.disconnect then
                        pcall(function() c:disconnect() end)
                    end
                end
                connections = {}
            end

            local function handlePrompt(p)
                pcall(function() p.MaxActivationDistance = 40 end)
                if p.Enabled then
                    pcall(fireproximityprompt, p)
                end
            end

            local function processDrop(d)
                for _, desc in ipairs(d:GetDescendants()) do
                    if desc:IsA("ProximityPrompt") then
                        pcall(handlePrompt, desc)
                    end
                end

                local con = d.DescendantAdded:Connect(function(desc)
                    if desc:IsA("ProximityPrompt") then
                        pcall(function() task.defer(handlePrompt, desc) end)
                    end
                end)
                table.insert(connections, con)
            end

            local function scanDrops()
                local drops = workspace:FindFirstChild("Drops")
                if not drops then return end

                for _, child in ipairs(drops:GetChildren()) do
                    if child:IsA("Model") or child:IsA("Folder") then
                        processDrop(child)
                    end
                end
            end

            if Value then
                running = true
                safeDisconnect()
                
                task.spawn(function()
                    scanDrops()
                    local drops = workspace:FindFirstChild("Drops")
                    if drops then
                        local con = drops.ChildAdded:Connect(function(c)
                            if not running then return end
                            if c:IsA("Model") or c:IsA("Folder") then
                                task.defer(processDrop, c)
                            end
                        end)
                        table.insert(connections, con)
                    end

                    while running and Value do
                        scanDrops()
                        task.wait(0.8)
                    end
                end)
            else
                running = false
                safeDisconnect()
            end
        end
    })
    B:Toggle({
        Title = "自动开火",
        Default = false,
        Callback = function(Value)
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local LocalPlayer = Players.LocalPlayer
            local Camera = workspace.CurrentCamera
            local RAY_DISTANCE = 50
            local con = nil
            local triggered = false

            local function safeMouse1Press() pcall(mouse1press) end
            local function safeMouse1Release() pcall(mouse1release) end

            local function isTargetVisible(targetPos)
                local rayParams = RaycastParams.new()
                rayParams.FilterType = Enum.RaycastFilterType.Exclude
                rayParams.FilterDescendantsInstances = {LocalPlayer.Character}

                local origin = Camera.CFrame.Position
                local direction = targetPos - origin
                local result = workspace:Raycast(origin, direction, rayParams)

                if not result then return true end
                return (result.Instance.Position - targetPos).Magnitude < 3
            end

            local function update()
                if not LocalPlayer.Character or not Camera then
                    if triggered then
                        safeMouse1Release()
                        triggered = false
                    end
                    return
                end

                local myChar = LocalPlayer.Character
                local myHead = myChar:FindFirstChild("Head")
                if not myHead then return end

                local lookVector = Camera.CFrame.LookVector
                local origin = Camera.CFrame.Position
                local bestTarget = nil
                local bestDot = 0.995

                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local targetPos = plr.Character.HumanoidRootPart.Position
                        local dirToTarget = (targetPos - origin).Unit
                        local dot = lookVector:Dot(dirToTarget)

                        if dot > bestDot then
                            local dist = (targetPos - origin).Magnitude
                            if dist < RAY_DISTANCE and isTargetVisible(targetPos) then
                                bestDot = dot
                                bestTarget = plr
                            end
                        end
                    end
                end

                if bestTarget then
                    if not triggered then
                        WindUI:Notify("自动开火", "正在向 " .. bestTarget.Name .. " 开火", 2)
                        safeMouse1Press()
                        triggered = true
                    end
                elseif triggered then
                    safeMouse1Release()
                    triggered = false
                end
            end

            if Value then
                if con and con.Connected then
                    con:Disconnect()
                end
                con = RunService.RenderStepped:Connect(function()
                    pcall(update)
                end)
            else
                if con then
                    con:Disconnect()
                    con = nil
                end
                if triggered then
                    safeMouse1Release()
                    triggered = false
                end
            end
        end
    })
    B:Toggle({
        Title = "自动房间",
        Default = false,
        Callback = function(enabled)
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local PathfindingService = game:GetService("PathfindingService")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Workspace = game:GetService("Workspace")
            local player = Players.LocalPlayer
            local rooms = Workspace:WaitForChild("CurrentRooms")
            local gameData = ReplicatedStorage:WaitForChild("GameData")
            local floor = gameData:WaitForChild("Floor")
            local active = false
            local runner
            local clone

            local function stop()
                active = false
                if runner then
                    runner:Disconnect()
                    runner = nil
                end
                if clone and clone.Parent then
                    clone:Destroy()
                end
                player:SetAttribute("AutoRoomsActive", false)
            end

            if not enabled then
                stop()
                return
            end

            player:SetAttribute("AutoRoomsActive", true)
            active = true

            if player.Character and player.Character:FindFirstChild("CollisionPart") then
                clone = player.Character.CollisionPart:Clone()
                clone.Name = "_AutoRoomsCollision"
                clone.Massless = true
                clone.Anchored = false
                clone.CanCollide = false
                clone.CanQuery = false
                clone.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0.7, 0, 1, 1)
                clone.Parent = player.Character
            end

            local function findClosestLocker()
                local best, bestDist = nil, math.huge
                for _, obj in ipairs(rooms:GetDescendants()) do
                    if obj.Name == "Rooms_Locker" or obj.Name == "Rooms_Locker_Fridge" then
                        if obj.PrimaryPart then
                            local dist = (player.Character.HumanoidRootPart.Position - obj.PrimaryPart.Position).Magnitude
                            if dist < bestDist then
                                best = obj
                                bestDist = dist
                            end
                        end
                    end
                end
                return best
            end

            local function walkTo(target)
                local char = player.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end

                local path = PathfindingService:CreatePath({
                    AgentRadius = 2,
                    AgentHeight = 1,
                    AgentCanJump = false,
                    WaypointSpacing = 5,
                })

                path:ComputeAsync(char.HumanoidRootPart.Position, target.Position)

                if path.Status == Enum.PathStatus.Success then
                    for _, waypoint in ipairs(path:GetWaypoints()) do
                        if not active then return end
                        char:FindFirstChildOfClass("Humanoid"):MoveTo(waypoint.Position)
                        char.Humanoid.MoveToFinished:Wait()
                    end
                end
            end

            runner = RunService.Heartbeat:Connect(function()
                if not active then return end
                if floor.Value ~= "Rooms" then return stop() end
                if gameData.LatestRoom.Value >= 1000 then return stop() end

                local entity = Workspace:FindFirstChild("A60") or Workspace:FindFirstChild("A120") or Workspace:FindFirstChild("GlitchRush") or Workspace:FindFirstChild("GlitchAmbush")

                if entity and entity.PrimaryPart and entity.PrimaryPart.Position.Y > -6 then
                    local locker = findClosestLocker()
                    if locker and locker.PrimaryPart then
                        local hide = locker:FindFirstChild("HidePoint")
                        if not hide then
                            hide = Instance.new("Part")
                            hide.Name = "HidePoint"
                            hide.Anchored = true
                            hide.Transparency = 1
                            hide.CanCollide = false
                            hide.Position = locker.PrimaryPart.Position + (locker.PrimaryPart.CFrame.LookVector * 7)
                            hide.Parent = locker
                        end

                        walkTo(hide)
                        task.wait(0.1)

                        local prompt = locker:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then
                            if fireproximityprompt then
                                fireproximityprompt(prompt)
                            else
                                prompt:InputHoldBegin()
                                prompt:InputHoldEnd()
                            end
                        end
                    end
                else
                    local currentRoom = gameData.LatestRoom.Value
                    local door = rooms[currentRoom] and rooms[currentRoom]:FindFirstChild("Door", true)
                    if door and door:FindFirstChild("Door") then
                        walkTo(door.Door)
                    end
                end
            end)
        end
    })

   B:Toggle({
        Title = "反AFK",
        Default = false,
        Callback = function(Value)
            local Players = game:GetService("Players")
            local VirtualUser = game:GetService("VirtualUser")
            local LocalPlayer = Players.LocalPlayer
            local AntiAFKConnection

            if Value then
                AntiAFKConnection = LocalPlayer.Idled:Connect(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end)
                WindUI:Notify("反AFK", "反AFK已启用", 3)
            elseif AntiAFKConnection then
                AntiAFKConnection:Disconnect()
                AntiAFKConnection = nil
                WindUI:Notify("反AFK", "反AFK已禁用", 3)
            end
        end
    })
    B:Toggle({
        Title = "自动门范围",
        Default = false,
        Callback = function(Value)
            local doorReachLoop

            if Value then
                local Rooms = workspace:FindFirstChild("CurrentRooms")
                if not Rooms then return end

                doorReachLoop = task.spawn(function()
                    while Value do
                        for _, room in pairs(Rooms:GetChildren()) do
                            local door = room:FindFirstChild("Door")
                            if door and door:FindFirstChild("ClientOpen") then
                                door.ClientOpen:FireServer()
                            end
                        end
                        task.wait(0.5)
                    end
                end)
                WindUI:Notify("自动门", "自动门范围已启用", 3)
            else
                doorReachLoop = nil
                WindUI:Notify("自动门", "自动门范围已禁用", 3)
            end
        end
    })
    B:Toggle({
        Title = "即时互动",
        Default = false,
        Callback = function(Value)
            if getgenv().ProximityConnection then
                getgenv().ProximityConnection:Disconnect()
                getgenv().ProximityConnection = nil
            end

            local function modifyPrompt(prompt, instant)
                if not prompt:IsA("ProximityPrompt") then return end
                if instant then
                    if not prompt:GetAttribute("OriginalHoldDuration") then
                        prompt:SetAttribute("OriginalHoldDuration", prompt.HoldDuration)
                        prompt:SetAttribute("OriginalLineOfSight", prompt.RequiresLineOfSight)
                    end
                    prompt.HoldDuration = 0
                    prompt.RequiresLineOfSight = false
                else
                    prompt.HoldDuration = prompt:GetAttribute("OriginalHoldDuration") or 1
                    prompt.RequiresLineOfSight = prompt:GetAttribute("OriginalLineOfSight") or true
                end
            end

            local currentRooms = workspace:FindFirstChild("CurrentRooms")
            if currentRooms then
                for _, prompt in ipairs(currentRooms:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") then
                        modifyPrompt(prompt, Value)
                    end
                end
            end

            if Value and currentRooms then
                getgenv().ProximityConnection = currentRooms.DescendantAdded:Connect(function(descendant)
                    if descendant:IsA("ProximityPrompt") then
                        modifyPrompt(descendant, true)
                    end
                end)
            end

            WindUI:Notify("即时互动", Value and "已启用" or "已禁用", 3)
        end
    })
    B:Slider({
        Title = "既时互动范围提升",
        Value = {Min = 1, Max = 5, Default = 1},
        Suffix = "x",
        Callback = function(multiplier)
            local originalRanges = {}
            local rangeConnections = {}

            local function updateProximityPromptRanges(multiplier)
                local function modifyPrompt(prompt)
                    if not originalRanges[prompt] then
                        originalRanges[prompt] = prompt.MaxActivationDistance
                    end
                    prompt.MaxActivationDistance = originalRanges[prompt] * multiplier
                end

                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant:IsA("ProximityPrompt") then
                        modifyPrompt(descendant)
                    end
                end
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player.PlayerGui then
                        for _, descendant in pairs(player.PlayerGui:GetDescendants()) do
                            if descendant:IsA("ProximityPrompt") then
                                modifyPrompt(descendant)
                            end
                        end
                    end
                end
            end

            local function setupRangeConnections(multiplier)
                for _, connection in pairs(rangeConnections) do
                    connection:Disconnect()
                end
                rangeConnections = {}

                table.insert(rangeConnections, workspace.DescendantAdded:Connect(function(descendant)
                    if descendant:IsA("ProximityPrompt") then
                        task.wait(0.1)
                        originalRanges[descendant] = descendant.MaxActivationDistance
                        descendant.MaxActivationDistance = originalRanges[descendant] * multiplier
                    end
                end))

                for _, player in pairs(game.Players:GetPlayers()) do
                    if player.PlayerGui then
                        table.insert(rangeConnections, player.PlayerGui.DescendantAdded:Connect(function(descendant)
                            if descendant:IsA("ProximityPrompt") then
                                task.wait(0.1)
                                originalRanges[descendant] = descendant.MaxActivationDistance
                                descendant.MaxActivationDistance = originalRanges[descendant] * multiplier
                            end
                        end))
                    end
                end
            end

            if multiplier == 1 then
                for prompt, originalRange in pairs(originalRanges) do
                    if prompt and prompt.Parent then
                        prompt.MaxActivationDistance = originalRange
                    end
                end
                for _, connection in pairs(rangeConnections) do
                    connection:Disconnect()
                end
                rangeConnections = {}
            else
                updateProximityPromptRanges(multiplier)
                setupRangeConnections(multiplier)
            end

            WindUI:Notify("互动范围", "已设置为 " .. multiplier .. "x", 3)
        end
    })
    local A = Window:Tab({Title = "规避类", Icon = "shield"})
    A:Toggle({
        Title = "规避Screech",
        Default = false,
        Callback = function(on)
            if on then
                for _, inst in ipairs(workspace:GetDescendants()) do
                    if inst.Name == "Screech" then
                        pcall(function()
                            inst:Destroy()
                        end)
                    end
                end

                getgenv().AntiScreechConn = workspace.DescendantAdded:Connect(function(inst)
                    if inst.Name == "Screech" then
                        task.defer(function()
                            if inst and inst.Parent then
                                pcall(function()
                                    inst:Destroy()
                                end)
                            end
                        end)
                    end
                end)
            elseif getgenv().AntiScreechConn then
                getgenv().AntiScreechConn:Disconnect()
                getgenv().AntiScreechConn = nil
            end
        end
    })

    A:Toggle({
        Title = "规避Gloom蛋",
        Default = false,
        Callback = function(Value)
            if getgenv().AntiGloomConn then
                getgenv().AntiGloomConn:Disconnect()
                getgenv().AntiGloomConn = nil
            end

            local rooms = workspace:WaitForChild("CurrentRooms")

            if Value then
                for _, v in ipairs(rooms:GetDescendants()) do
                    if v.Name == "GloomEgg" then
                        local egg = v:FindFirstChild("Egg")
                        if egg then
                            egg.CanTouch = false
                        end
                    end
                end

                getgenv().AntiGloomConn = rooms.DescendantAdded:Connect(function(v)
                    if v.Name == "GloomEgg" then
                        local egg = v:WaitForChild("Egg", 8999999488)
                        egg.CanTouch = false
                    elseif v.Name == "Egg" and v.Parent and v.Parent.Name == "GloomEgg" then
                        v.CanTouch = false
                    end
                end)
            else
                for _, v in ipairs(rooms:GetDescendants()) do
                    if v.Name == "GloomEgg" then
                        local egg = v:FindFirstChild("Egg")
                        if egg then
                            egg.CanTouch = true
                        end
                    end
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Dread",
        Default = false,
        Callback = function(isEnabled)
            local player = game:GetService("Players").LocalPlayer
            local modules = player.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules
            local dreadModule = modules:FindFirstChild("Dread") or modules:FindFirstChild("_Dread")

            if dreadModule then
                dreadModule.Name = isEnabled and "_Dread" or "Dread"
            end
        end
    })

    A:Toggle({
        Title = "规避Giggle",
        Default = false,
        Callback = function(Value)
            if getgenv().AntiGiggleConn then
                getgenv().AntiGiggleConn:Disconnect()
                getgenv().AntiGiggleConn = nil
            end

            local rooms = workspace:WaitForChild("CurrentRooms")

            if Value then
                for _, v in ipairs(rooms:GetDescendants()) do
                    if v.Name == "GiggleCeiling" then
                        local hitbox = v:FindFirstChild("Hitbox")
                        if hitbox then
                            hitbox.CanTouch = false
                        end
                    end
                end

                getgenv().AntiGiggleConn = rooms.DescendantAdded:Connect(function(v)
                    if v.Name == "GiggleCeiling" then
                        local hitbox = v:WaitForChild("Hitbox", 8999999488)
                        hitbox.CanTouch = false
                    elseif v.Name == "Hitbox" and v.Parent and v.Parent.Name == "GiggleCeiling" then
                        v.CanTouch = false
                    end
                end)
            else
                for _, v in ipairs(rooms:GetDescendants()) do
                    if v.Name == "GiggleCeiling" then
                        local hitbox = v:FindFirstChild("Hitbox")
                        if hitbox then
                            hitbox.CanTouch = true
                        end
                    end
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Figure听觉",
        Default = false,
        Tooltip = "让游戏认为你在蹲下",
        Callback = function(Value)
            local crouchConnection
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local RunService = game:GetService("RunService")

            if crouchConnection then
                crouchConnection:Disconnect()
                crouchConnection = nil
            end

            if Value then
                crouchConnection = RunService.Heartbeat:Connect(function()
                    ReplicatedStorage.RemotesFolder.Crouch:FireServer(true)
                end)
            else
                ReplicatedStorage.RemotesFolder.Crouch:FireServer(false)
            end
        end
    })

    A:Toggle({
        Title = "规避Surge",
        Default = false,
        Callback = function(Value)
            if Value then
                local surgeClient = game.ReplicatedStorage:WaitForChild("FloorReplicated"):WaitForChild("ClientRemote"):FindFirstChild("SurgeClient")
                if surgeClient then
                    surgeClient:Destroy()
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Halt",
        Default = false,
        Callback = function(Value)
            local entityModules = game:GetService("ReplicatedStorage"):WaitForChild("ModulesClient"):WaitForChild("EntityModules")

            if Value then
                local shade = entityModules:FindFirstChild("Shade")
                if shade and shade:IsA("ModuleScript") then
                    shade.Name = "_Shade"
                end
            else
                local shade = entityModules:FindFirstChild("_Shade")
                if shade and shade:IsA("ModuleScript") then
                    shade.Name = "Shade"
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Lookman",
        Default = false,
        Callback = function(Value)
            if Value then
                if workspace:FindFirstChild("BackdoorLookman") then
                    game.ReplicatedStorage.RemotesFolder.MotorReplication:FireServer(-890)
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Snare",
        Default = false,
        Callback = function(Value)
            local currentRooms = workspace:WaitForChild("CurrentRooms")

            local function handleSnare(snare)
                if snare.Name == "Snare" then
                    local hitbox = snare:FindFirstChild("Hitbox")
                    if hitbox then
                        hitbox.CanTouch = not Value
                    else
                        snare.ChildAdded:Connect(function(child)
                            if child.Name == "Hitbox" then
                                child.CanTouch = not Value
                            end
                        end)
                    end
                end
            end

            for _, v in ipairs(currentRooms:GetDescendants()) do
                handleSnare(v)
            end

            currentRooms.DescendantAdded:Connect(handleSnare)
        end
    })

    A:Toggle({
        Title = "规避Seek障碍物",
        Default = false,
        Callback = function(Value)
            local Rooms = workspace.CurrentRooms

            if Value then
                getgenv().AntiSeekObstaclesConn = Rooms.DescendantAdded:Connect(function(desc)
                    if desc.Name == "Seek_Arm" then
                        desc:WaitForChild("AnimatorPart", 8999999488)
                        desc.AnimatorPart.CanTouch = false
                        desc.AnimatorPart.Transparency = 1

                        for _, part in desc:GetDescendants() do
                            if part:IsA("BasePart") then
                                part.Transparency = 1
                            end
                        end
                    elseif desc.Name == "ChandelierObstruction" then
                        desc:WaitForChild("HurtPart", 8999999488)
                        desc.HurtPart.CanTouch = false
                        desc.HurtPart.Transparency = 1

                        for _, part in desc:GetDescendants() do
                            if part:IsA("BasePart") then
                                part.Transparency = 1
                            end
                        end
                    end
                end)

                for _, v in Rooms:GetDescendants() do
                    if v.Name == "Seek_Arm" and v:IsA("Model") then
                        v:WaitForChild("AnimatorPart", 8999999488)
                        v.AnimatorPart.CanTouch = false
                        v.AnimatorPart.Transparency = 1

                        for _, part in v:GetDescendants() do
                            if part:IsA("BasePart") then
                                part.Transparency = 1
                            end
                        end
                    elseif v.Name == "ChandelierObstruction" and v:IsA("Model") then
                        v:WaitForChild("HurtPart", 8999999488)
                        v.HurtPart.CanTouch = false
                        v.HurtPart.Transparency = 1

                        for _, part in v:GetDescendants() do
                            if part:IsA("BasePart") then
                                part.Transparency = 1
                            end
                        end
                    end
                end
            else
                if getgenv().AntiSeekObstaclesConn then
                    getgenv().AntiSeekObstaclesConn:Disconnect()
                end

                for _, v in Rooms:GetDescendants() do
                    if v.Name == "Seek_Arm" and v:IsA("Model") then
                        v:WaitForChild("AnimatorPart", 8999999488)
                        v.AnimatorPart.CanTouch = true
                        v.AnimatorPart.Transparency = 0

                        for _, part in v:GetDescendants() do
                            if part:IsA("BasePart") then
                                part.Transparency = 0
                            end
                        end
                    elseif v.Name == "ChandelierObstruction" and v:IsA("Model") then
                        v:WaitForChild("HurtPart", 8999999488)
                        v.HurtPart.CanTouch = true
                        v.HurtPart.Transparency = 0

                        for _, part in v:GetDescendants() do
                            if part:IsA("BasePart") then
                                part.Transparency = 0
                            end
                        end
                    end
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Dupe门",
        Default = false,
        Callback = function(Value)
            for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
                if v.Name == "DoorFake" then
                    v:WaitForChild("Hidden").CanTouch = not Value

                    local lock = v:FindFirstChild("Lock")
                    if lock then
                        local prompt = lock:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then
                            prompt.ClickablePrompt = not Value
                        end
                    end
                end
            end
        end
    })

    A:Toggle({
        Title = "规避真空区域",
        Default = false,
        Callback = function(Value)
            for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
                if v.Name == "SideroomSpace" then
                    for _, part in ipairs(v:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanTouch = not Value
                            part.CanCollide = Value
                        end
                    end
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Eyes",
        Default = false,
        Tooltip = "当Eyes出现时自动向下看以防止伤害",
        Callback = function(Value)
            local LocalPlayer = game.Players.LocalPlayer
            local Connections = {}

            if Value then
                Connections.AntiEyes = game:GetService("RunService").RenderStepped:Connect(function()
                    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        return
                    end
                    if not LocalPlayer.Character:GetAttribute("Hiding") then
                        for _, v in pairs(workspace:GetChildren()) do
                            if v.Name == "Eyes" and v:FindFirstChild("Core") and v.Core:FindFirstChild("Ambience") and v.Core.Ambience.Playing then
                                game.ReplicatedStorage.RemotesFolder.MotorReplication:FireServer(-650)
                                break
                            end
                        end
                    end
                end)
            elseif Connections.AntiEyes then
                Connections.AntiEyes:Disconnect()
                Connections.AntiEyes = nil
            end
        end
    })

    A:Toggle({
        Title = "规避A-90",
        Default = false,
        Tooltip = "移除A90",
        Callback = function(ad)
            local LocalPlayer = game.Players.LocalPlayer
            local modules = LocalPlayer.PlayerGui:FindFirstChild("MainUI") and 
                           LocalPlayer.PlayerGui.MainUI:FindFirstChild("Initiator") and 
                           LocalPlayer.PlayerGui.MainUI.Initiator:FindFirstChild("Main_Game") and 
                           LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game:FindFirstChild("RemoteListener") and 
                           LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener:FindFirstChild("Modules")
            local c3 = modules and (modules:FindFirstChild("A90") or modules:FindFirstChild("_A90"))

            if c3 then
                c3.Name = ad and "_A90" or "A90"
            end

            local remote = (game:GetService("ReplicatedStorage"):FindFirstChild("RemotesFolder") and 
                           game:GetService("ReplicatedStorage").RemotesFolder:FindFirstChild("A90")) or 
                           game:GetService("ReplicatedStorage").RemotesFolder:FindFirstChild("_A90")

            if remote then
                remote.Name = ad and "_A90" or "A90"
            end
        end
    })
    A:Toggle({
        Title = "规避虚空效果",
        Default = false,
        Callback = function(Value)
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local entityModules = ReplicatedStorage:FindFirstChild("ModulesClient") and 
                                 ReplicatedStorage.ModulesClient:FindFirstChild("EntityModules")

            if not entityModules then
                return
            end

            local voidModule = entityModules:FindFirstChild("Void") or entityModules:FindFirstChild("_Void")

            if not voidModule then
                return
            end

            if Value then
                if voidModule.Name == "Void" then
                    voidModule.Name = "_Void"
                end
            elseif voidModule.Name == "_Void" then
                voidModule.Name = "Void"
            end
        end
    })

    A:Toggle({
        Title = "规避Haste效果",
        Default = false,
        Callback = function(Value)
            if game.ReplicatedStorage.FloorReplicated.ClientRemote:FindFirstChild("Haste") then
                local HasteChanged = game.ReplicatedStorage.FloorReplicated.ClientRemote.Haste.Ambience:GetPropertyChangedSignal("Playing"):Connect(function()
                    if Value then
                        game.ReplicatedStorage.FloorReplicated.ClientRemote.Haste.Ambience.Playing = false
                    end
                end)
            end

            for _, v in workspace.CurrentCamera:GetChildren() do
                if v.Name == "LiveSanity" and workspace:FindFirstChild("EntityModel") then
                    v.Enabled = not Value
                end
            end
        end
    })

    A:Toggle({
        Title = "规避Firedamp",
        Default = false,
        Callback = function(Value)
            local camera = workspace:WaitForChild("Camera")
            local targets = {
                LiveSantity = true,
                LiveFiredamp = true,
            }

            local function checkAndDelete(obj)
                if targets[obj.Name] then
                    obj:Destroy()
                end
            end

            if getgenv().AntiFiredampConnection then
                getgenv().AntiFiredampConnection:Disconnect()
                getgenv().AntiFiredampConnection = nil
            end

            if Value then
                for _, child in ipairs(camera:GetChildren()) do
                    checkAndDelete(child)
                end

                getgenv().AntiFiredampConnection = camera.ChildAdded:Connect(function(child)
                    checkAndDelete(child)
                end)
            end
        end
    })

    A:Toggle({
        Title = "规避矿井氛围",
        Default = false,
        Callback = function(Value)
            local Lighting = game:GetService("Lighting")
            if Value then
                local caveAtmosphere = Lighting:FindFirstChild("CaveAtmosphere")
                if caveAtmosphere then
                    caveAtmosphere:Destroy()
                end

                local caves = Lighting:FindFirstChild("Caves")
                if caves then
                    caves:Destroy()
                end
            end
        end
    })

    A:Toggle({
        Title = "规避氧气/理智效果",
        Default = false,
        Callback = function(Value)
            local Lighting = game:GetService("Lighting")
            if Value then
                local sanity = Lighting:FindFirstChild("Sanity")
                if sanity then
                    sanity:Destroy()
                end

                local oxygenCC = Lighting:FindFirstChild("OxygenCC")
                if oxygenCC then
                    oxygenCC:Destroy()
                end

                local oxygenBlur = Lighting:FindFirstChild("OxygenBlur")
                if oxygenBlur then
                    oxygenBlur:Destroy()
                end
            end
        end
    })

    A:Toggle({
        Title = "无雾效果",
        Default = false,
        Callback = function(Value)
            local lighting = game:GetService("Lighting")
            local cave = lighting:FindFirstChild("CaveAtmosphere")

            if Value then
                if cave and cave:IsA("Atmosphere") then
                    cave.Density = 0
                else
                    lighting.FogStart = 1000000
                    lighting.FogEnd = 1000000
                end
            elseif cave and cave:IsA("Atmosphere") then
                cave.Density = 0.15
            else
                lighting.FogStart = 150
                lighting.FogEnd = 150
            end
        end
    })

    A:Toggle({
        Title = "无相机抖动",
        Default = false,
        Callback = function(Value)
            local RequiredMainGame = require(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Initiator"):WaitForChild("Main_Game"))
            
            task.spawn(function()
                while Value and RequiredMainGame do
                    task.wait()
                    if typeof(RequiredMainGame.csgo) == "CFrame" then
                        RequiredMainGame.csgo = CFrame.new()
                    end
                end
            end)
        end
    })

    A:Toggle({
        Title = "无头部晃动",
        Default = false,
        Callback = function(Value)
            local RunService = game:GetService("RunService")
            local RequiredMainGame = require(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Initiator"):WaitForChild("Main_Game"))

            if Value then
                if not getgenv().HeadBobDisabler then
                    getgenv().HeadBobDisabler = RunService.RenderStepped:Connect(function()
                        if RequiredMainGame and RequiredMainGame.spring then
                            if typeof(RequiredMainGame.spring.Target) == "Vector3" then
                                RequiredMainGame.spring.Target = Vector3.zero
                                RequiredMainGame.spring.Position = Vector3.zero
                            end
                        end
                    end)
                end
            elseif getgenv().HeadBobDisabler then
                getgenv().HeadBobDisabler:Disconnect()
                getgenv().HeadBobDisabler = nil
            end
        end
    })
    A:Toggle({
        Title = "无过场动画",
        Default = false,
        Callback = function(Value)
            local player = game:GetService("Players").LocalPlayer
            local RemoteListener = player.PlayerGui.MainUI.Initiator.Main_Game:WaitForChild("RemoteListener")
            local CutScenes = RemoteListener:FindFirstChild("Cutscenes") or RemoteListener:FindFirstChild("_Cutscenes")

            if not CutScenes then
                CutScenes = RemoteListener:WaitForChild("Cutscenes", 3) or RemoteListener:WaitForChild("_Cutscenes", 3)
            end

            if CutScenes then
                CutScenes.Name = Value and "_Cutscenes" or "Cutscenes"
            end
        end
    })

    A:Toggle({
        Title = "规避隐藏边缘",
        Default = false,
        Tooltip = "移除隐藏时的黑暗边缘",
        Callback = function(Value)
            local LocalPlayer = game.Players.LocalPlayer
            LocalPlayer.PlayerGui.MainUI.MainFrame.HideVignette.Image = Value and "rbxassetid://0" or "rbxassetid://6100076320"
        end
    })

   A:Toggle({
        Title = "防卡顿",
        Default = false,
        Callback = function(Value)
            local Modifiers = workspace:FindFirstChild("Modifiers")
            if Modifiers and not Modifiers:FindFirstChild("Jammin") then
                return
            end

            local mainTrack = game["SoundService"]:FindFirstChild("Main")
            if mainTrack then
                local jamming = mainTrack:FindFirstChild("Jamming")
                if jamming then
                    jamming.Enabled = not Value
                end
            end

            local mainUI = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("MainUI")
            if mainUI then
                local healthGui = mainUI:FindFirstChild("Initiator") and 
                                 mainUI.Initiator:FindFirstChild("Main_Game") and 
                                 mainUI.Initiator.Main_Game:FindFirstChild("Health")
                if healthGui then
                    local jamSound = healthGui:FindFirstChild("Jam")
                    if jamSound then
                        jamSound.Playing = not Value
                    end
                end
            end
        end
    })
    A:Toggle({
        Title = "防香蕉皮",
        Default = false,
        Callback = function(Value)
            local currentRooms = workspace:WaitForChild("CurrentRooms")
            
            if getgenv().antiBananaConn then
                getgenv().antiBananaConn:Disconnect()
                getgenv().antiBananaConn = nil
            end

            for _, v in pairs(currentRooms:GetDescendants()) do
                if v.Name == "BananaPeel" and v:IsA("BasePart") then
                    v.CanTouch = not Value
                end
            end

            if Value then
                getgenv().antiBananaConn = currentRooms.DescendantAdded:Connect(function(v)
                    if v.Name == "BananaPeel" and v:IsA("BasePart") then
                        v.CanTouch = false
                    end
                end)
            end
        end
    })

    A:Toggle({
        Title = "防Jeff杀手",
        Default = false,
        Callback = function(Value)
            local currentRooms = workspace:WaitForChild("CurrentRooms")
            
            if getgenv().antiJeffConn then
                getgenv().antiJeffConn:Disconnect()
                getgenv().antiJeffConn = nil
            end

            for _, model in pairs(currentRooms:GetDescendants()) do
                if model.Name == "JeffTheKiller" and model:IsA("Model") then
                    for _, part in ipairs(model:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanTouch = not Value
                        end
                    end
                end
            end

            if Value then
                getgenv().antiJeffConn = currentRooms.DescendantAdded:Connect(function(v)
                    if v.Name == "JeffTheKiller" and v:IsA("Model") then
                        for _, part in ipairs(v:GetChildren()) do
                            if part:IsA("BasePart") then
                                part.CanTouch = false
                            end
                        end
                    end
                end)
            end
        end
    })
    local ESPTab = Window:Tab({Title = "透视功能", Icon = "eye"})
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/mstudio45/MSESP/refs/heads/main/source.luau"))()
ESPLibrary.GlobalConfig.Distance = false
local ColorConfig = {
    ["红色"] = Color3.fromRGB(255, 0, 0),
    ["绿色"] = Color3.fromRGB(0, 255, 0),
    ["蓝色"] = Color3.fromRGB(0, 0, 255),
    ["黄色"] = Color3.fromRGB(255, 255, 0),
    ["紫色"] = Color3.fromRGB(255, 0, 255),
    ["青色"] = Color3.fromRGB(0, 255, 255),
    ["粉色"] = Color3.fromRGB(255, 182, 193),
    ["橙色"] = Color3.fromRGB(255, 165, 0),
    ["白色"] = Color3.fromRGB(255, 255, 255),
    ["彩虹动态"] = Color3.fromRGB(255, 0, 0)
}
local ESPGroup = ESPTab:Section({Title = "ESP设置[展开]", Side = "Left"})

ESPGroup:Toggle({
    Title = "启用追踪线",
    Default = false,
    Callback = function(Value)
        _G.EnableTracers = Value
        UpdateAllESP()
    end
})

ESPGroup:Toggle({
    Title = "启用方向箭头", 
    Default = false,
    Callback = function(Value)
        _G.EnableArrows = Value
        UpdateAllESP()
    end
})

ESPGroup:Dropdown({
    Title = "ESP类型",
    Values = {"高亮", "文字", "选择框"},
    Default = "高亮",
    Callback = function(Value)
        local espTypes = {
            ["高亮"] = "Highlight",
            ["文字"] = "Text", 
            ["选择框"] = "SelectionBox"
        }
        _G.ESPType = espTypes[Value]
        UpdateAllESP()
    end
})

local ObjectESPGroup = ESPTab:Section({Title = "物体透视[展开]", Side = "Left"})

local ObjectESPConfig = {
    {
        Name = "DoorESP",
        Title = "门透视",
        DefaultColor = "白色",
        Models = {"Door"},
        DisplayName = "门"
    },
    {
        Name = "ObjectiveESP", 
        Title = "目标物品透视",
        DefaultColor = "黄色",
        Models = {"KeyObtain", "FuseObtain", "LiveBreakerPolePickup"},
        DisplayName = "目标物品"
    },
    {
        Name = "CoinESP",
        Title = "金币透视",
        DefaultColor = "白色", 
        Models = {"GoldPile"},
        DisplayName = "金币"
    },
    {
        Name = "MinesGeneratorESP",
        Title = "矿洞发电机透视",
        DefaultColor = "青色",
        Models = {"MinesGenerator"},
        DisplayName = "发电机"
    },
    {
        Name = "LeverESP",
        Title = "杠杆透视",
        DefaultColor = "橙色",
        Models = {"LeverForGate"},
        DisplayName = "杠杆"
    },
    {
        Name = "ItemESP",
        Title = "所有物品透视", 
        DefaultColor = "黄色",
        Models = {
            "AlarmClock", "Aloe", "BandagePack", "Battery", "BatteryPack", "Candle",
            "Compass", "Crucifix", "Flashlight", "Glowstick", "HolyHandGrenade",
            "Lantern", "LaserPointer", "Lighter", "Lockpick", "LotusFlower", 
            "Multitool", "NVCS3000", "Shears", "SkeletonKey", "Smoothie", "Vitamins"
        },
        DisplayName = "物品"
    },
    {
        Name = "ClosetESP",
        Title = "柜子透视",
        DefaultColor = "粉色",
        Models = {"Wardrobe", "Toolshed", "Locker_Large", "Backdoor_Wardrobe"},
        DisplayName = "柜子"
    },
    {
        Name = "AnchorESP",
        Title = "锚点透视",
        DefaultColor = "粉色",
        Models = {"MinesAnchor"},
        DisplayName = "锚点"
    },
    {
        Name = "LibraryBookESP",
        Title = "图书馆书籍透视",
        DefaultColor = "青色", 
        Models = {"LiveHintBook"},
        DisplayName = "书籍"
    },
    {
        Name = "ChestESP",
        Title = "宝箱透视",
        DefaultColor = "绿色",
        Models = {"ChestBox", "ChestBoxLocked"},
        DisplayName = "宝箱"
    }
}

local EntityESPConfig = {
    {
        Name = "SeekESP",
        Title = "追逐者透视", 
        DefaultColor = "红色",
        Models = {"SeekMoving"},
        DisplayName = "追逐者"
    },
    {
        Name = "FigureESP",
        Title = "雕像透视",
        DefaultColor = "白色",
        Models = {"FigureRig"},
        DisplayName = "雕像"
    },
    {
        Name = "AmbushESP",
        Title = "伏击透视",
        DefaultColor = "白色",
        Models = {"AmbushMoving"},
        DisplayName = "伏击"
    },
    {
        Name = "RushESP", 
        Title = "冲刺透视",
        DefaultColor = "白色",
        Models = {"RushMoving"},
        DisplayName = "冲刺"
    },
    {
        Name = "SnareESP",
        Title = "陷阱透视",
        DefaultColor = "白色",
        Models = {"Snare"},
        DisplayName = "陷阱"
    },
    {
        Name = "GiggleESP",
        Title = "傻笑透视",
        DefaultColor = "白色",
        Models = {"GiggleCeiling"},
        DisplayName = "傻笑"
    },
    {
        Name = "EyestalkESP",
        Title = "眼柄透视",
        DefaultColor = "白色", 
        Models = {"EyestalkMoving"},
        DisplayName = "眼柄"
    },
    {
        Name = "MandrakeESP",
        Title = "曼德拉草透视",
        DefaultColor = "白色",
        Models = {"Mandrake"},
        DisplayName = "曼德拉草"
    },
    {
        Name = "GroundskeeperESP",
        Title = "园丁透视",
        DefaultColor = "白色",
        Models = {"Groundskeeper"},
        DisplayName = "园丁"
    },
    {
        Name = "BlitzESP",
        Title = "闪电透视",
        DefaultColor = "白色",
        Models = {"BackdoorRush"},
        DisplayName = "闪电"
    }
}

for _, config in ipairs(ObjectESPConfig) do
    ObjectESPGroup:Toggle({
        Title = config.Title,
        Default = false,
        Callback = function(Value)
            CreateESP(config.Name, Value, config.Models, config.DisplayName, _G[config.Name .. "_Color"])
        end
    })
    
    ObjectESPGroup:Dropdown({
        Title = config.Title .. "颜色",
        Values = {"红色", "绿色", "蓝色", "黄色", "紫色", "青色", "粉色", "橙色", "白色", "彩虹动态"},
        Default = config.DefaultColor,
        Callback = function(Value)
            _G[config.Name .. "_Color"] = ColorConfig[Value]
            if _G[config.Name .. "_Enabled"] then
                CreateESP(config.Name, true, config.Models, config.DisplayName, _G[config.Name .. "_Color"])
            end
        end
    })
end
local EntityESPGroup = ESPTab:Section({Title = "实体透视[展开]", Side = "Right"})
for _, config in ipairs(EntityESPConfig) do
    EntityESPGroup:Toggle({
        Title = config.Title,
        Default = false,
        Callback = function(Value)
            CreateESP(config.Name, Value, config.Models, config.DisplayName, _G[config.Name .. "_Color"])
        end
    })
    
    EntityESPGroup:Dropdown({
        Title = config.Title .. "颜色",
        Values = {"红色", "绿色", "蓝色", "黄色", "紫色", "青色", "粉色", "橙色", "白色", "彩虹动态"},
        Default = config.DefaultColor,
        Callback = function(Value)
            _G[config.Name .. "_Color"] = ColorConfig[Value]
            if _G[config.Name .. "_Enabled"] then
                CreateESP(config.Name, true, config.Models, config.DisplayName, _G[config.Name .. "_Color"])
            end
        end
    })
end
local ESPData = {}
local RainbowConnection
function CreateESP(espName, enabled, targetModels, displayName, color)
    if not enabled then
     
        if ESPData[espName] then
            for _, element in pairs(ESPData[espName].Elements) do
                if element and element.Destroy then
                    element:Destroy()
                end
            end
            
            if ESPData[espName].Connections then
                for _, conn in pairs(ESPData[espName].Connections) do
                    if conn then conn:Disconnect() end
                end
            end
            
            ESPData[espName] = nil
        end
        _G[espName .. "_Enabled"] = false
        return
    end
    
  
    _G[espName .. "_Enabled"] = true
    
    if not ESPData[espName] then
        ESPData[espName] = {
            Elements = {},
            Connections = {},
            Models = targetModels,
            DisplayName = displayName,
            Color = color or Color3.fromRGB(255, 255, 255)
        }
    else
       
        for _, element in pairs(ESPData[espName].Elements) do
            if element and element.Destroy then
                element:Destroy()
            end
        end
        ESPData[espName].Elements = {}
    end
    
    ESPData[espName].Color = color or ESPData[espName].Color
    
    local function AddESPToObject(obj)
        if not obj:IsA("Model") then return end
        
        local isValid = false
        for _, modelName in ipairs(targetModels) do
            if obj.Name == modelName then
                isValid = true
                break
            end
        end
        
        if not isValid then return end
        
        local targetPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
        if not targetPart then return end
        
     
        for _, existingElement in pairs(ESPData[espName].Elements) do
            if existingElement.Object == obj then
                return
            end
        end
        
        local espSettings = {
            Name = displayName,
            Model = targetPart,
            Color = ESPData[espName].Color,
            MaxDistance = 1000,
            TextSize = 14,
            ESPType = _G.ESPType or "Highlight",
            FillColor = ESPData[espName].Color,
            OutlineColor = ESPData[espName].Color,
            FillTransparency = 0.7,
            OutlineTransparency = 0,
            Tracer = {
                Enabled = _G.EnableTracers or false,
                Color = ESPData[espName].Color,
                From = "Bottom",
            },
            Arrow = {
                Enabled = _G.EnableArrows or false,
                Color = ESPData[espName].Color,
            },
        }
        
        local espElement = ESPLibrary:Add(espSettings)
        
        table.insert(ESPData[espName].Elements, {
            Object = obj,
            Element = espElement,
            Part = targetPart
        })
    end
    
   
    for _, obj in ipairs(workspace:GetDescendants()) do
        AddESPToObject(obj)
    end
    
   
    local addedConn = workspace.DescendantAdded:Connect(function(obj)
        if _G[espName .. "_Enabled"] then
            AddESPToObject(obj)
        end
    end)
    local removingConn = workspace.DescendantRemoving:Connect(function(obj)
        if not _G[espName .. "_Enabled"] then return end
        
        for i, elementData in ipairs(ESPData[espName].Elements) do
            if elementData.Object == obj then
                if elementData.Element and elementData.Element.Destroy then
                    elementData.Element:Destroy()
                end
                table.remove(ESPData[espName].Elements, i)
                break
            end
        end
    end)
    
 
    local updateConn = game:GetService("RunService").Heartbeat:Connect(function()
        if not _G[espName .. "_Enabled"] then
            updateConn:Disconnect()
            return
        end
        
        local player = game.Players.LocalPlayer
        local character = player and player.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        
        if not rootPart then return end
        
      
        local currentColor = ESPData[espName].Color
        if ESPData[espName].Color == ColorConfig["彩虹动态"] then
            local time = tick()
            local r = math.sin(time * 2) * 0.5 + 0.5
            local g = math.sin(time * 2 + 2) * 0.5 + 0.5  
            local b = math.sin(time * 2 + 4) * 0.5 + 0.5
            currentColor = Color3.new(r, g, b)
        end
        
        for i, elementData in ipairs(ESPData[espName].Elements) do
            if elementData.Object and elementData.Object.Parent and elementData.Part and elementData.Part.Parent then
                if elementData.Element then
                    local distance = (rootPart.Position - elementData.Part.Position).Magnitude
                    elementData.Element.CurrentSettings.Name = string.format("%s\n%d单位", displayName, math.floor(distance))
                    
                 
                    elementData.Element.CurrentSettings.Color = currentColor
                    elementData.Element.CurrentSettings.FillColor = currentColor
                    elementData.Element.CurrentSettings.OutlineColor = currentColor
                    elementData.Element.CurrentSettings.Tracer.Color = currentColor
                    elementData.Element.CurrentSettings.Arrow.Color = currentColor
                    
                 
                    elementData.Element.CurrentSettings.Tracer.Enabled = _G.EnableTracers or false
                    elementData.Element.CurrentSettings.Arrow.Enabled = _G.EnableArrows or false
                    elementData.Element.CurrentSettings.ESPType = _G.ESPType or "Highlight"
                end
            else
              
                if elementData.Element and elementData.Element.Destroy then
                    elementData.Element:Destroy()
                end
                table.remove(ESPData[espName].Elements, i)
            end
        end
    end)
    
    table.insert(ESPData[espName].Connections, addedConn)
    table.insert(ESPData[espName].Connections, removingConn) 
    table.insert(ESPData[espName].Connections, updateConn)
end
function UpdateAllESP()
    for espName, data in pairs(ESPData) do
        if _G[espName .. "_Enabled"] then
            CreateESP(espName, true, data.Models, data.DisplayName, data.Color)
        end
    end
end
for _, config in ipairs(ObjectESPConfig) do
    _G[config.Name .. "_Color"] = ColorConfig[config.DefaultColor]
end

for _, config in ipairs(EntityESPConfig) do
    _G[config.Name .. "_Color"] = ColorConfig[config.DefaultColor]
end
local function StartRainbowEffect()
    if RainbowConnection then RainbowConnection:Disconnect() end
    
    RainbowConnection = game:GetService("RunService").Heartbeat:Connect(function()
        local time = tick()
        local r = math.sin(time * 2) * 0.5 + 0.5
        local g = math.sin(time * 2 + 2) * 0.5 + 0.5
        local b = math.sin(time * 2 + 4) * 0.5 + 0.5
        
        ColorConfig["彩虹动态"] = Color3.new(r, g, b)
        for espName, data in pairs(ESPData) do
            if data.Color == ColorConfig["彩虹动态"] and _G[espName .. "_Enabled"] then
                data.Color = ColorConfig["彩虹动态"]
            end
        end
    end)
end
local function CleanupESP()
    for espName, data in pairs(ESPData) do
        for _, elementData in pairs(data.Elements) do
            if elementData.Element and elementData.Element.Destroy then
                elementData.Element:Destroy()
            end
        end
        
        for _, conn in pairs(data.Connections) do
            if conn then conn:Disconnect() end
        end
    end
    
    ESPData = {}
    
    if RainbowConnection then
        RainbowConnection:Disconnect()
        RainbowConnection = nil
    end
end
game:GetService("Players").LocalPlayer.AncestryChanged:Connect(function(_, parent)
    if not parent then
        CleanupESP()
    end
end)
StartRainbowEffect()
_G.ESPType = "Highlight"
_G.EnableTracers = false
_G.EnableArrows = false
    local NotificationTab = Window:Tab({Title = "提示", Icon = "bell"})

local EntityNotifyGroup = NotificationTab:Section({Title = "实体刷新提示[展开]", Side = "Left"})

local EntityNotifications = {
    Screech = {
        Description = "尖啸者已生成",
        Color = Color3.fromRGB(255, 255, 0)
    },
    Halt = {
        Description = "暂停实体已出现", 
        Color = Color3.fromRGB(0, 255, 255)
    },
    FigureRig = {
        Description = "检测到雕像",
        Color = Color3.fromRGB(255, 0, 0)
    },
    Eyes = {
        Description = "眼睛实体已生成",
        Color = Color3.fromRGB(127, 30, 220)
    },
    SeekMoving = {
        Description = "追逐者已生成",
        Color = Color3.fromRGB(255, 100, 100)
    },
    RushMoving = {
        Description = "冲刺正在接近",
        Color = Color3.fromRGB(0, 255, 0)
    },
    AmbushMoving = {
        Description = "伏击正在接近", 
        Color = Color3.fromRGB(80, 255, 110)
    },
    A60 = {
        Description = "A-60 正在冲刺",
        Color = Color3.fromRGB(200, 50, 50)
    },
    A120 = {
        Description = "A-120 在附近",
        Color = Color3.fromRGB(55, 55, 55)
    },
    GiggleCeiling = {
        Description = "傻笑在天花板上",
        Color = Color3.fromRGB(200, 200, 200)
    },
    GrumbleRig = {
        Description = "咕噜在巡逻",
        Color = Color3.fromRGB(150, 150, 150)
    },
    GloombatSwarm = {
        Description = "暗影蝙蝠群来袭",
        Color = Color3.fromRGB(100, 100, 100)
    },
    Dread = {
        Description = "恐惧实体已激活",
        Color = Color3.fromRGB(80, 80, 80)
    },
    BackdoorLookman = {
        Description = "观察者在注视",
        Color = Color3.fromRGB(110, 15, 15)
    },
    Snare = {
        Description = "陷阱已生成",
        Color = Color3.fromRGB(100, 100, 100)
    },
    WorldLotus = {
        Description = "检测到世界莲花",
        Color = Color3.fromRGB(200, 230, 50)
    },
    Bramble = {
        Description = "荆棘在生长",
        Color = Color3.fromRGB(50, 150, 30)
    },
    Caws = {
        Description = "乌鸦在飞行",
        Color = Color3.fromRGB(30, 30, 30)
    },
    Eyestalk = {
        Description = "眼柄将要追逐",
        Color = Color3.fromRGB(150, 80, 200)
    },
    Grampy = {
        Description = "爷爷已出现",
        Color = Color3.fromRGB(180, 180, 180)
    },
    Groundskeeper = {
        Description = "园丁在附近",
        Color = Color3.fromRGB(100, 150, 50)
    },
    Mandrake = {
        Description = "曼德拉草在尖叫",
        Color = Color3.fromRGB(130, 80, 30)
    },
    Monument = {
        Description = "纪念碑已激活",
        Color = Color3.fromRGB(150, 150, 150)
    },
    Surge = {
        Description = "浪涌在充能",
        Color = Color3.fromRGB(230, 130, 30)
    },
    BackdoorRush = {
        Description = "闪电即将到来",
        Color = Color3.fromRGB(230, 130, 30)
    }
}

local NotifyConnections = {}

EntityNotifyGroup:Toggle({
    Title = "尖啸者提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Screech", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "暂停实体提示", 
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Halt", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "雕像提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("FigureRig", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "眼睛提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Eyes", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "追逐者提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("SeekMoving", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "冲刺提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("RushMoving", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "伏击提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("AmbushMoving", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "A-60提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("A60", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "A-120提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("A120", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "傻笑提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("GiggleCeiling", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "咕噜提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("GrumbleRig", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "暗影蝙蝠提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("GloombatSwarm", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "恐惧提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Dread", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "观察者提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("BackdoorLookman", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "陷阱提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Snare", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "世界莲花提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("WorldLotus", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "荆棘提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Bramble", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "乌鸦提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Caws", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "眼柄提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Eyestalk", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "爷爷提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Grampy", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "园丁提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Groundskeeper", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "曼德拉草提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Mandrake", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "纪念碑提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Monument", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "浪涌提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("Surge", Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = "闪电提示",
    Default = false,
    Callback = function(Value)
        SetupEntityNotification("BackdoorRush", Value)
    end
})

function SetupEntityNotification(entityName, enabled)
    if NotifyConnections[entityName] then
        NotifyConnections[entityName]:Disconnect()
        NotifyConnections[entityName] = nil
    end

    if not enabled then return end

    local entityData = EntityNotifications[entityName]
    if not entityData then return end

    local function onEntityAdded(obj)
        if obj.Name == entityName then
            WindUI:Notify("实体刷新", entityData.Description, 5)
        end
    end

    NotifyConnections[entityName] = workspace.ChildAdded:Connect(onEntityAdded)

    local rooms = workspace:FindFirstChild("CurrentRooms")
    if rooms then
        local roomConn = rooms.DescendantAdded:Connect(function(obj)
            if obj.Name == entityName then
                WindUI:Notify("实体刷新", entityData.Description, 5)
            end
        end)
        NotifyConnections[entityName .. "_Rooms"] = roomConn
    end
end

    end
      end
})
Section:Button({
    Title = "XY脚本-模仿者",
    Callback = function()
    
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
        Title = "XY脚本<font color='#00FF00'>模仿者</font>",
        Icon = "rbxassetid://81944629903864",
        IconTransparency = 0.5,
        IconThemed = true,
        Author = "作者:小夜",
        Folder = "CloudHub",
        Size = UDim2.fromOffset(400, 300),
        Transparent = true,
        Theme = "Light",
        User = {
            Enabled = true,
            Callback = function() print("clicked") end,
            Anonymous = false
        },
        SideBarWidth = 200,
        ScrollBarEnabled = true,
        Background = "rbxassetid://4155801252"
    })
    

Window:EditOpenButton({
    Title = "XY脚本-模仿者",
    Icon = "monitor",
    CornerRadius = UDim.new(0, 16),
    StrokeThickness = 2,
    Color = openButtonColor,
    Draggable = true,
})

Window:Tag({
    Title = "XY脚本",
    Color = Color3.fromHex("#30ff6a")
})

Window:Tag({
        Title = "XY脚本", -- 标签汉化
        Color = Color3.fromHex("#315dff")
    })
    local TimeTag = Window:Tag({
        Title = "模仿者",
        Color = Color3.fromHex("#000000")
    })

local Tabs = {
    Main = Window:Section({ Title = "所有关卡", Opened = true }),
    gn = Window:Section({ Title = "功能", Opened = true }),    
}

local TabHandles = {
    Q = Tabs.Main:Tab({ Title = "传送嫉妒1", Icon = "layout-grid" }),
    W = Tabs.Main:Tab({ Title = "透视功能", Icon = "layout-grid" }),
    E = Tabs.Main:Tab({ Title = "", Icon = "layout-grid" }),
    R = Tabs.Main:Tab({ Title = "", Icon = "layout-grid" }),
    T = Tabs.Main:Tab({ Title = "", Icon = "layout-grid" }),
    Y = Tabs.Main:Tab({ Title = "", Icon = "layout-grid" }),
    U = Tabs.Main:Tab({ Title = "", Icon = "layout-grid" }),    
}
-----------------------------------屋子里------------------------------------------------

local Button = TabHandles.Q:Button({
    Title = "提示",
    Desc = "第一关卡在日本屋子里",
    Image = "palette",
    ImageSize = 20,
    Color = "White"
})

Button = TabHandles.Q:Button({
    Title = "隐身怪物看不见",
    Desc = "有些关卡，一卡一卡的",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Yungengxin/roblox/main/yinshen"))()
            
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 1, -- 3 seconds
    Icon = "layout-grid",
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = "动画房间",
    Desc = "",
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( -1675.27, -23.32, -3411.01)
            
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 1, -- 3 seconds
    Icon = "layout-grid",
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = "放毒老鼠地方",
    Desc = "",
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( -1562.39,  -29.25,  -3403.67)
            
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 1, -- 3 seconds
    Icon = "layout-grid",
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = "老鼠1",
    Desc = "",
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( -1524.21,  -29.25,  -3580.63)
            
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 1, -- 3 seconds
    Icon = "layout-grid",
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = "老鼠2",
    Desc = "",
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1642.97,  -23.44,  -3434.15)
            
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 1, -- 3 seconds
    Icon = "layout-grid",
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = "老鼠3",
    Desc = "",
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( -1680.65,  -23.47,  -3391.97)
            
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 1, -- 3 seconds
    Icon = "layout-grid",
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = "老鼠4",
    Desc = "",
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( -1620.64,  -23.44,  -3397.37)
            
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 1, -- 3 seconds
    Icon = "layout-grid",
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = "毒老鼠老井",
    Desc = "老鼠毒放在老鼠身上的",
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( -1531.34, -30.17,  -3541.97)
            
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 1, -- 3 seconds
    Icon = "layout-grid",
})                        
            
 end
})
-----------------------------------山坡上巨蛇------------------------------------------------

local Button = TabHandles.Q:Button({
    Title = "提示",
    Desc = "第二关卡山坡上的巨蛇",
    Image = "palette",
    ImageSize = 20,
    Color = "White"
})


Button = TabHandles.Q:Button({
    Title = "巨大蛇怪山坡秒过",
    Desc = "",
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( 578.31,  567.98,  -380.59)
            
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 1, -- 3 seconds
    Icon = "layout-grid",
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = "洞穴秒过",
    Desc = "",
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( 3837.46,  137.13,  12.84)
            
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 3, -- 3 seconds
    Icon = "layout-grid",
})                        
            
 end
})
-----------------------------------村庄------------------------------------------------

local Button = TabHandles.Q:Button({
    Title = "提示",
    Desc = "第三关卡你在村庄里",
    Image = "palette",
    ImageSize = 20,
    Color = "White"
})


Button = TabHandles.Q:Button({
    Title = "传送谈话村民",
    Desc = "",
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new()
            
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 1, -- 3 seconds
    Icon = "layout-grid",
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = "传送洞穴里",
    Desc = "",
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( 343.48,  20.66,  3608.81)
            
WindUI:Notify({
    Title = "通知",
    Content = "加载成功",
    Duration = 1, -- 3 seconds
    Icon = "layout-grid",
})                        
            
 end
})

-----------------------------------透视功能------------------------------------------------

getgenv().ESPEnabled = false
getgenv().ShowBox = false
getgenv().ShowHealth = false
getgenv().ShowName = false
getgenv().ShowDistance = false
getgenv().ShowTracer = false
getgenv().TeamCheck = false
getgenv().ShowSkeleton = false
getgenv().ShowRadar = false
getgenv().ShowPlayerCount = false
getgenv().ShowWeapon = false
getgenv().ShowFOV = false
getgenv().OutOfViewArrows = false
getgenv().Chams = false

getgenv().TracerColor = Color3.new(1, 0, 0)
getgenv().SkeletonColor = Color3.new(0.2, 0.8, 1)
getgenv().BoxColor = Color3.new(1, 1, 1)
getgenv().HealthBarColor = Color3.new(0, 1, 0)
getgenv().HealthTextColor = Color3.new(1, 1, 1)
getgenv().NameColor = Color3.new(1, 1, 1)
getgenv().DistanceColor = Color3.new(1, 1, 0)
getgenv().WeaponColor = Color3.new(1, 0.5, 0)
getgenv().ArrowColor = Color3.new(1, 0, 0)
getgenv().FOVColor = Color3.new(1, 1, 1)
getgenv().ChamsColor = Color3.new(1, 0, 0)

getgenv().BoxThickness = 1
getgenv().TracerThickness = 1
getgenv().SkeletonThickness = 2
getgenv().FOVRadius = 100
getgenv().ArrowSize = 15

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local function getGradientColor(time)
    local r = math.sin(time * 2) * 0.5 + 0.5
    local g = math.sin(time * 3) * 0.5 + 0.5
    local b = math.sin(time * 4) * 0.5 + 0.5
    return Color3.new(r, g, b)
end

local playerCountText = Drawing.new("Text")
playerCountText.Visible = false
playerCountText.Color = Color3.new(1, 1, 1)
playerCountText.Size = 20
playerCountText.Font = Drawing.Fonts.Monospace
playerCountText.Outline = true
playerCountText.OutlineColor = Color3.new(0, 0, 0)
playerCountText.Position = Vector2.new(Camera.ViewportSize.X / 2, 10)

local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Color = getgenv().FOVColor
fovCircle.Thickness = 1
fovCircle.Filled = false
fovCircle.Radius = getgenv().FOVRadius
fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

local function updatePlayerCount()
    local playerCount = #Players:GetPlayers()
    playerCountText.Text = "在线玩家: " .. playerCount
    playerCountText.Visible = getgenv().ESPEnabled and getgenv().ShowPlayerCount

    local time = tick()
    playerCountText.Color = getGradientColor(time)
end

local function updateFOV()
    fovCircle.Visible = getgenv().ShowFOV
    fovCircle.Color = getgenv().FOVColor
    fovCircle.Radius = getgenv().FOVRadius
    fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
end

local ESPComponents = {}

local function createESP(player)
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = getgenv().BoxColor
    box.Thickness = getgenv().BoxThickness
    box.Filled = false

    local healthBar = Drawing.new("Square")
    healthBar.Visible = false
    healthBar.Color = getgenv().HealthBarColor
    healthBar.Thickness = 1
    healthBar.Filled = true

    local healthBarBackground = Drawing.new("Square")
    healthBarBackground.Visible = false
    healthBarBackground.Color = Color3.new(0, 0, 0)
    healthBarBackground.Transparency = 0.5
    healthBarBackground.Thickness = 1
    healthBarBackground.Filled = true

    local healthBarBorder = Drawing.new("Square")
    healthBarBorder.Visible = false
    healthBarBorder.Color = Color3.new(1, 1, 1)
    healthBarBorder.Thickness = 1
    healthBarBorder.Filled = false

    local healthText = Drawing.new("Text")
    healthText.Visible = false
    healthText.Color = getgenv().HealthTextColor
    healthText.Size = 14
    healthText.Font = Drawing.Fonts.Monospace
    healthText.Outline = true
    healthText.OutlineColor = Color3.new(0, 0, 0)

    local nameText = Drawing.new("Text")
    nameText.Visible = false
    nameText.Color = getgenv().NameColor
    nameText.Size = 16
    nameText.Font = Drawing.Fonts.Monospace
    nameText.Outline = true
    nameText.OutlineColor = Color3.new(0, 0, 0)

    local distanceText = Drawing.new("Text")
    distanceText.Visible = false
    distanceText.Color = getgenv().DistanceColor
    distanceText.Size = 14
    distanceText.Font = Drawing.Fonts.Monospace
    distanceText.Outline = true
    distanceText.OutlineColor = Color3.new(0, 0, 0)

    local weaponText = Drawing.new("Text")
    weaponText.Visible = false
    weaponText.Color = getgenv().WeaponColor
    weaponText.Size = 14
    weaponText.Font = Drawing.Fonts.Monospace
    weaponText.Outline = true
    weaponText.OutlineColor = Color3.new(0, 0, 0)

    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Color = getgenv().TracerColor
    tracer.Thickness = getgenv().TracerThickness

    local arrow = Drawing.new("Triangle")
    arrow.Visible = false
    arrow.Color = getgenv().ArrowColor
    arrow.Filled = true
    arrow.Thickness = 1

    local skeletonLines = {}
    local skeletonPoints = {}

    local function createSkeleton()
        for i = 1, 15 do
            skeletonLines[i] = Drawing.new("Line")
            skeletonLines[i].Visible = false
            skeletonLines[i].Color = getgenv().SkeletonColor
            skeletonLines[i].Thickness = getgenv().SkeletonThickness
        end

        skeletonPoints["Head"] = Drawing.new("Circle")
        skeletonPoints["Head"].Visible = false
        skeletonPoints["Head"].Color = Color3.new(1, 0.5, 0)
        skeletonPoints["Head"].Thickness = 2
        skeletonPoints["Head"].Filled = true
        skeletonPoints["Head"].Radius = 4
    end

    createSkeleton()

    local lastHealth = 100
    local healthChangeTime = 0
    local smoothHealth = 100

    ESPComponents[player] = {
        box = box,
        healthBar = healthBar,
        healthBarBackground = healthBarBackground,
        healthBarBorder = healthBarBorder,
        healthText = healthText,
        nameText = nameText,
        distanceText = distanceText,
        weaponText = weaponText,
        tracer = tracer,
        arrow = arrow,
        skeletonLines = skeletonLines,
        skeletonPoints = skeletonPoints
    }

    RunService.RenderStepped:Connect(function()
        if not getgenv().ESPEnabled or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") or not player.Character:FindFirstChild("Humanoid") or player == LocalPlayer then
            box.Visible = false
            healthBar.Visible = false
            healthBarBackground.Visible = false
            healthBarBorder.Visible = false
            healthText.Visible = false
            nameText.Visible = false
            distanceText.Visible = false
            weaponText.Visible = false
            tracer.Visible = false
            arrow.Visible = false
            for _, line in pairs(skeletonLines) do
                line.Visible = false
            end
            for _, point in pairs(skeletonPoints) do
                point.Visible = false
            end
            return
        end

        if getgenv().TeamCheck and player.Team == LocalPlayer.Team then
            box.Visible = false
            healthBar.Visible = false
            healthBarBackground.Visible = false
            healthBarBorder.Visible = false
            healthText.Visible = false
            nameText.Visible = false
            distanceText.Visible = false
            weaponText.Visible = false
            tracer.Visible = false
            arrow.Visible = false
            for _, line in pairs(skeletonLines) do
                line.Visible = false
            end
            for _, point in pairs(skeletonPoints) do
                point.Visible = false
            end
            return
        end

        local character = player.Character
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")

        if rootPart and humanoid and humanoid.Health > 0 then
            local rootPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            local headPos, _ = Camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 3, 0))
            local legPos, _ = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))

            local weaponName = "无武器"
            for _, tool in ipairs(character:GetChildren()) do
                if tool:IsA("Tool") then
                    weaponName = tool.Name
                    break
                end
            end

            if getgenv().ShowBox and onScreen then
                box.Size = Vector2.new(1000 / rootPos.Z, headPos.Y - legPos.Y)
                box.Position = Vector2.new(rootPos.X - box.Size.X / 2, rootPos.Y - box.Size.Y / 2)
                box.Visible = true
                box.Color = getgenv().BoxColor
                box.Thickness = getgenv().BoxThickness
            else
                box.Visible = false
            end

            if getgenv().ShowHealth and onScreen then
                local healthPercentage = humanoid.Health / humanoid.MaxHealth
                local barWidth = 50
                local barHeight = 5
                local barX = headPos.X - barWidth / 2
                local barY = headPos.Y - 20

                healthBarBackground.Size = Vector2.new(barWidth, barHeight)
                healthBarBackground.Position = Vector2.new(barX, barY)
                healthBarBackground.Visible = true

                healthBarBorder.Size = Vector2.new(barWidth, barHeight)
                healthBarBorder.Position = Vector2.new(barX, barY)
                healthBarBorder.Visible = true

                smoothHealth = smoothHealth + (humanoid.Health - smoothHealth) * 0.1
                local smoothHealthPercentage = smoothHealth / humanoid.MaxHealth

                healthBar.Size = Vector2.new(barWidth * smoothHealthPercentage, barHeight)
                healthBar.Position = Vector2.new(barX, barY)

                if smoothHealthPercentage >= 0.8 then
                    healthBar.Color = Color3.new(0, 1, 0)
                elseif smoothHealthPercentage >= 0.5 then
                    healthBar.Color = Color3.new(1, 1, 0)
                elseif smoothHealthPercentage >= 0.2 then
                    healthBar.Color = Color3.new(1, 0.5, 0)
                else
                    healthBar.Color = Color3.new(1, 0, 0)
                end

                healthBar.Visible = true

                if humanoid.Health ~= lastHealth then
                    healthChangeTime = tick()
                    lastHealth = humanoid.Health
                end

                if tick() - healthChangeTime < 0.5 then
                    healthBar.Color = Color3.new(1, 0, 0)
                end

                healthText.Position = Vector2.new(barX + barWidth + 5, barY - 5)
                healthText.Text = math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
                healthText.Visible = true
            else
                healthBar.Visible = false
                healthBarBackground.Visible = false
                healthBarBorder.Visible = false
                healthText.Visible = false
            end

            if getgenv().ShowName and onScreen then
                nameText.Position = Vector2.new(headPos.X, headPos.Y - 35)
                nameText.Text = player.Name
                nameText.Visible = true

                if getgenv().ShowDistance then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude
                    distanceText.Position = Vector2.new(headPos.X, headPos.Y + 10)
                    distanceText.Text = math.floor(distance) .. "m"
                    distanceText.Visible = true
                else
                    distanceText.Visible = false
                end
                
                if getgenv().ShowWeapon then
                    weaponText.Position = Vector2.new(headPos.X, headPos.Y - 50)
                    weaponText.Text = weaponName
                    weaponText.Visible = true
                else
                    weaponText.Visible = false
                end
            else
                nameText.Visible = false
                distanceText.Visible = false
                weaponText.Visible = false
            end

            if getgenv().ShowTracer then
                local head = character:FindFirstChild("Head")
                if head then
                    local headPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        tracer.To = Vector2.new(headPos.X, headPos.Y)
                        tracer.Visible = true
                        tracer.Color = getgenv().TracerColor
                        tracer.Thickness = getgenv().TracerThickness
                        
                        local distance = (LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude
                        if distance < 20 then
                            tracer.Color = Color3.new(0, 1, 0)
                        elseif distance < 50 then
                            tracer.Color = Color3.new(1, 1, 0) 
                        else
                            tracer.Color = getgenv().TracerColor 
                        end
                    else
                        tracer.Visible = false
                    end
                else
                    tracer.Visible = false
                end
            else
                tracer.Visible = false
            end

            if getgenv().OutOfViewArrows and not onScreen then
                local direction = (rootPart.Position - Camera.CFrame.Position).Unit
                local dotProduct = Camera.CFrame.RightVector:Dot(direction)
                local crossProduct = Camera.CFrame.RightVector:Cross(direction)
                
                local screenPosition = Vector2.new(
                    Camera.ViewportSize.X / 2 + dotProduct * Camera.ViewportSize.X / 3,
                    Camera.ViewportSize.Y / 2 - crossProduct.Y * Camera.ViewportSize.Y / 3
                )
                
                screenPosition = Vector2.new(
                    math.clamp(screenPosition.X, getgenv().ArrowSize, Camera.ViewportSize.X - getgenv().ArrowSize),
                    math.clamp(screenPosition.Y, getgenv().ArrowSize, Camera.ViewportSize.Y - getgenv().ArrowSize)
                )
                
                local angle = math.atan2(screenPosition.Y - Camera.ViewportSize.Y / 2, screenPosition.X - Camera.ViewportSize.X / 2)
                
                arrow.PointA = screenPosition
                arrow.PointB = Vector2.new(
                    screenPosition.X - getgenv().ArrowSize * math.cos(angle - 0.5),
                    screenPosition.Y - getgenv().ArrowSize * math.sin(angle - 0.5)
                )
                arrow.PointC = Vector2.new(
                    screenPosition.X - getgenv().ArrowSize * math.cos(angle + 0.5),
                    screenPosition.Y - getgenv().ArrowSize * math.sin(angle + 0.5)
                )
                
                arrow.Color = getgenv().ArrowColor
                arrow.Visible = true
            else
                arrow.Visible = false
            end

            if getgenv().ShowSkeleton and onScreen then
                local head = character:FindFirstChild("Head")
                local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
                local leftArm = character:FindFirstChild("Left Arm") or character:FindFirstChild("LeftUpperArm")
                local rightArm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightUpperArm")
                local leftLeg = character:FindFirstChild("Left Leg") or character:FindFirstChild("LeftUpperLeg")
                local rightLeg = character:FindFirstChild("Right Leg") or character:FindFirstChild("RightUpperLeg")
                
                if head and torso and leftArm and rightArm and leftLeg and rightLeg then
                    local headPos = Camera:WorldToViewportPoint(head.Position)
                    local torsoPos = Camera:WorldToViewportPoint(torso.Position)
                    local leftArmPos = Camera:WorldToViewportPoint(leftArm.Position)
                    local rightArmPos = Camera:WorldToViewportPoint(rightArm.Position)
                    local leftLegPos = Camera:WorldToViewportPoint(leftLeg.Position)
                    local rightLegPos = Camera:WorldToViewportPoint(rightLeg.Position)

                    skeletonPoints["Head"].Position = Vector2.new(headPos.X, headPos.Y)
                    skeletonPoints["Head"].Visible = true

                    skeletonLines[1].From = Vector2.new(headPos.X, headPos.Y)
                    skeletonLines[1].To = Vector2.new(torsoPos.X, torsoPos.Y) 
                    skeletonLines[1].Visible = true

                    skeletonLines[2].From = Vector2.new(torsoPos.X, torsoPos.Y)
                    skeletonLines[2].To = Vector2.new(leftArmPos.X, leftArmPos.Y)
                    skeletonLines[2].Visible = true

                    skeletonLines[3].From = Vector2.new(torsoPos.X, torsoPos.Y)
                    skeletonLines[3].To = Vector2.new(rightArmPos.X, rightArmPos.Y)
                    skeletonLines[3].Visible = true

                    skeletonLines[4].From = Vector2.new(torsoPos.X, torsoPos.Y)
                    skeletonLines[4].To = Vector2.new(leftLegPos.X, leftLegPos.Y)
                    skeletonLines[4].Visible = true

                    skeletonLines[5].From = Vector2.new(torsoPos.X, torsoPos.Y)
                    skeletonLines[5].To = Vector2.new(rightLegPos.X, rightLegPos.Y)
                    skeletonLines[5].Visible = true
                    
                    if character:FindFirstChild("LeftLowerArm") then
                        local leftLowerArmPos = Camera:WorldToViewportPoint(character.LeftLowerArm.Position)
                        skeletonLines[6].From = Vector2.new(leftArmPos.X, leftArmPos.Y)
                        skeletonLines[6].To = Vector2.new(leftLowerArmPos.X, leftLowerArmPos.Y)
                        skeletonLines[6].Visible = true
                    end

                    if character:FindFirstChild("LeftLowerLeg") then
                        local leftLowerLegPos = Camera:WorldToViewportPoint(character.LeftLowerLeg.Position)
                        skeletonLines[8].From = Vector2.new(leftLegPos.X, leftLegPos.Y)
                        skeletonLines[8].To = Vector2.new(leftLowerLegPos.X, leftLowerLegPos.Y)
                        skeletonLines[8].Visible = true
                    end

                    if character:FindFirstChild("RightLowerLeg") then
                        local rightLowerLegPos = Camera:WorldToViewportPoint(character.RightLowerLeg.Position)
                        skeletonLines[9].From = Vector2.new(rightLegPos.X, rightLegPos.Y)
                        skeletonLines[9].To = Vector2.new(rightLowerLegPos.X, rightLowerLegPos.Y)
                        skeletonLines[9].Visible = true
                    end
                else
                    for _, line in pairs(skeletonLines) do
                        line.Visible = false
                    end
                    for _, point in pairs(skeletonPoints) do
                        point.Visible = false
                    end
                end
            else
                for _, line in pairs(skeletonLines) do
                    line.Visible = false
                end
                for _, point in pairs(skeletonPoints) do
                    point.Visible = false
                end
            end
        else
            box.Visible = false
            healthBar.Visible = false
            healthBarBackground.Visible = false
            healthBarBorder.Visible = false
            healthText.Visible = false
            nameText.Visible = false
            distanceText.Visible = false
            weaponText.Visible = false
            tracer.Visible = false
            arrow.Visible = false
            for _, line in pairs(skeletonLines) do
                line.Visible = false
            end
            for _, point in pairs(skeletonPoints) do
                point.Visible = false
            end
        end
    end)
end

local radar = Drawing.new("Circle")
radar.Visible = false
radar.Color = Color3.new(1, 1, 1)
radar.Thickness = 2
radar.Filled = false
radar.Radius = 100
radar.Position = Vector2.new(Camera.ViewportSize.X - 120, 120)

local radarCenter = Drawing.new("Circle")
radarCenter.Visible = false
radarCenter.Color = Color3.new(1, 1, 1)
radarCenter.Thickness = 2
radarCenter.Filled = true
radarCenter.Radius = 3
radarCenter.Position = radar.Position

local radarDirection = Drawing.new("Line")
radarDirection.Visible = false
radarDirection.Color = Color3.new(1, 1, 1)
radarDirection.Thickness = 2

local radarGridLines = {}
for i = 1, 4 do
    radarGridLines[i] = Drawing.new("Line")
    radarGridLines[i].Visible = false
    radarGridLines[i].Color = Color3.new(0.5, 0.5, 0.5)
    radarGridLines[i].Thickness = 1
end

local radarRangeText = Drawing.new("Text")
radarRangeText.Visible = false
radarRangeText.Color = Color3.new(1, 1, 1)
radarRangeText.Size = 14
radarRangeText.Font = Drawing.Fonts.Monospace
radarRangeText.Outline = true
radarRangeText.OutlineColor = Color3.new(0, 0, 0)
radarRangeText.Text = "100m"

local radarPlayers = {}

local function updateRadar()
    if not getgenv().ShowRadar then
        radar.Visible = false
        radarCenter.Visible = false
        radarDirection.Visible = false
        radarRangeText.Visible = false
        
        for _, line in pairs(radarGridLines) do
            line.Visible = false
        end
        
        for _, player in pairs(radarPlayers) do
            if player.dot then player.dot.Visible = false end
            if player.direction then player.direction.Visible = false end
            if player.name then player.name.Visible = false end
        end
        return
    end

    radar.Visible = true
    radarCenter.Visible = true
    radarDirection.Visible = true
    radarRangeText.Visible = true
    
    radarRangeText.Position = Vector2.new(radar.Position.X, radar.Position.Y + radar.Radius + 5)
    
    for i = 1, 4 do
        local angle = (i-1) * math.pi / 2
        radarGridLines[i].From = radar.Position
        radarGridLines[i].To = Vector2.new(
            radar.Position.X + math.cos(angle) * radar.Radius,
            radar.Position.Y + math.sin(angle) * radar.Radius
        )
        radarGridLines[i].Visible = true
    end
    
    radarDirection.From = radar.Position
    radarDirection.To = Vector2.new(radar.Position.X, radar.Position.Y - radar.Radius)

    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player ~= LocalPlayer then
            local rootPart = player.Character.HumanoidRootPart
            local relativePosition = rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position
            
            local radarX = radar.Position.X + (relativePosition.X / 10)
            local radarY = radar.Position.Y + (relativePosition.Z / 10)
            
            local distanceFromCenter = math.sqrt((radarX - radar.Position.X)^2 + (radarY - radar.Position.Y)^2)
            
            if distanceFromCenter > radar.Radius then
                local angle = math.atan2(radarY - radar.Position.Y, radarX - radar.Position.X)
                radarX = radar.Position.X + math.cos(angle) * radar.Radius
                radarY = radar.Position.Y + math.sin(angle) * radar.Radius
            end
            
            if not radarPlayers[player] then
                radarPlayers[player] = {
                    dot = Drawing.new("Circle"),
                    direction = Drawing.new("Line"),
                    name = Drawing.new("Text")
                }
                
                radarPlayers[player].dot.Thickness = 1
                radarPlayers[player].dot.Filled = true
                radarPlayers[player].dot.Radius = 4
                
                radarPlayers[player].direction.Thickness = 2
                radarPlayers[player].direction.Visible = true
                
                radarPlayers[player].name.Size = 12
                radarPlayers[player].name.Font = Drawing.Fonts.Monospace
                radarPlayers[player].name.Outline = true
                radarPlayers[player].name.OutlineColor = Color3.new(0, 0, 0)
            end
            
            if player.Team == LocalPlayer.Team then
                radarPlayers[player].dot.Color = Color3.new(0, 1, 0)  
                radarPlayers[player].direction.Color = Color3.new(0, 0.8, 0)
                radarPlayers[player].name.Color = Color3.new(0, 1, 0)
            else
                radarPlayers[player].dot.Color = Color3.new(1, 0, 0) 
                radarPlayers[player].direction.Color = Color3.new(1, 0, 0)
                radarPlayers[player].name.Color = Color3.new(1, 0, 0)
            end
            
            radarPlayers[player].dot.Position = Vector2.new(radarX, radarY)
            radarPlayers[player].dot.Visible = true
            
            local lookVector = rootPart.CFrame.LookVector
            local directionLength = 10
            radarPlayers[player].direction.From = Vector2.new(radarX, radarY)
            radarPlayers[player].direction.To = Vector2.new(
                radarX + lookVector.X * directionLength,
                radarY + lookVector.Z * directionLength
            )
            
            radarPlayers[player].name.Position = Vector2.new(radarX, radarY - 15)
            radarPlayers[player].name.Text = player.Name
            radarPlayers[player].name.Visible = distanceFromCenter <= radar.Radius
        elseif radarPlayers[player] then
            radarPlayers[player].dot.Visible = false
            radarPlayers[player].direction.Visible = false
            radarPlayers[player].name.Visible = false
        end
    end
    
    for player, components in pairs(radarPlayers) do
        if not Players:FindFirstChild(player.Name) then
            components.dot.Visible = false
            components.direction.Visible = false
            components.name.Visible = false
            radarPlayers[player] = nil
        end
    end
end

RunService.RenderStepped:Connect(updateRadar)
RunService.RenderStepped:Connect(updatePlayerCount)
RunService.RenderStepped:Connect(updateFOV)

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createESP(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        createESP(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if ESPComponents[player] then
        for _, component in pairs(ESPComponents[player]) do
            if typeof(component) == "table" then
                for _, drawing in pairs(component) do
                    drawing:Remove()
                end
            else
                component:Remove()
            end
        end
        ESPComponents[player] = nil
    end
end)
---------------------------------------------------------------------------------------------透视功能
Toggle = TabHandles.W:Toggle({
    Title = "透视开启", 
    Value = false, 
    Callback = function(Value)
        getgenv().ESPEnabled = Value
    end
})

Toggle = TabHandles.W:Toggle({
    Title = "模型透视", 
    Value = false, 
    Callback = function(Value)
        getgenv().ShowSkeleton = Value
    end
})

Toggle = TabHandles.W:Toggle({
    Title = "方框透视", 
    Value = false, 
    Callback = function(Value)
        getgenv().ShowBox = Value
    end
})



Toggle = TabHandles.W:Toggle({
    Title = "射线透视", 
    Value = false, 
    Callback = function(Value)
        getgenv().ShowTracer = Value
    end
})

local bulletTrackingEnabled = true  
local oldHook = nil

Toggle = TabHandles.W:Toggle({
    Title = "名字透视", 
    Value = false, 
    Callback = function(Value)
        getgenv().ShowName = Value
    end
})
      end
})
local Section = Tab:Section({
    Title = "其他",
    Opened = true
})
Section:Button({
    Title = "叶脚本",
    Callback = function()
    
loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua"))()
      end
})
Section:Button({
    Title = "无敌少侠飞行",
    Callback = function()
    
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
      end
})
    -- ════════════════════════════════════════════════════════════
end

-- ================================================================
--  ★★★ 修复后的验证函数 ★★★
-- ================================================================

-- 降级验证方案
local function fallbackVerify(inputKey)
    print("[卡密验证] 使用 HttpGet 验证")
    local url = API_URL .. "?key=" .. HttpService:URLEncode(inputKey) .. "&player=" .. HttpService:URLEncode(LocalPlayer.Name)
    print("[卡密验证] 请求URL: " .. url)
    
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    
    if not success then
        print("[卡密验证] HttpGet 失败: " .. tostring(response))
        return false, "网络连接失败，请检查网络后重试"
    end
    
    print("[卡密验证] HttpGet 响应: " .. tostring(response))
    local decoded = HttpService:JSONDecode(response)
    return decoded and decoded.success == true, decoded and decoded.message or "未知错误"
end

-- 主验证函数
local function verifyKeyOnCloud(inputKey)
    print("[卡密验证] 开始验证卡密: " .. inputKey)
    
    local requestData = {
        key = inputKey,
        player = LocalPlayer.Name
    }
    local jsonBody = HttpService:JSONEncode(requestData)
    
    if syn and syn.request then
        print("[卡密验证] 使用 syn.request 发送请求")
        local success, response = pcall(function()
            return syn.request({
                Url = API_URL,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = jsonBody,
                Timeout = 10
            })
        end)
        
        if success and response then
            print("[卡密验证] 收到响应, 状态码: " .. tostring(response.StatusCode))
            if response.StatusCode == 200 then
                local decoded = HttpService:JSONDecode(response.Body)
                print("[卡密验证] 解析结果: success=" .. tostring(decoded.success))
                return decoded.success == true, decoded.message
            else
                return false, "服务器错误: " .. tostring(response.StatusCode)
            end
        else
            print("[卡密验证] syn.request 失败，降级到 HttpGet")
            return fallbackVerify(inputKey)
        end
    else
        return fallbackVerify(inputKey)
    end
end

-- ================================================================
--  检查缓存
-- ================================================================
if checkCache() then
    print("[卡密验证] 缓存有效，跳过验证，执行主脚本！")
    executeMainScript()
    return
end

print("[卡密验证] 无有效缓存，显示验证窗口")

-- ================================================================
--  UI 部分（保持原有精美UI）
-- ================================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CloudKeySystem"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
screenGui.IgnoreGuiInset = true
screenGui.Parent = PlayerGui

local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.6
overlay.BorderSizePixel = 0
overlay.Parent = screenGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 300)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(20, 18, 35)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 28)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1.5
stroke.Color = Color3.fromRGB(200, 180, 255)
stroke.Transparency = 0.4
stroke.Parent = frame

local blur = Instance.new("BlurEffect")
blur.Size = 20
blur.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 34, 0, 34)
closeBtn.Position = UDim2.new(1, -46, 0, 12)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(200, 190, 240)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 55)
title.Position = UDim2.new(0, 0, 0, 18)
title.BackgroundTransparency = 1
title.Text = "星辉 · 卡密验证"
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = frame

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -40, 0, 28)
subtitle.Position = UDim2.new(0, 20, 0, 76)
subtitle.BackgroundTransparency = 1
subtitle.Text = "请输入您的卡密以解锁全部功能"
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 14
subtitle.TextColor3 = Color3.fromRGB(180, 175, 210)
subtitle.TextXAlignment = Enum.TextXAlignment.Center
subtitle.TextWrapped = true
subtitle.Parent = frame

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0.8, 0, 0, 48)
inputBox.Position = UDim2.new(0.1, 0, 0, 118)
inputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
inputBox.BackgroundTransparency = 0.06
inputBox.BorderSizePixel = 0
inputBox.PlaceholderText = "在此输入卡密..."
inputBox.PlaceholderColor3 = Color3.fromRGB(150, 145, 190)
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
inputStroke.Thickness = 1.5
inputStroke.Color = Color3.fromRGB(200, 180, 255)
inputStroke.Transparency = 0.4
inputStroke.Parent = inputBox

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.8, 0, 0, 50)
submitBtn.Position = UDim2.new(0.1, 0, 0, 188)
submitBtn.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
submitBtn.BackgroundTransparency = 0.15
submitBtn.BorderSizePixel = 0
submitBtn.Text = "立即激活"
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 18
submitBtn.Parent = frame
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = submitBtn
local btnStroke = Instance.new("UIStroke")
btnStroke.Thickness = 1.5
btnStroke.Color = Color3.fromRGB(200, 180, 255)
btnStroke.Transparency = 0.5
btnStroke.Parent = submitBtn

-- ==================== 入场动画 ====================
frame.BackgroundTransparency = 1
frame.Size = UDim2.new(0, 0, 0, 0)
task.wait(0.05)

local introTween = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local sizeTween = TweenService:Create(frame, introTween, {
    Size = UDim2.new(0, 420, 0, 300)
})
local fadeTween = TweenService:Create(frame, TweenInfo.new(0.4), {
    BackgroundTransparency = 0.15
})
sizeTween:Play()
fadeTween:Play()

print("[卡密验证] UI 已显示")

-- ================================================================
--  UI 逻辑
-- ================================================================
local verificationComplete = false

local function closeGUI()
    local closeTween = TweenService:Create(frame, TweenInfo.new(0.3), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 0, 0)
    })
    closeTween:Play()
    closeTween.Completed:Wait()
    screenGui:Destroy()
end

local function startValidation()
    if verificationComplete then return end

    local inputKey = inputBox.Text
    if inputKey == "" then
        inputBox.PlaceholderText = "请输入卡密"
        task.wait(1)
        inputBox.PlaceholderText = "在此输入卡密..."
        return
    end

    print("[卡密验证] 用户输入卡密: " .. inputKey)

    submitBtn.Text = "验证中..."
    submitBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    submitBtn.Active = false

    task.spawn(function()
        print("[卡密验证] 开始调用验证函数...")
        local isValid, message = verifyKeyOnCloud(inputKey)
        print("[卡密验证] 验证结果: " .. tostring(isValid) .. ", 消息: " .. tostring(message))

        submitBtn.Text = "立即激活"
        submitBtn.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
        submitBtn.Active = true

        if isValid then
            local cacheData = {
                key = inputKey,
                expires_at = os.time() + (24 * 60 * 60)
            }
            setCache(cacheData)

            verificationComplete = true
            subtitle.Text = "验证成功！即将启动..."
            subtitle.TextColor3 = Color3.fromRGB(100, 255, 180)
            submitBtn.Text = "已激活"
            submitBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
            submitBtn.Active = false
            inputBox.Active = false
            closeBtn.Visible = false

            print("[卡密验证] 验证通过！已缓存卡密")
            task.wait(1.5)
            closeGUI()
            executeMainScript()
        else
            inputBox.Text = ""
            inputBox.PlaceholderText = "卡密错误，请重试"
            inputBox.PlaceholderColor3 = Color3.fromRGB(255, 150, 150)
            subtitle.Text = message or "卡密无效，请重新输入"
            subtitle.TextColor3 = Color3.fromRGB(255, 150, 150)

            task.wait(1.5)
            inputBox.PlaceholderText = "在此输入卡密..."
            inputBox.PlaceholderColor3 = Color3.fromRGB(150, 145, 190)
            subtitle.Text = "请输入您的卡密以解锁全部功能"
            subtitle.TextColor3 = Color3.fromRGB(180, 175, 210)
        end
    end)
end

submitBtn.MouseButton1Click:Connect(startValidation)

inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then startValidation() end
end)

closeBtn.MouseButton1Click:Connect(function()
    if verificationComplete then return end
    verificationComplete = true
    closeGUI()
    print("[卡密验证] 用户手动关闭了验证弹窗")
end)

overlay.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if not verificationComplete then
            closeBtn.MouseButton1Click:Fire()
        end
    end
end)

print("[卡密验证] 等待用户输入卡密...")
print("[卡密验证] API 地址: " .. API_URL)