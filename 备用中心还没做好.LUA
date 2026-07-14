local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/WuMing-YYDS/Script-UI/refs/heads/main/Wind%20UI.LUA"))()

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local Main = WindUI:CreateWindow({
    Title = "<font color='#ff007f'>XY备用中心脚本</font>-<font color='#00ffff'>备用</font>",
    Author = "<font color='#00ffff'>by</font> <font color='#ff007f'>小夜</font>",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(300, 400),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    Icon = "rbxassetid://86036299921359",
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
    Title = "<font color='#ff007f'>名</font><font color='#00ffff'>Script</font>",
    Icon = "rbxassetid://86036299921359",
    CornerRadius = UDim.new(0, 8),
    StrokeThickness = 2,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("#ff007f")),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex("#00ffff")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("#ff007f"))
    })
})

Main:Tag({
    Title = "名脚本",
    Color = Color3.fromHex("#00ffff")
})

Main:Tag({
    Title = "公益",
    Color = Color3.fromHex("#ff007f")
})

local TimeTag = Main:Tag({
    Title = "当前时间: 00:00:00",
    Color = Color3.fromHex("#00ffff")
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
    Title = "备用功能",
    Icon = "bird", -- optional
    Locked = false,
})
Section:Button({
    Title = "全自动翻译",
    Callback = function()
    
if not (Script and Script == "全自动翻译") then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "XY Script",
        Text = "❌错误–请复制完整",
        Icon = "rbxassetid://82031063194606",
        Duration = 10,
    })
    return
end

if not (TX and TX == "TX Script") then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "XY Script",
        Text = "❌错误–请复制完整",
        Icon = "rbxassetid://82031063194606",
        Duration = 10,
    })
    return
end

_G.TXHub = nil

local WindUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/JsYb666/UI/refs/heads/main/Wind%20lib.txt"
))()

local Window = WindUI:CreateWindow({
    Title = "XY脚本自动翻译器",
    Icon = "languages",
    Author = "XY",
    Folder = "XY-HUB",
    Size = UDim2.fromOffset(300, 300),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 0.5,
})

Window:EditOpenButton({
    Title = "打开",
    Icon = "globe",
    CornerRadius = UDim.new(0, 12),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromHex("00D1FF"), Color3.fromHex("FF6B9D")),
    Draggable = true,
})

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Chat = game:GetService("Chat")
local LocalPlayer = Players.LocalPlayer

local targetLang = "zh-CN"
local maxTextLength = 500
local baseScanInterval = 1.5
local speedMultiplier = 2
local translationMode = "智能翻译"
local translateNumbers = false
local translateSymbolsOnly = false
local skipPlayerNames = false
local autoTranslateEnabled = false
local heartbeatConnection = nil
local lastScanTime = 0

local translationCache = {}
local translatedInstances = {}

local emoteKeywords = {
    "neon", "shine", "ghost", "gold", "spin",
    "bighead", "smallhead", "giant", "squash",
}

local function detectLanguage(text)
    if not text or #text == 0 then
        return "en"
    end

    local counts = {
        cjk = 0,
        zht = 0,
        ko = 0,
        ja = 0,
        en = 0,
    }

    for _, code in utf8.codes(text) do
        local char = utf8.char(code)
        if char:match("[\228-\233][\128-\191][\128-\191]") then
            counts.cjk += 1
        elseif char:match("[\227][\128-\191][\128-\191]") then
            counts.zht += 1
        elseif char:match("[\234-\237][\128-\191]") then
            counts.ko += 1
        elseif char:match("[\227-\227][\128-\191][\128-\191]*") or char:match("[\227-\233][\128-\191]") then
            counts.ja += 1
        elseif char:match("[%a]") then
            counts.en += 1
        end
    end

    if counts.cjk > 3 then
        return counts.zht > 3 and "zh-TW" or "zh-CN"
    end
    if counts.ko > 2 then
        return "ko"
    end
    if counts.ja > 2 then
        return "ja"
    end
    if counts.en > 5 then
        return "en"
    end
    return "en"
end

local function shouldSkipText(text)
    if not text or text == "" or translationCache[text] then
        return true
    end
    if text:match("^%s*$") then
        return true
    end
    if not translateNumbers and text:match("^[%d%.%%,%s:/]+$") then
        return true
    end
    if not translateSymbolsOnly and text:match("^[^%w%s]+$") then
        return true
    end
    if #text > maxTextLength then
        return true
    end
    if not skipPlayerNames then
        if Players:FindFirstChild(text) then
            return true
        end
    end
    local lower = string.lower(text)
    for _, keyword in ipairs(emoteKeywords) do
        if string.find(lower, keyword) then
            return true
        end
    end
    return false
end

local function shouldTranslateByMode(text, detectedLang)
    if translationMode == "仅翻译英文" and detectedLang ~= "en" then
        return false
    end
    if translationMode == "仅翻译日文" and detectedLang ~= "ja" then
        return false
    end
    if translationMode == "仅翻译韩文" and detectedLang ~= "ko" then
        return false
    end
    if translationMode == "快速翻译" and #text > 50 then
        return false
    end
    return true
end

local function translateGoogle(text, fromLang, toLang)
    local url = string.format(
        "https://translate.googleapis.com/translate_a/single?client=gtx&sl=%s&tl=%s&dt=t&q=%s",
        fromLang,
        toLang,
        HttpService:UrlEncode(text)
    )

    local ok, body = pcall(function()
        return game:HttpGet(url, false, {
            ["User-Agent"] = "Mozilla/5.0",
        })
    end)
    if not ok or not body then
        return nil
    end

    local decodeOk, data = pcall(HttpService.JSONDecode, HttpService, body)
    if not decodeOk or not data or not data[1] then
        return nil
    end

    local result = ""
    for _, part in ipairs(data[1]) do
        if part[1] then
            result ..= part[1]
        end
    end
    return result ~= "" and result or nil
end

local function translateMyMemory(text, fromLang, toLang)
    local url = string.format(
        "https://api.mymemory.translated.net/get?q=%s&langpair=%s|%s",
        HttpService:UrlEncode(text),
        fromLang,
        toLang
    )

    local ok, body = pcall(function()
        return game:HttpGet(url, false, {
            ["User-Agent"] = "Roblox",
        })
    end)
    if not ok or not body then
        return nil
    end

    local decodeOk, data = pcall(HttpService.JSONDecode, HttpService, body)
    if not decodeOk or not data or not data.responseData then
        return nil
    end
    return data.responseData.translatedText
end

local function translateText(text)
    if shouldSkipText(text) then
        return translationCache[text] or text
    end

    local detected = detectLanguage(text)
    if detected == "zh-CN" then
        return text
    end
    if not shouldTranslateByMode(text, detected) then
        return text
    end

    local translated = translateGoogle(text, detected, targetLang)
    if translated then
        translationCache[text] = translated
        return translated
    end

    translated = translateMyMemory(text, detected, targetLang)
    if translated then
        translationCache[text] = translated
        return translated
    end

    return text
end

local function isTextInstance(obj)
    return obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")
end

local function shouldSkipInstance(obj)
    if not obj then
        return true
    end
    if obj == Chat or obj.Parent == Chat then
        return true
    end
    local ancestor = obj:FindFirstAncestorWhichIsA("TextChannel")
    if ancestor then
        return true
    end
    return false
end

local function getText(instance)
    if not isTextInstance(instance) then
        return nil
    end
    if not instance.Text or instance.Text == "" or shouldSkipInstance(instance) then
        return nil
    end
    return instance.Text
end

local function setText(instance, text)
    if isTextInstance(instance) and not shouldSkipInstance(instance) then
        instance.Text = text
    end
end

local function translateInstance(instance)
    if not isTextInstance(instance) or translatedInstances[instance] then
        return false
    end

    local original = getText(instance)
    if not original then
        return false
    end

    translatedInstances[instance] = true
    if getText(instance) == original then
        setText(instance, translateText(original))
        return true
    end
    return false
end

local function scanAndTranslate(root)
    local now = tick()
    if now - lastScanTime < baseScanInterval / speedMultiplier then
        return 0
    end
    lastScanTime = now

    local count = 0
    for _, descendant in ipairs(root:GetDescendants()) do
        if isTextInstance(descendant) and not translatedInstances[descendant] and not shouldSkipInstance(descendant) then
            if translateInstance(descendant) then
                count += 1
            end
        end
    end
    return count
end

local function onDescendantAdded(obj)
    if not autoTranslateEnabled or not isTextInstance(obj) then
        return
    end
    task.delay(0.1, function()
        if obj.Parent and not shouldSkipInstance(obj) then
            translateInstance(obj)
        end
    end)
end

LocalPlayer:WaitForChild("PlayerGui").DescendantAdded:Connect(onDescendantAdded)
game:GetService("CoreGui").DescendantAdded:Connect(onDescendantAdded)

-- UI
local Tab = Window:Tab({
    Title = "自动翻译",
    Icon = "languages",
})

Tab:Section({
    Title = "注意:请先加载此脚本开启翻译 再加载你需要翻译的脚本",
})

Tab:Section({
    Title = "小部分特殊UI无法翻译",
})

Tab:Toggle({
    Title = "启用自动翻译",
    Default = false,
    Callback = function(enabled)
        autoTranslateEnabled = enabled
        if enabled then
            if heartbeatConnection then
                heartbeatConnection:Disconnect()
            end
            scanAndTranslate(LocalPlayer:WaitForChild("PlayerGui"))
            heartbeatConnection = RunService.Heartbeat:Connect(function()
                if autoTranslateEnabled then
                    scanAndTranslate(LocalPlayer.PlayerGui)
                end
            end)
        else
            if heartbeatConnection then
                heartbeatConnection:Disconnect()
                heartbeatConnection = nil
            end
        end
    end,
})

Tab:Slider({
    Title = "翻译速度",
    Value = {
        Min = 1,
        Max = 5,
        Default = 2,
    },
    Callback = function(value)
        speedMultiplier = value
    end,
})

Tab:Button({
    Title = "官方群聊",
    Desc = "点击复制",
    Callback = function()
        if setclipboard then
            setclipboard("1034114548")
        end
    end,
})

Window:SelectTab(1)

loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/TX-User"
))()

print("[XY Script] 自动翻译器已加载")
    
      end
})