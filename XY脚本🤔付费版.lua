local _ = {}
_._0x1 = string.char

local WindUI = loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(87).._._0x1(117).._._0x1(77).._._0x1(105).._._0x1(110).._._0x1(103).._._0x1(45).._._0x1(89).._._0x1(89).._._0x1(68).._._0x1(83).._._0x1(47).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(45).._._0x1(85).._._0x1(73).._._0x1(47).._._0x1(114).._._0x1(101).._._0x1(102).._._0x1(115).._._0x1(47).._._0x1(104).._._0x1(101).._._0x1(97).._._0x1(100).._._0x1(115).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(87).._._0x1(105).._._0x1(110).._._0x1(100).._._0x1(37).._._0x1(50).._._0x1(48).._._0x1(85).._._0x1(73).._._0x1(46).._._0x1(76).._._0x1(85).._._0x1(65)))()

-- ================================================================
--  ★★★ 内嵌卡密验证模块（支持多卡密） ★★★
-- ================================================================

-- ==================== 配置区 ====================
-- ★★★ 在这里添加所有有效卡密，用逗号分隔 ★★★
local VALID_KEYS = {
    _._0x1(88).._._0x1(89).._._0x1(45).._._0x1(229).._._0x1(134).._._0x1(133).._._0x1(233).._._0x1(131).._._0x1(168).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(145).._._0x1(152).._._0x1(228).._._0x1(184).._._0x1(147).._._0x1(229).._._0x1(177).._._0x1(158),
    -- 继续添加更多卡密...
}

-- ==================== 验证 UI ====================
local Players = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(71).._._0x1(117).._._0x1(105))
local TweenService = game:GetService(_._0x1(84).._._0x1(119).._._0x1(101).._._0x1(101).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101))

local screenGui = Instance.new(_._0x1(83).._._0x1(99).._._0x1(114).._._0x1(101).._._0x1(101).._._0x1(110).._._0x1(71).._._0x1(117).._._0x1(105))
screenGui.Name = _._0x1(75).._._0x1(101).._._0x1(121).._._0x1(86).._._0x1(97).._._0x1(108).._._0x1(105).._._0x1(100).._._0x1(97).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110)
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
screenGui.IgnoreGuiInset = true
screenGui.Parent = PlayerGui

local overlay = Instance.new(_._0x1(70).._._0x1(114).._._0x1(97).._._0x1(109).._._0x1(101))
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.5
overlay.BorderSizePixel = 0
overlay.Parent = screenGui

local frame = Instance.new(_._0x1(70).._._0x1(114).._._0x1(97).._._0x1(109).._._0x1(101))
frame.Size = UDim2.new(0, 420, 0, 260)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BackgroundTransparency = 0.12
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = screenGui

local corner = Instance.new(_._0x1(85).._._0x1(73).._._0x1(67).._._0x1(111).._._0x1(114).._._0x1(110).._._0x1(101).._._0x1(114))
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = frame

local stroke = Instance.new(_._0x1(85).._._0x1(73).._._0x1(83).._._0x1(116).._._0x1(114).._._0x1(111).._._0x1(107).._._0x1(101))
stroke.Thickness = 1.5
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Transparency = 0.6
stroke.Parent = frame

local blur = Instance.new(_._0x1(66).._._0x1(108).._._0x1(117).._._0x1(114).._._0x1(69).._._0x1(102).._._0x1(102).._._0x1(101).._._0x1(99).._._0x1(116))
blur.Size = 18
blur.Parent = frame

local glow = Instance.new(_._0x1(70).._._0x1(114).._._0x1(97).._._0x1(109).._._0x1(101))
glow.Size = UDim2.new(0, 180, 0, 180)
glow.Position = UDim2.new(0, -50, 0, -50)
glow.BackgroundColor3 = Color3.fromRGB(150, 200, 255)
glow.BackgroundTransparency = 0.6
glow.BorderSizePixel = 0
glow.Parent = frame
local glowCorner = Instance.new(_._0x1(85).._._0x1(73).._._0x1(67).._._0x1(111).._._0x1(114).._._0x1(110).._._0x1(101).._._0x1(114))
glowCorner.CornerRadius = UDim.new(1, 0)
glowCorner.Parent = glow

local closeBtn = Instance.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116).._._0x1(66).._._0x1(117).._._0x1(116).._._0x1(116).._._0x1(111).._._0x1(110))
closeBtn.Size = UDim2.new(0, 36, 0, 36)
closeBtn.Position = UDim2.new(1, -46, 0, 12)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = _._0x1(226).._._0x1(156).._._0x1(149)
closeBtn.TextColor3 = Color3.fromRGB(220, 220, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 22
closeBtn.Parent = frame

local title = Instance.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116).._._0x1(76).._._0x1(97).._._0x1(98).._._0x1(101).._._0x1(108))
title.Size = UDim2.new(1, 0, 0, 60)
title.Position = UDim2.new(0, 0, 0, 12)
title.BackgroundTransparency = 1
title.Text = _._0x1(226).._._0x1(156).._._0x1(168).._._0x1(32).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(175).._._0x1(134).._._0x1(233).._._0x1(170).._._0x1(140).._._0x1(232).._._0x1(175).._._0x1(129)
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = frame

local subtitle = Instance.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116).._._0x1(76).._._0x1(97).._._0x1(98).._._0x1(101).._._0x1(108))
subtitle.Size = UDim2.new(1, -40, 0, 30)
subtitle.Position = UDim2.new(0, 20, 0, 72)
subtitle.BackgroundTransparency = 1
subtitle.Text = _._0x1(232).._._0x1(175).._._0x1(183).._._0x1(232).._._0x1(190).._._0x1(147).._._0x1(229).._._0x1(133).._._0x1(165).._._0x1(230).._._0x1(130).._._0x1(168).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(175).._._0x1(134).._._0x1(228).._._0x1(187).._._0x1(165).._._0x1(232).._._0x1(167).._._0x1(163).._._0x1(233).._._0x1(148).._._0x1(129).._._0x1(229).._._0x1(138).._._0x1(159).._._0x1(232).._._0x1(131).._._0x1(189)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 15
subtitle.TextColor3 = Color3.fromRGB(220, 220, 255)
subtitle.TextXAlignment = Enum.TextXAlignment.Center
subtitle.TextWrapped = true
subtitle.Parent = frame

local inputBox = Instance.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116).._._0x1(66).._._0x1(111).._._0x1(120))
inputBox.Size = UDim2.new(0.8, 0, 0, 48)
inputBox.Position = UDim2.new(0.1, 0, 0, 112)
inputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
inputBox.BackgroundTransparency = 0.15
inputBox.BorderSizePixel = 0
inputBox.PlaceholderText = _._0x1(229).._._0x1(156).._._0x1(168).._._0x1(230).._._0x1(173).._._0x1(164).._._0x1(232).._._0x1(190).._._0x1(147).._._0x1(229).._._0x1(133).._._0x1(165).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(175).._._0x1(134).._._0x1(46).._._0x1(46).._._0x1(46)
inputBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 200)
inputBox.Text = _._0x1()
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 18
inputBox.ClearTextOnFocus = false
inputBox.Parent = frame
local inputCorner = Instance.new(_._0x1(85).._._0x1(73).._._0x1(67).._._0x1(111).._._0x1(114).._._0x1(110).._._0x1(101).._._0x1(114))
inputCorner.CornerRadius = UDim.new(0, 12)
inputCorner.Parent = inputBox
local inputStroke = Instance.new(_._0x1(85).._._0x1(73).._._0x1(83).._._0x1(116).._._0x1(114).._._0x1(111).._._0x1(107).._._0x1(101))
inputStroke.Thickness = 1
inputStroke.Color = Color3.fromRGB(255, 255, 255)
inputStroke.Transparency = 0.3
inputStroke.Parent = inputBox

local submitBtn = Instance.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116).._._0x1(66).._._0x1(117).._._0x1(116).._._0x1(116).._._0x1(111).._._0x1(110))
submitBtn.Size = UDim2.new(0.8, 0, 0, 52)
submitBtn.Position = UDim2.new(0.1, 0, 0, 180)
submitBtn.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
submitBtn.BackgroundTransparency = 0.2
submitBtn.BorderSizePixel = 0
submitBtn.Text = _._0x1(240).._._0x1(159).._._0x1(154).._._0x1(128).._._0x1(32).._._0x1(231).._._0x1(171).._._0x1(139).._._0x1(229).._._0x1(141).._._0x1(179).._._0x1(230).._._0x1(191).._._0x1(128).._._0x1(230).._._0x1(180).._._0x1(187)
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 19
submitBtn.Parent = frame
local btnCorner = Instance.new(_._0x1(85).._._0x1(73).._._0x1(67).._._0x1(111).._._0x1(114).._._0x1(110).._._0x1(101).._._0x1(114))
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = submitBtn
local btnStroke = Instance.new(_._0x1(85).._._0x1(73).._._0x1(83).._._0x1(116).._._0x1(114).._._0x1(111).._._0x1(107).._._0x1(101))
btnStroke.Thickness = 1.5
btnStroke.Color = Color3.fromRGB(255, 255, 255)
btnStroke.Transparency = 0.4
btnStroke.Parent = submitBtn

-- ==================== 入场动画 ====================
frame.BackgroundTransparency = 1
frame.Size = UDim2.new(0, 0, 0, 0)
task.wait(0.05)
local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local sizeTween = TweenService:Create(frame, tweenInfo, { Size = UDim2.new(0, 420, 0, 260) })
local fadeTween = TweenService:Create(frame, TweenInfo.new(0.3), { BackgroundTransparency = 0.12 })
sizeTween:Play()
fadeTween:Play()

-- ==================== 核心逻辑 ====================
local verificationComplete = false

-- ================================================================
--  ★★★ 主脚本执行函数（验证成功后自动调用） ★★★
--  ★★★ 把你的主脚本代码放在这里 ★★★
-- ================================================================
local function executeMainScript()
    _G[_._0x1(112).._._0x1(114).._._0x1(105).._._0x1(110).._._0x1(116)](_._0x1(91).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(175).._._0x1(134).._._0x1(233).._._0x1(170).._._0x1(140).._._0x1(232).._._0x1(175).._._0x1(129).._._0x1(93).._._0x1(32).._._0x1(226).._._0x1(156).._._0x1(133).._._0x1(32).._._0x1(233).._._0x1(170).._._0x1(140).._._0x1(232).._._0x1(175).._._0x1(129).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159).._._0x1(239).._._0x1(188).._._0x1(140).._._0x1(229).._._0x1(188).._._0x1(128).._._0x1(229).._._0x1(167).._._0x1(139).._._0x1(230).._._0x1(137).._._0x1(167).._._0x1(232).._._0x1(161).._._0x1(140).._._0x1(228).._._0x1(184).._._0x1(187).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(239).._._0x1(188).._._0x1(129))
    
    -- ════════════════════════════════════════════════════════════
    --  ★★★ 把你的主脚本代码放在下面 ★★★
    --  ★★★ 验证通过后会自动执行 ★★★
    -- ════════════════════════════════════════════════════════════

do
    local ok, err = pcall(function()
        local Players = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115))
        local TweenService = game:GetService(_._0x1(84).._._0x1(119).._._0x1(101).._._0x1(101).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101))
        local RunService = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101))
        local CoreGui = game:GetService(_._0x1(67).._._0x1(111).._._0x1(114).._._0x1(101).._._0x1(71).._._0x1(117).._._0x1(105))
        local LocalPlayer = Players.LocalPlayer

        local function getGuiParent()
            local s, p = pcall(function()
                if gethui then return gethui() end
                return CoreGui
            end)
            if s and p then return p end
            return LocalPlayer:FindFirstChildOfClass(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(71).._._0x1(117).._._0x1(105)) or LocalPlayer:WaitForChild(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(71).._._0x1(117).._._0x1(105))
        end

        local old = getGuiParent():FindFirstChild(_._0x1(71).._._0x1(114).._._0x1(105).._._0x1(100).._._0x1(67).._._0x1(111).._._0x1(108).._._0x1(108).._._0x1(97).._._0x1(112).._._0x1(115).._._0x1(101).._._0x1(66).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(65).._._0x1(110).._._0x1(105).._._0x1(109).._._0x1(97).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110))
        if old then old:Destroy() end

        local gui = Instance.new(_._0x1(83).._._0x1(99).._._0x1(114).._._0x1(101).._._0x1(101).._._0x1(110).._._0x1(71).._._0x1(117).._._0x1(105))
        gui.Name = _._0x1(71).._._0x1(114).._._0x1(105).._._0x1(100).._._0x1(67).._._0x1(111).._._0x1(108).._._0x1(108).._._0x1(97).._._0x1(112).._._0x1(115).._._0x1(101).._._0x1(66).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(65).._._0x1(110).._._0x1(105).._._0x1(109).._._0x1(97).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110)
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
            local sound = Instance.new(_._0x1(83).._._0x1(111).._._0x1(117).._._0x1(110).._._0x1(100))
            sound.SoundId = soundId
            sound.Volume = volume or 0.5
            sound.Pitch = pitch or 1
            sound.Parent = gui
            return sound
        end

        local bgMusic = createSound(_._0x1(114).._._0x1(98).._._0x1(120).._._0x1(97).._._0x1(115).._._0x1(115).._._0x1(101).._._0x1(116).._._0x1(105).._._0x1(100).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(49).._._0x1(56).._._0x1(52).._._0x1(49).._._0x1(50).._._0x1(50).._._0x1(56).._._0x1(53).._._0x1(57).._._0x1(51), 0.3, 1.2)
        local typeSound = createSound(_._0x1(114).._._0x1(98).._._0x1(120).._._0x1(97).._._0x1(115).._._0x1(115).._._0x1(101).._._0x1(116).._._0x1(105).._._0x1(100).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(49).._._0x1(50).._._0x1(50).._._0x1(50).._._0x1(49).._._0x1(57).._._0x1(54).._._0x1(55), 0.15, 1)
        local completeSound = createSound(_._0x1(114).._._0x1(98).._._0x1(120).._._0x1(97).._._0x1(115).._._0x1(115).._._0x1(101).._._0x1(116).._._0x1(105).._._0x1(100).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(49).._._0x1(48).._._0x1(56).._._0x1(52).._._0x1(54).._._0x1(48).._._0x1(53).._._0x1(51).._._0x1(48).._._0x1(55), 0.5, 1.1)
        local collapseSound = createSound(_._0x1(114).._._0x1(98).._._0x1(120).._._0x1(97).._._0x1(115).._._0x1(115).._._0x1(101).._._0x1(116).._._0x1(105).._._0x1(100).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(49).._._0x1(53).._._0x1(54).._._0x1(54).._._0x1(53).._._0x1(49).._._0x1(49).._._0x1(54).._._0x1(51).._._0x1(53), 0.2, 1.3)

        -- 全屏黑色背景
        local bg = Instance.new(_._0x1(70).._._0x1(114).._._0x1(97).._._0x1(109).._._0x1(101))
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        bg.BackgroundTransparency = 0
        bg.ZIndex = 1
        bg.Parent = gui

        -- 网格背景容器
        local gridContainer = Instance.new(_._0x1(70).._._0x1(114).._._0x1(97).._._0x1(109).._._0x1(101))
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
                local gridSquare = Instance.new(_._0x1(70).._._0x1(114).._._0x1(97).._._0x1(109).._._0x1(101))
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
        local centerBox = Instance.new(_._0x1(70).._._0x1(114).._._0x1(97).._._0x1(109).._._0x1(101))
        centerBox.Size = UDim2.new(0, 420, 0, 300)
        centerBox.Position = UDim2.new(0.5, -210, 0.5, -150)
        centerBox.BackgroundColor3 = Color3.fromRGB(0, 10, 5)
        centerBox.BackgroundTransparency = 0.2
        centerBox.BorderSizePixel = 0
        centerBox.ZIndex = 10
        centerBox.Parent = bg
        Instance.new(_._0x1(85).._._0x1(73).._._0x1(67).._._0x1(111).._._0x1(114).._._0x1(110).._._0x1(101).._._0x1(114), centerBox).CornerRadius = UDim.new(0, 12)

        local centerStroke = Instance.new(_._0x1(85).._._0x1(73).._._0x1(83).._._0x1(116).._._0x1(114).._._0x1(111).._._0x1(107).._._0x1(101), centerBox)
        centerStroke.Color = Color3.fromRGB(0, 255, 100)
        centerStroke.Thickness = 2

        -- 标题
        local title = Instance.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116).._._0x1(76).._._0x1(97).._._0x1(98).._._0x1(101).._._0x1(108))
        title.Size = UDim2.new(1, 0, 0, 50)
        title.Position = UDim2.new(0, 0, 0, 15)
        title.BackgroundTransparency = 1
        title.Text = _._0x1(226).._._0x1(150).._._0x1(140).._._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(230).._._0x1(173).._._0x1(163).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(32).._._0x1(226).._._0x1(150).._._0x1(140)
        title.TextColor3 = Color3.fromRGB(0, 255, 100)
        title.TextTransparency = 1
        title.TextSize = 20
        title.Font = Enum.Font.Code
        title.TextXAlignment = Enum.TextXAlignment.Center
        title.ZIndex = 11
        title.Parent = centerBox

        -- 进度条背景
        local progressBg = Instance.new(_._0x1(70).._._0x1(114).._._0x1(97).._._0x1(109).._._0x1(101))
        progressBg.Size = UDim2.new(0, 350, 0, 8)
        progressBg.Position = UDim2.new(0, 35, 0, 80)
        progressBg.BackgroundColor3 = Color3.fromRGB(20, 30, 20)
        progressBg.BorderSizePixel = 0
        progressBg.ZIndex = 11
        progressBg.Parent = centerBox
        Instance.new(_._0x1(85).._._0x1(73).._._0x1(67).._._0x1(111).._._0x1(114).._._0x1(110).._._0x1(101).._._0x1(114), progressBg).CornerRadius = UDim.new(0, 4)

        local progressStroke = Instance.new(_._0x1(85).._._0x1(73).._._0x1(83).._._0x1(116).._._0x1(114).._._0x1(111).._._0x1(107).._._0x1(101), progressBg)
        progressStroke.Color = Color3.fromRGB(0, 255, 100)
        progressStroke.Thickness = 1

        -- 进度条填充
        local progressFill = Instance.new(_._0x1(70).._._0x1(114).._._0x1(97).._._0x1(109).._._0x1(101))
        progressFill.Size = UDim2.new(0, 0, 1, 0)
        progressFill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        progressFill.BorderSizePixel = 0
        progressFill.ZIndex = 12
        progressFill.Parent = progressBg
        Instance.new(_._0x1(85).._._0x1(73).._._0x1(67).._._0x1(111).._._0x1(114).._._0x1(110).._._0x1(101).._._0x1(114), progressFill).CornerRadius = UDim.new(0, 4)

        local fillGradient = Instance.new(_._0x1(85).._._0x1(73).._._0x1(71).._._0x1(114).._._0x1(97).._._0x1(100).._._0x1(105).._._0x1(101).._._0x1(110).._._0x1(116), progressFill)
        fillGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 100)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 150)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 100)),
        })

        -- 百分比文本
        local percentText = Instance.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116).._._0x1(76).._._0x1(97).._._0x1(98).._._0x1(101).._._0x1(108))
        percentText.Size = UDim2.new(0, 80, 0, 25)
        percentText.Position = UDim2.new(0, 35, 0, 105)
        percentText.BackgroundTransparency = 1
        percentText.Text = _._0x1(48).._._0x1(37)
        percentText.TextColor3 = Color3.fromRGB(0, 255, 100)
        percentText.TextTransparency = 1
        percentText.TextSize = 18
        percentText.Font = Enum.Font.Code
        percentText.TextXAlignment = Enum.TextXAlignment.Left
        percentText.ZIndex = 11
        percentText.Parent = centerBox

        -- 状态信息
        local statusInfo = Instance.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116).._._0x1(76).._._0x1(97).._._0x1(98).._._0x1(101).._._0x1(108))
        statusInfo.Size = UDim2.new(1, -70, 0, 60)
        statusInfo.Position = UDim2.new(0, 35, 0, 150)
        statusInfo.BackgroundTransparency = 1
        statusInfo.Text = _._0x1(62).._._0x1(32).._._0x1(229).._._0x1(136).._._0x1(157).._._0x1(229).._._0x1(167).._._0x1(139).._._0x1(229).._._0x1(140).._._0x1(150).._._0x1(231).._._0x1(189).._._0x1(145).._._0x1(230).._._0x1(160).._._0x1(188).._._0x1(231).._._0x1(179).._._0x1(187).._._0x1(231).._._0x1(187).._._0x1(159).._._0x1(92).._._0x1(110).._._0x1(62).._._0x1(32).._._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(149).._._0x1(176).._._0x1(230).._._0x1(141).._._0x1(174).._._0x1(231).._._0x1(159).._._0x1(169).._._0x1(233).._._0x1(152).._._0x1(181).._._0x1(92).._._0x1(110).._._0x1(62).._._0x1(32).._._0x1(229).._._0x1(135).._._0x1(134).._._0x1(229).._._0x1(164).._._0x1(135).._._0x1(229).._._0x1(174).._._0x1(140).._._0x1(230).._._0x1(175).._._0x1(149)
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
                percentText.Text = math.floor(progress * 100) .. _._0x1(37)
                
                if math.floor(progress * 100) % 25 == 0 then
                    typeSound:Play()
                end
                
                if progress >= 1.0 then
                    percentText.Text = _._0x1(49).._._0x1(48).._._0x1(48).._._0x1(37)
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
        warn(_._0x1(231).._._0x1(189).._._0x1(145).._._0x1(230).._._0x1(160).._._0x1(188).._._0x1(229).._._0x1(180).._._0x1(169).._._0x1(229).._._0x1(157).._._0x1(143).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(231).._._0x1(148).._._0x1(187).._._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(229).._._0x1(164).._._0x1(177).._._0x1(232).._._0x1(180).._._0x1(165).._._0x1(239).._._0x1(188).._._0x1(154) .. tostring(err))
    end
end

WindUI:Popup({
    Title = _._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Icon = _._0x1(105).._._0x1(110).._._0x1(102).._._0x1(111),
    Content = _._0x1(230).._._0x1(152).._._0x1(175).._._0x1(229).._._0x1(144).._._0x1(166).._._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(156).._._0x1(128).._._0x1(230).._._0x1(150).._._0x1(176).._._0x1(231).._._0x1(137).._._0x1(136).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(32).._._0x1(51).._._0x1(46).._._0x1(55).._._0x1(56).._._0x1(227).._._0x1(128).._._0x1(138).._._0x1(230).._._0x1(156).._._0x1(128).._._0x1(230).._._0x1(150).._._0x1(176).._._0x1(227).._._0x1(128).._._0x1(139),
    Buttons = {
        {
            Title = _._0x1(229).._._0x1(143).._._0x1(150).._._0x1(230).._._0x1(182).._._0x1(136),
            Callback = function() end,
            Variant = _._0x1(84).._._0x1(101).._._0x1(114).._._0x1(116).._._0x1(105).._._0x1(97).._._0x1(114).._._0x1(121),
        },
        {
            Title = _._0x1(231).._._0x1(161).._._0x1(174).._._0x1(229).._._0x1(174).._._0x1(154),
            Icon = _._0x1(97).._._0x1(114).._._0x1(114).._._0x1(111).._._0x1(119).._._0x1(45).._._0x1(114).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116),
            Callback = function() end,
            Variant = _._0x1(80).._._0x1(114).._._0x1(105).._._0x1(109).._._0x1(97).._._0x1(114).._._0x1(121),
        }
    }
})

WindUI:Notify({
    Title = _._0x1(231).._._0x1(180).._._0x1(167).._._0x1(230).._._0x1(128).._._0x1(165).._._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165).._._0x1(239).._._0x1(188).._._0x1(154).._._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(229).._._0x1(143).._._0x1(175).._._0x1(232).._._0x1(131).._._0x1(189).._._0x1(228).._._0x1(188).._._0x1(154).._._0x1(229).._._0x1(129).._._0x1(156).._._0x1(230).._._0x1(155).._._0x1(180),
    Content = _._0x1(78).._._0x1(111).._._0x1(116).._._0x1(105).._._0x1(102).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110).._._0x1(32).._._0x1(67).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(32).._._0x1(101).._._0x1(120).._._0x1(97).._._0x1(109).._._0x1(112).._._0x1(108).._._0x1(101).._._0x1(33),
    Duration = 3, -- 3 seconds
    Icon = _._0x1(98).._._0x1(105).._._0x1(114).._._0x1(100),
})

WindUI:Notify({
    Title = _._0x1(230).._._0x1(172).._._0x1(162).._._0x1(232).._._0x1(191).._._0x1(142).._._0x1(228).._._0x1(189).._._0x1(191).._._0x1(231).._._0x1(148).._._0x1(168),
    Content = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Duration = 3,
    Position = _._0x1(76).._._0x1(101).._._0x1(102).._._0x1(116)
})

WindUI:Notify({
    Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Content = _._0x1(228).._._0x1(184).._._0x1(141).._._0x1(232).._._0x1(183).._._0x1(145).._._0x1(232).._._0x1(183).._._0x1(175),
    Duration = 11,
})

WindUI:Notify({
    Title = _._0x1(230).._._0x1(172).._._0x1(162).._._0x1(232).._._0x1(191).._._0x1(142).._._0x1(228).._._0x1(189).._._0x1(191).._._0x1(231).._._0x1(148).._._0x1(168),
    Content = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Duration = 10,
})

WindUI:Notify({
    Title = _._0x1(81).._._0x1(32).._._0x1(231).._._0x1(190).._._0x1(164),
    Content = _._0x1(49).._._0x1(48).._._0x1(49).._._0x1(51).._._0x1(48).._._0x1(49).._._0x1(51).._._0x1(52).._._0x1(56).._._0x1(53),
    Duration = 10,
})

WindUI:Popup({
    Title = _._0x1(230).._._0x1(172).._._0x1(162).._._0x1(232).._._0x1(191).._._0x1(142).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(230).._._0x1(136).._._0x1(183).._._0x1(232).._._0x1(191).._._0x1(155).._._0x1(229).._._0x1(133).._._0x1(165).._._0x1(32).._._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Icon = _._0x1(105).._._0x1(110).._._0x1(102).._._0x1(111),
    Content = _._0x1(230).._._0x1(172).._._0x1(162).._._0x1(232).._._0x1(191).._._0x1(142).._._0x1(228).._._0x1(189).._._0x1(160).._._0x1(230).._._0x1(184).._._0x1(184).._._0x1(231).._._0x1(142).._._0x1(169).._._0x1(230).._._0x1(136).._._0x1(145).._._0x1(228).._._0x1(187).._._0x1(172).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(32).._._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(240).._._0x1(159).._._0x1(152).._._0x1(139),
    Buttons = {
        {
            Title = _._0x1(230).._._0x1(136).._._0x1(145).._._0x1(228).._._0x1(184).._._0x1(141).._._0x1(231).._._0x1(159).._._0x1(165).._._0x1(233).._._0x1(129).._._0x1(147),
            Callback = function() end,
            Variant = _._0x1(84).._._0x1(101).._._0x1(114).._._0x1(116).._._0x1(105).._._0x1(97).._._0x1(114).._._0x1(121),
        },
        {
            Title = _._0x1(230).._._0x1(136).._._0x1(145).._._0x1(231).._._0x1(159).._._0x1(165).._._0x1(233).._._0x1(129).._._0x1(147).._._0x1(231).._._0x1(154).._._0x1(132),
            Icon = _._0x1(97).._._0x1(114).._._0x1(114).._._0x1(111).._._0x1(119).._._0x1(45).._._0x1(114).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116),
            Callback = function() end,
            Variant = _._0x1(80).._._0x1(114).._._0x1(105).._._0x1(109).._._0x1(97).._._0x1(114).._._0x1(121),
        }
    }
})

WindUI:Popup({
    Title = _._0x1(229).._._0x1(133).._._0x1(172).._._0x1(229).._._0x1(145).._._0x1(138),
    Icon = _._0x1(105).._._0x1(110).._._0x1(102).._._0x1(111),
    Content = _._0x1(232).._._0x1(175).._._0x1(165).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(231).._._0x1(166).._._0x1(129).._._0x1(230).._._0x1(173).._._0x1(162).._._0x1(229).._._0x1(128).._._0x1(146).._._0x1(229).._._0x1(141).._._0x1(150).._._0x1(228).._._0x1(189).._._0x1(156).._._0x1(232).._._0x1(128).._._0x1(133).._._0x1(239).._._0x1(188).._._0x1(154).._._0x1(229).._._0x1(176).._._0x1(143).._._0x1(229).._._0x1(164).._._0x1(156).._._0x1(228).._._0x1(189).._._0x1(156).._._0x1(232).._._0x1(128).._._0x1(133).._._0x1(32).._._0x1(81).._._0x1(81).._._0x1(32).._._0x1(229).._._0x1(143).._._0x1(183).._._0x1(32).._._0x1(50).._._0x1(55).._._0x1(50).._._0x1(53).._._0x1(56).._._0x1(57).._._0x1(50).._._0x1(50).._._0x1(53).._._0x1(48).._._0x1(232).._._0x1(175).._._0x1(165).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(232).._._0x1(189).._._0x1(172).._._0x1(228).._._0x1(184).._._0x1(186).._._0x1(228).._._0x1(187).._._0x1(152).._._0x1(232).._._0x1(180).._._0x1(185),
    Buttons = {
        {
            Title = _._0x1(230).._._0x1(136).._._0x1(145).._._0x1(228).._._0x1(184).._._0x1(141).._._0x1(231).._._0x1(159).._._0x1(165).._._0x1(233).._._0x1(129).._._0x1(147),
            Callback = function() end,
            Variant = _._0x1(84).._._0x1(101).._._0x1(114).._._0x1(116).._._0x1(105).._._0x1(97).._._0x1(114).._._0x1(121),
        },
        {
            Title = _._0x1(230).._._0x1(136).._._0x1(145).._._0x1(231).._._0x1(159).._._0x1(165).._._0x1(233).._._0x1(129).._._0x1(147).._._0x1(231).._._0x1(154).._._0x1(132),
            Icon = _._0x1(97).._._0x1(114).._._0x1(114).._._0x1(111).._._0x1(119).._._0x1(45).._._0x1(114).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116),
            Callback = function() end,
            Variant = _._0x1(80).._._0x1(114).._._0x1(105).._._0x1(109).._._0x1(97).._._0x1(114).._._0x1(121),
        }
    }
})

local Players = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115))
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local Main = WindUI:CreateWindow({
    Title = _._0x1(60).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(32).._._0x1(99).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114).._._0x1(61).._._0x1(39).._._0x1(35).._._0x1(102).._._0x1(102).._._0x1(48).._._0x1(48).._._0x1(55).._._0x1(102).._._0x1(39).._._0x1(62).._._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(60).._._0x1(47).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(62).._._0x1(45).._._0x1(60).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(32).._._0x1(99).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114).._._0x1(61).._._0x1(39).._._0x1(35).._._0x1(48).._._0x1(48).._._0x1(102).._._0x1(102).._._0x1(102).._._0x1(102).._._0x1(39).._._0x1(62).._._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(60).._._0x1(47).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(62),
    Author = _._0x1(60).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(32).._._0x1(99).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114).._._0x1(61).._._0x1(39).._._0x1(35).._._0x1(48).._._0x1(48).._._0x1(102).._._0x1(102).._._0x1(102).._._0x1(102).._._0x1(39).._._0x1(62).._._0x1(98).._._0x1(121).._._0x1(60).._._0x1(47).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(62).._._0x1(32).._._0x1(60).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(32).._._0x1(99).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114).._._0x1(61).._._0x1(39).._._0x1(35).._._0x1(102).._._0x1(102).._._0x1(48).._._0x1(48).._._0x1(55).._._0x1(102).._._0x1(39).._._0x1(62).._._0x1(229).._._0x1(176).._._0x1(143).._._0x1(229).._._0x1(164).._._0x1(156).._._0x1(60).._._0x1(47).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(62),
    Folder = _._0x1(67).._._0x1(108).._._0x1(111).._._0x1(117).._._0x1(100).._._0x1(72).._._0x1(117).._._0x1(98),
    Size = UDim2.fromOffset(300, 400),
    Transparent = true,
    Theme = _._0x1(68).._._0x1(97).._._0x1(114).._._0x1(107),
    SideBarWidth = 200,
    Icon = _._0x1(114).._._0x1(98).._._0x1(120).._._0x1(97).._._0x1(115).._._0x1(115).._._0x1(101).._._0x1(116).._._0x1(105).._._0x1(100).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(49).._._0x1(50).._._0x1(55).._._0x1(52).._._0x1(49).._._0x1(56).._._0x1(49).._._0x1(49).._._0x1(56).._._0x1(53).._._0x1(49).._._0x1(52).._._0x1(55).._._0x1(50).._._0x1(50),
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
    Title = _._0x1(60).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(32).._._0x1(99).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114).._._0x1(61).._._0x1(39).._._0x1(35).._._0x1(102).._._0x1(102).._._0x1(48).._._0x1(48).._._0x1(55).._._0x1(102).._._0x1(39).._._0x1(62).._._0x1(88).._._0x1(89).._._0x1(60).._._0x1(47).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(62).._._0x1(60).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(32).._._0x1(99).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114).._._0x1(61).._._0x1(39).._._0x1(35).._._0x1(48).._._0x1(48).._._0x1(102).._._0x1(102).._._0x1(102).._._0x1(102).._._0x1(39).._._0x1(62).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(32).._._0x1(228).._._0x1(187).._._0x1(152).._._0x1(232).._._0x1(180).._._0x1(185).._._0x1(231).._._0x1(137).._._0x1(136).._._0x1(60).._._0x1(47).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(62),
    Icon = _._0x1(114).._._0x1(98).._._0x1(120).._._0x1(97).._._0x1(115).._._0x1(115).._._0x1(101).._._0x1(116).._._0x1(105).._._0x1(100).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(49).._._0x1(50).._._0x1(55).._._0x1(52).._._0x1(49).._._0x1(56).._._0x1(49).._._0x1(49).._._0x1(56).._._0x1(53).._._0x1(49).._._0x1(52).._._0x1(55).._._0x1(50).._._0x1(50),
    CornerRadius = UDim.new(0, 8),
    StrokeThickness = 2,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex(_._0x1(35).._._0x1(102).._._0x1(102).._._0x1(48).._._0x1(48).._._0x1(55).._._0x1(102))),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex(_._0x1(35).._._0x1(48).._._0x1(48).._._0x1(102).._._0x1(102).._._0x1(102).._._0x1(102))),
        ColorSequenceKeypoint.new(1, Color3.fromHex(_._0x1(35).._._0x1(102).._._0x1(102).._._0x1(48).._._0x1(48).._._0x1(55).._._0x1(102)))
    })
})

Main:Tag({
    Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Color = Color3.fromHex(_._0x1(35).._._0x1(48).._._0x1(48).._._0x1(102).._._0x1(102).._._0x1(102).._._0x1(102))
})

Main:Tag({
    Title = _._0x1(228).._._0x1(187).._._0x1(152).._._0x1(232).._._0x1(180).._._0x1(185),
    Color = Color3.fromHex(_._0x1(35).._._0x1(102).._._0x1(102).._._0x1(48).._._0x1(48).._._0x1(55).._._0x1(102))
})

local TimeTag = Main:Tag({
    Title = _._0x1(229).._._0x1(189).._._0x1(147).._._0x1(229).._._0x1(137).._._0x1(141).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(233).._._0x1(151).._._0x1(180).._._0x1(58).._._0x1(32).._._0x1(48).._._0x1(48).._._0x1(58).._._0x1(48).._._0x1(48).._._0x1(58).._._0x1(48).._._0x1(48),
    Color = Color3.fromHex(_._0x1(35).._._0x1(48).._._0x1(48).._._0x1(102).._._0x1(102).._._0x1(102).._._0x1(102))
})

Main:Tag({
    Title = _._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(229).._._0x1(136).._._0x1(155).._._0x1(229).._._0x1(187).._._0x1(186).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(54).._._0x1(229).._._0x1(164).._._0x1(169),
    Color = Color3.fromHex(_._0x1(35).._._0x1(102).._._0x1(102).._._0x1(48).._._0x1(48).._._0x1(55).._._0x1(102))
})

local hue = 0
local running = true

task.spawn(function()
    while running do
        local now = os.date(_._0x1(42).._._0x1(116))
        local hours = string.format(_._0x1(37).._._0x1(48).._._0x1(50).._._0x1(100), now.hour)
        local minutes = string.format(_._0x1(37).._._0x1(48).._._0x1(50).._._0x1(100), now.min)
        local seconds = string.format(_._0x1(37).._._0x1(48).._._0x1(50).._._0x1(100), now.sec)
        local timeString = string.format(_._0x1(229).._._0x1(189).._._0x1(147).._._0x1(229).._._0x1(137).._._0x1(141).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(233).._._0x1(151).._._0x1(180).._._0x1(58).._._0x1(32).._._0x1(37).._._0x1(115).._._0x1(58).._._0x1(37).._._0x1(115).._._0x1(58).._._0x1(37).._._0x1(115), hours, minutes, seconds)
        hue = (hue + 0.01) % 1
        local color = Color3.fromHSV(hue, 1, 1)
        TimeTag:SetTitle(timeString)
        TimeTag:SetColor(color)
        task.wait(0.06)
    end
end)

local TimeTag2 = Main:Tag({
    Title = _._0x1(230).._._0x1(150).._._0x1(176).._._0x1(229).._._0x1(185).._._0x1(180).._._0x1(229).._._0x1(128).._._0x1(146).._._0x1(232).._._0x1(174).._._0x1(161).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(58).._._0x1(32).._._0x1(45).._._0x1(45),
    Color = Color3.fromHex(_._0x1(35).._._0x1(102).._._0x1(53).._._0x1(55).._._0x1(99).._._0x1(48).._._0x1(48))
})

local function getNextNewYear()
    local now = os.date(_._0x1(42).._._0x1(116))
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
            displayText = string.format(_._0x1(230).._._0x1(150).._._0x1(176).._._0x1(229).._._0x1(185).._._0x1(180).._._0x1(229).._._0x1(128).._._0x1(146).._._0x1(232).._._0x1(174).._._0x1(161).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(58).._._0x1(32).._._0x1(37).._._0x1(100).._._0x1(229).._._0x1(164).._._0x1(169).._._0x1(37).._._0x1(48).._._0x1(50).._._0x1(100).._._0x1(58).._._0x1(37).._._0x1(48).._._0x1(50).._._0x1(100).._._0x1(58).._._0x1(37).._._0x1(48).._._0x1(50).._._0x1(100), days, hours, minutes, seconds)
        else
            displayText = string.format(_._0x1(230).._._0x1(150).._._0x1(176).._._0x1(229).._._0x1(185).._._0x1(180).._._0x1(229).._._0x1(128).._._0x1(146).._._0x1(232).._._0x1(174).._._0x1(161).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(58).._._0x1(32).._._0x1(37).._._0x1(48).._._0x1(50).._._0x1(100).._._0x1(58).._._0x1(37).._._0x1(48).._._0x1(50).._._0x1(100).._._0x1(58).._._0x1(37).._._0x1(48).._._0x1(50).._._0x1(100), hours, minutes, seconds)
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
    local Corner = Instance.new(_._0x1(85).._._0x1(73).._._0x1(67).._._0x1(111).._._0x1(114).._._0x1(110).._._0x1(101).._._0x1(114))
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = MainFrame
    local Border = Instance.new(_._0x1(85).._._0x1(73).._._0x1(83).._._0x1(116).._._0x1(114).._._0x1(111).._._0x1(107).._._0x1(101))
    Border.Name = _._0x1(78).._._0x1(101).._._0x1(111).._._0x1(110).._._0x1(66).._._0x1(111).._._0x1(114).._._0x1(100).._._0x1(101).._._0x1(114)
    Border.Thickness = 2
    Border.Color = Color3.new(1, 1, 1)
    Border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Border.LineJoinMode = Enum.LineJoinMode.Round
    Border.Parent = MainFrame
    local Gradient = Instance.new(_._0x1(85).._._0x1(73).._._0x1(71).._._0x1(114).._._0x1(97).._._0x1(100).._._0x1(105).._._0x1(101).._._0x1(110).._._0x1(116))
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex(_._0x1(35).._._0x1(48).._._0x1(48).._._0x1(70).._._0x1(70).._._0x1(70).._._0x1(70))),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex(_._0x1(35).._._0x1(70).._._0x1(70).._._0x1(48).._._0x1(48).._._0x1(70).._._0x1(70))),
        ColorSequenceKeypoint.new(1, Color3.fromHex(_._0x1(35).._._0x1(48).._._0x1(48).._._0x1(70).._._0x1(70).._._0x1(70).._._0x1(70)))
    })
    Gradient.Rotation = 0
    Gradient.Parent = Border
    local Connection
    Connection = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101)).Heartbeat:Connect(function()
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
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(148).._._0x1(168),
    Icon = _._0x1(98).._._0x1(105).._._0x1(114).._._0x1(100), -- optional
    Locked = false,
})
local Section = Tab:Section({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(229).._._0x1(138).._._0x1(159).._._0x1(232).._._0x1(131).._._0x1(189).._._0x1(227).._._0x1(128).._._0x1(138).._._0x1(229).._._0x1(166).._._0x1(130).._._0x1(230).._._0x1(158).._._0x1(156).._._0x1(230).._._0x1(137).._._0x1(167).._._0x1(232).._._0x1(161).._._0x1(140).._._0x1(228).._._0x1(184).._._0x1(141).._._0x1(228).._._0x1(186).._._0x1(134).._._0x1(32).._._0x1(232).._._0x1(175).._._0x1(183).._._0x1(230).._._0x1(141).._._0x1(162).._._0x1(229).._._0x1(138).._._0x1(160).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(153).._._0x1(168).._._0x1(227).._._0x1(128).._._0x1(139),
    Opened = true
})
Section:Button({
    Title = _._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(184).._._0x1(162),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(115).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(115).._._0x1(46).._._0x1(110).._._0x1(101).._._0x1(116).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(47).._._0x1(85).._._0x1(110).._._0x1(105).._._0x1(118).._._0x1(101).._._0x1(114).._._0x1(115).._._0x1(97).._._0x1(108).._._0x1(45).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(45).._._0x1(70).._._0x1(101).._._0x1(45).._._0x1(68).._._0x1(114).._._0x1(111).._._0x1(112).._._0x1(75).._._0x1(105).._._0x1(99).._._0x1(107).._._0x1(45).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(45).._._0x1(49).._._0x1(54).._._0x1(53).._._0x1(56).._._0x1(49).._._0x1(51)))()    
      end
})
Section:Button({
    Title = _._0x1(230).._._0x1(151).._._0x1(160).._._0x1(230).._._0x1(149).._._0x1(140),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(115).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(115).._._0x1(46).._._0x1(110).._._0x1(101).._._0x1(116).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(47).._._0x1(85).._._0x1(110).._._0x1(105).._._0x1(118).._._0x1(101).._._0x1(114).._._0x1(115).._._0x1(97).._._0x1(108).._._0x1(45).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(45).._._0x1(70).._._0x1(101).._._0x1(45).._._0x1(68).._._0x1(114).._._0x1(111).._._0x1(112).._._0x1(75).._._0x1(105).._._0x1(99).._._0x1(107).._._0x1(45).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(45).._._0x1(49).._._0x1(54).._._0x1(53).._._0x1(56).._._0x1(49).._._0x1(51)))()    
      end
})
Section:Button({
    Title = _._0x1(86).._._0x1(82).._._0x1(232).._._0x1(167).._._0x1(134).._._0x1(232).._._0x1(167).._._0x1(146),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(115).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(115).._._0x1(46).._._0x1(110).._._0x1(101).._._0x1(116).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(47).._._0x1(85).._._0x1(110).._._0x1(105).._._0x1(118).._._0x1(101).._._0x1(114).._._0x1(115).._._0x1(97).._._0x1(108).._._0x1(45).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(45).._._0x1(70).._._0x1(101).._._0x1(45).._._0x1(68).._._0x1(114).._._0x1(111).._._0x1(112).._._0x1(75).._._0x1(105).._._0x1(99).._._0x1(107).._._0x1(45).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(45).._._0x1(49).._._0x1(54).._._0x1(53).._._0x1(56).._._0x1(49).._._0x1(51)))()    
      end
})
Section:Button({
    Title = _._0x1(230).._._0x1(151).._._0x1(160).._._0x1(233).._._0x1(153).._._0x1(144).._._0x1(231).._._0x1(189).._._0x1(151).._._0x1(229).._._0x1(174).._._0x1(157).._._0x1(240).._._0x1(159).._._0x1(152).._._0x1(177),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(115).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(115).._._0x1(46).._._0x1(110).._._0x1(101).._._0x1(116).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(47).._._0x1(85).._._0x1(110).._._0x1(105).._._0x1(118).._._0x1(101).._._0x1(114).._._0x1(115).._._0x1(97).._._0x1(108).._._0x1(45).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(45).._._0x1(70).._._0x1(101).._._0x1(45).._._0x1(68).._._0x1(114).._._0x1(111).._._0x1(112).._._0x1(75).._._0x1(105).._._0x1(99).._._0x1(107).._._0x1(45).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(45).._._0x1(49).._._0x1(54).._._0x1(53).._._0x1(56).._._0x1(49).._._0x1(51)))()    
      end
})
Section:Button({
    Title = _._0x1(229).._._0x1(162).._._0x1(158).._._0x1(229).._._0x1(138).._._0x1(160).._._0x1(70).._._0x1(80).._._0x1(83),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(112).._._0x1(97).._._0x1(115).._._0x1(116).._._0x1(101).._._0x1(102).._._0x1(121).._._0x1(46).._._0x1(97).._._0x1(112).._._0x1(112).._._0x1(47).._._0x1(73).._._0x1(89).._._0x1(85).._._0x1(65).._._0x1(111).._._0x1(121).._._0x1(55).._._0x1(97).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119)))()
   
      end
})
Section:Button({
    Title = _._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(161).._._0x1(140),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(114).._._0x1(111).._._0x1(100).._._0x1(97).._._0x1(110).._._0x1(45).._._0x1(100).._._0x1(101).._._0x1(109).._._0x1(105).._._0x1(114).._._0x1(97).._._0x1(108).._._0x1(105).._._0x1(47).._._0x1(82).._._0x1(111).._._0x1(98).._._0x1(108).._._0x1(111).._._0x1(120).._._0x1(85).._._0x1(73).._._0x1(47).._._0x1(114).._._0x1(101).._._0x1(102).._._0x1(115).._._0x1(47).._._0x1(104).._._0x1(101).._._0x1(97).._._0x1(100).._._0x1(115).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(102).._._0x1(108).._._0x1(121).._._0x1(85).._._0x1(73).._._0x1(115).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116)))    
      end
})
Section:Button({
    Title = _._0x1(230).._._0x1(151).._._0x1(160).._._0x1(230).._._0x1(149).._._0x1(140).._._0x1(229).._._0x1(176).._._0x1(145).._._0x1(228).._._0x1(190).._._0x1(160).._._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(161).._._0x1(140).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(115).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(115).._._0x1(46).._._0x1(110).._._0x1(101).._._0x1(116).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(47).._._0x1(85).._._0x1(110).._._0x1(105).._._0x1(118).._._0x1(101).._._0x1(114).._._0x1(115).._._0x1(97).._._0x1(108).._._0x1(45).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(45).._._0x1(73).._._0x1(110).._._0x1(118).._._0x1(105).._._0x1(110).._._0x1(105).._._0x1(99).._._0x1(105).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(45).._._0x1(70).._._0x1(108).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116).._._0x1(45).._._0x1(82).._._0x1(49).._._0x1(53).._._0x1(45).._._0x1(52).._._0x1(53).._._0x1(52).._._0x1(49).._._0x1(52)))()
      end
})

local Section = Tab:Section({
    Title = _._0x1(228).._._0x1(191).._._0x1(161).._._0x1(230).._._0x1(129).._._0x1(175),
    Opened = true
})
Section:Button({
    Title = _._0x1(228).._._0x1(189).._._0x1(156).._._0x1(232).._._0x1(128).._._0x1(133).._._0x1(32).._._0x1(81).._._0x1(81).._._0x1(32).._._0x1(51).._._0x1(49).._._0x1(48).._._0x1(56).._._0x1(55).._._0x1(57).._._0x1(50).._._0x1(48).._._0x1(52).._._0x1(51),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(103).._._0x1(105).._._0x1(111).._._0x1(98).._._0x1(111).._._0x1(108).._._0x1(113).._._0x1(118).._._0x1(105).._._0x1(49).._._0x1(47).._._0x1(104).._._0x1(111).._._0x1(109).._._0x1(101).._._0x1(108).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(101).._._0x1(114).._._0x1(45).._._0x1(98).._._0x1(121).._._0x1(45).._._0x1(71).._._0x1(105).._._0x1(111).._._0x1(66).._._0x1(111).._._0x1(108).._._0x1(113).._._0x1(118).._._0x1(49).._._0x1(47).._._0x1(114).._._0x1(101).._._0x1(102).._._0x1(115).._._0x1(47).._._0x1(104).._._0x1(101).._._0x1(97).._._0x1(100).._._0x1(115).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(104).._._0x1(111).._._0x1(109).._._0x1(101).._._0x1(108).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(101).._._0x1(114).._._0x1(46).._._0x1(108).._._0x1(117).._._0x1(97)))()
      end
})
Section:Button({
    Title = _._0x1(228).._._0x1(189).._._0x1(160).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(230).._._0x1(179).._._0x1(168).._._0x1(229).._._0x1(133).._._0x1(165).._._0x1(229).._._0x1(153).._._0x1(168).._._0x1(239).._._0x1(188).._._0x1(154).._._0x1(229).._._0x1(191).._._0x1(141).._._0x1(232).._._0x1(128).._._0x1(133).._._0x1(230).._._0x1(179).._._0x1(168).._._0x1(229).._._0x1(133).._._0x1(165).._._0x1(229).._._0x1(153).._._0x1(168),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(103).._._0x1(105).._._0x1(111).._._0x1(98).._._0x1(111).._._0x1(108).._._0x1(113).._._0x1(118).._._0x1(105).._._0x1(49).._._0x1(47).._._0x1(104).._._0x1(111).._._0x1(109).._._0x1(101).._._0x1(108).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(101).._._0x1(114).._._0x1(45).._._0x1(98).._._0x1(121).._._0x1(45).._._0x1(71).._._0x1(105).._._0x1(111).._._0x1(66).._._0x1(111).._._0x1(108).._._0x1(113).._._0x1(118).._._0x1(49).._._0x1(47).._._0x1(114).._._0x1(101).._._0x1(102).._._0x1(115).._._0x1(47).._._0x1(104).._._0x1(101).._._0x1(97).._._0x1(100).._._0x1(115).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(104).._._0x1(111).._._0x1(109).._._0x1(101).._._0x1(108).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(101).._._0x1(114).._._0x1(46).._._0x1(108).._._0x1(117).._._0x1(97)))()
      end
})
Section:Button({
    Title = _._0x1(232).._._0x1(175).._._0x1(165).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(228).._._0x1(184).._._0x1(141).._._0x1(229).._._0x1(156).._._0x1(136).._._0x1(233).._._0x1(146).._._0x1(177).._._0x1(228).._._0x1(185).._._0x1(159).._._0x1(228).._._0x1(184).._._0x1(141).._._0x1(228).._._0x1(188).._._0x1(154).._._0x1(232).._._0x1(183).._._0x1(145).._._0x1(232).._._0x1(183).._._0x1(175).._._0x1(232).._._0x1(137).._._0x1(175).._._0x1(229).._._0x1(191).._._0x1(131).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(103).._._0x1(105).._._0x1(111).._._0x1(98).._._0x1(111).._._0x1(108).._._0x1(113).._._0x1(118).._._0x1(105).._._0x1(49).._._0x1(47).._._0x1(104).._._0x1(111).._._0x1(109).._._0x1(101).._._0x1(108).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(101).._._0x1(114).._._0x1(45).._._0x1(98).._._0x1(121).._._0x1(45).._._0x1(71).._._0x1(105).._._0x1(111).._._0x1(66).._._0x1(111).._._0x1(108).._._0x1(113).._._0x1(118).._._0x1(49).._._0x1(47).._._0x1(114).._._0x1(101).._._0x1(102).._._0x1(115).._._0x1(47).._._0x1(104).._._0x1(101).._._0x1(97).._._0x1(100).._._0x1(115).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(104).._._0x1(111).._._0x1(109).._._0x1(101).._._0x1(108).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(101).._._0x1(114).._._0x1(46).._._0x1(108).._._0x1(117).._._0x1(97)))()
      end
})

local Tab = Window:Tab({
    Title = _._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(228).._._0x1(184).._._0x1(173).._._0x1(229).._._0x1(191).._._0x1(131),
    Icon = _._0x1(98).._._0x1(105).._._0x1(114).._._0x1(100), -- optional
    Locked = false,
})
local Section = Tab:Section({
    Title = _._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Opened = true
})
Section:Button({
    Title = _._0x1(233).._._0x1(159).._._0x1(179).._._0x1(228).._._0x1(185).._._0x1(144).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(102).._._0x1(110).._._0x1(105).._._0x1(110).._._0x1(103).._._0x1(110).._._0x1(97).._._0x1(53).._._0x1(49).._._0x1(45).._._0x1(115).._._0x1(116).._._0x1(97).._._0x1(99).._._0x1(107).._._0x1(47).._._0x1(45).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(65).._._0x1(70).._._0x1(37).._._0x1(50).._._0x1(48).._._0x1(37).._._0x1(69).._._0x1(57).._._0x1(37).._._0x1(57).._._0x1(70).._._0x1(37).._._0x1(66).._._0x1(51).._._0x1(37).._._0x1(69).._._0x1(52).._._0x1(37).._._0x1(66).._._0x1(57).._._0x1(37).._._0x1(57).._._0x1(48).._._0x1(37).._._0x1(69).._._0x1(56).._._0x1(37).._._0x1(56).._._0x1(52).._._0x1(37).._._0x1(57).._._0x1(65).._._0x1(37).._._0x1(69).._._0x1(54).._._0x1(37).._._0x1(57).._._0x1(67).._._0x1(37).._._0x1(65).._._0x1(67)))()
      end
})
Section:Button({
    Title = _._0x1(88).._._0x1(75).._._0x1(32).._._0x1(72).._._0x1(117).._._0x1(98),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(115).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(115).._._0x1(46).._._0x1(110).._._0x1(101).._._0x1(116).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(47).._._0x1(85).._._0x1(110).._._0x1(105).._._0x1(118).._._0x1(101).._._0x1(114).._._0x1(115).._._0x1(97).._._0x1(108).._._0x1(45).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(45).._._0x1(88).._._0x1(75).._._0x1(45).._._0x1(72).._._0x1(117).._._0x1(98).._._0x1(45).._._0x1(55).._._0x1(54).._._0x1(56).._._0x1(48).._._0x1(51)))()
      end
})
Section:Button({
    Title = _._0x1(230).._._0x1(178).._._0x1(179).._._0x1(229).._._0x1(140).._._0x1(151).._._0x1(229).._._0x1(148).._._0x1(144).._._0x1(229).._._0x1(142).._._0x1(191),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(77).._._0x1(97).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(56).._._0x1(54).._._0x1(52).._._0x1(50).._._0x1(47).._._0x1(115).._._0x1(99).._._0x1(105).._._0x1(101).._._0x1(110).._._0x1(99).._._0x1(101).._._0x1(47).._._0x1(111).._._0x1(107).._._0x1(47).._._0x1(84).._._0x1(37).._._0x1(50).._._0x1(48).._._0x1(97).._._0x1(110).._._0x1(103).._._0x1(37).._._0x1(50).._._0x1(48).._._0x1(67).._._0x1(111).._._0x1(117).._._0x1(110).._._0x1(116).._._0x1(121)))()
      end
})
Section:Button({
    Title = _._0x1(231).._._0x1(154).._._0x1(174).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(120).._._0x1(105).._._0x1(97).._._0x1(111).._._0x1(112).._._0x1(105).._._0x1(55).._._0x1(55).._._0x1(47).._._0x1(120).._._0x1(105).._._0x1(97).._._0x1(111).._._0x1(112).._._0x1(105).._._0x1(55).._._0x1(55).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(81).._._0x1(81).._._0x1(49).._._0x1(48).._._0x1(48).._._0x1(50).._._0x1(49).._._0x1(48).._._0x1(48).._._0x1(48).._._0x1(51).._._0x1(50).._._0x1(45).._._0x1(82).._._0x1(111).._._0x1(98).._._0x1(108).._._0x1(111).._._0x1(120).._._0x1(45).._._0x1(80).._._0x1(105).._._0x1(45).._._0x1(115).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(46).._._0x1(108).._._0x1(117).._._0x1(97)))()
      end
})
Section:Button({
    Title = _._0x1(231).._._0x1(165).._._0x1(150).._._0x1(229).._._0x1(155).._._0x1(189).._._0x1(228).._._0x1(186).._._0x1(186).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(103).._._0x1(105).._._0x1(111).._._0x1(98).._._0x1(111).._._0x1(108).._._0x1(113).._._0x1(118).._._0x1(105).._._0x1(49).._._0x1(47).._._0x1(104).._._0x1(111).._._0x1(109).._._0x1(101).._._0x1(108).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(101).._._0x1(114).._._0x1(45).._._0x1(98).._._0x1(121).._._0x1(45).._._0x1(71).._._0x1(105).._._0x1(111).._._0x1(66).._._0x1(111).._._0x1(108).._._0x1(113).._._0x1(118).._._0x1(49).._._0x1(47).._._0x1(114).._._0x1(101).._._0x1(102).._._0x1(115).._._0x1(47).._._0x1(104).._._0x1(101).._._0x1(97).._._0x1(100).._._0x1(115).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(104).._._0x1(111).._._0x1(109).._._0x1(101).._._0x1(108).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(101).._._0x1(114).._._0x1(46).._._0x1(108).._._0x1(117).._._0x1(97)))()
      end
})
Section:Button({
    Title = _._0x1(229).._._0x1(164).._._0x1(156).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(103).._._0x1(105).._._0x1(111).._._0x1(98).._._0x1(111).._._0x1(108).._._0x1(113).._._0x1(118).._._0x1(105).._._0x1(49).._._0x1(47).._._0x1(104).._._0x1(111).._._0x1(109).._._0x1(101).._._0x1(108).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(101).._._0x1(114).._._0x1(45).._._0x1(98).._._0x1(121).._._0x1(45).._._0x1(71).._._0x1(105).._._0x1(111).._._0x1(66).._._0x1(111).._._0x1(108).._._0x1(113).._._0x1(118).._._0x1(49).._._0x1(47).._._0x1(114).._._0x1(101).._._0x1(102).._._0x1(115).._._0x1(47).._._0x1(104).._._0x1(101).._._0x1(97).._._0x1(100).._._0x1(115).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(104).._._0x1(111).._._0x1(109).._._0x1(101).._._0x1(108).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(101).._._0x1(114).._._0x1(46).._._0x1(108).._._0x1(117).._._0x1(97)))()
      end
})
Section:Button({
    Title = _._0x1(232).._._0x1(175).._._0x1(165).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(228).._._0x1(187).._._0x1(165).._._0x1(233).._._0x1(148).._._0x1(153).._._0x1(232).._._0x1(175).._._0x1(175).._._0x1(226).._._0x1(157).._._0x1(140).._._0x1(230).._._0x1(151).._._0x1(160).._._0x1(230).._._0x1(179).._._0x1(149).._._0x1(230).._._0x1(137).._._0x1(167).._._0x1(232).._._0x1(161).._._0x1(140),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(97).._._0x1(97).._._0x1(97).._._0x1(97).._._0x1(97).._._0x1(45).._._0x1(97).._._0x1(114).._._0x1(99).._._0x1(104).._._0x1(47).._._0x1(101).._._0x1(102).._._0x1(102).._._0x1(101).._._0x1(99).._._0x1(116).._._0x1(105).._._0x1(118).._._0x1(101).._._0x1(45).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(117).._._0x1(116).._._0x1(105).._._0x1(110).._._0x1(103).._._0x1(45).._._0x1(109).._._0x1(97).._._0x1(99).._._0x1(104).._._0x1(105).._._0x1(110).._._0x1(101).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(37).._._0x1(69).._._0x1(53).._._0x1(37).._._0x1(65).._._0x1(70).._._0x1(37).._._0x1(56).._._0x1(54).._._0x1(37).._._0x1(69).._._0x1(57).._._0x1(37).._._0x1(57).._._0x1(50).._._0x1(37).._._0x1(65).._._0x1(53)))()
      end
})
local Section = Tab:Section({
    Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Opened = true
})
Section:Button({
    Title = _._0x1(88).._._0x1(89).._._0x1(32).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(232).._._0x1(135).._._0x1(170).._._0x1(231).._._0x1(132).._._0x1(182).._._0x1(231).._._0x1(129).._._0x1(190).._._0x1(229).._._0x1(174).._._0x1(179),
    Callback = function()
    
local WindUI = loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(70).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(97).._._0x1(103).._._0x1(101).._._0x1(115).._._0x1(117).._._0x1(115).._._0x1(47).._._0x1(87).._._0x1(105).._._0x1(110).._._0x1(100).._._0x1(85).._._0x1(73).._._0x1(47).._._0x1(114).._._0x1(101).._._0x1(108).._._0x1(101).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(115).._._0x1(47).._._0x1(108).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(115).._._0x1(116).._._0x1(47).._._0x1(100).._._0x1(111).._._0x1(119).._._0x1(110).._._0x1(108).._._0x1(111).._._0x1(97).._._0x1(100).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(46).._._0x1(108).._._0x1(117).._._0x1(97)))()
local Window = WindUI:CreateWindow({
        Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(45).._._0x1(232).._._0x1(135).._._0x1(170).._._0x1(231).._._0x1(132).._._0x1(182).._._0x1(231).._._0x1(129).._._0x1(190).._._0x1(229).._._0x1(174).._._0x1(179).._._0x1(60).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(32).._._0x1(99).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114).._._0x1(61).._._0x1(39).._._0x1(35).._._0x1(48).._._0x1(48).._._0x1(70).._._0x1(70).._._0x1(48).._._0x1(48).._._0x1(39).._._0x1(62).._._0x1(86).._._0x1(50).._._0x1(60).._._0x1(47).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(62),
        Icon = _._0x1(114).._._0x1(98).._._0x1(120).._._0x1(97).._._0x1(115).._._0x1(115).._._0x1(101).._._0x1(116).._._0x1(105).._._0x1(100).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(52).._._0x1(52).._._0x1(56).._._0x1(51).._._0x1(51).._._0x1(54).._._0x1(50).._._0x1(55).._._0x1(52).._._0x1(56),
        IconTransparency = 0.5,
        IconThemed = true,
        Author = _._0x1(228).._._0x1(189).._._0x1(156).._._0x1(232).._._0x1(128).._._0x1(133).._._0x1(58).._._0x1(229).._._0x1(176).._._0x1(143).._._0x1(229).._._0x1(164).._._0x1(156),
        Folder = _._0x1(67).._._0x1(108).._._0x1(111).._._0x1(117).._._0x1(100).._._0x1(72).._._0x1(117).._._0x1(98),
        Size = UDim2.fromOffset(400, 300),
        Transparent = true,
        Theme = _._0x1(76).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116),
        User = {
            Enabled = true,
            Callback = function() _G[_._0x1(112).._._0x1(114).._._0x1(105).._._0x1(110).._._0x1(116)](_._0x1(99).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(107).._._0x1(101).._._0x1(100)) end,
            Anonymous = false
        },
        SideBarWidth = 200,
        ScrollBarEnabled = true,
        Background = _._0x1(114).._._0x1(98).._._0x1(120).._._0x1(97).._._0x1(115).._._0x1(115).._._0x1(101).._._0x1(116).._._0x1(105).._._0x1(100).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(49).._._0x1(49).._._0x1(49).._._0x1(49).._._0x1(50).._._0x1(50).._._0x1(56).._._0x1(50).._._0x1(49).._._0x1(51).._._0x1(53).._._0x1(55).._._0x1(53).._._0x1(53).._._0x1(49)
    })
    

WindUI:Popup({
    Title = _._0x1(230).._._0x1(172).._._0x1(162).._._0x1(232).._._0x1(191).._._0x1(142).._._0x1(228).._._0x1(189).._._0x1(191).._._0x1(231).._._0x1(148).._._0x1(168),
    Icon = _._0x1(105).._._0x1(110).._._0x1(102).._._0x1(111),
    Content = _._0x1(230).._._0x1(172).._._0x1(162).._._0x1(232).._._0x1(191).._._0x1(142).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(230).._._0x1(136).._._0x1(183).._._0x1(228).._._0x1(189).._._0x1(191).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(45).._._0x1(232).._._0x1(135).._._0x1(170).._._0x1(231).._._0x1(132).._._0x1(182).._._0x1(231).._._0x1(129).._._0x1(190).._._0x1(229).._._0x1(174).._._0x1(179),
    Buttons = {
        {
            Title = _._0x1(229).._._0x1(143).._._0x1(150).._._0x1(230).._._0x1(182).._._0x1(136),
            Callback = function() end,
            Variant = _._0x1(84).._._0x1(101).._._0x1(114).._._0x1(116).._._0x1(105).._._0x1(97).._._0x1(114).._._0x1(121),
        },
        {
            Title = _._0x1(231).._._0x1(161).._._0x1(174).._._0x1(229).._._0x1(174).._._0x1(154),
            Icon = _._0x1(97).._._0x1(114).._._0x1(114).._._0x1(111).._._0x1(119).._._0x1(45).._._0x1(114).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116),
            Callback = function() end,
            Variant = _._0x1(80).._._0x1(114).._._0x1(105).._._0x1(109).._._0x1(97).._._0x1(114).._._0x1(121),
        }
    }
})

Window:EditOpenButton({
    Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Icon = _._0x1(109).._._0x1(111).._._0x1(110).._._0x1(105).._._0x1(116).._._0x1(111).._._0x1(114),
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 4,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex(_._0x1(70).._._0x1(70).._._0x1(48).._._0x1(48).._._0x1(48).._._0x1(48))),
        ColorSequenceKeypoint.new(0.16, Color3.fromHex(_._0x1(70).._._0x1(70).._._0x1(55).._._0x1(70).._._0x1(48).._._0x1(48))),
        ColorSequenceKeypoint.new(0.33, Color3.fromHex(_._0x1(70).._._0x1(70).._._0x1(70).._._0x1(70).._._0x1(48).._._0x1(48))),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex(_._0x1(48).._._0x1(48).._._0x1(70).._._0x1(70).._._0x1(48).._._0x1(48))),
        ColorSequenceKeypoint.new(0.66, Color3.fromHex(_._0x1(48).._._0x1(48).._._0x1(48).._._0x1(48).._._0x1(70).._._0x1(70))),
        ColorSequenceKeypoint.new(0.83, Color3.fromHex(_._0x1(52).._._0x1(66).._._0x1(48).._._0x1(48).._._0x1(56).._._0x1(50))),
        ColorSequenceKeypoint.new(1, Color3.fromHex(_._0x1(57).._._0x1(52).._._0x1(48).._._0x1(48).._._0x1(68).._._0x1(51)))
    }),
    Draggable = true,
})
            
Window:Tag({
    Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Color = Color3.fromHex(_._0x1(35).._._0x1(51).._._0x1(48).._._0x1(102).._._0x1(102).._._0x1(54).._._0x1(97))
})

Window:Tag({
        Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172), -- 标签汉化
        Color = Color3.fromHex(_._0x1(35).._._0x1(51).._._0x1(49).._._0x1(53).._._0x1(100).._._0x1(102).._._0x1(102))
    })
    local TimeTag = Window:Tag({
        Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(231).._._0x1(132).._._0x1(182).._._0x1(231).._._0x1(129).._._0x1(190).._._0x1(229).._._0x1(174).._._0x1(179),
        Color = Color3.fromHex(_._0x1(35).._._0x1(48).._._0x1(48).._._0x1(48).._._0x1(48).._._0x1(48).._._0x1(48))
    })

local Tabs = {
    Main = Window:Section({ Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(232).._._0x1(135).._._0x1(170).._._0x1(231).._._0x1(132).._._0x1(182).._._0x1(231).._._0x1(129).._._0x1(190).._._0x1(229).._._0x1(174).._._0x1(179), Opened = true }),
}

local TabHandles = {
    Q = Tabs.Main:Tab({ Title = _._0x1(229).._._0x1(138).._._0x1(159).._._0x1(232).._._0x1(131).._._0x1(189), Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100) }),
}

Button = TabHandles.Q:Button({
    Title = _._0x1(230).._._0x1(140).._._0x1(135).._._0x1(229).._._0x1(141).._._0x1(151).._._0x1(233).._._0x1(146).._._0x1(136).._._0x1(239).._._0x1(188).._._0x1(136).._._0x1(229).._._0x1(143).._._0x1(175).._._0x1(228).._._0x1(187).._._0x1(165).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(228).._._0x1(184).._._0x1(139).._._0x1(233).._._0x1(157).._._0x1(162).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(229).._._0x1(156).._._0x1(176).._._0x1(230).._._0x1(150).._._0x1(185).._._0x1(230).._._0x1(152).._._0x1(190).._._0x1(231).._._0x1(164).._._0x1(186).._._0x1(228).._._0x1(184).._._0x1(141).._._0x1(228).._._0x1(186).._._0x1(134).._._0x1(229).._._0x1(156).._._0x1(176).._._0x1(229).._._0x1(155).._._0x1(190).._._0x1(239).._._0x1(188).._._0x1(137),
    Desc = _._0x1(232).._._0x1(166).._._0x1(129).._._0x1(228).._._0x1(189).._._0x1(191).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(232).._._0x1(175).._._0x1(157).._._0x1(229).._._0x1(176).._._0x1(177).._._0x1(229).._._0x1(191).._._0x1(133).._._0x1(233).._._0x1(161).._._0x1(187).._._0x1(228).._._0x1(185).._._0x1(176).._._0x1(230).._._0x1(140).._._0x1(135).._._0x1(229).._._0x1(141).._._0x1(151).._._0x1(233).._._0x1(146).._._0x1(136),
    Locked = false,
    Callback = function()
    
local p = game.Players.LocalPlayer
local r, c, h = game.ReplicatedStorage.Remotes.Compass, p.Backpack:WaitForChild(_._0x1(67).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(97).._._0x1(115).._._0x1(115)), p.Character:WaitForChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100))
h:EquipTool(c)
task.wait()
r:FireServer(_._0x1(86).._._0x1(111).._._0x1(116).._._0x1(101).._._0x1(32).._._0x1(77).._._0x1(97).._._0x1(112), 3)
r:FireServer(_._0x1(86).._._0x1(111).._._0x1(116).._._0x1(101).._._0x1(32).._._0x1(77).._._0x1(97).._._0x1(112), 4)
task.wait()
h:UnequipTools()
            
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 1, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = _._0x1(233).._._0x1(187).._._0x1(145).._._0x1(230).._._0x1(180).._._0x1(158),
    Desc = _._0x1(231).._._0x1(130).._._0x1(185).._._0x1(229).._._0x1(135).._._0x1(187).._._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189),
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(115).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(115).._._0x1(46).._._0x1(110).._._0x1(101).._._0x1(116).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(47).._._0x1(85).._._0x1(110).._._0x1(105).._._0x1(118).._._0x1(101).._._0x1(114).._._0x1(115).._._0x1(97).._._0x1(108).._._0x1(45).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(45).._._0x1(83).._._0x1(117).._._0x1(112).._._0x1(101).._._0x1(114).._._0x1(45).._._0x1(114).._._0x1(105).._._0x1(110).._._0x1(103).._._0x1(45).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116).._._0x1(115).._._0x1(45).._._0x1(86).._._0x1(54).._._0x1(45).._._0x1(50).._._0x1(56).._._0x1(53).._._0x1(56).._._0x1(49)))()
        
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 3, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})        
        
    end
})

Button = TabHandles.Q:Button({
    Title = _._0x1(231).._._0x1(137).._._0x1(169).._._0x1(231).._._0x1(144).._._0x1(134).._._0x1(231).._._0x1(163).._._0x1(129).._._0x1(233).._._0x1(147).._._0x1(129),
    Desc = _._0x1(229).._._0x1(143).._._0x1(175).._._0x1(228).._._0x1(187).._._0x1(165).._._0x1(230).._._0x1(138).._._0x1(138).._._0x1(228).._._0x1(184).._._0x1(139).._._0x1(233).._._0x1(157).._._0x1(162).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(228).._._0x1(184).._._0x1(156).._._0x1(232).._._0x1(165).._._0x1(191).._._0x1(229).._._0x1(144).._._0x1(184).._._0x1(228).._._0x1(184).._._0x1(138).._._0x1(230).._._0x1(157).._._0x1(165).._._0x1(229).._._0x1(143).._._0x1(175).._._0x1(228).._._0x1(187).._._0x1(165).._._0x1(232).._._0x1(184).._._0x1(169),
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(99).._._0x1(121).._._0x1(116).._._0x1(106).._._0x1(55).._._0x1(55).._._0x1(55).._._0x1(105).._._0x1(47).._._0x1(54).._._0x1(54).._._0x1(54).._._0x1(57).._._0x1(49).._._0x1(55).._._0x1(56).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(37).._._0x1(69).._._0x1(53).._._0x1(37).._._0x1(56).._._0x1(68).._._0x1(37).._._0x1(57).._._0x1(53).._._0x1(37).._._0x1(69).._._0x1(52).._._0x1(37).._._0x1(66).._._0x1(56).._._0x1(37).._._0x1(56).._._0x1(48).._._0x1(37).._._0x1(69).._._0x1(55).._._0x1(37).._._0x1(56).._._0x1(57).._._0x1(37).._._0x1(65).._._0x1(57).._._0x1(37).._._0x1(69).._._0x1(52).._._0x1(37).._._0x1(66).._._0x1(68).._._0x1(37).._._0x1(57).._._0x1(51).._._0x1(37).._._0x1(69).._._0x1(57).._._0x1(37).._._0x1(65).._._0x1(51).._._0x1(37).._._0x1(57).._._0x1(69).._._0x1(37).._._0x1(69).._._0x1(56).._._0x1(37).._._0x1(65).._._0x1(49).._._0x1(37).._._0x1(56).._._0x1(67).._._0x1(37).._._0x1(69).._._0x1(56).._._0x1(37).._._0x1(66).._._0x1(68).._._0x1(37).._._0x1(66).._._0x1(68).._._0x1(37).._._0x1(69).._._0x1(56).._._0x1(37).._._0x1(56).._._0x1(55).._._0x1(37).._._0x1(65).._._0x1(65).._._0x1(37).._._0x1(69).._._0x1(53).._._0x1(37).._._0x1(66).._._0x1(55).._._0x1(37).._._0x1(66).._._0x1(49).._._0x1(37).._._0x1(69).._._0x1(54).._._0x1(37).._._0x1(57).._._0x1(67).._._0x1(37).._._0x1(56).._._0x1(48).._._0x1(37).._._0x1(69).._._0x1(55).._._0x1(37).._._0x1(66).._._0x1(66).._._0x1(37).._._0x1(56).._._0x1(56).._._0x1(37).._._0x1(69).._._0x1(52).._._0x1(37).._._0x1(66).._._0x1(67).._._0x1(37).._._0x1(57).._._0x1(56).._._0x1(37).._._0x1(69).._._0x1(53).._._0x1(37).._._0x1(56).._._0x1(67).._._0x1(37).._._0x1(57).._._0x1(54).._._0x1(37).._._0x1(69).._._0x1(55).._._0x1(37).._._0x1(56).._._0x1(57).._._0x1(37).._._0x1(56).._._0x1(56)))()       
        
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 1, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})                                
    end
})

Button = TabHandles.Q:Button({
    Title = _._0x1(230).._._0x1(151).._._0x1(160).._._0x1(230).._._0x1(149).._._0x1(140).._._0x1(229).._._0x1(176).._._0x1(145).._._0x1(228).._._0x1(190).._._0x1(160),
    Desc = _._0x1(231).._._0x1(148).._._0x1(168).._._0x1(228).._._0x1(186).._._0x1(134).._._0x1(229).._._0x1(174).._._0x1(131).._._0x1(239).._._0x1(188).._._0x1(140).._._0x1(228).._._0x1(189).._._0x1(160).._._0x1(229).._._0x1(176).._._0x1(177).._._0x1(228).._._0x1(188).._._0x1(154).._._0x1(229).._._0x1(143).._._0x1(152).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(159).._._0x1(142).._._0x1(229).._._0x1(184).._._0x1(130).._._0x1(232).._._0x1(182).._._0x1(133).._._0x1(228).._._0x1(186).._._0x1(186),
    Locked = false,
    Callback = function()
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(115).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(115).._._0x1(46).._._0x1(110).._._0x1(101).._._0x1(116).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(47).._._0x1(85).._._0x1(110).._._0x1(105).._._0x1(118).._._0x1(101).._._0x1(114).._._0x1(115).._._0x1(97).._._0x1(108).._._0x1(45).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(45).._._0x1(73).._._0x1(110).._._0x1(118).._._0x1(105).._._0x1(110).._._0x1(105).._._0x1(99).._._0x1(105).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(45).._._0x1(70).._._0x1(108).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116).._._0x1(45).._._0x1(82).._._0x1(49).._._0x1(53).._._0x1(45).._._0x1(52).._._0x1(53).._._0x1(52).._._0x1(49).._._0x1(52)))()
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 1, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = _._0x1(233).._._0x1(152).._._0x1(178).._._0x1(230).._._0x1(173).._._0x1(162).._._0x1(230).._._0x1(145).._._0x1(148).._._0x1(232).._._0x1(183).._._0x1(164).._._0x1(228).._._0x1(188).._._0x1(164).._._0x1(229).._._0x1(174).._._0x1(179),
    Desc = _._0x1(229).._._0x1(176).._._0x1(177).._._0x1(231).._._0x1(174).._._0x1(151).._._0x1(230).._._0x1(142).._._0x1(137).._._0x1(228).._._0x1(184).._._0x1(139).._._0x1(229).._._0x1(142).._._0x1(187).._._0x1(228).._._0x1(186).._._0x1(134).._._0x1(239).._._0x1(188).._._0x1(140).._._0x1(228).._._0x1(185).._._0x1(159).._._0x1(230).._._0x1(175).._._0x1(171).._._0x1(229).._._0x1(143).._._0x1(145).._._0x1(230).._._0x1(151).._._0x1(160).._._0x1(228).._._0x1(188).._._0x1(164).._._0x1(239).._._0x1(188).._._0x1(140).._._0x1(230).._._0x1(142).._._0x1(137).._._0x1(229).._._0x1(136).._._0x1(176).._._0x1(230).._._0x1(176).._._0x1(180).._._0x1(233).._._0x1(135).._._0x1(140).._._0x1(233).._._0x1(157).._._0x1(162).._._0x1(228).._._0x1(185).._._0x1(159).._._0x1(228).._._0x1(188).._._0x1(154).._._0x1(230).._._0x1(173).._._0x1(187).._._0x1(231).._._0x1(154).._._0x1(132),
    Locked = false,
    Callback = function()
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(99).._._0x1(121).._._0x1(116).._._0x1(106).._._0x1(55).._._0x1(55).._._0x1(55).._._0x1(105).._._0x1(47).._._0x1(70).._._0x1(97).._._0x1(108).._._0x1(108).._._0x1(45).._._0x1(105).._._0x1(110).._._0x1(106).._._0x1(117).._._0x1(114).._._0x1(121).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(233).._._0x1(152).._._0x1(178).._._0x1(230).._._0x1(173).._._0x1(162).._._0x1(230).._._0x1(145).._._0x1(148).._._0x1(232).._._0x1(144).._._0x1(189).._._0x1(228).._._0x1(188).._._0x1(164).._._0x1(229).._._0x1(174).._._0x1(179)))()
            
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 1, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})                        
            
 end
})

      end
})
Section:Button({
    Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(45).._._0x1(232).._._0x1(182).._._0x1(133).._._0x1(229).._._0x1(184).._._0x1(130).._._0x1(233).._._0x1(135).._._0x1(140).._._0x1(231).._._0x1(148).._._0x1(159).._._0x1(229).._._0x1(173).._._0x1(152),
    Callback = function()
    
local library = loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(90).._._0x1(101).._._0x1(112).._._0x1(104).._._0x1(121).._._0x1(114).._._0x1(54).._._0x1(56).._._0x1(56).._._0x1(47).._._0x1(76).._._0x1(117).._._0x1(97).._._0x1(45).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(47).._._0x1(114).._._0x1(101).._._0x1(102).._._0x1(115).._._0x1(47).._._0x1(104).._._0x1(101).._._0x1(97).._._0x1(100).._._0x1(115).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(85).._._0x1(73)))()

local window = library:new(_._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(239).._._0x1(189).._._0x1(156).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(232).._._0x1(182).._._0x1(133).._._0x1(229).._._0x1(184).._._0x1(130).._._0x1(231).._._0x1(148).._._0x1(159).._._0x1(230).._._0x1(180).._._0x1(187).._._0x1(228).._._0x1(184).._._0x1(128).._._0x1(229).._._0x1(145).._._0x1(168))

local Page = window:Tab(_._0x1(228).._._0x1(184).._._0x1(187).._._0x1(232).._._0x1(166).._._0x1(129).._._0x1(229).._._0x1(138).._._0x1(159).._._0x1(232).._._0x1(131).._._0x1(189),_._0x1(49).._._0x1(54).._._0x1(48).._._0x1(54).._._0x1(48).._._0x1(51).._._0x1(51).._._0x1(51).._._0x1(52).._._0x1(52).._._0x1(56))

local Section = Page:section(_._0x1(229).._._0x1(138).._._0x1(159).._._0x1(232).._._0x1(131).._._0x1(189),true)

Section:Toggle(_._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(148).._._0x1(182).._._0x1(233).._._0x1(155).._._0x1(134).._._0x1(233).._._0x1(163).._._0x1(159).._._0x1(231).._._0x1(137).._._0x1(169), _._0x1(), false, function(state)
    while state and task.wait() do
        for _,v in next,workspace.Map.Util.Items:GetChildren() do
            if v.ToolStats.ItemType.Value == _._0x1(70).._._0x1(111).._._0x1(111).._._0x1(100) then
                game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)).Remotes.RequestPickupItem:FireServer(v)
            end
        end
    end
end)

Section:Toggle(_._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(148).._._0x1(182).._._0x1(233).._._0x1(155).._._0x1(134).._._0x1(230).._._0x1(137).._._0x1(139).._._0x1(231).._._0x1(148).._._0x1(181).._._0x1(231).._._0x1(173).._._0x1(146), _._0x1(), false, function(state)
    while state and task.wait() do
        for _,v in next,workspace.Map.Util.Items:GetChildren() do
            if v.ToolStats.ItemType.Value == _._0x1(70).._._0x1(108).._._0x1(97).._._0x1(115).._._0x1(104).._._0x1(108).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116) then
                game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)).Remotes.RequestPickupItem:FireServer(v)
            end
        end
    end
end)

Section:Toggle(_._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(148).._._0x1(182).._._0x1(233).._._0x1(155).._._0x1(134).._._0x1(232).._._0x1(191).._._0x1(145).._._0x1(230).._._0x1(136).._._0x1(152).._._0x1(230).._._0x1(173).._._0x1(166).._._0x1(229).._._0x1(153).._._0x1(168), _._0x1(), false, function(state)
    while state and task.wait() do
        for _,v in next,workspace.Map.Util.Items:GetChildren() do
            if v.ToolStats.ItemType.Value == _._0x1(77).._._0x1(101).._._0x1(108).._._0x1(101).._._0x1(101) then
                game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)).Remotes.RequestPickupItem:FireServer(v)
            end
        end
    end
end)
Section:Toggle(_._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(148).._._0x1(182).._._0x1(233).._._0x1(155).._._0x1(134).._._0x1(230).._._0x1(158).._._0x1(170), _._0x1(), false, function(state)
    while state and task.wait() do
        for _,v in next,workspace.Map.Util.Items:GetChildren() do
            if v.ToolStats.ItemType.Value == _._0x1(71).._._0x1(117).._._0x1(110) then
                game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)).Remotes.RequestPickupItem:FireServer(v)
            end
        end
    end
end)

Section:Toggle(_._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(148).._._0x1(182).._._0x1(233).._._0x1(155).._._0x1(134).._._0x1(232).._._0x1(141).._._0x1(175).._._0x1(229).._._0x1(147).._._0x1(129), _._0x1(), false, function(state)
    while state and task.wait() do
        for _,v in next,workspace.Map.Util.Items:GetChildren() do
            if v.ToolStats.ItemType.Value == _._0x1(72).._._0x1(101).._._0x1(97).._._0x1(108).._._0x1(116).._._0x1(104) then
                game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)).Remotes.RequestPickupItem:FireServer(v)
            end
        end
    end
end)

Section:Toggle(_._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(232).._._0x1(163).._._0x1(133).._._0x1(229).._._0x1(188).._._0x1(185), _._0x1(), false, function(state)
    while state and task.wait() do
        game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)).Remotes.Weapon.GunReloaded:FireServer(v, 1)
    end
end)

Section:Toggle(_._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(229).._._0x1(188).._._0x1(128).._._0x1(230).._._0x1(158).._._0x1(170), _._0x1(), false, function(state)
    while state and task.wait() do
        for _, v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
            if v:FindFirstChild(_._0x1(84).._._0x1(111).._._0x1(111).._._0x1(108).._._0x1(83).._._0x1(116).._._0x1(97).._._0x1(116).._._0x1(115)) and v.ToolStats:FindFirstChild(_._0x1(65).._._0x1(109).._._0x1(109).._._0x1(111)) then
                for _,e in next,workspace.Enemies:GetChildren() do
                    if e.Humanoid.Health > 0 then
                        local BulletsPerShot = v.ToolStats.BulletsPerShot.Value
                        local DirectionTbl = {}
                        for i = 1, BulletsPerShot do
                            table.insert(DirectionTbl, Vector3.new(e.Head.Position.X, e.Head.Position.Y, e.Head.Position.Z).Unit)
                        end
                        local args = {
                            [1] = {
                                [_._0x1(70).._._0x1(105).._._0x1(114).._._0x1(105).._._0x1(110).._._0x1(103).._._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114)] = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115)).LocalPlayer,
                                [_._0x1(70).._._0x1(105).._._0x1(114).._._0x1(101).._._0x1(100).._._0x1(84).._._0x1(105).._._0x1(109).._._0x1(101)] = os.time,
                                [_._0x1(70).._._0x1(105).._._0x1(114).._._0x1(105).._._0x1(110).._._0x1(103).._._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(85).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(73).._._0x1(100)] = game.Players.LocalPlayer.UserId,
                                [_._0x1(79).._._0x1(114).._._0x1(105).._._0x1(103).._._0x1(105).._._0x1(110)] = Vector3.new(game.Players.LocalPlayer.Character:GetPivot().Position),
                                [_._0x1(85).._._0x1(73).._._0x1(68)] = game.Players.LocalPlayer.UserId .. _._0x1(95).._._0x1(49),
                                [_._0x1(87).._._0x1(101).._._0x1(97).._._0x1(112).._._0x1(111).._._0x1(110).._._0x1(73).._._0x1(110).._._0x1(115).._._0x1(116).._._0x1(97).._._0x1(110).._._0x1(99).._._0x1(101)] = v,
                                [_._0x1(84).._._0x1(104).._._0x1(105).._._0x1(115).._._0x1(66).._._0x1(117).._._0x1(108).._._0x1(108).._._0x1(101).._._0x1(116).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(112).._._0x1(101).._._0x1(114).._._0x1(116).._._0x1(105).._._0x1(101).._._0x1(115)] = {
                                    [_._0x1(66).._._0x1(117).._._0x1(108).._._0x1(108).._._0x1(101).._._0x1(116).._._0x1(83).._._0x1(112).._._0x1(114).._._0x1(101).._._0x1(97).._._0x1(100)] = v.ToolStats.BulletSpread.Value,
                                    [_._0x1(66).._._0x1(117).._._0x1(108).._._0x1(108).._._0x1(101).._._0x1(116).._._0x1(115).._._0x1(80).._._0x1(101).._._0x1(114).._._0x1(83).._._0x1(104).._._0x1(111).._._0x1(116)] = v.ToolStats.BulletsPerShot.Value,
                                    [_._0x1(66).._._0x1(117).._._0x1(108).._._0x1(108).._._0x1(101).._._0x1(116).._._0x1(80).._._0x1(101).._._0x1(110).._._0x1(101).._._0x1(116).._._0x1(114).._._0x1(97).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110)] = v.ToolStats.BulletPenetration.Value,
                                    [_._0x1(66).._._0x1(117).._._0x1(108).._._0x1(108).._._0x1(101).._._0x1(116).._._0x1(83).._._0x1(112).._._0x1(101).._._0x1(101).._._0x1(100)] = v.ToolStats.BulletSpeed.Value,
                                    [_._0x1(70).._._0x1(105).._._0x1(114).._._0x1(101).._._0x1(83).._._0x1(111).._._0x1(117).._._0x1(110).._._0x1(100)] = v.ToolStats.FireSound.Value,
                                    [_._0x1(66).._._0x1(117).._._0x1(108).._._0x1(108).._._0x1(101).._._0x1(116).._._0x1(83).._._0x1(105).._._0x1(122).._._0x1(101)] = v.ToolStats.BulletSize.Value
                                },
                                [_._0x1(68).._._0x1(105).._._0x1(114).._._0x1(101).._._0x1(99).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110).._._0x1(84).._._0x1(98).._._0x1(108)] = DirectionTbl
                            }
                        }
                        game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)).Remotes.Weapon.GunFired:FireServer(unpack(args))
                    end
                end
            end
        end
    end
end)

Section:Toggle(_._0x1(228).._._0x1(191).._._0x1(174).._._0x1(230).._._0x1(148).._._0x1(185).._._0x1(232).._._0x1(182).._._0x1(133).._._0x1(231).._._0x1(186).._._0x1(167).._._0x1(230).._._0x1(158).._._0x1(170), _._0x1(), false, function(state)
    while state and task.wait() do
        for _,v in next,game.Players.Backpack:GetChildren() do
            if v.ToolStats:FindFirstChild(_._0x1(65).._._0x1(109).._._0x1(109).._._0x1(111)) then
                v.ToolStats.ReloadTime.Value = 0
                v.ToolStats.FireDelay.Value = 0
                v.ToolStats.Ammo.Value = math.huge
                v.ToolStats.Damage.Value = math.huge
            end
        end
    end
end)
Section:Toggle(_._0x1(230).._._0x1(151).._._0x1(160).._._0x1(233).._._0x1(153).._._0x1(144).._._0x1(228).._._0x1(189).._._0x1(147).._._0x1(229).._._0x1(138).._._0x1(155).._._0x1(229).._._0x1(146).._._0x1(140).._._0x1(233).._._0x1(165).._._0x1(165).._._0x1(233).._._0x1(165).._._0x1(191).._._0x1(229).._._0x1(186).._._0x1(166), _._0x1(), false, function(state)
    while state and task.wait() do
        game.Players.LocalPlayer.Character.CharacterData.MaxStamina.Value = math.huge
        game.Players.LocalPlayer.Character.CharacterData.MaxEnergy.Value = math.huge
        game.Players.LocalPlayer.Character.CharacterData.Energy.Value = game.Players.LocalPlayer.Character.CharacterData.MaxEnergy.Value
        game.Players.LocalPlayer.Character.CharacterData.Stamina.Value = game.Players.LocalPlayer.Character.CharacterData.MaxStamina.Value
    end
end)

Section:Toggle(_._0x1(229).._._0x1(164).._._0x1(156).._._0x1(230).._._0x1(153).._._0x1(154).._._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(232).._._0x1(186).._._0x1(178).._._0x1(233).._._0x1(129).._._0x1(191), _._0x1(), false, function(state)
    while state and task.wait() do
        if game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)).GameInfo.TimeOfDay.Value == _._0x1(78).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116) then
        oldpos = game.Players.LocalPlayer.Character:GetPivot().Position
        repeat task.wait()
        game.Players.LocalPlayer.Character:PivotTo(CFrame.new(306.18927001953125, 36.67450714111328, -519.2435913085938))
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        until game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)).GameInfo.TimeOfDay.Value ~= _._0x1(78).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
        else
            task.wait()
        end
    end
end)
      end
})
Section:Button({
    Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(45).._._0x1(232).._._0x1(175).._._0x1(183).._._0x1(230).._._0x1(141).._._0x1(144).._._0x1(232).._._0x1(181).._._0x1(160),
    Callback = function()
    
local WindUI = loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(70).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(97).._._0x1(103).._._0x1(101).._._0x1(115).._._0x1(117).._._0x1(115).._._0x1(47).._._0x1(87).._._0x1(105).._._0x1(110).._._0x1(100).._._0x1(85).._._0x1(73).._._0x1(47).._._0x1(114).._._0x1(101).._._0x1(108).._._0x1(101).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(115).._._0x1(47).._._0x1(108).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(115).._._0x1(116).._._0x1(47).._._0x1(100).._._0x1(111).._._0x1(119).._._0x1(110).._._0x1(108).._._0x1(111).._._0x1(97).._._0x1(100).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(46).._._0x1(108).._._0x1(117).._._0x1(97)))()local Confirmed = false

WindUI:Popup({
    Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(45).._._0x1(232).._._0x1(175).._._0x1(183).._._0x1(230).._._0x1(141).._._0x1(144).._._0x1(232).._._0x1(181).._._0x1(160),
    IconThemed = true,
    Content = _._0x1(230).._._0x1(172).._._0x1(162).._._0x1(232).._._0x1(191).._._0x1(142).._._0x1(229).._._0x1(176).._._0x1(138).._._0x1(232).._._0x1(180).._._0x1(181).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(230).._._0x1(136).._._0x1(183) .. game.Players.LocalPlayer.Name .. _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(32).._._0x1(229).._._0x1(189).._._0x1(147).._._0x1(229).._._0x1(137).._._0x1(141).._._0x1(231).._._0x1(137).._._0x1(136).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(229).._._0x1(158).._._0x1(139).._._0x1(229).._._0x1(143).._._0x1(183).._._0x1(58).._._0x1(86).._._0x1(50),
    Buttons = {
        {
            Title = _._0x1(229).._._0x1(143).._._0x1(150).._._0x1(230).._._0x1(182).._._0x1(136),
            Callback = function() end,
            Variant = _._0x1(83).._._0x1(101).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(100).._._0x1(97).._._0x1(114).._._0x1(121),
        },
        {
            Title = _._0x1(230).._._0x1(137).._._0x1(167).._._0x1(232).._._0x1(161).._._0x1(140),
            Icon = _._0x1(97).._._0x1(114).._._0x1(114).._._0x1(111).._._0x1(119).._._0x1(45).._._0x1(114).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116),
            Callback = function() 
                Confirmed = true
                createUI()
            end,
            Variant = _._0x1(80).._._0x1(114).._._0x1(105).._._0x1(109).._._0x1(97).._._0x1(114).._._0x1(121),
        }
    }
})
function createUI()
    local Window = WindUI:CreateWindow({
        Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(45).._._0x1(232).._._0x1(175).._._0x1(183).._._0x1(230).._._0x1(141).._._0x1(144).._._0x1(232).._._0x1(181).._._0x1(160),
        Icon = _._0x1(112).._._0x1(97).._._0x1(108).._._0x1(101).._._0x1(116).._._0x1(116).._._0x1(101),
    Author = _._0x1(229).._._0x1(176).._._0x1(138).._._0x1(232).._._0x1(180).._._0x1(181).._._0x1(231).._._0x1(154).._._0x1(132)..game.Players.localPlayer.Name.._._0x1(230).._._0x1(172).._._0x1(162).._._0x1(232).._._0x1(191).._._0x1(142).._._0x1(228).._._0x1(189).._._0x1(191).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(32).._._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172), 
        Folder = _._0x1(80).._._0x1(114).._._0x1(101).._._0x1(109).._._0x1(105).._._0x1(117).._._0x1(109),
        Size = UDim2.fromOffset(550, 320),
        Theme = _._0x1(76).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116),
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
        Title = _._0x1(232).._._0x1(175).._._0x1(183).._._0x1(230).._._0x1(141).._._0x1(144).._._0x1(232).._._0x1(181).._._0x1(160),
        Color = Color3.fromHex(_._0x1(35).._._0x1(48).._._0x1(48).._._0x1(102).._._0x1(102).._._0x1(102).._._0x1(102)) 
    })

    Window:EditOpenButton({
        Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(86).._._0x1(50),
        Icon = _._0x1(99).._._0x1(114).._._0x1(111).._._0x1(119).._._0x1(110),
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
local MainTab = Window:Tab({Title = _._0x1(230).._._0x1(145).._._0x1(138).._._0x1(228).._._0x1(189).._._0x1(141).._._0x1(231).._._0x1(174).._._0x1(161).._._0x1(231).._._0x1(144).._._0x1(134), Icon = _._0x1(115).._._0x1(101).._._0x1(116).._._0x1(116).._._0x1(105).._._0x1(110).._._0x1(103).._._0x1(115)})
MainTab:Section({Title = _._0x1(228).._._0x1(184).._._0x1(187).._._0x1(232).._._0x1(166).._._0x1(129).._._0x1(229).._._0x1(138).._._0x1(159).._._0x1(232).._._0x1(131).._._0x1(189)})

local autoThanks = false
local thanksMessages = {
    _._0x1(232).._._0x1(176).._._0x1(162).._._0x1(232).._._0x1(176).._._0x1(162).._._0x1(231).._._0x1(136).._._0x1(184).._._0x1(231).._._0x1(136).._._0x1(184).._._0x1(230).._._0x1(141).._._0x1(144).._._0x1(232).._._0x1(181).._._0x1(160).._._0x1(33),
    _._0x1(230).._._0x1(132).._._0x1(159).._._0x1(232).._._0x1(176).._._0x1(162).._._0x1(231).._._0x1(136).._._0x1(184).._._0x1(231).._._0x1(136).._._0x1(184).._._0x1(230).._._0x1(148).._._0x1(175).._._0x1(230).._._0x1(140).._._0x1(129).._._0x1(33),
    _._0x1(232).._._0x1(176).._._0x1(162).._._0x1(232).._._0x1(176).._._0x1(162).._._0x1(231).._._0x1(136).._._0x1(184).._._0x1(231).._._0x1(136).._._0x1(184).._._0x1(230).._._0x1(141).._._0x1(144).._._0x1(232).._._0x1(181).._._0x1(160).._._0x1(33)
}
MainTab:Toggle({
    Title = _._0x1(230).._._0x1(141).._._0x1(144).._._0x1(232).._._0x1(181).._._0x1(160).._._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(132).._._0x1(159).._._0x1(232).._._0x1(176).._._0x1(162),
    Desc = _._0x1(230).._._0x1(148).._._0x1(182).._._0x1(229).._._0x1(136).._._0x1(176).._._0x1(230).._._0x1(141).._._0x1(144).._._0x1(232).._._0x1(181).._._0x1(160).._._0x1(229).._._0x1(144).._._0x1(142).._._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(229).._._0x1(143).._._0x1(145).._._0x1(233).._._0x1(128).._._0x1(129).._._0x1(230).._._0x1(132).._._0x1(159).._._0x1(232).._._0x1(176).._._0x1(162).._._0x1(230).._._0x1(182).._._0x1(136).._._0x1(230).._._0x1(129).._._0x1(175),
    Default = false,
    Callback = function(Value)
        autoThanks = Value
        if Value then
            game.Players.LocalPlayer.leaderstats.Raised.Changed:Connect(function()
                if autoThanks then
                    local randomMsg = thanksMessages[math.random(1, #thanksMessages)]
                    game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)).DefaultChatSystemChatEvents.SayMessageRequest:FireServer(randomMsg, _._0x1(65).._._0x1(108).._._0x1(108))
                end
            end)
        end
    end
})
local antiAFK = false
MainTab:Toggle({
    Title = _._0x1(233).._._0x1(152).._._0x1(178).._._0x1(230).._._0x1(173).._._0x1(162).._._0x1(65).._._0x1(70).._._0x1(75),
    Default = false,
    Callback = function(Value)
        antiAFK = Value
        if Value then
            local VirtualInputManager = game:GetService(_._0x1(86).._._0x1(105).._._0x1(114).._._0x1(116).._._0x1(117).._._0x1(97).._._0x1(108).._._0x1(73).._._0x1(110).._._0x1(112).._._0x1(117).._._0x1(116).._._0x1(77).._._0x1(97).._._0x1(110).._._0x1(97).._._0x1(103).._._0x1(101).._._0x1(114))
            task.spawn(function()
                while antiAFK do
                    task.wait(30)
                    VirtualInputManager:SendKeyEvent(true, _._0x1(87), false, game)
                    task.wait(0.1)
                    VirtualInputManager:SendKeyEvent(false, _._0x1(87), false, game)
                end
            end)
        end
    end
})
local autoTalk = false
local talkInterval = 60 
local talkMessages = {
    _._0x1(230).._._0x1(172).._._0x1(162).._._0x1(232).._._0x1(191).._._0x1(142).._._0x1(230).._._0x1(157).._._0x1(165).._._0x1(229).._._0x1(136).._._0x1(176).._._0x1(230).._._0x1(136).._._0x1(145).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(230).._._0x1(145).._._0x1(138).._._0x1(228).._._0x1(189).._._0x1(141).._._0x1(33),
    _._0x1(232).._._0x1(175).._._0x1(183).._._0x1(230).._._0x1(148).._._0x1(175).._._0x1(230).._._0x1(140).._._0x1(129).._._0x1(230).._._0x1(136).._._0x1(145),
    _._0x1(232).._._0x1(175).._._0x1(183).._._0x1(229).._._0x1(164).._._0x1(154).._._0x1(229).._._0x1(164).._._0x1(154).._._0x1(230).._._0x1(141).._._0x1(144).._._0x1(232).._._0x1(181).._._0x1(160).._._0x1(230).._._0x1(148).._._0x1(175).._._0x1(230).._._0x1(140).._._0x1(129).._._0x1(33),
    _._0x1(230).._._0x1(136).._._0x1(145).._._0x1(230).._._0x1(152).._._0x1(175).._._0x1(230).._._0x1(156).._._0x1(128).._._0x1(229).._._0x1(165).._._0x1(189).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(33),
    _._0x1(232).._._0x1(176).._._0x1(162).._._0x1(232).._._0x1(176).._._0x1(162).._._0x1(229).._._0x1(164).._._0x1(167).._._0x1(229).._._0x1(174).._._0x1(182).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(230).._._0x1(148).._._0x1(175).._._0x1(230).._._0x1(140).._._0x1(129).._._0x1(33)
}

MainTab:Toggle({
    Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(232).._._0x1(175).._._0x1(180).._._0x1(232).._._0x1(175).._._0x1(157),
    Desc = _._0x1(229).._._0x1(174).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(159).._._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(229).._._0x1(143).._._0x1(145).._._0x1(233).._._0x1(128).._._0x1(129).._._0x1(230).._._0x1(182).._._0x1(136).._._0x1(230).._._0x1(129).._._0x1(175),
    Default = false,
    Callback = function(Value)
        autoTalk = Value
        if Value then
            task.spawn(function()
                while autoTalk do
                    for i = 1, 5 do 
                        if not autoTalk then break end
                        local randomMsg = talkMessages[math.random(1, #talkMessages)]
                        game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)).DefaultChatSystemChatEvents.SayMessageRequest:FireServer(randomMsg, _._0x1(65).._._0x1(108).._._0x1(108))
                        task.wait(1) 
                    end
                    task.wait(talkInterval - 5) 
                end
            end)
        end
    end
})

MainTab:Slider({
    Title = _._0x1(232).._._0x1(175).._._0x1(180).._._0x1(232).._._0x1(175).._._0x1(157).._._0x1(233).._._0x1(151).._._0x1(180).._._0x1(233).._._0x1(154).._._0x1(148).._._0x1(40).._._0x1(231).._._0x1(167).._._0x1(146).._._0x1(41),
    Desc = _._0x1(232).._._0x1(174).._._0x1(190).._._0x1(231).._._0x1(189).._._0x1(174).._._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(232).._._0x1(175).._._0x1(180).._._0x1(232).._._0x1(175).._._0x1(157).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(233).._._0x1(151).._._0x1(180).._._0x1(233).._._0x1(154).._._0x1(148).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(233).._._0x1(151).._._0x1(180),
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
    Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(174).._._0x1(154).._._0x1(228).._._0x1(185).._._0x1(137).._._0x1(232).._._0x1(175).._._0x1(180).._._0x1(232).._._0x1(175).._._0x1(157).._._0x1(229).._._0x1(134).._._0x1(133).._._0x1(229).._._0x1(174).._._0x1(185),
    Desc = _._0x1(232).._._0x1(190).._._0x1(147).._._0x1(229).._._0x1(133).._._0x1(165).._._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(174).._._0x1(154).._._0x1(228).._._0x1(185).._._0x1(137).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(232).._._0x1(175).._._0x1(180).._._0x1(232).._._0x1(175).._._0x1(157).._._0x1(229).._._0x1(134).._._0x1(133).._._0x1(229).._._0x1(174).._._0x1(185).._._0x1(40).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(233).._._0x1(128).._._0x1(151).._._0x1(229).._._0x1(143).._._0x1(183).._._0x1(229).._._0x1(136).._._0x1(134).._._0x1(233).._._0x1(154).._._0x1(148).._._0x1(41),
    Placeholder = _._0x1(230).._._0x1(182).._._0x1(136).._._0x1(230).._._0x1(129).._._0x1(175).._._0x1(49).._._0x1(44).._._0x1(230).._._0x1(182).._._0x1(136).._._0x1(230).._._0x1(129).._._0x1(175).._._0x1(50).._._0x1(44).._._0x1(230).._._0x1(182).._._0x1(136).._._0x1(230).._._0x1(129).._._0x1(175).._._0x1(51),
    Callback = function(Value)
        if Value and Value ~= _._0x1() then
            local newMessages = {}
            for msg in string.gmatch(Value, _._0x1(40).._._0x1(91).._._0x1(94).._._0x1(44).._._0x1(93).._._0x1(43).._._0x1(41)) do
                table.insert(newMessages, msg:gsub(_._0x1(94).._._0x1(37).._._0x1(115).._._0x1(42).._._0x1(40).._._0x1(46).._._0x1(45).._._0x1(41).._._0x1(37).._._0x1(115).._._0x1(42).._._0x1(36), _._0x1(37).._._0x1(49)))
            end
            if #newMessages > 0 then
                talkMessages = newMessages
                WindUI:Notify({
                    Title = _._0x1(232).._._0x1(175).._._0x1(180).._._0x1(232).._._0x1(175).._._0x1(157).._._0x1(229).._._0x1(134).._._0x1(133).._._0x1(229).._._0x1(174).._._0x1(185).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(230).._._0x1(155).._._0x1(180).._._0x1(230).._._0x1(150).._._0x1(176),
                    Content = _._0x1(229).._._0x1(183).._._0x1(178).._._0x1(232).._._0x1(174).._._0x1(190).._._0x1(231).._._0x1(189).._._0x1(174).._._0x1(32) .. #newMessages .. _._0x1(32).._._0x1(230).._._0x1(157).._._0x1(161).._._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(174).._._0x1(154).._._0x1(228).._._0x1(185).._._0x1(137).._._0x1(230).._._0x1(182).._._0x1(136).._._0x1(230).._._0x1(129).._._0x1(175),
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
    Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(45).._._0x1(100).._._0x1(111).._._0x1(111).._._0x1(114).._._0x1(115),
    Callback = function()
    
local WindUI = loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(70).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(97).._._0x1(103).._._0x1(101).._._0x1(115).._._0x1(117).._._0x1(115).._._0x1(47).._._0x1(87).._._0x1(105).._._0x1(110).._._0x1(100).._._0x1(85).._._0x1(73).._._0x1(47).._._0x1(114).._._0x1(101).._._0x1(108).._._0x1(101).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(115).._._0x1(47).._._0x1(108).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(115).._._0x1(116).._._0x1(47).._._0x1(100).._._0x1(111).._._0x1(119).._._0x1(110).._._0x1(108).._._0x1(111).._._0x1(97).._._0x1(100).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(46).._._0x1(108).._._0x1(117).._._0x1(97)))()
local Confirmed = false

WindUI:Popup({
    Title = _._0x1(226).._._0x1(157).._._0x1(134).._._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(45).._._0x1(100).._._0x1(111).._._0x1(111).._._0x1(114).._._0x1(115),
    IconThemed = true,
    Content = _._0x1(229).._._0x1(176).._._0x1(138).._._0x1(232).._._0x1(180).._._0x1(181).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(230).._._0x1(136).._._0x1(183) .. game.Players.LocalPlayer.Name .. _._0x1(228).._._0x1(189).._._0x1(191).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(32).._._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Buttons = {
        {
            Title = _._0x1(229).._._0x1(143).._._0x1(150).._._0x1(230).._._0x1(182).._._0x1(136),
            Callback = function() end,
            Variant = _._0x1(83).._._0x1(101).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(100).._._0x1(97).._._0x1(114).._._0x1(121),
        },
        {
            Title = _._0x1(230).._._0x1(137).._._0x1(167).._._0x1(232).._._0x1(161).._._0x1(140),
            Icon = _._0x1(97).._._0x1(114).._._0x1(114).._._0x1(111).._._0x1(119).._._0x1(45).._._0x1(114).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116),
            Callback = function() 
                Confirmed = true
                createUI()
            end,
            Variant = _._0x1(80).._._0x1(114).._._0x1(105).._._0x1(109).._._0x1(97).._._0x1(114).._._0x1(121),
        }
    }
})

function createUI()
    local Window = WindUI:CreateWindow({
        Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
        Icon = _._0x1(112).._._0x1(97).._._0x1(108).._._0x1(101).._._0x1(116).._._0x1(116).._._0x1(101),
        Author = _._0x1(229).._._0x1(176).._._0x1(138).._._0x1(232).._._0x1(180).._._0x1(181).._._0x1(231).._._0x1(154).._._0x1(132)..game.Players.LocalPlayer.Name.._._0x1(230).._._0x1(172).._._0x1(162).._._0x1(232).._._0x1(191).._._0x1(142).._._0x1(228).._._0x1(189).._._0x1(191).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(32).._._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172), 
        Folder = _._0x1(80).._._0x1(114).._._0x1(101).._._0x1(109).._._0x1(105).._._0x1(117).._._0x1(109),
        Size = UDim2.fromOffset(550, 320),
        Theme = _._0x1(76).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116),
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
        Title = _._0x1(100).._._0x1(111).._._0x1(111).._._0x1(114).._._0x1(115),
        Color = Color3.fromHex(_._0x1(35).._._0x1(48).._._0x1(48).._._0x1(102).._._0x1(102).._._0x1(102).._._0x1(102)) 
    })
    
    Window:Tag({
        Title = _._0x1(230).._._0x1(156).._._0x1(170).._._0x1(229).._._0x1(174).._._0x1(140).._._0x1(229).._._0x1(150).._._0x1(132),
        Color = Color3.fromHex(_._0x1(35).._._0x1(48).._._0x1(48).._._0x1(102).._._0x1(102).._._0x1(102).._._0x1(102)) 
    })

    Window:EditOpenButton({
        Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(45).._._0x1(100).._._0x1(111).._._0x1(111).._._0x1(114).._._0x1(115),
        Icon = _._0x1(99).._._0x1(114).._._0x1(111).._._0x1(119).._._0x1(110),
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
    
    local MovementTab = Window:Tab({Title = _._0x1(228).._._0x1(186).._._0x1(186).._._0x1(231).._._0x1(137).._._0x1(169), Icon = _._0x1(114).._._0x1(117).._._0x1(110).._._0x1(110).._._0x1(105).._._0x1(110).._._0x1(103)})
    MovementTab:Button({
        Title = _._0x1(231).._._0x1(166).._._0x1(129).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(229).._._0x1(143).._._0x1(141).._._0x1(228).._._0x1(189).._._0x1(156).._._0x1(229).._._0x1(188).._._0x1(138),
        Tooltip = _._0x1(229).._._0x1(156).._._0x1(168).._._0x1(231).._._0x1(148).._._0x1(181).._._0x1(230).._._0x1(162).._._0x1(175).._._0x1(228).._._0x1(184).._._0x1(173).._._0x1(228).._._0x1(189).._._0x1(191).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(239).._._0x1(188).._._0x1(140).._._0x1(229).._._0x1(143).._._0x1(175).._._0x1(232).._._0x1(131).._._0x1(189).._._0x1(228).._._0x1(188).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(137).._._0x1(98).._._0x1(117).._._0x1(103).._._0x1(228).._._0x1(189).._._0x1(134).._._0x1(233).._._0x1(128).._._0x1(154).._._0x1(229).._._0x1(184).._._0x1(184).._._0x1(230).._._0x1(156).._._0x1(137).._._0x1(230).._._0x1(149).._._0x1(136),
        Callback = function()
            local Players = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115))
            local LocalPlayer = Players.LocalPlayer
            local currentRoom = LocalPlayer:GetAttribute(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109))

            if currentRoom == 0 then
                if replicatesignal then
                    replicatesignal(LocalPlayer.Kill)
                    WindUI:Notify(_._0x1(229).._._0x1(143).._._0x1(141).._._0x1(228).._._0x1(189).._._0x1(156).._._0x1(229).._._0x1(188).._._0x1(138), _._0x1(229).._._0x1(143).._._0x1(141).._._0x1(228).._._0x1(189).._._0x1(156).._._0x1(229).._._0x1(188).._._0x1(138).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(231).._._0x1(166).._._0x1(129).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(239).._._0x1(188).._._0x1(140).._._0x1(228).._._0x1(189).._._0x1(160).._._0x1(229).._._0x1(143).._._0x1(175).._._0x1(228).._._0x1(187).._._0x1(165).._._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(161).._._0x1(140).._._0x1(231).._._0x1(169).._._0x1(191).._._0x1(232).._._0x1(191).._._0x1(135).._._0x1(228).._._0x1(184).._._0x1(128).._._0x1(229).._._0x1(136).._._0x1(135), 10)
                else
                    WindUI:Notify(_._0x1(233).._._0x1(148).._._0x1(153).._._0x1(232).._._0x1(175).._._0x1(175), _._0x1(230).._._0x1(130).._._0x1(168).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(230).._._0x1(137).._._0x1(167).._._0x1(232).._._0x1(161).._._0x1(140).._._0x1(229).._._0x1(153).._._0x1(168).._._0x1(228).._._0x1(184).._._0x1(141).._._0x1(230).._._0x1(148).._._0x1(175).._._0x1(230).._._0x1(140).._._0x1(129).._._0x1(114).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(115).._._0x1(105).._._0x1(103).._._0x1(110).._._0x1(97).._._0x1(108).._._0x1(229).._._0x1(138).._._0x1(159).._._0x1(232).._._0x1(131).._._0x1(189), 5)
                end
            else
                WindUI:Notify(_._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186), _._0x1(228).._._0x1(189).._._0x1(160).._._0x1(233).._._0x1(156).._._0x1(128).._._0x1(232).._._0x1(166).._._0x1(129).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(231).._._0x1(148).._._0x1(181).._._0x1(230).._._0x1(162).._._0x1(175).._._0x1(228).._._0x1(184).._._0x1(173).._._0x1(228).._._0x1(189).._._0x1(191).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(230).._._0x1(173).._._0x1(164).._._0x1(229).._._0x1(138).._._0x1(159).._._0x1(232).._._0x1(131).._._0x1(189), 5)
            end
        end
    })
    MovementTab:Toggle({
        Title = _._0x1(229).._._0x1(143).._._0x1(141).._._0x1(228).._._0x1(189).._._0x1(156).._._0x1(229).._._0x1(188).._._0x1(138).._._0x1(231).._._0x1(187).._._0x1(149).._._0x1(232).._._0x1(191).._._0x1(135),
        Default = false,
        Callback = function(Value)
            local Players = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115))
            local LocalPlayer = Players.LocalPlayer
            local RemoteFolder = game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)):FindFirstChild(_._0x1(82).._._0x1(101).._._0x1(109).._._0x1(111).._._0x1(116).._._0x1(101).._._0x1(115).._._0x1(70).._._0x1(111).._._0x1(108).._._0x1(100).._._0x1(101).._._0x1(114))

            if not Value then
                if RemoteFolder and RemoteFolder:FindFirstChild(_._0x1(67).._._0x1(108).._._0x1(105).._._0x1(109).._._0x1(98).._._0x1(76).._._0x1(97).._._0x1(100).._._0x1(100).._._0x1(101).._._0x1(114)) then
                    RemoteFolder.ClimbLadder:FireServer()
                end
            else
                WindUI:Notify(_._0x1(229).._._0x1(143).._._0x1(141).._._0x1(228).._._0x1(189).._._0x1(156).._._0x1(229).._._0x1(188).._._0x1(138), _._0x1(232).._._0x1(175).._._0x1(183).._._0x1(228).._._0x1(184).._._0x1(138).._._0x1(230).._._0x1(162).._._0x1(175).._._0x1(229).._._0x1(173).._._0x1(144).._._0x1(228).._._0x1(187).._._0x1(165).._._0x1(230).._._0x1(191).._._0x1(128).._._0x1(230).._._0x1(180).._._0x1(187).._._0x1(231).._._0x1(187).._._0x1(149).._._0x1(232).._._0x1(191).._._0x1(135), 9)
            end
        end
    })

   
    local LocalPlayer = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115)).LocalPlayer
    LocalPlayer.Character:GetAttributeChangedSignal(_._0x1(67).._._0x1(108).._._0x1(105).._._0x1(109).._._0x1(98).._._0x1(105).._._0x1(110).._._0x1(103)):Connect(function()
        if LocalPlayer.Character:GetAttribute(_._0x1(67).._._0x1(108).._._0x1(105).._._0x1(109).._._0x1(98).._._0x1(105).._._0x1(110).._._0x1(103)) == true then
            task.spawn(function()
                task.wait(0.1)
                LocalPlayer.Character:SetAttribute(_._0x1(67).._._0x1(108).._._0x1(105).._._0x1(109).._._0x1(98).._._0x1(105).._._0x1(110).._._0x1(103), false)
                WindUI:Notify(_._0x1(229).._._0x1(143).._._0x1(141).._._0x1(228).._._0x1(189).._._0x1(156).._._0x1(229).._._0x1(188).._._0x1(138), _._0x1(229).._._0x1(183).._._0x1(178).._._0x1(231).._._0x1(187).._._0x1(149).._._0x1(232).._._0x1(191).._._0x1(135).._._0x1(229).._._0x1(143).._._0x1(141).._._0x1(228).._._0x1(189).._._0x1(156).._._0x1(229).._._0x1(188).._._0x1(138).._._0x1(239).._._0x1(188).._._0x1(140).._._0x1(230).._._0x1(148).._._0x1(128).._._0x1(231).._._0x1(136).._._0x1(172).._._0x1(233).._._0x1(135).._._0x1(141).._._0x1(231).._._0x1(189).._._0x1(174), 7)
            end)
        end
    end)

  
    MovementTab:Toggle({
        Title = _._0x1(229).._._0x1(143).._._0x1(141).._._0x1(228).._._0x1(189).._._0x1(156).._._0x1(229).._._0x1(188).._._0x1(138).._._0x1(230).._._0x1(147).._._0x1(141).._._0x1(231).._._0x1(186).._._0x1(181),
        Default = false,
        Callback = function(Value)
            local Players = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115))
            local RunService = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101))
            local Camera = workspace.CurrentCamera
            local LocalPlayer = Players.LocalPlayer
            local PlayerGui = LocalPlayer:WaitForChild(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(71).._._0x1(117).._._0x1(105))
            local UserInputService = game:GetService(_._0x1(85).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(73).._._0x1(110).._._0x1(112).._._0x1(117).._._0x1(116).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101))
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

                local screenGui = Instance.new(_._0x1(83).._._0x1(99).._._0x1(114).._._0x1(101).._._0x1(101).._._0x1(110).._._0x1(71).._._0x1(117).._._0x1(105))
                screenGui.Name = _._0x1(65).._._0x1(67).._._0x1(77).._._0x1(71).._._0x1(117).._._0x1(105)
                screenGui.ResetOnSpawn = false
                screenGui.Parent = PlayerGui

                local button = Instance.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116).._._0x1(66).._._0x1(117).._._0x1(116).._._0x1(116).._._0x1(111).._._0x1(110))
                button.Name = _._0x1(65).._._0x1(67).._._0x1(77).._._0x1(66).._._0x1(117).._._0x1(116).._._0x1(116).._._0x1(111).._._0x1(110)
                button.Size = BUTTON_SIZE
                button.Position = BUTTON_POSITION
                button.BackgroundColor3 = BUTTON_COLOR
                button.Text = _._0x1(65).._._0x1(67).._._0x1(77)
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
                    local hrp = char and char:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116))

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
        Title = _._0x1(229).._._0x1(143).._._0x1(141).._._0x1(228).._._0x1(189).._._0x1(156).._._0x1(229).._._0x1(188).._._0x1(138).._._0x1(230).._._0x1(147).._._0x1(141).._._0x1(231).._._0x1(186).._._0x1(181).._._0x1(230).._._0x1(140).._._0x1(137).._._0x1(233).._._0x1(148).._._0x1(174),
        Default = _._0x1(84),
        Mode = _._0x1(72).._._0x1(111).._._0x1(108).._._0x1(100),
        Callback = function(Value) end
    })
    
    local SpeedValue = 21
    local SpeedEnabled = false
    local SpeedConnection = nil
    local BypassLabel = nil

    MovementTab:Toggle({
        Title = _._0x1(229).._._0x1(188).._._0x1(128).._._0x1(229).._._0x1(144).._._0x1(175).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166),
        Default = false,
        Tooltip = _._0x1(229).._._0x1(176).._._0x1(134).._._0x1(228).._._0x1(189).._._0x1(160).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(232).._._0x1(161).._._0x1(140).._._0x1(232).._._0x1(181).._._0x1(176).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166).._._0x1(230).._._0x1(155).._._0x1(180).._._0x1(230).._._0x1(148).._._0x1(185).._._0x1(228).._._0x1(184).._._0x1(186).._._0x1(232).._._0x1(174).._._0x1(190).._._0x1(229).._._0x1(174).._._0x1(154).._._0x1(229).._._0x1(128).._._0x1(188),
        Callback = function(Value)
            SpeedEnabled = Value
            local LocalPlayer = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115)).LocalPlayer
            
            if Value then
                SpeedConnection = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101)).Heartbeat:Connect(function()
                    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100))
                    if humanoid then
                        humanoid.WalkSpeed = SpeedValue
                    end
                end)
                WindUI:Notify(_._0x1(231).._._0x1(167).._._0x1(187).._._0x1(233).._._0x1(128).._._0x1(159), _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(174).._._0x1(154).._._0x1(228).._._0x1(185).._._0x1(137).._._0x1(231).._._0x1(167).._._0x1(187).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(229).._._0x1(144).._._0x1(175).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(58).._._0x1(32) .. SpeedValue, 3)
            else
                if SpeedConnection then
                    SpeedConnection:Disconnect()
                    SpeedConnection = nil
                end
                WindUI:Notify(_._0x1(231).._._0x1(167).._._0x1(187).._._0x1(233).._._0x1(128).._._0x1(159), _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(174).._._0x1(154).._._0x1(228).._._0x1(185).._._0x1(137).._._0x1(231).._._0x1(167).._._0x1(187).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(231).._._0x1(166).._._0x1(129).._._0x1(231).._._0x1(148).._._0x1(168), 3)
            end
        end
    })

    MovementTab:Slider({
        Title = _._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166).._._0x1(230).._._0x1(149).._._0x1(176).._._0x1(229).._._0x1(128).._._0x1(188),
        Value = {Min = 0, Max = 100, Default = 21},
        Suffix = _._0x1(32).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166),
        Tooltip = _._0x1(232).._._0x1(174).._._0x1(190).._._0x1(231).._._0x1(189).._._0x1(174).._._0x1(228).._._0x1(189).._._0x1(160).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(232).._._0x1(161).._._0x1(140).._._0x1(232).._._0x1(181).._._0x1(176).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166),
        Callback = function(Value)
            SpeedValue = Value
            if SpeedEnabled then
                WindUI:Notify(_._0x1(231).._._0x1(167).._._0x1(187).._._0x1(233).._._0x1(128).._._0x1(159), _._0x1(231).._._0x1(167).._._0x1(187).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(230).._._0x1(155).._._0x1(180).._._0x1(230).._._0x1(150).._._0x1(176).._._0x1(58).._._0x1(32) .. Value, 2)
            end
        end
    })
    MovementTab:Toggle({
        Title = _._0x1(229).._._0x1(141).._._0x1(179).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(229).._._0x1(138).._._0x1(160).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166),
        Default = false,
        Tooltip = _._0x1(231).._._0x1(167).._._0x1(187).._._0x1(233).._._0x1(153).._._0x1(164).._._0x1(230).._._0x1(148).._._0x1(185).._._0x1(229).._._0x1(143).._._0x1(152).._._0x1(230).._._0x1(150).._._0x1(185).._._0x1(229).._._0x1(144).._._0x1(145).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(229).._._0x1(135).._._0x1(143).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(230).._._0x1(149).._._0x1(136).._._0x1(230).._._0x1(158).._._0x1(156),
        Callback = function(Value)
            local LocalPlayer = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115)).LocalPlayer
            local OldAccel = PhysicalProperties.new(0.01, 0.7, 0, 1, 1)
            
            local function updateAcceleration()
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116))
                if hrp then
                    hrp.CustomPhysicalProperties = Value and PhysicalProperties.new(100, 0, 0, 0, 0) or OldAccel
                end
            end

            if Value then
                updateAcceleration()
                WindUI:Notify(_._0x1(229).._._0x1(138).._._0x1(160).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166), _._0x1(229).._._0x1(141).._._0x1(179).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(229).._._0x1(138).._._0x1(160).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(229).._._0x1(144).._._0x1(175).._._0x1(231).._._0x1(148).._._0x1(168), 3)
            else
                updateAcceleration()
                WindUI:Notify(_._0x1(229).._._0x1(138).._._0x1(160).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166), _._0x1(229).._._0x1(141).._._0x1(179).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(229).._._0x1(138).._._0x1(160).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(231).._._0x1(166).._._0x1(129).._._0x1(231).._._0x1(148).._._0x1(168), 3)
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

        local humanoid = character:FindFirstChildOfClass(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100))
        if not humanoid then
            return
        end

        local hrp = character:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116))
        if not hrp then
            return
        end
        local bv = Instance.new(_._0x1(66).._._0x1(111).._._0x1(100).._._0x1(121).._._0x1(86).._._0x1(101).._._0x1(108).._._0x1(111).._._0x1(99).._._0x1(105).._._0x1(116).._._0x1(121))
        bv.Name = _._0x1(70).._._0x1(108).._._0x1(121).._._0x1(86).._._0x1(101).._._0x1(108).._._0x1(111).._._0x1(99).._._0x1(105).._._0x1(116).._._0x1(121)
        bv.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = hrp

        local bg = Instance.new(_._0x1(66).._._0x1(111).._._0x1(100).._._0x1(121).._._0x1(71).._._0x1(121).._._0x1(114).._._0x1(111))
        bg.Name = _._0x1(70).._._0x1(108).._._0x1(121).._._0x1(71).._._0x1(121).._._0x1(114).._._0x1(111)
        bg.MaxTorque = Vector3.new(1000000000, 1000000000, 1000000000)
        bg.P = 20000
        bg.D = 1000
        bg.Parent = hrp

        humanoid.AutoRotate = false
        humanoid.PlatformStand = true
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        local inputBegan = game:GetService(_._0x1(85).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(73).._._0x1(110).._._0x1(112).._._0x1(117).._._0x1(116).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101)).InputBegan:Connect(function(input, gpe)
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

        local inputEnded = game:GetService(_._0x1(85).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(73).._._0x1(110).._._0x1(112).._._0x1(117).._._0x1(116).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101)).InputEnded:Connect(function(input)
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
        local renderConnection = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101)).RenderStepped:Connect(function()
            local cam = workspace.CurrentCamera

            if not cam or not hrp or not hrp:FindFirstChild(_._0x1(70).._._0x1(108).._._0x1(121).._._0x1(86).._._0x1(101).._._0x1(108).._._0x1(111).._._0x1(99).._._0x1(105).._._0x1(116).._._0x1(121)) or not humanoid or humanoid.Health <= 0 then
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
        local humanoid = character and character:FindFirstChildOfClass(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100))
        local hrp = character and character:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116))

        if hrp then
            local flyVelocity = hrp:FindFirstChild(_._0x1(70).._._0x1(108).._._0x1(121).._._0x1(86).._._0x1(101).._._0x1(108).._._0x1(111).._._0x1(99).._._0x1(105).._._0x1(116).._._0x1(121))
            if flyVelocity then
                flyVelocity:Destroy()
            end

            local flyGyro = hrp:FindFirstChild(_._0x1(70).._._0x1(108).._._0x1(121).._._0x1(71).._._0x1(121).._._0x1(114).._._0x1(111))
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
        Title = _._0x1(229).._._0x1(188).._._0x1(128).._._0x1(229).._._0x1(144).._._0x1(175).._._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(161).._._0x1(140),
        Default = false,
        Callback = function(Value)
            isFlying = Value

            if Value then
                startFly()
                WindUI:Notify(_._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(161).._._0x1(140), _._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(161).._._0x1(140).._._0x1(230).._._0x1(168).._._0x1(161).._._0x1(229).._._0x1(188).._._0x1(143).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(229).._._0x1(144).._._0x1(175).._._0x1(231).._._0x1(148).._._0x1(168), 3)
            else
                stopFly()
                WindUI:Notify(_._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(161).._._0x1(140), _._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(161).._._0x1(140).._._0x1(230).._._0x1(168).._._0x1(161).._._0x1(229).._._0x1(188).._._0x1(143).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(231).._._0x1(166).._._0x1(129).._._0x1(231).._._0x1(148).._._0x1(168), 3)
            end
        end
    })

    MovementTab:Keybind({
        Title = _._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(161).._._0x1(140).._._0x1(231).._._0x1(148).._._0x1(181).._._0x1(232).._._0x1(132).._._0x1(145).._._0x1(229).._._0x1(136).._._0x1(135).._._0x1(230).._._0x1(141).._._0x1(162).._._0x1(233).._._0x1(148).._._0x1(174),
        Default = _._0x1(70),
        Mode = _._0x1(84).._._0x1(111).._._0x1(103).._._0x1(103).._._0x1(108).._._0x1(101),
        Callback = function(Value) end
    })

    MovementTab:Slider({
        Title = _._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(161).._._0x1(140).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166),
        Value = {Min = 0, Max = 150, Default = 50},
        Suffix = _._0x1(32).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166),
        Tooltip = _._0x1(230).._._0x1(155).._._0x1(180).._._0x1(230).._._0x1(148).._._0x1(185).._._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(161).._._0x1(140).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166),
        Callback = function(Value)
            FlySpeed = Value
            if isFlying then
                WindUI:Notify(_._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(161).._._0x1(140), _._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(161).._._0x1(140).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(230).._._0x1(155).._._0x1(180).._._0x1(230).._._0x1(150).._._0x1(176).._._0x1(58).._._0x1(32) .. Value, 2)
            end
        end
    })
    local noclipConnection = nil
    local originalGroups = {}

    MovementTab:Toggle({
        Title = _._0x1(231).._._0x1(169).._._0x1(191).._._0x1(229).._._0x1(162).._._0x1(153).._._0x1(230).._._0x1(168).._._0x1(161).._._0x1(229).._._0x1(188).._._0x1(143),
        Default = false,
        Tooltip = _._0x1(232).._._0x1(174).._._0x1(169).._._0x1(228).._._0x1(189).._._0x1(160).._._0x1(229).._._0x1(143).._._0x1(175).._._0x1(228).._._0x1(187).._._0x1(165).._._0x1(231).._._0x1(169).._._0x1(191).._._0x1(232).._._0x1(191).._._0x1(135).._._0x1(229).._._0x1(162).._._0x1(153).._._0x1(229).._._0x1(163).._._0x1(129),
        Callback = function(Value)
            local Players = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115))
            local RunService = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101))
            local lp = Players.LocalPlayer

            local function enableNoclip()
                if noclipConnection then
                    return
                end

                noclipConnection = RunService.Stepped:Connect(function()
                    if lp.Character then
                        for _, part in pairs(lp.Character:GetDescendants()) do
                            if part:IsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                                part.CanCollide = false
                                if not originalGroups[part] then
                                    originalGroups[part] = part.CollisionGroup
                                end
                                part.CollisionGroup = _._0x1(68).._._0x1(101).._._0x1(102).._._0x1(97).._._0x1(117).._._0x1(108).._._0x1(116)
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

                local collision = char:FindFirstChild(_._0x1(67).._._0x1(111).._._0x1(108).._._0x1(108).._._0x1(105).._._0x1(115).._._0x1(105).._._0x1(111).._._0x1(110))
                local crouch = collision and collision:FindFirstChild(_._0x1(67).._._0x1(111).._._0x1(108).._._0x1(108).._._0x1(105).._._0x1(115).._._0x1(105).._._0x1(111).._._0x1(110).._._0x1(67).._._0x1(114).._._0x1(111).._._0x1(117).._._0x1(99).._._0x1(104))

                if collision and crouch then
                    local crouching = collision.CollisionGroup == _._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(67).._._0x1(114).._._0x1(111).._._0x1(117).._._0x1(99).._._0x1(104).._._0x1(105).._._0x1(110).._._0x1(103)
                    collision.CanCollide = not crouching
                    crouch.CanCollide = crouching
                end
            end

            if Value then
                enableNoclip()
                WindUI:Notify(_._0x1(231).._._0x1(169).._._0x1(191).._._0x1(229).._._0x1(162).._._0x1(153), _._0x1(231).._._0x1(169).._._0x1(191).._._0x1(229).._._0x1(162).._._0x1(153).._._0x1(230).._._0x1(168).._._0x1(161).._._0x1(229).._._0x1(188).._._0x1(143).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(229).._._0x1(144).._._0x1(175).._._0x1(231).._._0x1(148).._._0x1(168), 3)
            else
                disableNoclip()
                WindUI:Notify(_._0x1(231).._._0x1(169).._._0x1(191).._._0x1(229).._._0x1(162).._._0x1(153), _._0x1(231).._._0x1(169).._._0x1(191).._._0x1(229).._._0x1(162).._._0x1(153).._._0x1(230).._._0x1(168).._._0x1(161).._._0x1(229).._._0x1(188).._._0x1(143).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(231).._._0x1(166).._._0x1(129).._._0x1(231).._._0x1(148).._._0x1(168), 3)
            end
        end
    })

    MovementTab:Keybind({
        Title = _._0x1(231).._._0x1(169).._._0x1(191).._._0x1(229).._._0x1(162).._._0x1(153).._._0x1(231).._._0x1(148).._._0x1(181).._._0x1(232).._._0x1(132).._._0x1(145).._._0x1(229).._._0x1(136).._._0x1(135).._._0x1(230).._._0x1(141).._._0x1(162).._._0x1(233).._._0x1(148).._._0x1(174),
        Default = _._0x1(78),
        Mode = _._0x1(84).._._0x1(111).._._0x1(103).._._0x1(103).._._0x1(108).._._0x1(101),
        Callback = function(Value) end
    })
    local LadderSpeedValue = 20
    local LadderSpeedEnabled = false
    local LadderConnection = nil

    MovementTab:Toggle({
        Title = _._0x1(230).._._0x1(155).._._0x1(180).._._0x1(229).._._0x1(191).._._0x1(171).._._0x1(231).._._0x1(136).._._0x1(172).._._0x1(230).._._0x1(162).._._0x1(175),
        Default = false,
        Callback = function(on)
            local LocalPlayer = game.Players.LocalPlayer
            local RunService = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101))

            if on then
                LadderConnection = RunService.Heartbeat:Connect(function()
                    local char = LocalPlayer.Character
                    local hum = char and char:FindFirstChildOfClass(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100))
                    local hrp = char and char:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116))

                    if hum and hrp and hum:GetState() == Enum.HumanoidStateType.Climbing then
                        hrp.Velocity = Vector3.new(hrp.Velocity.X, LadderSpeedValue, hrp.Velocity.Z)
                    end
                end)
                WindUI:Notify(_._0x1(231).._._0x1(136).._._0x1(172).._._0x1(230).._._0x1(162).._._0x1(175), _._0x1(230).._._0x1(162).._._0x1(175).._._0x1(229).._._0x1(173).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(160).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(229).._._0x1(144).._._0x1(175).._._0x1(231).._._0x1(148).._._0x1(168), 3)
            elseif LadderConnection then
                LadderConnection:Disconnect()
                LadderConnection = nil
                WindUI:Notify(_._0x1(231).._._0x1(136).._._0x1(172).._._0x1(230).._._0x1(162).._._0x1(175), _._0x1(230).._._0x1(162).._._0x1(175).._._0x1(229).._._0x1(173).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(160).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(231).._._0x1(166).._._0x1(129).._._0x1(231).._._0x1(148).._._0x1(168), 3)
            end
        end
    })

    MovementTab:Slider({
        Title = _._0x1(231).._._0x1(136).._._0x1(172).._._0x1(230).._._0x1(162).._._0x1(175).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166),
        Value = {Min = 0, Max = 100, Default = 20},
        Suffix = _._0x1(32).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166),
        Tooltip = _._0x1(231).._._0x1(136).._._0x1(172).._._0x1(230).._._0x1(162).._._0x1(175).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(229).._._0x1(138).._._0x1(160).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(128).._._0x1(188).._._0x1(239).._._0x1(188).._._0x1(140).._._0x1(232).._._0x1(191).._._0x1(135).._._0x1(233).._._0x1(171).._._0x1(152).._._0x1(229).._._0x1(143).._._0x1(175).._._0x1(232).._._0x1(131).._._0x1(189).._._0x1(228).._._0x1(184).._._0x1(141).._._0x1(231).._._0x1(168).._._0x1(179).._._0x1(229).._._0x1(174).._._0x1(154),
        Callback = function(Value)
            LadderSpeedValue = Value
            if LadderSpeedEnabled then
                WindUI:Notify(_._0x1(231).._._0x1(136).._._0x1(172).._._0x1(230).._._0x1(162).._._0x1(175), _._0x1(231).._._0x1(136).._._0x1(172).._._0x1(230).._._0x1(162).._._0x1(175).._._0x1(233).._._0x1(128).._._0x1(159).._._0x1(229).._._0x1(186).._._0x1(166).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(230).._._0x1(155).._._0x1(180).._._0x1(230).._._0x1(150).._._0x1(176).._._0x1(58).._._0x1(32) .. Value, 2)
            end
        end
    })
    MovementTab:Toggle({
        Title = _._0x1(229).._._0x1(167).._._0x1(139).._._0x1(231).._._0x1(187).._._0x1(136).._._0x1(229).._._0x1(143).._._0x1(175).._._0x1(232).._._0x1(183).._._0x1(179).._._0x1(232).._._0x1(183).._._0x1(131),
        Default = false,
        Tooltip = _._0x1(232).._._0x1(174).._._0x1(169).._._0x1(228).._._0x1(189).._._0x1(160).._._0x1(233).._._0x1(154).._._0x1(143).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(229).._._0x1(143).._._0x1(175).._._0x1(228).._._0x1(187).._._0x1(165).._._0x1(232).._._0x1(183).._._0x1(179).._._0x1(232).._._0x1(183).._._0x1(131),
        Callback = function(Value)
            local LocalPlayer = game.Players.LocalPlayer
            LocalPlayer.Character:SetAttribute(_._0x1(67).._._0x1(97).._._0x1(110).._._0x1(74).._._0x1(117).._._0x1(109).._._0x1(112), Value)
            
            if Value then
                WindUI:Notify(_._0x1(232).._._0x1(183).._._0x1(179).._._0x1(232).._._0x1(183).._._0x1(131), _._0x1(229).._._0x1(167).._._0x1(139).._._0x1(231).._._0x1(187).._._0x1(136).._._0x1(232).._._0x1(183).._._0x1(179).._._0x1(232).._._0x1(183).._._0x1(131).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(229).._._0x1(144).._._0x1(175).._._0x1(231).._._0x1(148).._._0x1(168), 3)
            else
                WindUI:Notify(_._0x1(232).._._0x1(183).._._0x1(179).._._0x1(232).._._0x1(183).._._0x1(131), _._0x1(229).._._0x1(167).._._0x1(139).._._0x1(231).._._0x1(187).._._0x1(136).._._0x1(232).._._0x1(183).._._0x1(179).._._0x1(232).._._0x1(183).._._0x1(131).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(231).._._0x1(166).._._0x1(129).._._0x1(231).._._0x1(148).._._0x1(168), 3)
            end
            LocalPlayer.CharacterAdded:Connect(function(newCharacter)
                task.wait(1.5)
                newCharacter:SetAttribute(_._0x1(67).._._0x1(97).._._0x1(110).._._0x1(74).._._0x1(117).._._0x1(109).._._0x1(112), Value)
            end)
        end
    })
    local B = Window:Tab({Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(231).._._0x1(177).._._0x1(187), Icon = _._0x1(112).._._0x1(117).._._0x1(122).._._0x1(122).._._0x1(108).._._0x1(101)})
    B:Toggle({
        Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(233).._._0x1(148).._._0x1(154).._._0x1(231).._._0x1(130).._._0x1(185).._._0x1(228).._._0x1(187).._._0x1(163).._._0x1(231).._._0x1(160).._._0x1(129).._._0x1(230).._._0x1(177).._._0x1(130).._._0x1(232).._._0x1(167).._._0x1(163),
        Default = false,
        Callback = function(enabled)
            local running = false
            local Players = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115))
            local LocalPlayer = Players.LocalPlayer
            local Workspace = game:GetService(_._0x1(87).._._0x1(111).._._0x1(114).._._0x1(107).._._0x1(115).._._0x1(112).._._0x1(97).._._0x1(99).._._0x1(101))
            
            if enabled then
                if running then return end
                running = true
                
                task.spawn(function()
                    local playerGui = LocalPlayer:WaitForChild(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(71).._._0x1(117).._._0x1(105))
                    
                    local function findFrame()
                        local mainUI = playerGui:FindFirstChild(_._0x1(77).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(85).._._0x1(73))
                        if mainUI and mainUI:FindFirstChild(_._0x1(77).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(70).._._0x1(114).._._0x1(97).._._0x1(109).._._0x1(101)) then
                            local frame = mainUI.MainFrame:FindFirstChild(_._0x1(65).._._0x1(110).._._0x1(99).._._0x1(104).._._0x1(111).._._0x1(114).._._0x1(72).._._0x1(105).._._0x1(110).._._0x1(116).._._0x1(70).._._0x1(114).._._0x1(97).._._0x1(109).._._0x1(101))
                            if frame then return frame end
                        end

                        local anchorUI = playerGui:FindFirstChild(_._0x1(65).._._0x1(110).._._0x1(99).._._0x1(104).._._0x1(111).._._0x1(114).._._0x1(72).._._0x1(105).._._0x1(110).._._0x1(116).._._0x1(85).._._0x1(73))
                        if anchorUI then
                            local frame = anchorUI:FindFirstChild(_._0x1(65).._._0x1(110).._._0x1(99).._._0x1(104).._._0x1(111).._._0x1(114).._._0x1(72).._._0x1(105).._._0x1(110).._._0x1(116).._._0x1(70).._._0x1(114).._._0x1(97).._._0x1(109).._._0x1(101))
                            if frame then return frame end
                        end
                        return nil
                    end

                    while running do
                        task.wait(0.9)
                        local frame = findFrame()
                        
                        if frame then
                            local anchorName = (frame:FindFirstChild(_._0x1(65).._._0x1(110).._._0x1(99).._._0x1(104).._._0x1(111).._._0x1(114).._._0x1(67).._._0x1(111).._._0x1(100).._._0x1(101)) and frame.AnchorCode.Text) or _._0x1()
                            local codeText = (frame:FindFirstChild(_._0x1(67).._._0x1(111).._._0x1(100).._._0x1(101)) and frame.Code.Text) or _._0x1()
                            
                            if anchorName ~= _._0x1() and codeText ~= _._0x1() then
                                local anchorObject
                                for _, obj in ipairs(Workspace.CurrentRooms:GetDescendants()) do
                                    if obj.Name == _._0x1(77).._._0x1(105).._._0x1(110).._._0x1(101).._._0x1(115).._._0x1(65).._._0x1(110).._._0x1(99).._._0x1(104).._._0x1(111).._._0x1(114) then
                                        local sign = obj:FindFirstChild(_._0x1(83).._._0x1(105).._._0x1(103).._._0x1(110))
                                        if sign then
                                            local label = sign:FindFirstChild(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116).._._0x1(76).._._0x1(97).._._0x1(98).._._0x1(101).._._0x1(108)) or sign:FindFirstChildWhichIsA(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116).._._0x1(76).._._0x1(97).._._0x1(98).._._0x1(101).._._0x1(108))
                                            if label and label.Text == anchorName then
                                                anchorObject = obj
                                                break
                                            end
                                        end
                                    end
                                end

                                if anchorObject then
                                    local note = anchorObject:FindFirstChild(_._0x1(78).._._0x1(111).._._0x1(116).._._0x1(101))
                                    if not note then
                                        WindUI:Notify(_._0x1(233).._._0x1(148).._._0x1(154).._._0x1(231).._._0x1(130).._._0x1(185).._._0x1(228).._._0x1(187).._._0x1(163).._._0x1(231).._._0x1(160).._._0x1(129), _._0x1(233).._._0x1(148).._._0x1(154).._._0x1(231).._._0x1(130).._._0x1(185).._._0x1(32) .. anchorName .. _._0x1(32).._._0x1(228).._._0x1(187).._._0x1(163).._._0x1(231).._._0x1(160).._._0x1(129).._._0x1(230).._._0x1(152).._._0x1(175).._._0x1(32) .. codeText, 3)
                                    else
                                        local surfaceGui = note:FindFirstChildOfClass(_._0x1(83).._._0x1(117).._._0x1(114).._._0x1(102).._._0x1(97).._._0x1(99).._._0x1(101).._._0x1(71).._._0x1(117).._._0x1(105)) or note:FindFirstChild(_._0x1(83).._._0x1(117).._._0x1(114).._._0x1(102).._._0x1(97).._._0x1(99).._._0x1(101).._._0x1(71).._._0x1(117).._._0x1(105))
                                        local noteText = (surfaceGui and surfaceGui:FindFirstChild(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116).._._0x1(76).._._0x1(97).._._0x1(98).._._0x1(101).._._0x1(108)) and surfaceGui.TextLabel.Text) or _._0x1(48)
                                        local noteValue = tonumber(noteText) or 0
                                        local solved = _._0x1()
                                        
                                        for i = 1, #codeText do
                                            local digit = tonumber(codeText:sub(i, i)) or 0
                                            digit = (digit + noteValue) % 10
                                            solved = solved .. tostring(digit)
                                        end
                                        
                                        WindUI:Notify(_._0x1(233).._._0x1(148).._._0x1(154).._._0x1(231).._._0x1(130).._._0x1(185).._._0x1(228).._._0x1(187).._._0x1(163).._._0x1(231).._._0x1(160).._._0x1(129), _._0x1(233).._._0x1(148).._._0x1(154).._._0x1(231).._._0x1(130).._._0x1(185).._._0x1(32) .. anchorName .. _._0x1(32).._._0x1(228).._._0x1(187).._._0x1(163).._._0x1(231).._._0x1(160).._._0x1(129).._._0x1(230).._._0x1(152).._._0x1(175).._._0x1(32) .. solved, 5)
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
        Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(150).._._0x1(173).._._0x1(232).._._0x1(183).._._0x1(175).._._0x1(229).._._0x1(153).._._0x1(168).._._0x1(230).._._0x1(184).._._0x1(184).._._0x1(230).._._0x1(136).._._0x1(143),
        Default = false,
        Callback = function(Value)
            local Players = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115))
            local ReplicatedStorage = game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101))
            local LocalPlayer = Players.LocalPlayer
            local RemoteFolder = ReplicatedStorage:FindFirstChild(_._0x1(82).._._0x1(101).._._0x1(109).._._0x1(111).._._0x1(116).._._0x1(101).._._0x1(115).._._0x1(70).._._0x1(111).._._0x1(108).._._0x1(100).._._0x1(101).._._0x1(114)) or ReplicatedStorage:FindFirstChild(_._0x1(69).._._0x1(110).._._0x1(116).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(73).._._0x1(110).._._0x1(102).._._0x1(111)) or ReplicatedStorage:FindFirstChild(_._0x1(66).._._0x1(114).._._0x1(105).._._0x1(99).._._0x1(107).._._0x1(115))
            
            while task.wait() and Value do
                if not Value then break end
                
                local currentRoom = LocalPlayer:GetAttribute(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109))
                if currentRoom ~= 100 then
                    WindUI:Notify(_._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186), _._0x1(228).._._0x1(189).._._0x1(160).._._0x1(233).._._0x1(156).._._0x1(128).._._0x1(232).._._0x1(166).._._0x1(129).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(49).._._0x1(48).._._0x1(48).._._0x1(229).._._0x1(143).._._0x1(183).._._0x1(230).._._0x1(136).._._0x1(191).._._0x1(233).._._0x1(151).._._0x1(180).._._0x1(228).._._0x1(189).._._0x1(191).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(230).._._0x1(173).._._0x1(164).._._0x1(229).._._0x1(138).._._0x1(159).._._0x1(232).._._0x1(131).._._0x1(189), 5)
                    break
                end

                local Breaker = nil
                for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
                    if v.Name == _._0x1(69).._._0x1(108).._._0x1(101).._._0x1(118).._._0x1(97).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(66).._._0x1(114).._._0x1(101).._._0x1(97).._._0x1(107).._._0x1(101).._._0x1(114) then
                        Breaker = v
                        break
                    end
                end

                if Breaker then
                    local solved = true
                    for _, v in ipairs(Breaker:GetChildren()) do
                        if v.Name == _._0x1(66).._._0x1(114).._._0x1(101).._._0x1(97).._._0x1(107).._._0x1(101).._._0x1(114).._._0x1(83).._._0x1(119).._._0x1(105).._._0x1(116).._._0x1(99).._._0x1(104) then
                            local codeText = Breaker:WaitForChild(_._0x1(83).._._0x1(117).._._0x1(114).._._0x1(102).._._0x1(97).._._0x1(99).._._0x1(101).._._0x1(71).._._0x1(117).._._0x1(105)).Frame.Code.Text
                            if v:GetAttribute(_._0x1(73).._._0x1(68)) == tonumber(codeText) then
                                if Breaker.SurfaceGui.Frame.Code.Frame.BackgroundTransparency == 0 then
                                    v:SetAttribute(_._0x1(69).._._0x1(110).._._0x1(97).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(100), true)
                                    if not v.Sound.Playing then
                                        v.Sound.Playing = true
                                    end
                                    v.Material = Enum.Material.Neon
                                    v.Light.Attachment.Spark:Emit(1)
                                    v.PrismaticConstraint.TargetPosition = -0.2
                                else
                                    v:SetAttribute(_._0x1(69).._._0x1(110).._._0x1(97).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(100), false)
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
                        local breakerRemote = RemoteFolder:FindFirstChild(_._0x1(66).._._0x1(114).._._0x1(101).._._0x1(97).._._0x1(107).._._0x1(101).._._0x1(114).._._0x1(77).._._0x1(105).._._0x1(110).._._0x1(105).._._0x1(103).._._0x1(97).._._0x1(109).._._0x1(101))
                        if breakerRemote then
                            breakerRemote:FireServer(_._0x1(83).._._0x1(111).._._0x1(108).._._0x1(118).._._0x1(101).._._0x1(100))
                        end
                    end
                end
            end
        end
    })
    B:Toggle({
        Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(233).._._0x1(154).._._0x1(144).._._0x1(232).._._0x1(151).._._0x1(143).._._0x1(91).._._0x1(233).._._0x1(152).._._0x1(178).._._0x1(230).._._0x1(128).._._0x1(170).._._0x1(231).._._0x1(137).._._0x1(169).._._0x1(93),
        Default = false,
        Risky = true,
        Tooltip = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(228).._._0x1(184).._._0x1(186).._._0x1(228).._._0x1(189).._._0x1(160).._._0x1(233).._._0x1(154).._._0x1(144).._._0x1(232).._._0x1(151).._._0x1(143),
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
                local currRoom = Rooms and Rooms[LocalPlayer:GetAttribute(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109))]
                if not currRoom then return nil end

                local char = LocalPlayer.Character
                if not char then return nil end

                local hrp = char:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) or char:FindFirstChild(_._0x1(67).._._0x1(111).._._0x1(108).._._0x1(108).._._0x1(105).._._0x1(115).._._0x1(105).._._0x1(111).._._0x1(110)) or char.PrimaryPart
                if not hrp then return nil end

                local function distFromPlayer(model)
                    if not model then return math.huge end
                    local part = model.PrimaryPart or model:FindFirstChildWhichIsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116), true)
                    if not part then return math.huge end
                    return (part.Position - hrp.Position).Magnitude
                end

                local assets = currRoom:FindFirstChild(_._0x1(65).._._0x1(115).._._0x1(115).._._0x1(101).._._0x1(116).._._0x1(115))
                if assets then
                    for _, v in pairs(assets:GetChildren()) do
                        if v:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) then
                            if ((v.Name == _._0x1(76).._._0x1(111).._._0x1(99).._._0x1(107).._._0x1(101).._._0x1(114).._._0x1(95).._._0x1(76).._._0x1(97).._._0x1(114).._._0x1(103).._._0x1(101)) or (v.Name == _._0x1(87).._._0x1(97).._._0x1(114).._._0x1(100).._._0x1(114).._._0x1(111).._._0x1(98).._._0x1(101)) or (v.Name == _._0x1(84).._._0x1(111).._._0x1(111).._._0x1(108).._._0x1(115).._._0x1(104).._._0x1(101).._._0x1(100)) or (v.Name == _._0x1(66).._._0x1(101).._._0x1(100)) or (v.Name == _._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115).._._0x1(95).._._0x1(76).._._0x1(111).._._0x1(99).._._0x1(107).._._0x1(101).._._0x1(114)) or (v.Name == _._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115).._._0x1(95).._._0x1(76).._._0x1(111).._._0x1(99).._._0x1(107).._._0x1(101).._._0x1(114).._._0x1(95).._._0x1(70).._._0x1(114).._._0x1(105).._._0x1(100).._._0x1(103).._._0x1(101)) or (v.Name == _._0x1(66).._._0x1(97).._._0x1(99).._._0x1(107).._._0x1(100).._._0x1(111).._._0x1(111).._._0x1(114).._._0x1(95).._._0x1(87).._._0x1(97).._._0x1(114).._._0x1(100).._._0x1(114).._._0x1(111).._._0x1(98).._._0x1(101))) and v:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(101).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) and v:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(100).._._0x1(101).._._0x1(110).._._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114)) then
                                if not v.HiddenPlayer.Value and not v:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(101).._._0x1(69).._._0x1(110).._._0x1(116).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(79).._._0x1(110).._._0x1(83).._._0x1(112).._._0x1(111).._._0x1(116), true) then
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
                            elseif v.Name == _._0x1(68).._._0x1(111).._._0x1(117).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(95).._._0x1(66).._._0x1(101).._._0x1(100) then
                                for _, x in pairs(v:GetChildren()) do
                                    if x.Name == _._0x1(68).._._0x1(111).._._0x1(117).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(66).._._0x1(101).._._0x1(100) and x:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(101).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) and x:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(100).._._0x1(101).._._0x1(110).._._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114)) then
                                        if not x.HiddenPlayer.Value and not x:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(101).._._0x1(69).._._0x1(110).._._0x1(116).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(79).._._0x1(110).._._0x1(83).._._0x1(112).._._0x1(111).._._0x1(116), true) then
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
                            elseif v.Name == _._0x1(68).._._0x1(117).._._0x1(109).._._0x1(112).._._0x1(115).._._0x1(116).._._0x1(101).._._0x1(114) then
                                for _, x in pairs(v:GetChildren()) do
                                    if x:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(101).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) and x:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(100).._._0x1(101).._._0x1(110).._._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114)) then
                                        local dumpsterBaseHasSpot = v:FindFirstChild(_._0x1(68).._._0x1(117).._._0x1(109).._._0x1(112).._._0x1(115).._._0x1(116).._._0x1(101).._._0x1(114).._._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101)) and v.DumpsterBase:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(101).._._0x1(69).._._0x1(110).._._0x1(116).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(79).._._0x1(110).._._0x1(83).._._0x1(112).._._0x1(111).._._0x1(116))
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
                        elseif v:IsA(_._0x1(70).._._0x1(111).._._0x1(108).._._0x1(100).._._0x1(101).._._0x1(114)) then
                            if v.Name == _._0x1(66).._._0x1(108).._._0x1(111).._._0x1(99).._._0x1(107).._._0x1(97).._._0x1(103).._._0x1(101) then
                                for _, x in pairs(v:GetChildren()) do
                                    if x:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) and x.Name == _._0x1(87).._._0x1(97).._._0x1(114).._._0x1(100).._._0x1(114).._._0x1(111).._._0x1(98).._._0x1(101) and x:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(100).._._0x1(101).._._0x1(110).._._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114)) and x:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(101).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) then
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
                            elseif v.Name == _._0x1(86).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(115) then
                                for _, x in pairs(v:GetChildren()) do
                                    if x.Name == _._0x1(67).._._0x1(105).._._0x1(114).._._0x1(99).._._0x1(117).._._0x1(108).._._0x1(97).._._0x1(114).._._0x1(86).._._0x1(101).._._0x1(110).._._0x1(116) and x:FindFirstChild(_._0x1(71).._._0x1(114).._._0x1(97).._._0x1(116).._._0x1(101)) and x.Grate:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(101).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) and x:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(100).._._0x1(101).._._0x1(110).._._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114)) then
                                        if not x.HiddenPlayer.Value and not v:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(101).._._0x1(69).._._0x1(110).._._0x1(116).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(79).._._0x1(110).._._0x1(83).._._0x1(112).._._0x1(111).._._0x1(116), true) then
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
                    if v:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) then
                        if v.Name == _._0x1(67).._._0x1(105).._._0x1(114).._._0x1(99).._._0x1(117).._._0x1(108).._._0x1(97).._._0x1(114).._._0x1(86).._._0x1(101).._._0x1(110).._._0x1(116) and v:FindFirstChild(_._0x1(71).._._0x1(114).._._0x1(97).._._0x1(116).._._0x1(101)) and v.Grate:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(101).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) and v:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(100).._._0x1(101).._._0x1(110).._._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114)) then
                            if not v.HiddenPlayer.Value and not v:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(101).._._0x1(69).._._0x1(110).._._0x1(116).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(79).._._0x1(110).._._0x1(83).._._0x1(112).._._0x1(111).._._0x1(116), true) then
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
                    if v:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) and EntityDistances[v.Name] then
                        task.wait(1)
                        local Part = v.PrimaryPart or v:FindFirstChildWhichIsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116), true)
                        if not Part then return end

                        v:SetAttribute(_._0x1(95).._._0x1(80).._._0x1(114).._._0x1(101).._._0x1(100).._._0x1(105).._._0x1(99).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110), Part.Position)

                        while task.wait() and v.Parent do
                            task.spawn(function()
                                local LastPosition = Part.Position
                                task.wait(0.3333333333333333)
                                if Part and Part.Parent then
                                    v:SetAttribute(_._0x1(95).._._0x1(80).._._0x1(114).._._0x1(101).._._0x1(100).._._0x1(105).._._0x1(99).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110), Part.Position - LastPosition)
                                end
                            end)

                            if Value then
                                local IncludeList = {}
                                for _, Room in pairs(Rooms:GetChildren()) do
                                    if Room:FindFirstChild(_._0x1(65).._._0x1(115).._._0x1(115).._._0x1(101).._._0x1(116).._._0x1(115)) then
                                        table.insert(IncludeList, Room.Assets)
                                    end
                                    if Room:FindFirstChild(_._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116).._._0x1(115)) then
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
                                    local predAttr = v:GetAttribute(_._0x1(95).._._0x1(80).._._0x1(114).._._0x1(101).._._0x1(100).._._0x1(105).._._0x1(99).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110))
                                    local Prediction = (predAttr and (predAttr * 3)) or Vector3.new(0, 0, 0)
                                    Prediction = Prediction * Number

                                    local char = LocalPlayer.Character
                                    if not char then break end

                                    local hrp = char:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) or char:FindFirstChild(_._0x1(67).._._0x1(111).._._0x1(108).._._0x1(108).._._0x1(105).._._0x1(115).._._0x1(105).._._0x1(111).._._0x1(110)) or char.PrimaryPart
                                    if not hrp then break end

                                    if Vector3.new(Prediction.X, 0, Prediction.Z).Magnitude > 1 then
                                        local PredictionPosition = Part.Position + Prediction
                                        local Raycast
                                        if true then
                                            Raycast = workspace:Raycast(hrp.Position, PredictionPosition - hrp.Position, RaycastParams)
                                        end

                                        local distMultiplier = 1
                                        local mode = _._0x1(83).._._0x1(97).._._0x1(102).._._0x1(101).._._0x1(116).._._0x1(121)
                                        local adjust = 0

                                        if mode == _._0x1(83).._._0x1(97).._._0x1(102).._._0x1(101).._._0x1(116).._._0x1(121) then
                                            adjust = 20
                                        elseif mode == _._0x1(67).._._0x1(108).._._0x1(111).._._0x1(115).._._0x1(101).._._0x1(32).._._0x1(67).._._0x1(97).._._0x1(108).._._0x1(108) then
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
                                if char and not entityInRange and char:GetAttribute(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(105).._._0x1(110).._._0x1(103)) then
                                    char:SetAttribute(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(105).._._0x1(110).._._0x1(103), false)
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
        Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(233).._._0x1(154).._._0x1(144).._._0x1(232).._._0x1(151).._._0x1(143).._._0x1(230).._._0x1(168).._._0x1(161).._._0x1(229).._._0x1(188).._._0x1(143),
        Values = {_._0x1(83).._._0x1(97).._._0x1(102).._._0x1(101).._._0x1(116).._._0x1(121), _._0x1(67).._._0x1(108).._._0x1(111).._._0x1(115).._._0x1(101).._._0x1(32).._._0x1(67).._._0x1(97).._._0x1(108).._._0x1(108)},
        Default = _._0x1(83).._._0x1(97).._._0x1(102).._._0x1(101).._._0x1(116).._._0x1(121),
        Callback = function(Value) end
    })

   B:Slider({
        Title = _._0x1(233).._._0x1(162).._._0x1(132).._._0x1(230).._._0x1(181).._._0x1(139).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(233).._._0x1(151).._._0x1(180),
        Value = {Min = 0.1, Max = 1.5, Default = 1.5},
        Suffix = _._0x1(115),
        Callback = function(Value) end
    })

    B:Slider({
        Title = _._0x1(232).._._0x1(183).._._0x1(157).._._0x1(231).._._0x1(166).._._0x1(187).._._0x1(229).._._0x1(128).._._0x1(141).._._0x1(230).._._0x1(149).._._0x1(176),
        Value = {Min = 1, Max = 1.5, Default = 1},
        Suffix = _._0x1(120),
        Callback = function(Value) end
    })
    local AutoInteractDistance = 10
    B:Toggle({
        Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(228).._._0x1(186).._._0x1(146).._._0x1(229).._._0x1(138).._._0x1(168),
        Default = false,
        Callback = function(Value)
            if Value then
                local RunService = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101))
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
                    if prompt and prompt.Parent and prompt.Parent:IsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                        return prompt.Parent
                    end
                    if obj:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) then
                        if obj.PrimaryPart and obj.PrimaryPart:IsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                            return obj.PrimaryPart
                        end
                        local common = obj:FindFirstChild(_._0x1(77).._._0x1(97).._._0x1(105).._._0x1(110), true) or obj:FindFirstChild(_._0x1(72).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(108).._._0x1(101), true) or obj:FindFirstChild(_._0x1(68).._._0x1(111).._._0x1(111).._._0x1(114), true)
                        if common and common:IsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                            return common
                        end
                    end
                    return obj:FindFirstChildWhichIsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116), true)
                end

                local function AddPromptsFromObject(obj)
                    for _, desc in ipairs(obj:GetDescendants()) do
                        if desc:IsA(_._0x1(80).._._0x1(114).._._0x1(111).._._0x1(120).._._0x1(105).._._0x1(109).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) and not PromptSeen[desc] then
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
                        if v:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) or v:IsA(_._0x1(70).._._0x1(111).._._0x1(108).._._0x1(100).._._0x1(101).._._0x1(114)) then
                            if v.Name == _._0x1(68).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(101).._._0x1(114).._._0x1(67).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(101).._._0x1(114) or InteractableModels[v.Name] or v.Name == _._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115).._._0x1(76).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(73).._._0x1(116).._._0x1(101).._._0x1(109) or v.Name == _._0x1(76).._._0x1(111).._._0x1(99).._._0x1(107).._._0x1(101).._._0x1(114).._._0x1(95).._._0x1(83).._._0x1(109).._._0x1(97).._._0x1(108).._._0x1(108) or v.Name == _._0x1(84).._._0x1(111).._._0x1(111).._._0x1(108).._._0x1(98).._._0x1(111).._._0x1(120) or v.Name == _._0x1(67).._._0x1(104).._._0x1(101).._._0x1(115).._._0x1(116).._._0x1(66).._._0x1(111).._._0x1(120) or v.Name == _._0x1(84).._._0x1(111).._._0x1(111).._._0x1(108).._._0x1(115).._._0x1(104).._._0x1(101).._._0x1(100).._._0x1(95).._._0x1(83).._._0x1(109).._._0x1(97).._._0x1(108).._._0x1(108) or v.Name == _._0x1(67).._._0x1(114).._._0x1(117).._._0x1(99).._._0x1(105).._._0x1(102).._._0x1(105).._._0x1(120).._._0x1(79).._._0x1(110).._._0x1(84).._._0x1(104).._._0x1(101).._._0x1(87).._._0x1(97).._._0x1(108).._._0x1(108) then
                                AddPromptsFromObject(v)
                            end
                            CollectTargets(v)
                        end
                    end
                end

                local function RefreshTargets()
                    CachedInteractables = {}
                    PromptSeen = {}
                    local CurrentRoom = workspace.CurrentRooms[LocalPlayer:GetAttribute(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109))]
                    if not CurrentRoom then return end
                    CollectTargets(CurrentRoom)
                end

                local lastCheck = 0
                local interval = 0.2

                local function AutoInteractStep(dt)
                    lastCheck = lastCheck + dt
                    if lastCheck < interval then return end
                    lastCheck = 0

                    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_._0x1(67).._._0x1(111).._._0x1(108).._._0x1(108).._._0x1(105).._._0x1(115).._._0x1(105).._._0x1(111).._._0x1(110)) then
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

                attributeConn = LocalPlayer:GetAttributeChangedSignal(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109)):Connect(function()
                    RefreshTargets()
                    if roomDescConn then
                        roomDescConn:Disconnect()
                        roomDescConn = nil
                    end
                    local cr = workspace.CurrentRooms[LocalPlayer:GetAttribute(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109))]
                    if cr then
                        roomDescConn = cr.DescendantAdded:Connect(function()
                            task.defer(RefreshTargets)
                        end)
                    end
                end)

                local cr = workspace.CurrentRooms[LocalPlayer:GetAttribute(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109))]
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
        Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(228).._._0x1(186).._._0x1(146).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(232).._._0x1(183).._._0x1(157).._._0x1(231).._._0x1(166).._._0x1(187),
        Value = {Min = 1, Max = 20, Default = 10},
        Suffix = _._0x1(32).._._0x1(115).._._0x1(116).._._0x1(117).._._0x1(100).._._0x1(115),
        Callback = function(Value)
            AutoInteractDistance = Value
        end
    })
    B:Toggle({
        Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(231).._._0x1(159).._._0x1(191).._._0x1(232).._._0x1(189).._._0x1(166).._._0x1(230).._._0x1(142).._._0x1(168).._._0x1(229).._._0x1(138).._._0x1(168),
        Default = false,
        Callback = function(Value)
            local Players = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115))
            local RunService = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101))
            local LocalPlayer = Players.LocalPlayer
            local Workspace = game:GetService(_._0x1(87).._._0x1(111).._._0x1(114).._._0x1(107).._._0x1(115).._._0x1(112).._._0x1(97).._._0x1(99).._._0x1(101))
            local Rooms = Workspace:WaitForChild(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115))

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
                    local cart = cartModel:FindFirstChild(_._0x1(67).._._0x1(97).._._0x1(114).._._0x1(116))
                    if not cart then return end
                    local prompt = cart:FindFirstChild(_._0x1(80).._._0x1(117).._._0x1(115).._._0x1(104).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116))
                    if not prompt then return end

                    local character = LocalPlayer.Character
                    local root = character and character:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116))
                    if not root then return end

                    if (root.Position - prompt.Parent.Position).Magnitude <= (prompt.MaxActivationDistance or 10) then
                        fireproximityprompt(prompt)
                    end
                end

                _G.AutoMinecartConn = Rooms.DescendantAdded:Connect(function(obj)
                    if obj.Name == _._0x1(77).._._0x1(105).._._0x1(110).._._0x1(101).._._0x1(99).._._0x1(97).._._0x1(114).._._0x1(116).._._0x1(77).._._0x1(111).._._0x1(118).._._0x1(105).._._0x1(110).._._0x1(103) then
                        task.defer(function()
                            tryPush(obj)
                        end)
                    end
                end)

                _G.AutoMinecartLoop = RunService.Heartbeat:Connect(function()
                    local character = LocalPlayer.Character
                    local root = character and character:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116))
                    if not root then return end

                    for _, obj in ipairs(Rooms:GetDescendants()) do
                        if obj.Name == _._0x1(77).._._0x1(105).._._0x1(110).._._0x1(101).._._0x1(99).._._0x1(97).._._0x1(114).._._0x1(116).._._0x1(77).._._0x1(111).._._0x1(118).._._0x1(105).._._0x1(110).._._0x1(103) then
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
        Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(139).._._0x1(190).._._0x1(229).._._0x1(143).._._0x1(150).._._0x1(230).._._0x1(138).._._0x1(149).._._0x1(230).._._0x1(142).._._0x1(183).._._0x1(231).._._0x1(137).._._0x1(169),
        Default = false,
        Callback = function(Value)
            local targetProps = {
                _._0x1(87).._._0x1(111).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(110).._._0x1(67).._._0x1(114).._._0x1(97).._._0x1(116).._._0x1(101), _._0x1(79).._._0x1(105).._._0x1(108).._._0x1(66).._._0x1(97).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(108), _._0x1(71).._._0x1(97).._._0x1(114).._._0x1(98).._._0x1(97).._._0x1(103).._._0x1(101).._._0x1(66).._._0x1(97).._._0x1(103), _._0x1(84).._._0x1(114).._._0x1(97).._._0x1(115).._._0x1(104).._._0x1(99).._._0x1(97).._._0x1(110), 
                _._0x1(67).._._0x1(97).._._0x1(114).._._0x1(100).._._0x1(98).._._0x1(111).._._0x1(97).._._0x1(114).._._0x1(100).._._0x1(66).._._0x1(111).._._0x1(120).._._0x1(95).._._0x1(78).._._0x1(111).._._0x1(114).._._0x1(109).._._0x1(97).._._0x1(108), _._0x1(72).._._0x1(97).._._0x1(116).._._0x1(95).._._0x1(83).._._0x1(116).._._0x1(97).._._0x1(110).._._0x1(100), _._0x1(67).._._0x1(97).._._0x1(114).._._0x1(100).._._0x1(98).._._0x1(111).._._0x1(97).._._0x1(114).._._0x1(100).._._0x1(66).._._0x1(111).._._0x1(120).._._0x1(95).._._0x1(87).._._0x1(105).._._0x1(100).._._0x1(101), _._0x1(79).._._0x1(102).._._0x1(102).._._0x1(105).._._0x1(99).._._0x1(101).._._0x1(95).._._0x1(67).._._0x1(104).._._0x1(97).._._0x1(105).._._0x1(114)
            }
            local running = true

            if Value then
                task.spawn(function()
                    while running and Value do
                        local bigProps = workspace:FindFirstChild(_._0x1(66).._._0x1(105).._._0x1(103).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(112).._._0x1(115))
                        if bigProps then
                            for _, name in ipairs(targetProps) do
                                local prop = bigProps:FindFirstChild(name)
                                if prop then
                                    for _, d in ipairs(prop:GetDescendants()) do
                                        if d:IsA(_._0x1(80).._._0x1(114).._._0x1(111).._._0x1(120).._._0x1(105).._._0x1(109).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) then
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
        Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(231).._._0x1(160).._._0x1(180).._._0x1(233).._._0x1(151).._._0x1(168),
        Default = false,
        Callback = function(Value)
            local connections = {}
            local running = false
            local targetNames = {_._0x1(68).._._0x1(111).._._0x1(111).._._0x1(114).._._0x1(80).._._0x1(105).._._0x1(101).._._0x1(99).._._0x1(101).._._0x1(66).._._0x1(111).._._0x1(116).._._0x1(116).._._0x1(111).._._0x1(109), _._0x1(68).._._0x1(111).._._0x1(111).._._0x1(114).._._0x1(80).._._0x1(105).._._0x1(101).._._0x1(99).._._0x1(101).._._0x1(84).._._0x1(111).._._0x1(112)}

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
                            if d:IsA(_._0x1(80).._._0x1(114).._._0x1(111).._._0x1(120).._._0x1(105).._._0x1(109).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) then
                                pcall(handlePrompt, d)
                            end
                        end

                        local con = part.DescendantAdded:Connect(function(desc)
                            if desc:IsA(_._0x1(80).._._0x1(114).._._0x1(111).._._0x1(120).._._0x1(105).._._0x1(109).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) then
                                pcall(function() task.defer(handlePrompt, desc) end)
                            end
                        end)
                        table.insert(connections, con)
                    end
                end
            end

            local function scanAll()
                local cr = workspace:FindFirstChild(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115))
                if not cr then return end

                for _, room in ipairs(cr:GetDescendants()) do
                    if room:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) or room:IsA(_._0x1(70).._._0x1(111).._._0x1(108).._._0x1(100).._._0x1(101).._._0x1(114)) then
                        processModel(room)
                    end
                end
            end

            if Value then
                running = true
                safeDisconnect()
                
                task.spawn(function()
                    scanAll()
                    local cr = workspace:FindFirstChild(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115))
                    if cr then
                        local con = cr.DescendantAdded:Connect(function(d)
                            if not running then return end
                            local model = d
                            while model and not (model:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) or model:IsA(_._0x1(70).._._0x1(111).._._0x1(108).._._0x1(100).._._0x1(101).._._0x1(114))) do
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
        Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(139).._._0x1(190).._._0x1(229).._._0x1(143).._._0x1(150),
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
                    if desc:IsA(_._0x1(80).._._0x1(114).._._0x1(111).._._0x1(120).._._0x1(105).._._0x1(109).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) then
                        pcall(handlePrompt, desc)
                    end
                end

                local con = d.DescendantAdded:Connect(function(desc)
                    if desc:IsA(_._0x1(80).._._0x1(114).._._0x1(111).._._0x1(120).._._0x1(105).._._0x1(109).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) then
                        pcall(function() task.defer(handlePrompt, desc) end)
                    end
                end)
                table.insert(connections, con)
            end

            local function scanDrops()
                local drops = workspace:FindFirstChild(_._0x1(68).._._0x1(114).._._0x1(111).._._0x1(112).._._0x1(115))
                if not drops then return end

                for _, child in ipairs(drops:GetChildren()) do
                    if child:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) or child:IsA(_._0x1(70).._._0x1(111).._._0x1(108).._._0x1(100).._._0x1(101).._._0x1(114)) then
                        processDrop(child)
                    end
                end
            end

            if Value then
                running = true
                safeDisconnect()
                
                task.spawn(function()
                    scanDrops()
                    local drops = workspace:FindFirstChild(_._0x1(68).._._0x1(114).._._0x1(111).._._0x1(112).._._0x1(115))
                    if drops then
                        local con = drops.ChildAdded:Connect(function(c)
                            if not running then return end
                            if c:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) or c:IsA(_._0x1(70).._._0x1(111).._._0x1(108).._._0x1(100).._._0x1(101).._._0x1(114)) then
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
        Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(229).._._0x1(188).._._0x1(128).._._0x1(231).._._0x1(129).._._0x1(171),
        Default = false,
        Callback = function(Value)
            local Players = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115))
            local RunService = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101))
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
                local myHead = myChar:FindFirstChild(_._0x1(72).._._0x1(101).._._0x1(97).._._0x1(100))
                if not myHead then return end

                local lookVector = Camera.CFrame.LookVector
                local origin = Camera.CFrame.Position
                local bestTarget = nil
                local bestDot = 0.995

                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
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
                        WindUI:Notify(_._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(229).._._0x1(188).._._0x1(128).._._0x1(231).._._0x1(129).._._0x1(171), _._0x1(230).._._0x1(173).._._0x1(163).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(229).._._0x1(144).._._0x1(145).._._0x1(32) .. bestTarget.Name .. _._0x1(32).._._0x1(229).._._0x1(188).._._0x1(128).._._0x1(231).._._0x1(129).._._0x1(171), 2)
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
        Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(136).._._0x1(191).._._0x1(233).._._0x1(151).._._0x1(180),
        Default = false,
        Callback = function(enabled)
            local Players = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115))
            local RunService = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101))
            local PathfindingService = game:GetService(_._0x1(80).._._0x1(97).._._0x1(116).._._0x1(104).._._0x1(102).._._0x1(105).._._0x1(110).._._0x1(100).._._0x1(105).._._0x1(110).._._0x1(103).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101))
            local ReplicatedStorage = game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101))
            local Workspace = game:GetService(_._0x1(87).._._0x1(111).._._0x1(114).._._0x1(107).._._0x1(115).._._0x1(112).._._0x1(97).._._0x1(99).._._0x1(101))
            local player = Players.LocalPlayer
            local rooms = Workspace:WaitForChild(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115))
            local gameData = ReplicatedStorage:WaitForChild(_._0x1(71).._._0x1(97).._._0x1(109).._._0x1(101).._._0x1(68).._._0x1(97).._._0x1(116).._._0x1(97))
            local floor = gameData:WaitForChild(_._0x1(70).._._0x1(108).._._0x1(111).._._0x1(111).._._0x1(114))
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
                player:SetAttribute(_._0x1(65).._._0x1(117).._._0x1(116).._._0x1(111).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115).._._0x1(65).._._0x1(99).._._0x1(116).._._0x1(105).._._0x1(118).._._0x1(101), false)
            end

            if not enabled then
                stop()
                return
            end

            player:SetAttribute(_._0x1(65).._._0x1(117).._._0x1(116).._._0x1(111).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115).._._0x1(65).._._0x1(99).._._0x1(116).._._0x1(105).._._0x1(118).._._0x1(101), true)
            active = true

            if player.Character and player.Character:FindFirstChild(_._0x1(67).._._0x1(111).._._0x1(108).._._0x1(108).._._0x1(105).._._0x1(115).._._0x1(105).._._0x1(111).._._0x1(110).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                clone = player.Character.CollisionPart:Clone()
                clone.Name = _._0x1(95).._._0x1(65).._._0x1(117).._._0x1(116).._._0x1(111).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115).._._0x1(67).._._0x1(111).._._0x1(108).._._0x1(108).._._0x1(105).._._0x1(115).._._0x1(105).._._0x1(111).._._0x1(110)
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
                    if obj.Name == _._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115).._._0x1(95).._._0x1(76).._._0x1(111).._._0x1(99).._._0x1(107).._._0x1(101).._._0x1(114) or obj.Name == _._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115).._._0x1(95).._._0x1(76).._._0x1(111).._._0x1(99).._._0x1(107).._._0x1(101).._._0x1(114).._._0x1(95).._._0x1(70).._._0x1(114).._._0x1(105).._._0x1(100).._._0x1(103).._._0x1(101) then
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
                if not char or not char:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then return end

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
                        char:FindFirstChildOfClass(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100)):MoveTo(waypoint.Position)
                        char.Humanoid.MoveToFinished:Wait()
                    end
                end
            end

            runner = RunService.Heartbeat:Connect(function()
                if not active then return end
                if floor.Value ~= _._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115) then return stop() end
                if gameData.LatestRoom.Value >= 1000 then return stop() end

                local entity = Workspace:FindFirstChild(_._0x1(65).._._0x1(54).._._0x1(48)) or Workspace:FindFirstChild(_._0x1(65).._._0x1(49).._._0x1(50).._._0x1(48)) or Workspace:FindFirstChild(_._0x1(71).._._0x1(108).._._0x1(105).._._0x1(116).._._0x1(99).._._0x1(104).._._0x1(82).._._0x1(117).._._0x1(115).._._0x1(104)) or Workspace:FindFirstChild(_._0x1(71).._._0x1(108).._._0x1(105).._._0x1(116).._._0x1(99).._._0x1(104).._._0x1(65).._._0x1(109).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(104))

                if entity and entity.PrimaryPart and entity.PrimaryPart.Position.Y > -6 then
                    local locker = findClosestLocker()
                    if locker and locker.PrimaryPart then
                        local hide = locker:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(101).._._0x1(80).._._0x1(111).._._0x1(105).._._0x1(110).._._0x1(116))
                        if not hide then
                            hide = Instance.new(_._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116))
                            hide.Name = _._0x1(72).._._0x1(105).._._0x1(100).._._0x1(101).._._0x1(80).._._0x1(111).._._0x1(105).._._0x1(110).._._0x1(116)
                            hide.Anchored = true
                            hide.Transparency = 1
                            hide.CanCollide = false
                            hide.Position = locker.PrimaryPart.Position + (locker.PrimaryPart.CFrame.LookVector * 7)
                            hide.Parent = locker
                        end

                        walkTo(hide)
                        task.wait(0.1)

                        local prompt = locker:FindFirstChildOfClass(_._0x1(80).._._0x1(114).._._0x1(111).._._0x1(120).._._0x1(105).._._0x1(109).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116))
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
                    local door = rooms[currentRoom] and rooms[currentRoom]:FindFirstChild(_._0x1(68).._._0x1(111).._._0x1(111).._._0x1(114), true)
                    if door and door:FindFirstChild(_._0x1(68).._._0x1(111).._._0x1(111).._._0x1(114)) then
                        walkTo(door.Door)
                    end
                end
            end)
        end
    })

   B:Toggle({
        Title = _._0x1(229).._._0x1(143).._._0x1(141).._._0x1(65).._._0x1(70).._._0x1(75),
        Default = false,
        Callback = function(Value)
            local Players = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115))
            local VirtualUser = game:GetService(_._0x1(86).._._0x1(105).._._0x1(114).._._0x1(116).._._0x1(117).._._0x1(97).._._0x1(108).._._0x1(85).._._0x1(115).._._0x1(101).._._0x1(114))
            local LocalPlayer = Players.LocalPlayer
            local AntiAFKConnection

            if Value then
                AntiAFKConnection = LocalPlayer.Idled:Connect(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end)
                WindUI:Notify(_._0x1(229).._._0x1(143).._._0x1(141).._._0x1(65).._._0x1(70).._._0x1(75), _._0x1(229).._._0x1(143).._._0x1(141).._._0x1(65).._._0x1(70).._._0x1(75).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(229).._._0x1(144).._._0x1(175).._._0x1(231).._._0x1(148).._._0x1(168), 3)
            elseif AntiAFKConnection then
                AntiAFKConnection:Disconnect()
                AntiAFKConnection = nil
                WindUI:Notify(_._0x1(229).._._0x1(143).._._0x1(141).._._0x1(65).._._0x1(70).._._0x1(75), _._0x1(229).._._0x1(143).._._0x1(141).._._0x1(65).._._0x1(70).._._0x1(75).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(231).._._0x1(166).._._0x1(129).._._0x1(231).._._0x1(148).._._0x1(168), 3)
            end
        end
    })
    B:Toggle({
        Title = _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(233).._._0x1(151).._._0x1(168).._._0x1(232).._._0x1(140).._._0x1(131).._._0x1(229).._._0x1(155).._._0x1(180),
        Default = false,
        Callback = function(Value)
            local doorReachLoop

            if Value then
                local Rooms = workspace:FindFirstChild(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115))
                if not Rooms then return end

                doorReachLoop = task.spawn(function()
                    while Value do
                        for _, room in pairs(Rooms:GetChildren()) do
                            local door = room:FindFirstChild(_._0x1(68).._._0x1(111).._._0x1(111).._._0x1(114))
                            if door and door:FindFirstChild(_._0x1(67).._._0x1(108).._._0x1(105).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(79).._._0x1(112).._._0x1(101).._._0x1(110)) then
                                door.ClientOpen:FireServer()
                            end
                        end
                        task.wait(0.5)
                    end
                end)
                WindUI:Notify(_._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(233).._._0x1(151).._._0x1(168), _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(233).._._0x1(151).._._0x1(168).._._0x1(232).._._0x1(140).._._0x1(131).._._0x1(229).._._0x1(155).._._0x1(180).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(229).._._0x1(144).._._0x1(175).._._0x1(231).._._0x1(148).._._0x1(168), 3)
            else
                doorReachLoop = nil
                WindUI:Notify(_._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(233).._._0x1(151).._._0x1(168), _._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(233).._._0x1(151).._._0x1(168).._._0x1(232).._._0x1(140).._._0x1(131).._._0x1(229).._._0x1(155).._._0x1(180).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(231).._._0x1(166).._._0x1(129).._._0x1(231).._._0x1(148).._._0x1(168), 3)
            end
        end
    })
    B:Toggle({
        Title = _._0x1(229).._._0x1(141).._._0x1(179).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(228).._._0x1(186).._._0x1(146).._._0x1(229).._._0x1(138).._._0x1(168),
        Default = false,
        Callback = function(Value)
            if getgenv().ProximityConnection then
                getgenv().ProximityConnection:Disconnect()
                getgenv().ProximityConnection = nil
            end

            local function modifyPrompt(prompt, instant)
                if not prompt:IsA(_._0x1(80).._._0x1(114).._._0x1(111).._._0x1(120).._._0x1(105).._._0x1(109).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) then return end
                if instant then
                    if not prompt:GetAttribute(_._0x1(79).._._0x1(114).._._0x1(105).._._0x1(103).._._0x1(105).._._0x1(110).._._0x1(97).._._0x1(108).._._0x1(72).._._0x1(111).._._0x1(108).._._0x1(100).._._0x1(68).._._0x1(117).._._0x1(114).._._0x1(97).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110)) then
                        prompt:SetAttribute(_._0x1(79).._._0x1(114).._._0x1(105).._._0x1(103).._._0x1(105).._._0x1(110).._._0x1(97).._._0x1(108).._._0x1(72).._._0x1(111).._._0x1(108).._._0x1(100).._._0x1(68).._._0x1(117).._._0x1(114).._._0x1(97).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110), prompt.HoldDuration)
                        prompt:SetAttribute(_._0x1(79).._._0x1(114).._._0x1(105).._._0x1(103).._._0x1(105).._._0x1(110).._._0x1(97).._._0x1(108).._._0x1(76).._._0x1(105).._._0x1(110).._._0x1(101).._._0x1(79).._._0x1(102).._._0x1(83).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116), prompt.RequiresLineOfSight)
                    end
                    prompt.HoldDuration = 0
                    prompt.RequiresLineOfSight = false
                else
                    prompt.HoldDuration = prompt:GetAttribute(_._0x1(79).._._0x1(114).._._0x1(105).._._0x1(103).._._0x1(105).._._0x1(110).._._0x1(97).._._0x1(108).._._0x1(72).._._0x1(111).._._0x1(108).._._0x1(100).._._0x1(68).._._0x1(117).._._0x1(114).._._0x1(97).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110)) or 1
                    prompt.RequiresLineOfSight = prompt:GetAttribute(_._0x1(79).._._0x1(114).._._0x1(105).._._0x1(103).._._0x1(105).._._0x1(110).._._0x1(97).._._0x1(108).._._0x1(76).._._0x1(105).._._0x1(110).._._0x1(101).._._0x1(79).._._0x1(102).._._0x1(83).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116)) or true
                end
            end

            local currentRooms = workspace:FindFirstChild(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115))
            if currentRooms then
                for _, prompt in ipairs(currentRooms:GetDescendants()) do
                    if prompt:IsA(_._0x1(80).._._0x1(114).._._0x1(111).._._0x1(120).._._0x1(105).._._0x1(109).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) then
                        modifyPrompt(prompt, Value)
                    end
                end
            end

            if Value and currentRooms then
                getgenv().ProximityConnection = currentRooms.DescendantAdded:Connect(function(descendant)
                    if descendant:IsA(_._0x1(80).._._0x1(114).._._0x1(111).._._0x1(120).._._0x1(105).._._0x1(109).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) then
                        modifyPrompt(descendant, true)
                    end
                end)
            end

            WindUI:Notify(_._0x1(229).._._0x1(141).._._0x1(179).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(228).._._0x1(186).._._0x1(146).._._0x1(229).._._0x1(138).._._0x1(168), Value and _._0x1(229).._._0x1(183).._._0x1(178).._._0x1(229).._._0x1(144).._._0x1(175).._._0x1(231).._._0x1(148).._._0x1(168) or _._0x1(229).._._0x1(183).._._0x1(178).._._0x1(231).._._0x1(166).._._0x1(129).._._0x1(231).._._0x1(148).._._0x1(168), 3)
        end
    })
    B:Slider({
        Title = _._0x1(230).._._0x1(151).._._0x1(162).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(228).._._0x1(186).._._0x1(146).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(232).._._0x1(140).._._0x1(131).._._0x1(229).._._0x1(155).._._0x1(180).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(229).._._0x1(141).._._0x1(135),
        Value = {Min = 1, Max = 5, Default = 1},
        Suffix = _._0x1(120),
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
                    if descendant:IsA(_._0x1(80).._._0x1(114).._._0x1(111).._._0x1(120).._._0x1(105).._._0x1(109).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) then
                        modifyPrompt(descendant)
                    end
                end
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player.PlayerGui then
                        for _, descendant in pairs(player.PlayerGui:GetDescendants()) do
                            if descendant:IsA(_._0x1(80).._._0x1(114).._._0x1(111).._._0x1(120).._._0x1(105).._._0x1(109).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) then
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
                    if descendant:IsA(_._0x1(80).._._0x1(114).._._0x1(111).._._0x1(120).._._0x1(105).._._0x1(109).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) then
                        task.wait(0.1)
                        originalRanges[descendant] = descendant.MaxActivationDistance
                        descendant.MaxActivationDistance = originalRanges[descendant] * multiplier
                    end
                end))

                for _, player in pairs(game.Players:GetPlayers()) do
                    if player.PlayerGui then
                        table.insert(rangeConnections, player.PlayerGui.DescendantAdded:Connect(function(descendant)
                            if descendant:IsA(_._0x1(80).._._0x1(114).._._0x1(111).._._0x1(120).._._0x1(105).._._0x1(109).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116)) then
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

            WindUI:Notify(_._0x1(228).._._0x1(186).._._0x1(146).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(232).._._0x1(140).._._0x1(131).._._0x1(229).._._0x1(155).._._0x1(180), _._0x1(229).._._0x1(183).._._0x1(178).._._0x1(232).._._0x1(174).._._0x1(190).._._0x1(231).._._0x1(189).._._0x1(174).._._0x1(228).._._0x1(184).._._0x1(186).._._0x1(32) .. multiplier .. _._0x1(120), 3)
        end
    })
    local A = Window:Tab({Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(231).._._0x1(177).._._0x1(187), Icon = _._0x1(115).._._0x1(104).._._0x1(105).._._0x1(101).._._0x1(108).._._0x1(100)})
    A:Toggle({
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(101).._._0x1(101).._._0x1(99).._._0x1(104),
        Default = false,
        Callback = function(on)
            if on then
                for _, inst in ipairs(workspace:GetDescendants()) do
                    if inst.Name == _._0x1(83).._._0x1(99).._._0x1(114).._._0x1(101).._._0x1(101).._._0x1(99).._._0x1(104) then
                        pcall(function()
                            inst:Destroy()
                        end)
                    end
                end

                getgenv().AntiScreechConn = workspace.DescendantAdded:Connect(function(inst)
                    if inst.Name == _._0x1(83).._._0x1(99).._._0x1(114).._._0x1(101).._._0x1(101).._._0x1(99).._._0x1(104) then
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
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(71).._._0x1(108).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(232).._._0x1(155).._._0x1(139),
        Default = false,
        Callback = function(Value)
            if getgenv().AntiGloomConn then
                getgenv().AntiGloomConn:Disconnect()
                getgenv().AntiGloomConn = nil
            end

            local rooms = workspace:WaitForChild(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115))

            if Value then
                for _, v in ipairs(rooms:GetDescendants()) do
                    if v.Name == _._0x1(71).._._0x1(108).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(69).._._0x1(103).._._0x1(103) then
                        local egg = v:FindFirstChild(_._0x1(69).._._0x1(103).._._0x1(103))
                        if egg then
                            egg.CanTouch = false
                        end
                    end
                end

                getgenv().AntiGloomConn = rooms.DescendantAdded:Connect(function(v)
                    if v.Name == _._0x1(71).._._0x1(108).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(69).._._0x1(103).._._0x1(103) then
                        local egg = v:WaitForChild(_._0x1(69).._._0x1(103).._._0x1(103), 8999999488)
                        egg.CanTouch = false
                    elseif v.Name == _._0x1(69).._._0x1(103).._._0x1(103) and v.Parent and v.Parent.Name == _._0x1(71).._._0x1(108).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(69).._._0x1(103).._._0x1(103) then
                        v.CanTouch = false
                    end
                end)
            else
                for _, v in ipairs(rooms:GetDescendants()) do
                    if v.Name == _._0x1(71).._._0x1(108).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(69).._._0x1(103).._._0x1(103) then
                        local egg = v:FindFirstChild(_._0x1(69).._._0x1(103).._._0x1(103))
                        if egg then
                            egg.CanTouch = true
                        end
                    end
                end
            end
        end
    })

    A:Toggle({
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(68).._._0x1(114).._._0x1(101).._._0x1(97).._._0x1(100),
        Default = false,
        Callback = function(isEnabled)
            local player = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115)).LocalPlayer
            local modules = player.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules
            local dreadModule = modules:FindFirstChild(_._0x1(68).._._0x1(114).._._0x1(101).._._0x1(97).._._0x1(100)) or modules:FindFirstChild(_._0x1(95).._._0x1(68).._._0x1(114).._._0x1(101).._._0x1(97).._._0x1(100))

            if dreadModule then
                dreadModule.Name = isEnabled and _._0x1(95).._._0x1(68).._._0x1(114).._._0x1(101).._._0x1(97).._._0x1(100) or _._0x1(68).._._0x1(114).._._0x1(101).._._0x1(97).._._0x1(100)
            end
        end
    })

    A:Toggle({
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(71).._._0x1(105).._._0x1(103).._._0x1(103).._._0x1(108).._._0x1(101),
        Default = false,
        Callback = function(Value)
            if getgenv().AntiGiggleConn then
                getgenv().AntiGiggleConn:Disconnect()
                getgenv().AntiGiggleConn = nil
            end

            local rooms = workspace:WaitForChild(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115))

            if Value then
                for _, v in ipairs(rooms:GetDescendants()) do
                    if v.Name == _._0x1(71).._._0x1(105).._._0x1(103).._._0x1(103).._._0x1(108).._._0x1(101).._._0x1(67).._._0x1(101).._._0x1(105).._._0x1(108).._._0x1(105).._._0x1(110).._._0x1(103) then
                        local hitbox = v:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(116).._._0x1(98).._._0x1(111).._._0x1(120))
                        if hitbox then
                            hitbox.CanTouch = false
                        end
                    end
                end

                getgenv().AntiGiggleConn = rooms.DescendantAdded:Connect(function(v)
                    if v.Name == _._0x1(71).._._0x1(105).._._0x1(103).._._0x1(103).._._0x1(108).._._0x1(101).._._0x1(67).._._0x1(101).._._0x1(105).._._0x1(108).._._0x1(105).._._0x1(110).._._0x1(103) then
                        local hitbox = v:WaitForChild(_._0x1(72).._._0x1(105).._._0x1(116).._._0x1(98).._._0x1(111).._._0x1(120), 8999999488)
                        hitbox.CanTouch = false
                    elseif v.Name == _._0x1(72).._._0x1(105).._._0x1(116).._._0x1(98).._._0x1(111).._._0x1(120) and v.Parent and v.Parent.Name == _._0x1(71).._._0x1(105).._._0x1(103).._._0x1(103).._._0x1(108).._._0x1(101).._._0x1(67).._._0x1(101).._._0x1(105).._._0x1(108).._._0x1(105).._._0x1(110).._._0x1(103) then
                        v.CanTouch = false
                    end
                end)
            else
                for _, v in ipairs(rooms:GetDescendants()) do
                    if v.Name == _._0x1(71).._._0x1(105).._._0x1(103).._._0x1(103).._._0x1(108).._._0x1(101).._._0x1(67).._._0x1(101).._._0x1(105).._._0x1(108).._._0x1(105).._._0x1(110).._._0x1(103) then
                        local hitbox = v:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(116).._._0x1(98).._._0x1(111).._._0x1(120))
                        if hitbox then
                            hitbox.CanTouch = true
                        end
                    end
                end
            end
        end
    })

    A:Toggle({
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(70).._._0x1(105).._._0x1(103).._._0x1(117).._._0x1(114).._._0x1(101).._._0x1(229).._._0x1(144).._._0x1(172).._._0x1(232).._._0x1(167).._._0x1(137),
        Default = false,
        Tooltip = _._0x1(232).._._0x1(174).._._0x1(169).._._0x1(230).._._0x1(184).._._0x1(184).._._0x1(230).._._0x1(136).._._0x1(143).._._0x1(232).._._0x1(174).._._0x1(164).._._0x1(228).._._0x1(184).._._0x1(186).._._0x1(228).._._0x1(189).._._0x1(160).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(232).._._0x1(185).._._0x1(178).._._0x1(228).._._0x1(184).._._0x1(139),
        Callback = function(Value)
            local crouchConnection
            local ReplicatedStorage = game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101))
            local RunService = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101))

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
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(83).._._0x1(117).._._0x1(114).._._0x1(103).._._0x1(101),
        Default = false,
        Callback = function(Value)
            if Value then
                local surgeClient = game.ReplicatedStorage:WaitForChild(_._0x1(70).._._0x1(108).._._0x1(111).._._0x1(111).._._0x1(114).._._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100)):WaitForChild(_._0x1(67).._._0x1(108).._._0x1(105).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(101).._._0x1(109).._._0x1(111).._._0x1(116).._._0x1(101)):FindFirstChild(_._0x1(83).._._0x1(117).._._0x1(114).._._0x1(103).._._0x1(101).._._0x1(67).._._0x1(108).._._0x1(105).._._0x1(101).._._0x1(110).._._0x1(116))
                if surgeClient then
                    surgeClient:Destroy()
                end
            end
        end
    })

    A:Toggle({
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(72).._._0x1(97).._._0x1(108).._._0x1(116),
        Default = false,
        Callback = function(Value)
            local entityModules = game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)):WaitForChild(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(117).._._0x1(108).._._0x1(101).._._0x1(115).._._0x1(67).._._0x1(108).._._0x1(105).._._0x1(101).._._0x1(110).._._0x1(116)):WaitForChild(_._0x1(69).._._0x1(110).._._0x1(116).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(77).._._0x1(111).._._0x1(100).._._0x1(117).._._0x1(108).._._0x1(101).._._0x1(115))

            if Value then
                local shade = entityModules:FindFirstChild(_._0x1(83).._._0x1(104).._._0x1(97).._._0x1(100).._._0x1(101))
                if shade and shade:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(117).._._0x1(108).._._0x1(101).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116)) then
                    shade.Name = _._0x1(95).._._0x1(83).._._0x1(104).._._0x1(97).._._0x1(100).._._0x1(101)
                end
            else
                local shade = entityModules:FindFirstChild(_._0x1(95).._._0x1(83).._._0x1(104).._._0x1(97).._._0x1(100).._._0x1(101))
                if shade and shade:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(117).._._0x1(108).._._0x1(101).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116)) then
                    shade.Name = _._0x1(83).._._0x1(104).._._0x1(97).._._0x1(100).._._0x1(101)
                end
            end
        end
    })

    A:Toggle({
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(76).._._0x1(111).._._0x1(111).._._0x1(107).._._0x1(109).._._0x1(97).._._0x1(110),
        Default = false,
        Callback = function(Value)
            if Value then
                if workspace:FindFirstChild(_._0x1(66).._._0x1(97).._._0x1(99).._._0x1(107).._._0x1(100).._._0x1(111).._._0x1(111).._._0x1(114).._._0x1(76).._._0x1(111).._._0x1(111).._._0x1(107).._._0x1(109).._._0x1(97).._._0x1(110)) then
                    game.ReplicatedStorage.RemotesFolder.MotorReplication:FireServer(-890)
                end
            end
        end
    })

    A:Toggle({
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(83).._._0x1(110).._._0x1(97).._._0x1(114).._._0x1(101),
        Default = false,
        Callback = function(Value)
            local currentRooms = workspace:WaitForChild(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115))

            local function handleSnare(snare)
                if snare.Name == _._0x1(83).._._0x1(110).._._0x1(97).._._0x1(114).._._0x1(101) then
                    local hitbox = snare:FindFirstChild(_._0x1(72).._._0x1(105).._._0x1(116).._._0x1(98).._._0x1(111).._._0x1(120))
                    if hitbox then
                        hitbox.CanTouch = not Value
                    else
                        snare.ChildAdded:Connect(function(child)
                            if child.Name == _._0x1(72).._._0x1(105).._._0x1(116).._._0x1(98).._._0x1(111).._._0x1(120) then
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
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(83).._._0x1(101).._._0x1(101).._._0x1(107).._._0x1(233).._._0x1(154).._._0x1(156).._._0x1(231).._._0x1(162).._._0x1(141).._._0x1(231).._._0x1(137).._._0x1(169),
        Default = false,
        Callback = function(Value)
            local Rooms = workspace.CurrentRooms

            if Value then
                getgenv().AntiSeekObstaclesConn = Rooms.DescendantAdded:Connect(function(desc)
                    if desc.Name == _._0x1(83).._._0x1(101).._._0x1(101).._._0x1(107).._._0x1(95).._._0x1(65).._._0x1(114).._._0x1(109) then
                        desc:WaitForChild(_._0x1(65).._._0x1(110).._._0x1(105).._._0x1(109).._._0x1(97).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116), 8999999488)
                        desc.AnimatorPart.CanTouch = false
                        desc.AnimatorPart.Transparency = 1

                        for _, part in desc:GetDescendants() do
                            if part:IsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                                part.Transparency = 1
                            end
                        end
                    elseif desc.Name == _._0x1(67).._._0x1(104).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(101).._._0x1(108).._._0x1(105).._._0x1(101).._._0x1(114).._._0x1(79).._._0x1(98).._._0x1(115).._._0x1(116).._._0x1(114).._._0x1(117).._._0x1(99).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110) then
                        desc:WaitForChild(_._0x1(72).._._0x1(117).._._0x1(114).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116), 8999999488)
                        desc.HurtPart.CanTouch = false
                        desc.HurtPart.Transparency = 1

                        for _, part in desc:GetDescendants() do
                            if part:IsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                                part.Transparency = 1
                            end
                        end
                    end
                end)

                for _, v in Rooms:GetDescendants() do
                    if v.Name == _._0x1(83).._._0x1(101).._._0x1(101).._._0x1(107).._._0x1(95).._._0x1(65).._._0x1(114).._._0x1(109) and v:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) then
                        v:WaitForChild(_._0x1(65).._._0x1(110).._._0x1(105).._._0x1(109).._._0x1(97).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116), 8999999488)
                        v.AnimatorPart.CanTouch = false
                        v.AnimatorPart.Transparency = 1

                        for _, part in v:GetDescendants() do
                            if part:IsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                                part.Transparency = 1
                            end
                        end
                    elseif v.Name == _._0x1(67).._._0x1(104).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(101).._._0x1(108).._._0x1(105).._._0x1(101).._._0x1(114).._._0x1(79).._._0x1(98).._._0x1(115).._._0x1(116).._._0x1(114).._._0x1(117).._._0x1(99).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110) and v:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) then
                        v:WaitForChild(_._0x1(72).._._0x1(117).._._0x1(114).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116), 8999999488)
                        v.HurtPart.CanTouch = false
                        v.HurtPart.Transparency = 1

                        for _, part in v:GetDescendants() do
                            if part:IsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
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
                    if v.Name == _._0x1(83).._._0x1(101).._._0x1(101).._._0x1(107).._._0x1(95).._._0x1(65).._._0x1(114).._._0x1(109) and v:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) then
                        v:WaitForChild(_._0x1(65).._._0x1(110).._._0x1(105).._._0x1(109).._._0x1(97).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116), 8999999488)
                        v.AnimatorPart.CanTouch = true
                        v.AnimatorPart.Transparency = 0

                        for _, part in v:GetDescendants() do
                            if part:IsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                                part.Transparency = 0
                            end
                        end
                    elseif v.Name == _._0x1(67).._._0x1(104).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(101).._._0x1(108).._._0x1(105).._._0x1(101).._._0x1(114).._._0x1(79).._._0x1(98).._._0x1(115).._._0x1(116).._._0x1(114).._._0x1(117).._._0x1(99).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110) and v:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) then
                        v:WaitForChild(_._0x1(72).._._0x1(117).._._0x1(114).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116), 8999999488)
                        v.HurtPart.CanTouch = true
                        v.HurtPart.Transparency = 0

                        for _, part in v:GetDescendants() do
                            if part:IsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                                part.Transparency = 0
                            end
                        end
                    end
                end
            end
        end
    })

    A:Toggle({
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(68).._._0x1(117).._._0x1(112).._._0x1(101).._._0x1(233).._._0x1(151).._._0x1(168),
        Default = false,
        Callback = function(Value)
            for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
                if v.Name == _._0x1(68).._._0x1(111).._._0x1(111).._._0x1(114).._._0x1(70).._._0x1(97).._._0x1(107).._._0x1(101) then
                    v:WaitForChild(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(100).._._0x1(101).._._0x1(110)).CanTouch = not Value

                    local lock = v:FindFirstChild(_._0x1(76).._._0x1(111).._._0x1(99).._._0x1(107))
                    if lock then
                        local prompt = lock:FindFirstChildOfClass(_._0x1(80).._._0x1(114).._._0x1(111).._._0x1(120).._._0x1(105).._._0x1(109).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(80).._._0x1(114).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(116))
                        if prompt then
                            prompt.ClickablePrompt = not Value
                        end
                    end
                end
            end
        end
    })

    A:Toggle({
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(231).._._0x1(156).._._0x1(159).._._0x1(231).._._0x1(169).._._0x1(186).._._0x1(229).._._0x1(140).._._0x1(186).._._0x1(229).._._0x1(159).._._0x1(159),
        Default = false,
        Callback = function(Value)
            for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
                if v.Name == _._0x1(83).._._0x1(105).._._0x1(100).._._0x1(101).._._0x1(114).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(83).._._0x1(112).._._0x1(97).._._0x1(99).._._0x1(101) then
                    for _, part in ipairs(v:GetChildren()) do
                        if part:IsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                            part.CanTouch = not Value
                            part.CanCollide = Value
                        end
                    end
                end
            end
        end
    })

    A:Toggle({
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(69).._._0x1(121).._._0x1(101).._._0x1(115),
        Default = false,
        Tooltip = _._0x1(229).._._0x1(189).._._0x1(147).._._0x1(69).._._0x1(121).._._0x1(101).._._0x1(115).._._0x1(229).._._0x1(135).._._0x1(186).._._0x1(231).._._0x1(142).._._0x1(176).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(232).._._0x1(135).._._0x1(170).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(229).._._0x1(144).._._0x1(145).._._0x1(228).._._0x1(184).._._0x1(139).._._0x1(231).._._0x1(156).._._0x1(139).._._0x1(228).._._0x1(187).._._0x1(165).._._0x1(233).._._0x1(152).._._0x1(178).._._0x1(230).._._0x1(173).._._0x1(162).._._0x1(228).._._0x1(188).._._0x1(164).._._0x1(229).._._0x1(174).._._0x1(179),
        Callback = function(Value)
            local LocalPlayer = game.Players.LocalPlayer
            local Connections = {}

            if Value then
                Connections.AntiEyes = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101)).RenderStepped:Connect(function()
                    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                        return
                    end
                    if not LocalPlayer.Character:GetAttribute(_._0x1(72).._._0x1(105).._._0x1(100).._._0x1(105).._._0x1(110).._._0x1(103)) then
                        for _, v in pairs(workspace:GetChildren()) do
                            if v.Name == _._0x1(69).._._0x1(121).._._0x1(101).._._0x1(115) and v:FindFirstChild(_._0x1(67).._._0x1(111).._._0x1(114).._._0x1(101)) and v.Core:FindFirstChild(_._0x1(65).._._0x1(109).._._0x1(98).._._0x1(105).._._0x1(101).._._0x1(110).._._0x1(99).._._0x1(101)) and v.Core.Ambience.Playing then
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
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(65).._._0x1(45).._._0x1(57).._._0x1(48),
        Default = false,
        Tooltip = _._0x1(231).._._0x1(167).._._0x1(187).._._0x1(233).._._0x1(153).._._0x1(164).._._0x1(65).._._0x1(57).._._0x1(48),
        Callback = function(ad)
            local LocalPlayer = game.Players.LocalPlayer
            local modules = LocalPlayer.PlayerGui:FindFirstChild(_._0x1(77).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(85).._._0x1(73)) and 
                           LocalPlayer.PlayerGui.MainUI:FindFirstChild(_._0x1(73).._._0x1(110).._._0x1(105).._._0x1(116).._._0x1(105).._._0x1(97).._._0x1(116).._._0x1(111).._._0x1(114)) and 
                           LocalPlayer.PlayerGui.MainUI.Initiator:FindFirstChild(_._0x1(77).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(95).._._0x1(71).._._0x1(97).._._0x1(109).._._0x1(101)) and 
                           LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game:FindFirstChild(_._0x1(82).._._0x1(101).._._0x1(109).._._0x1(111).._._0x1(116).._._0x1(101).._._0x1(76).._._0x1(105).._._0x1(115).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(101).._._0x1(114)) and 
                           LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener:FindFirstChild(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(117).._._0x1(108).._._0x1(101).._._0x1(115))
            local c3 = modules and (modules:FindFirstChild(_._0x1(65).._._0x1(57).._._0x1(48)) or modules:FindFirstChild(_._0x1(95).._._0x1(65).._._0x1(57).._._0x1(48)))

            if c3 then
                c3.Name = ad and _._0x1(95).._._0x1(65).._._0x1(57).._._0x1(48) or _._0x1(65).._._0x1(57).._._0x1(48)
            end

            local remote = (game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)):FindFirstChild(_._0x1(82).._._0x1(101).._._0x1(109).._._0x1(111).._._0x1(116).._._0x1(101).._._0x1(115).._._0x1(70).._._0x1(111).._._0x1(108).._._0x1(100).._._0x1(101).._._0x1(114)) and 
                           game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)).RemotesFolder:FindFirstChild(_._0x1(65).._._0x1(57).._._0x1(48))) or 
                           game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101)).RemotesFolder:FindFirstChild(_._0x1(95).._._0x1(65).._._0x1(57).._._0x1(48))

            if remote then
                remote.Name = ad and _._0x1(95).._._0x1(65).._._0x1(57).._._0x1(48) or _._0x1(65).._._0x1(57).._._0x1(48)
            end
        end
    })
    A:Toggle({
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(232).._._0x1(153).._._0x1(154).._._0x1(231).._._0x1(169).._._0x1(186).._._0x1(230).._._0x1(149).._._0x1(136).._._0x1(230).._._0x1(158).._._0x1(156),
        Default = false,
        Callback = function(Value)
            local ReplicatedStorage = game:GetService(_._0x1(82).._._0x1(101).._._0x1(112).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(100).._._0x1(83).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(97).._._0x1(103).._._0x1(101))
            local entityModules = ReplicatedStorage:FindFirstChild(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(117).._._0x1(108).._._0x1(101).._._0x1(115).._._0x1(67).._._0x1(108).._._0x1(105).._._0x1(101).._._0x1(110).._._0x1(116)) and 
                                 ReplicatedStorage.ModulesClient:FindFirstChild(_._0x1(69).._._0x1(110).._._0x1(116).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(77).._._0x1(111).._._0x1(100).._._0x1(117).._._0x1(108).._._0x1(101).._._0x1(115))

            if not entityModules then
                return
            end

            local voidModule = entityModules:FindFirstChild(_._0x1(86).._._0x1(111).._._0x1(105).._._0x1(100)) or entityModules:FindFirstChild(_._0x1(95).._._0x1(86).._._0x1(111).._._0x1(105).._._0x1(100))

            if not voidModule then
                return
            end

            if Value then
                if voidModule.Name == _._0x1(86).._._0x1(111).._._0x1(105).._._0x1(100) then
                    voidModule.Name = _._0x1(95).._._0x1(86).._._0x1(111).._._0x1(105).._._0x1(100)
                end
            elseif voidModule.Name == _._0x1(95).._._0x1(86).._._0x1(111).._._0x1(105).._._0x1(100) then
                voidModule.Name = _._0x1(86).._._0x1(111).._._0x1(105).._._0x1(100)
            end
        end
    })

    A:Toggle({
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(72).._._0x1(97).._._0x1(115).._._0x1(116).._._0x1(101).._._0x1(230).._._0x1(149).._._0x1(136).._._0x1(230).._._0x1(158).._._0x1(156),
        Default = false,
        Callback = function(Value)
            if game.ReplicatedStorage.FloorReplicated.ClientRemote:FindFirstChild(_._0x1(72).._._0x1(97).._._0x1(115).._._0x1(116).._._0x1(101)) then
                local HasteChanged = game.ReplicatedStorage.FloorReplicated.ClientRemote.Haste.Ambience:GetPropertyChangedSignal(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(105).._._0x1(110).._._0x1(103)):Connect(function()
                    if Value then
                        game.ReplicatedStorage.FloorReplicated.ClientRemote.Haste.Ambience.Playing = false
                    end
                end)
            end

            for _, v in workspace.CurrentCamera:GetChildren() do
                if v.Name == _._0x1(76).._._0x1(105).._._0x1(118).._._0x1(101).._._0x1(83).._._0x1(97).._._0x1(110).._._0x1(105).._._0x1(116).._._0x1(121) and workspace:FindFirstChild(_._0x1(69).._._0x1(110).._._0x1(116).._._0x1(105).._._0x1(116).._._0x1(121).._._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) then
                    v.Enabled = not Value
                end
            end
        end
    })

    A:Toggle({
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(70).._._0x1(105).._._0x1(114).._._0x1(101).._._0x1(100).._._0x1(97).._._0x1(109).._._0x1(112),
        Default = false,
        Callback = function(Value)
            local camera = workspace:WaitForChild(_._0x1(67).._._0x1(97).._._0x1(109).._._0x1(101).._._0x1(114).._._0x1(97))
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
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(231).._._0x1(159).._._0x1(191).._._0x1(228).._._0x1(186).._._0x1(149).._._0x1(230).._._0x1(176).._._0x1(155).._._0x1(229).._._0x1(155).._._0x1(180),
        Default = false,
        Callback = function(Value)
            local Lighting = game:GetService(_._0x1(76).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116).._._0x1(105).._._0x1(110).._._0x1(103))
            if Value then
                local caveAtmosphere = Lighting:FindFirstChild(_._0x1(67).._._0x1(97).._._0x1(118).._._0x1(101).._._0x1(65).._._0x1(116).._._0x1(109).._._0x1(111).._._0x1(115).._._0x1(112).._._0x1(104).._._0x1(101).._._0x1(114).._._0x1(101))
                if caveAtmosphere then
                    caveAtmosphere:Destroy()
                end

                local caves = Lighting:FindFirstChild(_._0x1(67).._._0x1(97).._._0x1(118).._._0x1(101).._._0x1(115))
                if caves then
                    caves:Destroy()
                end
            end
        end
    })

    A:Toggle({
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(230).._._0x1(176).._._0x1(167).._._0x1(230).._._0x1(176).._._0x1(148).._._0x1(47).._._0x1(231).._._0x1(144).._._0x1(134).._._0x1(230).._._0x1(153).._._0x1(186).._._0x1(230).._._0x1(149).._._0x1(136).._._0x1(230).._._0x1(158).._._0x1(156),
        Default = false,
        Callback = function(Value)
            local Lighting = game:GetService(_._0x1(76).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116).._._0x1(105).._._0x1(110).._._0x1(103))
            if Value then
                local sanity = Lighting:FindFirstChild(_._0x1(83).._._0x1(97).._._0x1(110).._._0x1(105).._._0x1(116).._._0x1(121))
                if sanity then
                    sanity:Destroy()
                end

                local oxygenCC = Lighting:FindFirstChild(_._0x1(79).._._0x1(120).._._0x1(121).._._0x1(103).._._0x1(101).._._0x1(110).._._0x1(67).._._0x1(67))
                if oxygenCC then
                    oxygenCC:Destroy()
                end

                local oxygenBlur = Lighting:FindFirstChild(_._0x1(79).._._0x1(120).._._0x1(121).._._0x1(103).._._0x1(101).._._0x1(110).._._0x1(66).._._0x1(108).._._0x1(117).._._0x1(114))
                if oxygenBlur then
                    oxygenBlur:Destroy()
                end
            end
        end
    })

    A:Toggle({
        Title = _._0x1(230).._._0x1(151).._._0x1(160).._._0x1(233).._._0x1(155).._._0x1(190).._._0x1(230).._._0x1(149).._._0x1(136).._._0x1(230).._._0x1(158).._._0x1(156),
        Default = false,
        Callback = function(Value)
            local lighting = game:GetService(_._0x1(76).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116).._._0x1(105).._._0x1(110).._._0x1(103))
            local cave = lighting:FindFirstChild(_._0x1(67).._._0x1(97).._._0x1(118).._._0x1(101).._._0x1(65).._._0x1(116).._._0x1(109).._._0x1(111).._._0x1(115).._._0x1(112).._._0x1(104).._._0x1(101).._._0x1(114).._._0x1(101))

            if Value then
                if cave and cave:IsA(_._0x1(65).._._0x1(116).._._0x1(109).._._0x1(111).._._0x1(115).._._0x1(112).._._0x1(104).._._0x1(101).._._0x1(114).._._0x1(101)) then
                    cave.Density = 0
                else
                    lighting.FogStart = 1000000
                    lighting.FogEnd = 1000000
                end
            elseif cave and cave:IsA(_._0x1(65).._._0x1(116).._._0x1(109).._._0x1(111).._._0x1(115).._._0x1(112).._._0x1(104).._._0x1(101).._._0x1(114).._._0x1(101)) then
                cave.Density = 0.15
            else
                lighting.FogStart = 150
                lighting.FogEnd = 150
            end
        end
    })

    A:Toggle({
        Title = _._0x1(230).._._0x1(151).._._0x1(160).._._0x1(231).._._0x1(155).._._0x1(184).._._0x1(230).._._0x1(156).._._0x1(186).._._0x1(230).._._0x1(138).._._0x1(150).._._0x1(229).._._0x1(138).._._0x1(168),
        Default = false,
        Callback = function(Value)
            local RequiredMainGame = require(game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115)).LocalPlayer:WaitForChild(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(71).._._0x1(117).._._0x1(105)):WaitForChild(_._0x1(77).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(85).._._0x1(73)):WaitForChild(_._0x1(73).._._0x1(110).._._0x1(105).._._0x1(116).._._0x1(105).._._0x1(97).._._0x1(116).._._0x1(111).._._0x1(114)):WaitForChild(_._0x1(77).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(95).._._0x1(71).._._0x1(97).._._0x1(109).._._0x1(101)))
            
            task.spawn(function()
                while Value and RequiredMainGame do
                    task.wait()
                    if typeof(RequiredMainGame.csgo) == _._0x1(67).._._0x1(70).._._0x1(114).._._0x1(97).._._0x1(109).._._0x1(101) then
                        RequiredMainGame.csgo = CFrame.new()
                    end
                end
            end)
        end
    })

    A:Toggle({
        Title = _._0x1(230).._._0x1(151).._._0x1(160).._._0x1(229).._._0x1(164).._._0x1(180).._._0x1(233).._._0x1(131).._._0x1(168).._._0x1(230).._._0x1(153).._._0x1(131).._._0x1(229).._._0x1(138).._._0x1(168),
        Default = false,
        Callback = function(Value)
            local RunService = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101))
            local RequiredMainGame = require(game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115)).LocalPlayer:WaitForChild(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(71).._._0x1(117).._._0x1(105)):WaitForChild(_._0x1(77).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(85).._._0x1(73)):WaitForChild(_._0x1(73).._._0x1(110).._._0x1(105).._._0x1(116).._._0x1(105).._._0x1(97).._._0x1(116).._._0x1(111).._._0x1(114)):WaitForChild(_._0x1(77).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(95).._._0x1(71).._._0x1(97).._._0x1(109).._._0x1(101)))

            if Value then
                if not getgenv().HeadBobDisabler then
                    getgenv().HeadBobDisabler = RunService.RenderStepped:Connect(function()
                        if RequiredMainGame and RequiredMainGame.spring then
                            if typeof(RequiredMainGame.spring.Target) == _._0x1(86).._._0x1(101).._._0x1(99).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(51) then
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
        Title = _._0x1(230).._._0x1(151).._._0x1(160).._._0x1(232).._._0x1(191).._._0x1(135).._._0x1(229).._._0x1(156).._._0x1(186).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(231).._._0x1(148).._._0x1(187),
        Default = false,
        Callback = function(Value)
            local player = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115)).LocalPlayer
            local RemoteListener = player.PlayerGui.MainUI.Initiator.Main_Game:WaitForChild(_._0x1(82).._._0x1(101).._._0x1(109).._._0x1(111).._._0x1(116).._._0x1(101).._._0x1(76).._._0x1(105).._._0x1(115).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(101).._._0x1(114))
            local CutScenes = RemoteListener:FindFirstChild(_._0x1(67).._._0x1(117).._._0x1(116).._._0x1(115).._._0x1(99).._._0x1(101).._._0x1(110).._._0x1(101).._._0x1(115)) or RemoteListener:FindFirstChild(_._0x1(95).._._0x1(67).._._0x1(117).._._0x1(116).._._0x1(115).._._0x1(99).._._0x1(101).._._0x1(110).._._0x1(101).._._0x1(115))

            if not CutScenes then
                CutScenes = RemoteListener:WaitForChild(_._0x1(67).._._0x1(117).._._0x1(116).._._0x1(115).._._0x1(99).._._0x1(101).._._0x1(110).._._0x1(101).._._0x1(115), 3) or RemoteListener:WaitForChild(_._0x1(95).._._0x1(67).._._0x1(117).._._0x1(116).._._0x1(115).._._0x1(99).._._0x1(101).._._0x1(110).._._0x1(101).._._0x1(115), 3)
            end

            if CutScenes then
                CutScenes.Name = Value and _._0x1(95).._._0x1(67).._._0x1(117).._._0x1(116).._._0x1(115).._._0x1(99).._._0x1(101).._._0x1(110).._._0x1(101).._._0x1(115) or _._0x1(67).._._0x1(117).._._0x1(116).._._0x1(115).._._0x1(99).._._0x1(101).._._0x1(110).._._0x1(101).._._0x1(115)
            end
        end
    })

    A:Toggle({
        Title = _._0x1(232).._._0x1(167).._._0x1(132).._._0x1(233).._._0x1(129).._._0x1(191).._._0x1(233).._._0x1(154).._._0x1(144).._._0x1(232).._._0x1(151).._._0x1(143).._._0x1(232).._._0x1(190).._._0x1(185).._._0x1(231).._._0x1(188).._._0x1(152),
        Default = false,
        Tooltip = _._0x1(231).._._0x1(167).._._0x1(187).._._0x1(233).._._0x1(153).._._0x1(164).._._0x1(233).._._0x1(154).._._0x1(144).._._0x1(232).._._0x1(151).._._0x1(143).._._0x1(230).._._0x1(151).._._0x1(182).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(233).._._0x1(187).._._0x1(145).._._0x1(230).._._0x1(154).._._0x1(151).._._0x1(232).._._0x1(190).._._0x1(185).._._0x1(231).._._0x1(188).._._0x1(152),
        Callback = function(Value)
            local LocalPlayer = game.Players.LocalPlayer
            LocalPlayer.PlayerGui.MainUI.MainFrame.HideVignette.Image = Value and _._0x1(114).._._0x1(98).._._0x1(120).._._0x1(97).._._0x1(115).._._0x1(115).._._0x1(101).._._0x1(116).._._0x1(105).._._0x1(100).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(48) or _._0x1(114).._._0x1(98).._._0x1(120).._._0x1(97).._._0x1(115).._._0x1(115).._._0x1(101).._._0x1(116).._._0x1(105).._._0x1(100).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(54).._._0x1(49).._._0x1(48).._._0x1(48).._._0x1(48).._._0x1(55).._._0x1(54).._._0x1(51).._._0x1(50).._._0x1(48)
        end
    })

   A:Toggle({
        Title = _._0x1(233).._._0x1(152).._._0x1(178).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(233).._._0x1(161).._._0x1(191),
        Default = false,
        Callback = function(Value)
            local Modifiers = workspace:FindFirstChild(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(105).._._0x1(102).._._0x1(105).._._0x1(101).._._0x1(114).._._0x1(115))
            if Modifiers and not Modifiers:FindFirstChild(_._0x1(74).._._0x1(97).._._0x1(109).._._0x1(109).._._0x1(105).._._0x1(110)) then
                return
            end

            local mainTrack = game[_._0x1(83).._._0x1(111).._._0x1(117).._._0x1(110).._._0x1(100).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101)]:FindFirstChild(_._0x1(77).._._0x1(97).._._0x1(105).._._0x1(110))
            if mainTrack then
                local jamming = mainTrack:FindFirstChild(_._0x1(74).._._0x1(97).._._0x1(109).._._0x1(109).._._0x1(105).._._0x1(110).._._0x1(103))
                if jamming then
                    jamming.Enabled = not Value
                end
            end

            local mainUI = LocalPlayer:FindFirstChild(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(71).._._0x1(117).._._0x1(105)) and LocalPlayer.PlayerGui:FindFirstChild(_._0x1(77).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(85).._._0x1(73))
            if mainUI then
                local healthGui = mainUI:FindFirstChild(_._0x1(73).._._0x1(110).._._0x1(105).._._0x1(116).._._0x1(105).._._0x1(97).._._0x1(116).._._0x1(111).._._0x1(114)) and 
                                 mainUI.Initiator:FindFirstChild(_._0x1(77).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(95).._._0x1(71).._._0x1(97).._._0x1(109).._._0x1(101)) and 
                                 mainUI.Initiator.Main_Game:FindFirstChild(_._0x1(72).._._0x1(101).._._0x1(97).._._0x1(108).._._0x1(116).._._0x1(104))
                if healthGui then
                    local jamSound = healthGui:FindFirstChild(_._0x1(74).._._0x1(97).._._0x1(109))
                    if jamSound then
                        jamSound.Playing = not Value
                    end
                end
            end
        end
    })
    A:Toggle({
        Title = _._0x1(233).._._0x1(152).._._0x1(178).._._0x1(233).._._0x1(166).._._0x1(153).._._0x1(232).._._0x1(149).._._0x1(137).._._0x1(231).._._0x1(154).._._0x1(174),
        Default = false,
        Callback = function(Value)
            local currentRooms = workspace:WaitForChild(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115))
            
            if getgenv().antiBananaConn then
                getgenv().antiBananaConn:Disconnect()
                getgenv().antiBananaConn = nil
            end

            for _, v in pairs(currentRooms:GetDescendants()) do
                if v.Name == _._0x1(66).._._0x1(97).._._0x1(110).._._0x1(97).._._0x1(110).._._0x1(97).._._0x1(80).._._0x1(101).._._0x1(101).._._0x1(108) and v:IsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                    v.CanTouch = not Value
                end
            end

            if Value then
                getgenv().antiBananaConn = currentRooms.DescendantAdded:Connect(function(v)
                    if v.Name == _._0x1(66).._._0x1(97).._._0x1(110).._._0x1(97).._._0x1(110).._._0x1(97).._._0x1(80).._._0x1(101).._._0x1(101).._._0x1(108) and v:IsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                        v.CanTouch = false
                    end
                end)
            end
        end
    })

    A:Toggle({
        Title = _._0x1(233).._._0x1(152).._._0x1(178).._._0x1(74).._._0x1(101).._._0x1(102).._._0x1(102).._._0x1(230).._._0x1(157).._._0x1(128).._._0x1(230).._._0x1(137).._._0x1(139),
        Default = false,
        Callback = function(Value)
            local currentRooms = workspace:WaitForChild(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115))
            
            if getgenv().antiJeffConn then
                getgenv().antiJeffConn:Disconnect()
                getgenv().antiJeffConn = nil
            end

            for _, model in pairs(currentRooms:GetDescendants()) do
                if model.Name == _._0x1(74).._._0x1(101).._._0x1(102).._._0x1(102).._._0x1(84).._._0x1(104).._._0x1(101).._._0x1(75).._._0x1(105).._._0x1(108).._._0x1(108).._._0x1(101).._._0x1(114) and model:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) then
                    for _, part in ipairs(model:GetChildren()) do
                        if part:IsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                            part.CanTouch = not Value
                        end
                    end
                end
            end

            if Value then
                getgenv().antiJeffConn = currentRooms.DescendantAdded:Connect(function(v)
                    if v.Name == _._0x1(74).._._0x1(101).._._0x1(102).._._0x1(102).._._0x1(84).._._0x1(104).._._0x1(101).._._0x1(75).._._0x1(105).._._0x1(108).._._0x1(108).._._0x1(101).._._0x1(114) and v:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) then
                        for _, part in ipairs(v:GetChildren()) do
                            if part:IsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) then
                                part.CanTouch = false
                            end
                        end
                    end
                end)
            end
        end
    })
    local ESPTab = Window:Tab({Title = _._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134).._._0x1(229).._._0x1(138).._._0x1(159).._._0x1(232).._._0x1(131).._._0x1(189), Icon = _._0x1(101).._._0x1(121).._._0x1(101)})
local ESPLibrary = loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(109).._._0x1(115).._._0x1(116).._._0x1(117).._._0x1(100).._._0x1(105).._._0x1(111).._._0x1(52).._._0x1(53).._._0x1(47).._._0x1(77).._._0x1(83).._._0x1(69).._._0x1(83).._._0x1(80).._._0x1(47).._._0x1(114).._._0x1(101).._._0x1(102).._._0x1(115).._._0x1(47).._._0x1(104).._._0x1(101).._._0x1(97).._._0x1(100).._._0x1(115).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(115).._._0x1(111).._._0x1(117).._._0x1(114).._._0x1(99).._._0x1(101).._._0x1(46).._._0x1(108).._._0x1(117).._._0x1(97).._._0x1(117)))()
ESPLibrary.GlobalConfig.Distance = false
local ColorConfig = {
    [_._0x1(231).._._0x1(186).._._0x1(162).._._0x1(232).._._0x1(137).._._0x1(178)] = Color3.fromRGB(255, 0, 0),
    [_._0x1(231).._._0x1(187).._._0x1(191).._._0x1(232).._._0x1(137).._._0x1(178)] = Color3.fromRGB(0, 255, 0),
    [_._0x1(232).._._0x1(147).._._0x1(157).._._0x1(232).._._0x1(137).._._0x1(178)] = Color3.fromRGB(0, 0, 255),
    [_._0x1(233).._._0x1(187).._._0x1(132).._._0x1(232).._._0x1(137).._._0x1(178)] = Color3.fromRGB(255, 255, 0),
    [_._0x1(231).._._0x1(180).._._0x1(171).._._0x1(232).._._0x1(137).._._0x1(178)] = Color3.fromRGB(255, 0, 255),
    [_._0x1(233).._._0x1(157).._._0x1(146).._._0x1(232).._._0x1(137).._._0x1(178)] = Color3.fromRGB(0, 255, 255),
    [_._0x1(231).._._0x1(178).._._0x1(137).._._0x1(232).._._0x1(137).._._0x1(178)] = Color3.fromRGB(255, 182, 193),
    [_._0x1(230).._._0x1(169).._._0x1(153).._._0x1(232).._._0x1(137).._._0x1(178)] = Color3.fromRGB(255, 165, 0),
    [_._0x1(231).._._0x1(153).._._0x1(189).._._0x1(232).._._0x1(137).._._0x1(178)] = Color3.fromRGB(255, 255, 255),
    [_._0x1(229).._._0x1(189).._._0x1(169).._._0x1(232).._._0x1(153).._._0x1(185).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(128).._._0x1(129)] = Color3.fromRGB(255, 0, 0)
}
local ESPGroup = ESPTab:Section({Title = _._0x1(69).._._0x1(83).._._0x1(80).._._0x1(232).._._0x1(174).._._0x1(190).._._0x1(231).._._0x1(189).._._0x1(174).._._0x1(91).._._0x1(229).._._0x1(177).._._0x1(149).._._0x1(229).._._0x1(188).._._0x1(128).._._0x1(93), Side = _._0x1(76).._._0x1(101).._._0x1(102).._._0x1(116)})

ESPGroup:Toggle({
    Title = _._0x1(229).._._0x1(144).._._0x1(175).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(232).._._0x1(191).._._0x1(189).._._0x1(232).._._0x1(184).._._0x1(170).._._0x1(231).._._0x1(186).._._0x1(191),
    Default = false,
    Callback = function(Value)
        _G.EnableTracers = Value
        UpdateAllESP()
    end
})

ESPGroup:Toggle({
    Title = _._0x1(229).._._0x1(144).._._0x1(175).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(230).._._0x1(150).._._0x1(185).._._0x1(229).._._0x1(144).._._0x1(145).._._0x1(231).._._0x1(174).._._0x1(173).._._0x1(229).._._0x1(164).._._0x1(180), 
    Default = false,
    Callback = function(Value)
        _G.EnableArrows = Value
        UpdateAllESP()
    end
})

ESPGroup:Dropdown({
    Title = _._0x1(69).._._0x1(83).._._0x1(80).._._0x1(231).._._0x1(177).._._0x1(187).._._0x1(229).._._0x1(158).._._0x1(139),
    Values = {_._0x1(233).._._0x1(171).._._0x1(152).._._0x1(228).._._0x1(186).._._0x1(174), _._0x1(230).._._0x1(150).._._0x1(135).._._0x1(229).._._0x1(173).._._0x1(151), _._0x1(233).._._0x1(128).._._0x1(137).._._0x1(230).._._0x1(139).._._0x1(169).._._0x1(230).._._0x1(161).._._0x1(134)},
    Default = _._0x1(233).._._0x1(171).._._0x1(152).._._0x1(228).._._0x1(186).._._0x1(174),
    Callback = function(Value)
        local espTypes = {
            [_._0x1(233).._._0x1(171).._._0x1(152).._._0x1(228).._._0x1(186).._._0x1(174)] = _._0x1(72).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(108).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116),
            [_._0x1(230).._._0x1(150).._._0x1(135).._._0x1(229).._._0x1(173).._._0x1(151)] = _._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116), 
            [_._0x1(233).._._0x1(128).._._0x1(137).._._0x1(230).._._0x1(139).._._0x1(169).._._0x1(230).._._0x1(161).._._0x1(134)] = _._0x1(83).._._0x1(101).._._0x1(108).._._0x1(101).._._0x1(99).._._0x1(116).._._0x1(105).._._0x1(111).._._0x1(110).._._0x1(66).._._0x1(111).._._0x1(120)
        }
        _G.ESPType = espTypes[Value]
        UpdateAllESP()
    end
})

local ObjectESPGroup = ESPTab:Section({Title = _._0x1(231).._._0x1(137).._._0x1(169).._._0x1(228).._._0x1(189).._._0x1(147).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134).._._0x1(91).._._0x1(229).._._0x1(177).._._0x1(149).._._0x1(229).._._0x1(188).._._0x1(128).._._0x1(93), Side = _._0x1(76).._._0x1(101).._._0x1(102).._._0x1(116)})

local ObjectESPConfig = {
    {
        Name = _._0x1(68).._._0x1(111).._._0x1(111).._._0x1(114).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(233).._._0x1(151).._._0x1(168).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(231).._._0x1(153).._._0x1(189).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(68).._._0x1(111).._._0x1(111).._._0x1(114)},
        DisplayName = _._0x1(233).._._0x1(151).._._0x1(168)
    },
    {
        Name = _._0x1(79).._._0x1(98).._._0x1(106).._._0x1(101).._._0x1(99).._._0x1(116).._._0x1(105).._._0x1(118).._._0x1(101).._._0x1(69).._._0x1(83).._._0x1(80), 
        Title = _._0x1(231).._._0x1(155).._._0x1(174).._._0x1(230).._._0x1(160).._._0x1(135).._._0x1(231).._._0x1(137).._._0x1(169).._._0x1(229).._._0x1(147).._._0x1(129).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(233).._._0x1(187).._._0x1(132).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(75).._._0x1(101).._._0x1(121).._._0x1(79).._._0x1(98).._._0x1(116).._._0x1(97).._._0x1(105).._._0x1(110), _._0x1(70).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(79).._._0x1(98).._._0x1(116).._._0x1(97).._._0x1(105).._._0x1(110), _._0x1(76).._._0x1(105).._._0x1(118).._._0x1(101).._._0x1(66).._._0x1(114).._._0x1(101).._._0x1(97).._._0x1(107).._._0x1(101).._._0x1(114).._._0x1(80).._._0x1(111).._._0x1(108).._._0x1(101).._._0x1(80).._._0x1(105).._._0x1(99).._._0x1(107).._._0x1(117).._._0x1(112)},
        DisplayName = _._0x1(231).._._0x1(155).._._0x1(174).._._0x1(230).._._0x1(160).._._0x1(135).._._0x1(231).._._0x1(137).._._0x1(169).._._0x1(229).._._0x1(147).._._0x1(129)
    },
    {
        Name = _._0x1(67).._._0x1(111).._._0x1(105).._._0x1(110).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(233).._._0x1(135).._._0x1(145).._._0x1(229).._._0x1(184).._._0x1(129).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(231).._._0x1(153).._._0x1(189).._._0x1(232).._._0x1(137).._._0x1(178), 
        Models = {_._0x1(71).._._0x1(111).._._0x1(108).._._0x1(100).._._0x1(80).._._0x1(105).._._0x1(108).._._0x1(101)},
        DisplayName = _._0x1(233).._._0x1(135).._._0x1(145).._._0x1(229).._._0x1(184).._._0x1(129)
    },
    {
        Name = _._0x1(77).._._0x1(105).._._0x1(110).._._0x1(101).._._0x1(115).._._0x1(71).._._0x1(101).._._0x1(110).._._0x1(101).._._0x1(114).._._0x1(97).._._0x1(116).._._0x1(111).._._0x1(114).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(231).._._0x1(159).._._0x1(191).._._0x1(230).._._0x1(180).._._0x1(158).._._0x1(229).._._0x1(143).._._0x1(145).._._0x1(231).._._0x1(148).._._0x1(181).._._0x1(230).._._0x1(156).._._0x1(186).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(233).._._0x1(157).._._0x1(146).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(77).._._0x1(105).._._0x1(110).._._0x1(101).._._0x1(115).._._0x1(71).._._0x1(101).._._0x1(110).._._0x1(101).._._0x1(114).._._0x1(97).._._0x1(116).._._0x1(111).._._0x1(114)},
        DisplayName = _._0x1(229).._._0x1(143).._._0x1(145).._._0x1(231).._._0x1(148).._._0x1(181).._._0x1(230).._._0x1(156).._._0x1(186)
    },
    {
        Name = _._0x1(76).._._0x1(101).._._0x1(118).._._0x1(101).._._0x1(114).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(230).._._0x1(157).._._0x1(160).._._0x1(230).._._0x1(157).._._0x1(134).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(230).._._0x1(169).._._0x1(153).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(76).._._0x1(101).._._0x1(118).._._0x1(101).._._0x1(114).._._0x1(70).._._0x1(111).._._0x1(114).._._0x1(71).._._0x1(97).._._0x1(116).._._0x1(101)},
        DisplayName = _._0x1(230).._._0x1(157).._._0x1(160).._._0x1(230).._._0x1(157).._._0x1(134)
    },
    {
        Name = _._0x1(73).._._0x1(116).._._0x1(101).._._0x1(109).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(230).._._0x1(137).._._0x1(128).._._0x1(230).._._0x1(156).._._0x1(137).._._0x1(231).._._0x1(137).._._0x1(169).._._0x1(229).._._0x1(147).._._0x1(129).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134), 
        DefaultColor = _._0x1(233).._._0x1(187).._._0x1(132).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {
            _._0x1(65).._._0x1(108).._._0x1(97).._._0x1(114).._._0x1(109).._._0x1(67).._._0x1(108).._._0x1(111).._._0x1(99).._._0x1(107), _._0x1(65).._._0x1(108).._._0x1(111).._._0x1(101), _._0x1(66).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(97).._._0x1(103).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(99).._._0x1(107), _._0x1(66).._._0x1(97).._._0x1(116).._._0x1(116).._._0x1(101).._._0x1(114).._._0x1(121), _._0x1(66).._._0x1(97).._._0x1(116).._._0x1(116).._._0x1(101).._._0x1(114).._._0x1(121).._._0x1(80).._._0x1(97).._._0x1(99).._._0x1(107), _._0x1(67).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(108).._._0x1(101),
            _._0x1(67).._._0x1(111).._._0x1(109).._._0x1(112).._._0x1(97).._._0x1(115).._._0x1(115), _._0x1(67).._._0x1(114).._._0x1(117).._._0x1(99).._._0x1(105).._._0x1(102).._._0x1(105).._._0x1(120), _._0x1(70).._._0x1(108).._._0x1(97).._._0x1(115).._._0x1(104).._._0x1(108).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116), _._0x1(71).._._0x1(108).._._0x1(111).._._0x1(119).._._0x1(115).._._0x1(116).._._0x1(105).._._0x1(99).._._0x1(107), _._0x1(72).._._0x1(111).._._0x1(108).._._0x1(121).._._0x1(72).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(71).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(97).._._0x1(100).._._0x1(101),
            _._0x1(76).._._0x1(97).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(114).._._0x1(110), _._0x1(76).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(80).._._0x1(111).._._0x1(105).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(114), _._0x1(76).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116).._._0x1(101).._._0x1(114), _._0x1(76).._._0x1(111).._._0x1(99).._._0x1(107).._._0x1(112).._._0x1(105).._._0x1(99).._._0x1(107), _._0x1(76).._._0x1(111).._._0x1(116).._._0x1(117).._._0x1(115).._._0x1(70).._._0x1(108).._._0x1(111).._._0x1(119).._._0x1(101).._._0x1(114), 
            _._0x1(77).._._0x1(117).._._0x1(108).._._0x1(116).._._0x1(105).._._0x1(116).._._0x1(111).._._0x1(111).._._0x1(108), _._0x1(78).._._0x1(86).._._0x1(67).._._0x1(83).._._0x1(51).._._0x1(48).._._0x1(48).._._0x1(48), _._0x1(83).._._0x1(104).._._0x1(101).._._0x1(97).._._0x1(114).._._0x1(115), _._0x1(83).._._0x1(107).._._0x1(101).._._0x1(108).._._0x1(101).._._0x1(116).._._0x1(111).._._0x1(110).._._0x1(75).._._0x1(101).._._0x1(121), _._0x1(83).._._0x1(109).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(104).._._0x1(105).._._0x1(101), _._0x1(86).._._0x1(105).._._0x1(116).._._0x1(97).._._0x1(109).._._0x1(105).._._0x1(110).._._0x1(115)
        },
        DisplayName = _._0x1(231).._._0x1(137).._._0x1(169).._._0x1(229).._._0x1(147).._._0x1(129)
    },
    {
        Name = _._0x1(67).._._0x1(108).._._0x1(111).._._0x1(115).._._0x1(101).._._0x1(116).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(230).._._0x1(159).._._0x1(156).._._0x1(229).._._0x1(173).._._0x1(144).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(231).._._0x1(178).._._0x1(137).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(87).._._0x1(97).._._0x1(114).._._0x1(100).._._0x1(114).._._0x1(111).._._0x1(98).._._0x1(101), _._0x1(84).._._0x1(111).._._0x1(111).._._0x1(108).._._0x1(115).._._0x1(104).._._0x1(101).._._0x1(100), _._0x1(76).._._0x1(111).._._0x1(99).._._0x1(107).._._0x1(101).._._0x1(114).._._0x1(95).._._0x1(76).._._0x1(97).._._0x1(114).._._0x1(103).._._0x1(101), _._0x1(66).._._0x1(97).._._0x1(99).._._0x1(107).._._0x1(100).._._0x1(111).._._0x1(111).._._0x1(114).._._0x1(95).._._0x1(87).._._0x1(97).._._0x1(114).._._0x1(100).._._0x1(114).._._0x1(111).._._0x1(98).._._0x1(101)},
        DisplayName = _._0x1(230).._._0x1(159).._._0x1(156).._._0x1(229).._._0x1(173).._._0x1(144)
    },
    {
        Name = _._0x1(65).._._0x1(110).._._0x1(99).._._0x1(104).._._0x1(111).._._0x1(114).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(233).._._0x1(148).._._0x1(154).._._0x1(231).._._0x1(130).._._0x1(185).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(231).._._0x1(178).._._0x1(137).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(77).._._0x1(105).._._0x1(110).._._0x1(101).._._0x1(115).._._0x1(65).._._0x1(110).._._0x1(99).._._0x1(104).._._0x1(111).._._0x1(114)},
        DisplayName = _._0x1(233).._._0x1(148).._._0x1(154).._._0x1(231).._._0x1(130).._._0x1(185)
    },
    {
        Name = _._0x1(76).._._0x1(105).._._0x1(98).._._0x1(114).._._0x1(97).._._0x1(114).._._0x1(121).._._0x1(66).._._0x1(111).._._0x1(111).._._0x1(107).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(229).._._0x1(155).._._0x1(190).._._0x1(228).._._0x1(185).._._0x1(166).._._0x1(233).._._0x1(166).._._0x1(134).._._0x1(228).._._0x1(185).._._0x1(166).._._0x1(231).._._0x1(177).._._0x1(141).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(233).._._0x1(157).._._0x1(146).._._0x1(232).._._0x1(137).._._0x1(178), 
        Models = {_._0x1(76).._._0x1(105).._._0x1(118).._._0x1(101).._._0x1(72).._._0x1(105).._._0x1(110).._._0x1(116).._._0x1(66).._._0x1(111).._._0x1(111).._._0x1(107)},
        DisplayName = _._0x1(228).._._0x1(185).._._0x1(166).._._0x1(231).._._0x1(177).._._0x1(141)
    },
    {
        Name = _._0x1(67).._._0x1(104).._._0x1(101).._._0x1(115).._._0x1(116).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(229).._._0x1(174).._._0x1(157).._._0x1(231).._._0x1(174).._._0x1(177).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(231).._._0x1(187).._._0x1(191).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(67).._._0x1(104).._._0x1(101).._._0x1(115).._._0x1(116).._._0x1(66).._._0x1(111).._._0x1(120), _._0x1(67).._._0x1(104).._._0x1(101).._._0x1(115).._._0x1(116).._._0x1(66).._._0x1(111).._._0x1(120).._._0x1(76).._._0x1(111).._._0x1(99).._._0x1(107).._._0x1(101).._._0x1(100)},
        DisplayName = _._0x1(229).._._0x1(174).._._0x1(157).._._0x1(231).._._0x1(174).._._0x1(177)
    }
}

local EntityESPConfig = {
    {
        Name = _._0x1(83).._._0x1(101).._._0x1(101).._._0x1(107).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(232).._._0x1(191).._._0x1(189).._._0x1(233).._._0x1(128).._._0x1(144).._._0x1(232).._._0x1(128).._._0x1(133).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134), 
        DefaultColor = _._0x1(231).._._0x1(186).._._0x1(162).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(83).._._0x1(101).._._0x1(101).._._0x1(107).._._0x1(77).._._0x1(111).._._0x1(118).._._0x1(105).._._0x1(110).._._0x1(103)},
        DisplayName = _._0x1(232).._._0x1(191).._._0x1(189).._._0x1(233).._._0x1(128).._._0x1(144).._._0x1(232).._._0x1(128).._._0x1(133)
    },
    {
        Name = _._0x1(70).._._0x1(105).._._0x1(103).._._0x1(117).._._0x1(114).._._0x1(101).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(233).._._0x1(155).._._0x1(149).._._0x1(229).._._0x1(131).._._0x1(143).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(231).._._0x1(153).._._0x1(189).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(70).._._0x1(105).._._0x1(103).._._0x1(117).._._0x1(114).._._0x1(101).._._0x1(82).._._0x1(105).._._0x1(103)},
        DisplayName = _._0x1(233).._._0x1(155).._._0x1(149).._._0x1(229).._._0x1(131).._._0x1(143)
    },
    {
        Name = _._0x1(65).._._0x1(109).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(104).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(228).._._0x1(188).._._0x1(143).._._0x1(229).._._0x1(135).._._0x1(187).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(231).._._0x1(153).._._0x1(189).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(65).._._0x1(109).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(104).._._0x1(77).._._0x1(111).._._0x1(118).._._0x1(105).._._0x1(110).._._0x1(103)},
        DisplayName = _._0x1(228).._._0x1(188).._._0x1(143).._._0x1(229).._._0x1(135).._._0x1(187)
    },
    {
        Name = _._0x1(82).._._0x1(117).._._0x1(115).._._0x1(104).._._0x1(69).._._0x1(83).._._0x1(80), 
        Title = _._0x1(229).._._0x1(134).._._0x1(178).._._0x1(229).._._0x1(136).._._0x1(186).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(231).._._0x1(153).._._0x1(189).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(82).._._0x1(117).._._0x1(115).._._0x1(104).._._0x1(77).._._0x1(111).._._0x1(118).._._0x1(105).._._0x1(110).._._0x1(103)},
        DisplayName = _._0x1(229).._._0x1(134).._._0x1(178).._._0x1(229).._._0x1(136).._._0x1(186)
    },
    {
        Name = _._0x1(83).._._0x1(110).._._0x1(97).._._0x1(114).._._0x1(101).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(233).._._0x1(153).._._0x1(183).._._0x1(233).._._0x1(152).._._0x1(177).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(231).._._0x1(153).._._0x1(189).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(83).._._0x1(110).._._0x1(97).._._0x1(114).._._0x1(101)},
        DisplayName = _._0x1(233).._._0x1(153).._._0x1(183).._._0x1(233).._._0x1(152).._._0x1(177)
    },
    {
        Name = _._0x1(71).._._0x1(105).._._0x1(103).._._0x1(103).._._0x1(108).._._0x1(101).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(229).._._0x1(130).._._0x1(187).._._0x1(231).._._0x1(172).._._0x1(145).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(231).._._0x1(153).._._0x1(189).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(71).._._0x1(105).._._0x1(103).._._0x1(103).._._0x1(108).._._0x1(101).._._0x1(67).._._0x1(101).._._0x1(105).._._0x1(108).._._0x1(105).._._0x1(110).._._0x1(103)},
        DisplayName = _._0x1(229).._._0x1(130).._._0x1(187).._._0x1(231).._._0x1(172).._._0x1(145)
    },
    {
        Name = _._0x1(69).._._0x1(121).._._0x1(101).._._0x1(115).._._0x1(116).._._0x1(97).._._0x1(108).._._0x1(107).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(231).._._0x1(156).._._0x1(188).._._0x1(230).._._0x1(159).._._0x1(132).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(231).._._0x1(153).._._0x1(189).._._0x1(232).._._0x1(137).._._0x1(178), 
        Models = {_._0x1(69).._._0x1(121).._._0x1(101).._._0x1(115).._._0x1(116).._._0x1(97).._._0x1(108).._._0x1(107).._._0x1(77).._._0x1(111).._._0x1(118).._._0x1(105).._._0x1(110).._._0x1(103)},
        DisplayName = _._0x1(231).._._0x1(156).._._0x1(188).._._0x1(230).._._0x1(159).._._0x1(132)
    },
    {
        Name = _._0x1(77).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(114).._._0x1(97).._._0x1(107).._._0x1(101).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(230).._._0x1(155).._._0x1(188).._._0x1(229).._._0x1(190).._._0x1(183).._._0x1(230).._._0x1(139).._._0x1(137).._._0x1(232).._._0x1(141).._._0x1(137).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(231).._._0x1(153).._._0x1(189).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(77).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(114).._._0x1(97).._._0x1(107).._._0x1(101)},
        DisplayName = _._0x1(230).._._0x1(155).._._0x1(188).._._0x1(229).._._0x1(190).._._0x1(183).._._0x1(230).._._0x1(139).._._0x1(137).._._0x1(232).._._0x1(141).._._0x1(137)
    },
    {
        Name = _._0x1(71).._._0x1(114).._._0x1(111).._._0x1(117).._._0x1(110).._._0x1(100).._._0x1(115).._._0x1(107).._._0x1(101).._._0x1(101).._._0x1(112).._._0x1(101).._._0x1(114).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(229).._._0x1(155).._._0x1(173).._._0x1(228).._._0x1(184).._._0x1(129).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(231).._._0x1(153).._._0x1(189).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(71).._._0x1(114).._._0x1(111).._._0x1(117).._._0x1(110).._._0x1(100).._._0x1(115).._._0x1(107).._._0x1(101).._._0x1(101).._._0x1(112).._._0x1(101).._._0x1(114)},
        DisplayName = _._0x1(229).._._0x1(155).._._0x1(173).._._0x1(228).._._0x1(184).._._0x1(129)
    },
    {
        Name = _._0x1(66).._._0x1(108).._._0x1(105).._._0x1(116).._._0x1(122).._._0x1(69).._._0x1(83).._._0x1(80),
        Title = _._0x1(233).._._0x1(151).._._0x1(170).._._0x1(231).._._0x1(148).._._0x1(181).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134),
        DefaultColor = _._0x1(231).._._0x1(153).._._0x1(189).._._0x1(232).._._0x1(137).._._0x1(178),
        Models = {_._0x1(66).._._0x1(97).._._0x1(99).._._0x1(107).._._0x1(100).._._0x1(111).._._0x1(111).._._0x1(114).._._0x1(82).._._0x1(117).._._0x1(115).._._0x1(104)},
        DisplayName = _._0x1(233).._._0x1(151).._._0x1(170).._._0x1(231).._._0x1(148).._._0x1(181)
    }
}

for _, config in ipairs(ObjectESPConfig) do
    ObjectESPGroup:Toggle({
        Title = config.Title,
        Default = false,
        Callback = function(Value)
            CreateESP(config.Name, Value, config.Models, config.DisplayName, _G[config.Name .. _._0x1(95).._._0x1(67).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114)])
        end
    })
    
    ObjectESPGroup:Dropdown({
        Title = config.Title .. _._0x1(233).._._0x1(162).._._0x1(156).._._0x1(232).._._0x1(137).._._0x1(178),
        Values = {_._0x1(231).._._0x1(186).._._0x1(162).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(231).._._0x1(187).._._0x1(191).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(232).._._0x1(147).._._0x1(157).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(233).._._0x1(187).._._0x1(132).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(231).._._0x1(180).._._0x1(171).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(233).._._0x1(157).._._0x1(146).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(231).._._0x1(178).._._0x1(137).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(230).._._0x1(169).._._0x1(153).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(231).._._0x1(153).._._0x1(189).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(229).._._0x1(189).._._0x1(169).._._0x1(232).._._0x1(153).._._0x1(185).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(128).._._0x1(129)},
        Default = config.DefaultColor,
        Callback = function(Value)
            _G[config.Name .. _._0x1(95).._._0x1(67).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114)] = ColorConfig[Value]
            if _G[config.Name .. _._0x1(95).._._0x1(69).._._0x1(110).._._0x1(97).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(100)] then
                CreateESP(config.Name, true, config.Models, config.DisplayName, _G[config.Name .. _._0x1(95).._._0x1(67).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114)])
            end
        end
    })
end
local EntityESPGroup = ESPTab:Section({Title = _._0x1(229).._._0x1(174).._._0x1(158).._._0x1(228).._._0x1(189).._._0x1(147).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134).._._0x1(91).._._0x1(229).._._0x1(177).._._0x1(149).._._0x1(229).._._0x1(188).._._0x1(128).._._0x1(93), Side = _._0x1(82).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116)})
for _, config in ipairs(EntityESPConfig) do
    EntityESPGroup:Toggle({
        Title = config.Title,
        Default = false,
        Callback = function(Value)
            CreateESP(config.Name, Value, config.Models, config.DisplayName, _G[config.Name .. _._0x1(95).._._0x1(67).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114)])
        end
    })
    
    EntityESPGroup:Dropdown({
        Title = config.Title .. _._0x1(233).._._0x1(162).._._0x1(156).._._0x1(232).._._0x1(137).._._0x1(178),
        Values = {_._0x1(231).._._0x1(186).._._0x1(162).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(231).._._0x1(187).._._0x1(191).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(232).._._0x1(147).._._0x1(157).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(233).._._0x1(187).._._0x1(132).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(231).._._0x1(180).._._0x1(171).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(233).._._0x1(157).._._0x1(146).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(231).._._0x1(178).._._0x1(137).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(230).._._0x1(169).._._0x1(153).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(231).._._0x1(153).._._0x1(189).._._0x1(232).._._0x1(137).._._0x1(178), _._0x1(229).._._0x1(189).._._0x1(169).._._0x1(232).._._0x1(153).._._0x1(185).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(128).._._0x1(129)},
        Default = config.DefaultColor,
        Callback = function(Value)
            _G[config.Name .. _._0x1(95).._._0x1(67).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114)] = ColorConfig[Value]
            if _G[config.Name .. _._0x1(95).._._0x1(69).._._0x1(110).._._0x1(97).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(100)] then
                CreateESP(config.Name, true, config.Models, config.DisplayName, _G[config.Name .. _._0x1(95).._._0x1(67).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114)])
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
        _G[espName .. _._0x1(95).._._0x1(69).._._0x1(110).._._0x1(97).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(100)] = false
        return
    end
    
  
    _G[espName .. _._0x1(95).._._0x1(69).._._0x1(110).._._0x1(97).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(100)] = true
    
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
        if not obj:IsA(_._0x1(77).._._0x1(111).._._0x1(100).._._0x1(101).._._0x1(108)) then return end
        
        local isValid = false
        for _, modelName in ipairs(targetModels) do
            if obj.Name == modelName then
                isValid = true
                break
            end
        end
        
        if not isValid then return end
        
        local targetPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA(_._0x1(66).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116))
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
            ESPType = _G.ESPType or _._0x1(72).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(108).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116),
            FillColor = ESPData[espName].Color,
            OutlineColor = ESPData[espName].Color,
            FillTransparency = 0.7,
            OutlineTransparency = 0,
            Tracer = {
                Enabled = _G.EnableTracers or false,
                Color = ESPData[espName].Color,
                From = _._0x1(66).._._0x1(111).._._0x1(116).._._0x1(116).._._0x1(111).._._0x1(109),
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
        if _G[espName .. _._0x1(95).._._0x1(69).._._0x1(110).._._0x1(97).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(100)] then
            AddESPToObject(obj)
        end
    end)
    local removingConn = workspace.DescendantRemoving:Connect(function(obj)
        if not _G[espName .. _._0x1(95).._._0x1(69).._._0x1(110).._._0x1(97).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(100)] then return end
        
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
    
 
    local updateConn = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101)).Heartbeat:Connect(function()
        if not _G[espName .. _._0x1(95).._._0x1(69).._._0x1(110).._._0x1(97).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(100)] then
            updateConn:Disconnect()
            return
        end
        
        local player = game.Players.LocalPlayer
        local character = player and player.Character
        local rootPart = character and character:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116))
        
        if not rootPart then return end
        
      
        local currentColor = ESPData[espName].Color
        if ESPData[espName].Color == ColorConfig[_._0x1(229).._._0x1(189).._._0x1(169).._._0x1(232).._._0x1(153).._._0x1(185).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(128).._._0x1(129)] then
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
                    elementData.Element.CurrentSettings.Name = string.format(_._0x1(37).._._0x1(115).._._0x1(92).._._0x1(110).._._0x1(37).._._0x1(100).._._0x1(229).._._0x1(141).._._0x1(149).._._0x1(228).._._0x1(189).._._0x1(141), displayName, math.floor(distance))
                    
                 
                    elementData.Element.CurrentSettings.Color = currentColor
                    elementData.Element.CurrentSettings.FillColor = currentColor
                    elementData.Element.CurrentSettings.OutlineColor = currentColor
                    elementData.Element.CurrentSettings.Tracer.Color = currentColor
                    elementData.Element.CurrentSettings.Arrow.Color = currentColor
                    
                 
                    elementData.Element.CurrentSettings.Tracer.Enabled = _G.EnableTracers or false
                    elementData.Element.CurrentSettings.Arrow.Enabled = _G.EnableArrows or false
                    elementData.Element.CurrentSettings.ESPType = _G.ESPType or _._0x1(72).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(108).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116)
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
        if _G[espName .. _._0x1(95).._._0x1(69).._._0x1(110).._._0x1(97).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(100)] then
            CreateESP(espName, true, data.Models, data.DisplayName, data.Color)
        end
    end
end
for _, config in ipairs(ObjectESPConfig) do
    _G[config.Name .. _._0x1(95).._._0x1(67).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114)] = ColorConfig[config.DefaultColor]
end

for _, config in ipairs(EntityESPConfig) do
    _G[config.Name .. _._0x1(95).._._0x1(67).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114)] = ColorConfig[config.DefaultColor]
end
local function StartRainbowEffect()
    if RainbowConnection then RainbowConnection:Disconnect() end
    
    RainbowConnection = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101)).Heartbeat:Connect(function()
        local time = tick()
        local r = math.sin(time * 2) * 0.5 + 0.5
        local g = math.sin(time * 2 + 2) * 0.5 + 0.5
        local b = math.sin(time * 2 + 4) * 0.5 + 0.5
        
        ColorConfig[_._0x1(229).._._0x1(189).._._0x1(169).._._0x1(232).._._0x1(153).._._0x1(185).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(128).._._0x1(129)] = Color3.new(r, g, b)
        for espName, data in pairs(ESPData) do
            if data.Color == ColorConfig[_._0x1(229).._._0x1(189).._._0x1(169).._._0x1(232).._._0x1(153).._._0x1(185).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(128).._._0x1(129)] and _G[espName .. _._0x1(95).._._0x1(69).._._0x1(110).._._0x1(97).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(100)] then
                data.Color = ColorConfig[_._0x1(229).._._0x1(189).._._0x1(169).._._0x1(232).._._0x1(153).._._0x1(185).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(230).._._0x1(128).._._0x1(129)]
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
game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115)).LocalPlayer.AncestryChanged:Connect(function(_, parent)
    if not parent then
        CleanupESP()
    end
end)
StartRainbowEffect()
_G.ESPType = _._0x1(72).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(108).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116)
_G.EnableTracers = false
_G.EnableArrows = false
    local NotificationTab = Window:Tab({Title = _._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186), Icon = _._0x1(98).._._0x1(101).._._0x1(108).._._0x1(108)})

local EntityNotifyGroup = NotificationTab:Section({Title = _._0x1(229).._._0x1(174).._._0x1(158).._._0x1(228).._._0x1(189).._._0x1(147).._._0x1(229).._._0x1(136).._._0x1(183).._._0x1(230).._._0x1(150).._._0x1(176).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186).._._0x1(91).._._0x1(229).._._0x1(177).._._0x1(149).._._0x1(229).._._0x1(188).._._0x1(128).._._0x1(93), Side = _._0x1(76).._._0x1(101).._._0x1(102).._._0x1(116)})

local EntityNotifications = {
    Screech = {
        Description = _._0x1(229).._._0x1(176).._._0x1(150).._._0x1(229).._._0x1(149).._._0x1(184).._._0x1(232).._._0x1(128).._._0x1(133).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(231).._._0x1(148).._._0x1(159).._._0x1(230).._._0x1(136).._._0x1(144),
        Color = Color3.fromRGB(255, 255, 0)
    },
    Halt = {
        Description = _._0x1(230).._._0x1(154).._._0x1(130).._._0x1(229).._._0x1(129).._._0x1(156).._._0x1(229).._._0x1(174).._._0x1(158).._._0x1(228).._._0x1(189).._._0x1(147).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(229).._._0x1(135).._._0x1(186).._._0x1(231).._._0x1(142).._._0x1(176), 
        Color = Color3.fromRGB(0, 255, 255)
    },
    FigureRig = {
        Description = _._0x1(230).._._0x1(163).._._0x1(128).._._0x1(230).._._0x1(181).._._0x1(139).._._0x1(229).._._0x1(136).._._0x1(176).._._0x1(233).._._0x1(155).._._0x1(149).._._0x1(229).._._0x1(131).._._0x1(143),
        Color = Color3.fromRGB(255, 0, 0)
    },
    Eyes = {
        Description = _._0x1(231).._._0x1(156).._._0x1(188).._._0x1(231).._._0x1(157).._._0x1(155).._._0x1(229).._._0x1(174).._._0x1(158).._._0x1(228).._._0x1(189).._._0x1(147).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(231).._._0x1(148).._._0x1(159).._._0x1(230).._._0x1(136).._._0x1(144),
        Color = Color3.fromRGB(127, 30, 220)
    },
    SeekMoving = {
        Description = _._0x1(232).._._0x1(191).._._0x1(189).._._0x1(233).._._0x1(128).._._0x1(144).._._0x1(232).._._0x1(128).._._0x1(133).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(231).._._0x1(148).._._0x1(159).._._0x1(230).._._0x1(136).._._0x1(144),
        Color = Color3.fromRGB(255, 100, 100)
    },
    RushMoving = {
        Description = _._0x1(229).._._0x1(134).._._0x1(178).._._0x1(229).._._0x1(136).._._0x1(186).._._0x1(230).._._0x1(173).._._0x1(163).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(230).._._0x1(142).._._0x1(165).._._0x1(232).._._0x1(191).._._0x1(145),
        Color = Color3.fromRGB(0, 255, 0)
    },
    AmbushMoving = {
        Description = _._0x1(228).._._0x1(188).._._0x1(143).._._0x1(229).._._0x1(135).._._0x1(187).._._0x1(230).._._0x1(173).._._0x1(163).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(230).._._0x1(142).._._0x1(165).._._0x1(232).._._0x1(191).._._0x1(145), 
        Color = Color3.fromRGB(80, 255, 110)
    },
    A60 = {
        Description = _._0x1(65).._._0x1(45).._._0x1(54).._._0x1(48).._._0x1(32).._._0x1(230).._._0x1(173).._._0x1(163).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(229).._._0x1(134).._._0x1(178).._._0x1(229).._._0x1(136).._._0x1(186),
        Color = Color3.fromRGB(200, 50, 50)
    },
    A120 = {
        Description = _._0x1(65).._._0x1(45).._._0x1(49).._._0x1(50).._._0x1(48).._._0x1(32).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(233).._._0x1(153).._._0x1(132).._._0x1(232).._._0x1(191).._._0x1(145),
        Color = Color3.fromRGB(55, 55, 55)
    },
    GiggleCeiling = {
        Description = _._0x1(229).._._0x1(130).._._0x1(187).._._0x1(231).._._0x1(172).._._0x1(145).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(229).._._0x1(164).._._0x1(169).._._0x1(232).._._0x1(138).._._0x1(177).._._0x1(230).._._0x1(157).._._0x1(191).._._0x1(228).._._0x1(184).._._0x1(138),
        Color = Color3.fromRGB(200, 200, 200)
    },
    GrumbleRig = {
        Description = _._0x1(229).._._0x1(146).._._0x1(149).._._0x1(229).._._0x1(153).._._0x1(156).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(229).._._0x1(183).._._0x1(161).._._0x1(233).._._0x1(128).._._0x1(187),
        Color = Color3.fromRGB(150, 150, 150)
    },
    GloombatSwarm = {
        Description = _._0x1(230).._._0x1(154).._._0x1(151).._._0x1(229).._._0x1(189).._._0x1(177).._._0x1(232).._._0x1(157).._._0x1(153).._._0x1(232).._._0x1(157).._._0x1(160).._._0x1(231).._._0x1(190).._._0x1(164).._._0x1(230).._._0x1(157).._._0x1(165).._._0x1(232).._._0x1(162).._._0x1(173),
        Color = Color3.fromRGB(100, 100, 100)
    },
    Dread = {
        Description = _._0x1(230).._._0x1(129).._._0x1(144).._._0x1(230).._._0x1(131).._._0x1(167).._._0x1(229).._._0x1(174).._._0x1(158).._._0x1(228).._._0x1(189).._._0x1(147).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(230).._._0x1(191).._._0x1(128).._._0x1(230).._._0x1(180).._._0x1(187),
        Color = Color3.fromRGB(80, 80, 80)
    },
    BackdoorLookman = {
        Description = _._0x1(232).._._0x1(167).._._0x1(130).._._0x1(229).._._0x1(175).._._0x1(159).._._0x1(232).._._0x1(128).._._0x1(133).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(230).._._0x1(179).._._0x1(168).._._0x1(232).._._0x1(167).._._0x1(134),
        Color = Color3.fromRGB(110, 15, 15)
    },
    Snare = {
        Description = _._0x1(233).._._0x1(153).._._0x1(183).._._0x1(233).._._0x1(152).._._0x1(177).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(231).._._0x1(148).._._0x1(159).._._0x1(230).._._0x1(136).._._0x1(144),
        Color = Color3.fromRGB(100, 100, 100)
    },
    WorldLotus = {
        Description = _._0x1(230).._._0x1(163).._._0x1(128).._._0x1(230).._._0x1(181).._._0x1(139).._._0x1(229).._._0x1(136).._._0x1(176).._._0x1(228).._._0x1(184).._._0x1(150).._._0x1(231).._._0x1(149).._._0x1(140).._._0x1(232).._._0x1(142).._._0x1(178).._._0x1(232).._._0x1(138).._._0x1(177),
        Color = Color3.fromRGB(200, 230, 50)
    },
    Bramble = {
        Description = _._0x1(232).._._0x1(141).._._0x1(134).._._0x1(230).._._0x1(163).._._0x1(152).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(231).._._0x1(148).._._0x1(159).._._0x1(233).._._0x1(149).._._0x1(191),
        Color = Color3.fromRGB(50, 150, 30)
    },
    Caws = {
        Description = _._0x1(228).._._0x1(185).._._0x1(140).._._0x1(233).._._0x1(184).._._0x1(166).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(161).._._0x1(140),
        Color = Color3.fromRGB(30, 30, 30)
    },
    Eyestalk = {
        Description = _._0x1(231).._._0x1(156).._._0x1(188).._._0x1(230).._._0x1(159).._._0x1(132).._._0x1(229).._._0x1(176).._._0x1(134).._._0x1(232).._._0x1(166).._._0x1(129).._._0x1(232).._._0x1(191).._._0x1(189).._._0x1(233).._._0x1(128).._._0x1(144),
        Color = Color3.fromRGB(150, 80, 200)
    },
    Grampy = {
        Description = _._0x1(231).._._0x1(136).._._0x1(183).._._0x1(231).._._0x1(136).._._0x1(183).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(229).._._0x1(135).._._0x1(186).._._0x1(231).._._0x1(142).._._0x1(176),
        Color = Color3.fromRGB(180, 180, 180)
    },
    Groundskeeper = {
        Description = _._0x1(229).._._0x1(155).._._0x1(173).._._0x1(228).._._0x1(184).._._0x1(129).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(233).._._0x1(153).._._0x1(132).._._0x1(232).._._0x1(191).._._0x1(145),
        Color = Color3.fromRGB(100, 150, 50)
    },
    Mandrake = {
        Description = _._0x1(230).._._0x1(155).._._0x1(188).._._0x1(229).._._0x1(190).._._0x1(183).._._0x1(230).._._0x1(139).._._0x1(137).._._0x1(232).._._0x1(141).._._0x1(137).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(229).._._0x1(176).._._0x1(150).._._0x1(229).._._0x1(143).._._0x1(171),
        Color = Color3.fromRGB(130, 80, 30)
    },
    Monument = {
        Description = _._0x1(231).._._0x1(186).._._0x1(170).._._0x1(229).._._0x1(191).._._0x1(181).._._0x1(231).._._0x1(162).._._0x1(145).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(230).._._0x1(191).._._0x1(128).._._0x1(230).._._0x1(180).._._0x1(187),
        Color = Color3.fromRGB(150, 150, 150)
    },
    Surge = {
        Description = _._0x1(230).._._0x1(181).._._0x1(170).._._0x1(230).._._0x1(182).._._0x1(140).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(229).._._0x1(133).._._0x1(133).._._0x1(232).._._0x1(131).._._0x1(189),
        Color = Color3.fromRGB(230, 130, 30)
    },
    BackdoorRush = {
        Description = _._0x1(233).._._0x1(151).._._0x1(170).._._0x1(231).._._0x1(148).._._0x1(181).._._0x1(229).._._0x1(141).._._0x1(179).._._0x1(229).._._0x1(176).._._0x1(134).._._0x1(229).._._0x1(136).._._0x1(176).._._0x1(230).._._0x1(157).._._0x1(165),
        Color = Color3.fromRGB(230, 130, 30)
    }
}

local NotifyConnections = {}

EntityNotifyGroup:Toggle({
    Title = _._0x1(229).._._0x1(176).._._0x1(150).._._0x1(229).._._0x1(149).._._0x1(184).._._0x1(232).._._0x1(128).._._0x1(133).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(83).._._0x1(99).._._0x1(114).._._0x1(101).._._0x1(101).._._0x1(99).._._0x1(104), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(230).._._0x1(154).._._0x1(130).._._0x1(229).._._0x1(129).._._0x1(156).._._0x1(229).._._0x1(174).._._0x1(158).._._0x1(228).._._0x1(189).._._0x1(147).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186), 
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(72).._._0x1(97).._._0x1(108).._._0x1(116), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(233).._._0x1(155).._._0x1(149).._._0x1(229).._._0x1(131).._._0x1(143).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(70).._._0x1(105).._._0x1(103).._._0x1(117).._._0x1(114).._._0x1(101).._._0x1(82).._._0x1(105).._._0x1(103), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(231).._._0x1(156).._._0x1(188).._._0x1(231).._._0x1(157).._._0x1(155).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(69).._._0x1(121).._._0x1(101).._._0x1(115), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(232).._._0x1(191).._._0x1(189).._._0x1(233).._._0x1(128).._._0x1(144).._._0x1(232).._._0x1(128).._._0x1(133).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(83).._._0x1(101).._._0x1(101).._._0x1(107).._._0x1(77).._._0x1(111).._._0x1(118).._._0x1(105).._._0x1(110).._._0x1(103), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(229).._._0x1(134).._._0x1(178).._._0x1(229).._._0x1(136).._._0x1(186).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(82).._._0x1(117).._._0x1(115).._._0x1(104).._._0x1(77).._._0x1(111).._._0x1(118).._._0x1(105).._._0x1(110).._._0x1(103), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(228).._._0x1(188).._._0x1(143).._._0x1(229).._._0x1(135).._._0x1(187).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(65).._._0x1(109).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(104).._._0x1(77).._._0x1(111).._._0x1(118).._._0x1(105).._._0x1(110).._._0x1(103), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(65).._._0x1(45).._._0x1(54).._._0x1(48).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(65).._._0x1(54).._._0x1(48), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(65).._._0x1(45).._._0x1(49).._._0x1(50).._._0x1(48).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(65).._._0x1(49).._._0x1(50).._._0x1(48), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(229).._._0x1(130).._._0x1(187).._._0x1(231).._._0x1(172).._._0x1(145).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(71).._._0x1(105).._._0x1(103).._._0x1(103).._._0x1(108).._._0x1(101).._._0x1(67).._._0x1(101).._._0x1(105).._._0x1(108).._._0x1(105).._._0x1(110).._._0x1(103), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(229).._._0x1(146).._._0x1(149).._._0x1(229).._._0x1(153).._._0x1(156).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(71).._._0x1(114).._._0x1(117).._._0x1(109).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(82).._._0x1(105).._._0x1(103), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(230).._._0x1(154).._._0x1(151).._._0x1(229).._._0x1(189).._._0x1(177).._._0x1(232).._._0x1(157).._._0x1(153).._._0x1(232).._._0x1(157).._._0x1(160).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(71).._._0x1(108).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(98).._._0x1(97).._._0x1(116).._._0x1(83).._._0x1(119).._._0x1(97).._._0x1(114).._._0x1(109), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(230).._._0x1(129).._._0x1(144).._._0x1(230).._._0x1(131).._._0x1(167).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(68).._._0x1(114).._._0x1(101).._._0x1(97).._._0x1(100), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(232).._._0x1(167).._._0x1(130).._._0x1(229).._._0x1(175).._._0x1(159).._._0x1(232).._._0x1(128).._._0x1(133).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(66).._._0x1(97).._._0x1(99).._._0x1(107).._._0x1(100).._._0x1(111).._._0x1(111).._._0x1(114).._._0x1(76).._._0x1(111).._._0x1(111).._._0x1(107).._._0x1(109).._._0x1(97).._._0x1(110), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(233).._._0x1(153).._._0x1(183).._._0x1(233).._._0x1(152).._._0x1(177).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(83).._._0x1(110).._._0x1(97).._._0x1(114).._._0x1(101), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(228).._._0x1(184).._._0x1(150).._._0x1(231).._._0x1(149).._._0x1(140).._._0x1(232).._._0x1(142).._._0x1(178).._._0x1(232).._._0x1(138).._._0x1(177).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(87).._._0x1(111).._._0x1(114).._._0x1(108).._._0x1(100).._._0x1(76).._._0x1(111).._._0x1(116).._._0x1(117).._._0x1(115), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(232).._._0x1(141).._._0x1(134).._._0x1(230).._._0x1(163).._._0x1(152).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(66).._._0x1(114).._._0x1(97).._._0x1(109).._._0x1(98).._._0x1(108).._._0x1(101), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(228).._._0x1(185).._._0x1(140).._._0x1(233).._._0x1(184).._._0x1(166).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(67).._._0x1(97).._._0x1(119).._._0x1(115), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(231).._._0x1(156).._._0x1(188).._._0x1(230).._._0x1(159).._._0x1(132).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(69).._._0x1(121).._._0x1(101).._._0x1(115).._._0x1(116).._._0x1(97).._._0x1(108).._._0x1(107), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(231).._._0x1(136).._._0x1(183).._._0x1(231).._._0x1(136).._._0x1(183).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(71).._._0x1(114).._._0x1(97).._._0x1(109).._._0x1(112).._._0x1(121), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(229).._._0x1(155).._._0x1(173).._._0x1(228).._._0x1(184).._._0x1(129).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(71).._._0x1(114).._._0x1(111).._._0x1(117).._._0x1(110).._._0x1(100).._._0x1(115).._._0x1(107).._._0x1(101).._._0x1(101).._._0x1(112).._._0x1(101).._._0x1(114), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(230).._._0x1(155).._._0x1(188).._._0x1(229).._._0x1(190).._._0x1(183).._._0x1(230).._._0x1(139).._._0x1(137).._._0x1(232).._._0x1(141).._._0x1(137).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(77).._._0x1(97).._._0x1(110).._._0x1(100).._._0x1(114).._._0x1(97).._._0x1(107).._._0x1(101), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(231).._._0x1(186).._._0x1(170).._._0x1(229).._._0x1(191).._._0x1(181).._._0x1(231).._._0x1(162).._._0x1(145).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(77).._._0x1(111).._._0x1(110).._._0x1(117).._._0x1(109).._._0x1(101).._._0x1(110).._._0x1(116), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(230).._._0x1(181).._._0x1(170).._._0x1(230).._._0x1(182).._._0x1(140).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(83).._._0x1(117).._._0x1(114).._._0x1(103).._._0x1(101), Value)
    end
})

EntityNotifyGroup:Toggle({
    Title = _._0x1(233).._._0x1(151).._._0x1(170).._._0x1(231).._._0x1(148).._._0x1(181).._._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Default = false,
    Callback = function(Value)
        SetupEntityNotification(_._0x1(66).._._0x1(97).._._0x1(99).._._0x1(107).._._0x1(100).._._0x1(111).._._0x1(111).._._0x1(114).._._0x1(82).._._0x1(117).._._0x1(115).._._0x1(104), Value)
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
            WindUI:Notify(_._0x1(229).._._0x1(174).._._0x1(158).._._0x1(228).._._0x1(189).._._0x1(147).._._0x1(229).._._0x1(136).._._0x1(183).._._0x1(230).._._0x1(150).._._0x1(176), entityData.Description, 5)
        end
    end

    NotifyConnections[entityName] = workspace.ChildAdded:Connect(onEntityAdded)

    local rooms = workspace:FindFirstChild(_._0x1(67).._._0x1(117).._._0x1(114).._._0x1(114).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115))
    if rooms then
        local roomConn = rooms.DescendantAdded:Connect(function(obj)
            if obj.Name == entityName then
                WindUI:Notify(_._0x1(229).._._0x1(174).._._0x1(158).._._0x1(228).._._0x1(189).._._0x1(147).._._0x1(229).._._0x1(136).._._0x1(183).._._0x1(230).._._0x1(150).._._0x1(176), entityData.Description, 5)
            end
        end)
        NotifyConnections[entityName .. _._0x1(95).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(109).._._0x1(115)] = roomConn
    end
end

    end
      end
})
Section:Button({
    Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(45).._._0x1(230).._._0x1(168).._._0x1(161).._._0x1(228).._._0x1(187).._._0x1(191).._._0x1(232).._._0x1(128).._._0x1(133),
    Callback = function()
    
local WindUI = loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(70).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(97).._._0x1(103).._._0x1(101).._._0x1(115).._._0x1(117).._._0x1(115).._._0x1(47).._._0x1(87).._._0x1(105).._._0x1(110).._._0x1(100).._._0x1(85).._._0x1(73).._._0x1(47).._._0x1(114).._._0x1(101).._._0x1(108).._._0x1(101).._._0x1(97).._._0x1(115).._._0x1(101).._._0x1(115).._._0x1(47).._._0x1(108).._._0x1(97).._._0x1(116).._._0x1(101).._._0x1(115).._._0x1(116).._._0x1(47).._._0x1(100).._._0x1(111).._._0x1(119).._._0x1(110).._._0x1(108).._._0x1(111).._._0x1(97).._._0x1(100).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(46).._._0x1(108).._._0x1(117).._._0x1(97)))()
local Window = WindUI:CreateWindow({
        Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(60).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(32).._._0x1(99).._._0x1(111).._._0x1(108).._._0x1(111).._._0x1(114).._._0x1(61).._._0x1(39).._._0x1(35).._._0x1(48).._._0x1(48).._._0x1(70).._._0x1(70).._._0x1(48).._._0x1(48).._._0x1(39).._._0x1(62).._._0x1(230).._._0x1(168).._._0x1(161).._._0x1(228).._._0x1(187).._._0x1(191).._._0x1(232).._._0x1(128).._._0x1(133).._._0x1(60).._._0x1(47).._._0x1(102).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(62),
        Icon = _._0x1(114).._._0x1(98).._._0x1(120).._._0x1(97).._._0x1(115).._._0x1(115).._._0x1(101).._._0x1(116).._._0x1(105).._._0x1(100).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(56).._._0x1(49).._._0x1(57).._._0x1(52).._._0x1(52).._._0x1(54).._._0x1(50).._._0x1(57).._._0x1(57).._._0x1(48).._._0x1(51).._._0x1(56).._._0x1(54).._._0x1(52),
        IconTransparency = 0.5,
        IconThemed = true,
        Author = _._0x1(228).._._0x1(189).._._0x1(156).._._0x1(232).._._0x1(128).._._0x1(133).._._0x1(58).._._0x1(229).._._0x1(176).._._0x1(143).._._0x1(229).._._0x1(164).._._0x1(156),
        Folder = _._0x1(67).._._0x1(108).._._0x1(111).._._0x1(117).._._0x1(100).._._0x1(72).._._0x1(117).._._0x1(98),
        Size = UDim2.fromOffset(400, 300),
        Transparent = true,
        Theme = _._0x1(76).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116),
        User = {
            Enabled = true,
            Callback = function() _G[_._0x1(112).._._0x1(114).._._0x1(105).._._0x1(110).._._0x1(116)](_._0x1(99).._._0x1(108).._._0x1(105).._._0x1(99).._._0x1(107).._._0x1(101).._._0x1(100)) end,
            Anonymous = false
        },
        SideBarWidth = 200,
        ScrollBarEnabled = true,
        Background = _._0x1(114).._._0x1(98).._._0x1(120).._._0x1(97).._._0x1(115).._._0x1(115).._._0x1(101).._._0x1(116).._._0x1(105).._._0x1(100).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(52).._._0x1(49).._._0x1(53).._._0x1(53).._._0x1(56).._._0x1(48).._._0x1(49).._._0x1(50).._._0x1(53).._._0x1(50)
    })
    

Window:EditOpenButton({
    Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(45).._._0x1(230).._._0x1(168).._._0x1(161).._._0x1(228).._._0x1(187).._._0x1(191).._._0x1(232).._._0x1(128).._._0x1(133),
    Icon = _._0x1(109).._._0x1(111).._._0x1(110).._._0x1(105).._._0x1(116).._._0x1(111).._._0x1(114),
    CornerRadius = UDim.new(0, 16),
    StrokeThickness = 2,
    Color = openButtonColor,
    Draggable = true,
})

Window:Tag({
    Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Color = Color3.fromHex(_._0x1(35).._._0x1(51).._._0x1(48).._._0x1(102).._._0x1(102).._._0x1(54).._._0x1(97))
})

Window:Tag({
        Title = _._0x1(88).._._0x1(89).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172), -- 标签汉化
        Color = Color3.fromHex(_._0x1(35).._._0x1(51).._._0x1(49).._._0x1(53).._._0x1(100).._._0x1(102).._._0x1(102))
    })
    local TimeTag = Window:Tag({
        Title = _._0x1(230).._._0x1(168).._._0x1(161).._._0x1(228).._._0x1(187).._._0x1(191).._._0x1(232).._._0x1(128).._._0x1(133),
        Color = Color3.fromHex(_._0x1(35).._._0x1(48).._._0x1(48).._._0x1(48).._._0x1(48).._._0x1(48).._._0x1(48))
    })

local Tabs = {
    Main = Window:Section({ Title = _._0x1(230).._._0x1(137).._._0x1(128).._._0x1(230).._._0x1(156).._._0x1(137).._._0x1(229).._._0x1(133).._._0x1(179).._._0x1(229).._._0x1(141).._._0x1(161), Opened = true }),
    gn = Window:Section({ Title = _._0x1(229).._._0x1(138).._._0x1(159).._._0x1(232).._._0x1(131).._._0x1(189), Opened = true }),    
}

local TabHandles = {
    Q = Tabs.Main:Tab({ Title = _._0x1(228).._._0x1(188).._._0x1(160).._._0x1(233).._._0x1(128).._._0x1(129).._._0x1(229).._._0x1(171).._._0x1(137).._._0x1(229).._._0x1(166).._._0x1(146).._._0x1(49), Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100) }),
    W = Tabs.Main:Tab({ Title = _._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134).._._0x1(229).._._0x1(138).._._0x1(159).._._0x1(232).._._0x1(131).._._0x1(189), Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100) }),
    E = Tabs.Main:Tab({ Title = _._0x1(), Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100) }),
    R = Tabs.Main:Tab({ Title = _._0x1(), Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100) }),
    T = Tabs.Main:Tab({ Title = _._0x1(), Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100) }),
    Y = Tabs.Main:Tab({ Title = _._0x1(), Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100) }),
    U = Tabs.Main:Tab({ Title = _._0x1(), Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100) }),    
}
-----------------------------------屋子里------------------------------------------------

local Button = TabHandles.Q:Button({
    Title = _._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Desc = _._0x1(231).._._0x1(172).._._0x1(172).._._0x1(228).._._0x1(184).._._0x1(128).._._0x1(229).._._0x1(133).._._0x1(179).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(230).._._0x1(151).._._0x1(165).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(229).._._0x1(177).._._0x1(139).._._0x1(229).._._0x1(173).._._0x1(144).._._0x1(233).._._0x1(135).._._0x1(140),
    Image = _._0x1(112).._._0x1(97).._._0x1(108).._._0x1(101).._._0x1(116).._._0x1(116).._._0x1(101),
    ImageSize = 20,
    Color = _._0x1(87).._._0x1(104).._._0x1(105).._._0x1(116).._._0x1(101)
})

Button = TabHandles.Q:Button({
    Title = _._0x1(233).._._0x1(154).._._0x1(144).._._0x1(232).._._0x1(186).._._0x1(171).._._0x1(230).._._0x1(128).._._0x1(170).._._0x1(231).._._0x1(137).._._0x1(169).._._0x1(231).._._0x1(156).._._0x1(139).._._0x1(228).._._0x1(184).._._0x1(141).._._0x1(232).._._0x1(167).._._0x1(129),
    Desc = _._0x1(230).._._0x1(156).._._0x1(137).._._0x1(228).._._0x1(186).._._0x1(155).._._0x1(229).._._0x1(133).._._0x1(179).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(239).._._0x1(188).._._0x1(140).._._0x1(228).._._0x1(184).._._0x1(128).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(228).._._0x1(184).._._0x1(128).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(231).._._0x1(154).._._0x1(132),
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(89).._._0x1(117).._._0x1(110).._._0x1(103).._._0x1(101).._._0x1(110).._._0x1(103).._._0x1(120).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(114).._._0x1(111).._._0x1(98).._._0x1(108).._._0x1(111).._._0x1(120).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(121).._._0x1(105).._._0x1(110).._._0x1(115).._._0x1(104).._._0x1(101).._._0x1(110)))()
            
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 1, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = _._0x1(229).._._0x1(138).._._0x1(168).._._0x1(231).._._0x1(148).._._0x1(187).._._0x1(230).._._0x1(136).._._0x1(191).._._0x1(233).._._0x1(151).._._0x1(180),
    Desc = _._0x1(),
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( -1675.27, -23.32, -3411.01)
            
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 1, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = _._0x1(230).._._0x1(148).._._0x1(190).._._0x1(230).._._0x1(175).._._0x1(146).._._0x1(232).._._0x1(128).._._0x1(129).._._0x1(233).._._0x1(188).._._0x1(160).._._0x1(229).._._0x1(156).._._0x1(176).._._0x1(230).._._0x1(150).._._0x1(185),
    Desc = _._0x1(),
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( -1562.39,  -29.25,  -3403.67)
            
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 1, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = _._0x1(232).._._0x1(128).._._0x1(129).._._0x1(233).._._0x1(188).._._0x1(160).._._0x1(49),
    Desc = _._0x1(),
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( -1524.21,  -29.25,  -3580.63)
            
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 1, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = _._0x1(232).._._0x1(128).._._0x1(129).._._0x1(233).._._0x1(188).._._0x1(160).._._0x1(50),
    Desc = _._0x1(),
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1642.97,  -23.44,  -3434.15)
            
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 1, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = _._0x1(232).._._0x1(128).._._0x1(129).._._0x1(233).._._0x1(188).._._0x1(160).._._0x1(51),
    Desc = _._0x1(),
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( -1680.65,  -23.47,  -3391.97)
            
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 1, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = _._0x1(232).._._0x1(128).._._0x1(129).._._0x1(233).._._0x1(188).._._0x1(160).._._0x1(52),
    Desc = _._0x1(),
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( -1620.64,  -23.44,  -3397.37)
            
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 1, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = _._0x1(230).._._0x1(175).._._0x1(146).._._0x1(232).._._0x1(128).._._0x1(129).._._0x1(233).._._0x1(188).._._0x1(160).._._0x1(232).._._0x1(128).._._0x1(129).._._0x1(228).._._0x1(186).._._0x1(149),
    Desc = _._0x1(232).._._0x1(128).._._0x1(129).._._0x1(233).._._0x1(188).._._0x1(160).._._0x1(230).._._0x1(175).._._0x1(146).._._0x1(230).._._0x1(148).._._0x1(190).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(232).._._0x1(128).._._0x1(129).._._0x1(233).._._0x1(188).._._0x1(160).._._0x1(232).._._0x1(186).._._0x1(171).._._0x1(228).._._0x1(184).._._0x1(138).._._0x1(231).._._0x1(154).._._0x1(132),
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( -1531.34, -30.17,  -3541.97)
            
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 1, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})                        
            
 end
})
-----------------------------------山坡上巨蛇------------------------------------------------

local Button = TabHandles.Q:Button({
    Title = _._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Desc = _._0x1(231).._._0x1(172).._._0x1(172).._._0x1(228).._._0x1(186).._._0x1(140).._._0x1(229).._._0x1(133).._._0x1(179).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(177).._._0x1(177).._._0x1(229).._._0x1(157).._._0x1(161).._._0x1(228).._._0x1(184).._._0x1(138).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(229).._._0x1(183).._._0x1(168).._._0x1(232).._._0x1(155).._._0x1(135),
    Image = _._0x1(112).._._0x1(97).._._0x1(108).._._0x1(101).._._0x1(116).._._0x1(116).._._0x1(101),
    ImageSize = 20,
    Color = _._0x1(87).._._0x1(104).._._0x1(105).._._0x1(116).._._0x1(101)
})


Button = TabHandles.Q:Button({
    Title = _._0x1(229).._._0x1(183).._._0x1(168).._._0x1(229).._._0x1(164).._._0x1(167).._._0x1(232).._._0x1(155).._._0x1(135).._._0x1(230).._._0x1(128).._._0x1(170).._._0x1(229).._._0x1(177).._._0x1(177).._._0x1(229).._._0x1(157).._._0x1(161).._._0x1(231).._._0x1(167).._._0x1(146).._._0x1(232).._._0x1(191).._._0x1(135),
    Desc = _._0x1(),
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( 578.31,  567.98,  -380.59)
            
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 1, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = _._0x1(230).._._0x1(180).._._0x1(158).._._0x1(231).._._0x1(169).._._0x1(180).._._0x1(231).._._0x1(167).._._0x1(146).._._0x1(232).._._0x1(191).._._0x1(135),
    Desc = _._0x1(),
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( 3837.46,  137.13,  12.84)
            
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 3, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})                        
            
 end
})
-----------------------------------村庄------------------------------------------------

local Button = TabHandles.Q:Button({
    Title = _._0x1(230).._._0x1(143).._._0x1(144).._._0x1(231).._._0x1(164).._._0x1(186),
    Desc = _._0x1(231).._._0x1(172).._._0x1(172).._._0x1(228).._._0x1(184).._._0x1(137).._._0x1(229).._._0x1(133).._._0x1(179).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(228).._._0x1(189).._._0x1(160).._._0x1(229).._._0x1(156).._._0x1(168).._._0x1(230).._._0x1(157).._._0x1(145).._._0x1(229).._._0x1(186).._._0x1(132).._._0x1(233).._._0x1(135).._._0x1(140),
    Image = _._0x1(112).._._0x1(97).._._0x1(108).._._0x1(101).._._0x1(116).._._0x1(116).._._0x1(101),
    ImageSize = 20,
    Color = _._0x1(87).._._0x1(104).._._0x1(105).._._0x1(116).._._0x1(101)
})


Button = TabHandles.Q:Button({
    Title = _._0x1(228).._._0x1(188).._._0x1(160).._._0x1(233).._._0x1(128).._._0x1(129).._._0x1(232).._._0x1(176).._._0x1(136).._._0x1(232).._._0x1(175).._._0x1(157).._._0x1(230).._._0x1(157).._._0x1(145).._._0x1(230).._._0x1(176).._._0x1(145),
    Desc = _._0x1(),
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new()
            
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 1, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
})                        
            
 end
})

Button = TabHandles.Q:Button({
    Title = _._0x1(228).._._0x1(188).._._0x1(160).._._0x1(233).._._0x1(128).._._0x1(129).._._0x1(230).._._0x1(180).._._0x1(158).._._0x1(231).._._0x1(169).._._0x1(180).._._0x1(233).._._0x1(135).._._0x1(140),
    Desc = _._0x1(),
    Locked = false,
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( 343.48,  20.66,  3608.81)
            
WindUI:Notify({
    Title = _._0x1(233).._._0x1(128).._._0x1(154).._._0x1(231).._._0x1(159).._._0x1(165),
    Content = _._0x1(229).._._0x1(138).._._0x1(160).._._0x1(232).._._0x1(189).._._0x1(189).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159),
    Duration = 1, -- 3 seconds
    Icon = _._0x1(108).._._0x1(97).._._0x1(121).._._0x1(111).._._0x1(117).._._0x1(116).._._0x1(45).._._0x1(103).._._0x1(114).._._0x1(105).._._0x1(100),
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

local Players = game:GetService(_._0x1(80).._._0x1(108).._._0x1(97).._._0x1(121).._._0x1(101).._._0x1(114).._._0x1(115))
local RunService = game:GetService(_._0x1(82).._._0x1(117).._._0x1(110).._._0x1(83).._._0x1(101).._._0x1(114).._._0x1(118).._._0x1(105).._._0x1(99).._._0x1(101))
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local function getGradientColor(time)
    local r = math.sin(time * 2) * 0.5 + 0.5
    local g = math.sin(time * 3) * 0.5 + 0.5
    local b = math.sin(time * 4) * 0.5 + 0.5
    return Color3.new(r, g, b)
end

local playerCountText = Drawing.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116))
playerCountText.Visible = false
playerCountText.Color = Color3.new(1, 1, 1)
playerCountText.Size = 20
playerCountText.Font = Drawing.Fonts.Monospace
playerCountText.Outline = true
playerCountText.OutlineColor = Color3.new(0, 0, 0)
playerCountText.Position = Vector2.new(Camera.ViewportSize.X / 2, 10)

local fovCircle = Drawing.new(_._0x1(67).._._0x1(105).._._0x1(114).._._0x1(99).._._0x1(108).._._0x1(101))
fovCircle.Visible = false
fovCircle.Color = getgenv().FOVColor
fovCircle.Thickness = 1
fovCircle.Filled = false
fovCircle.Radius = getgenv().FOVRadius
fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

local function updatePlayerCount()
    local playerCount = #Players:GetPlayers()
    playerCountText.Text = _._0x1(229).._._0x1(156).._._0x1(168).._._0x1(231).._._0x1(186).._._0x1(191).._._0x1(231).._._0x1(142).._._0x1(169).._._0x1(229).._._0x1(174).._._0x1(182).._._0x1(58).._._0x1(32) .. playerCount
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
    local box = Drawing.new(_._0x1(83).._._0x1(113).._._0x1(117).._._0x1(97).._._0x1(114).._._0x1(101))
    box.Visible = false
    box.Color = getgenv().BoxColor
    box.Thickness = getgenv().BoxThickness
    box.Filled = false

    local healthBar = Drawing.new(_._0x1(83).._._0x1(113).._._0x1(117).._._0x1(97).._._0x1(114).._._0x1(101))
    healthBar.Visible = false
    healthBar.Color = getgenv().HealthBarColor
    healthBar.Thickness = 1
    healthBar.Filled = true

    local healthBarBackground = Drawing.new(_._0x1(83).._._0x1(113).._._0x1(117).._._0x1(97).._._0x1(114).._._0x1(101))
    healthBarBackground.Visible = false
    healthBarBackground.Color = Color3.new(0, 0, 0)
    healthBarBackground.Transparency = 0.5
    healthBarBackground.Thickness = 1
    healthBarBackground.Filled = true

    local healthBarBorder = Drawing.new(_._0x1(83).._._0x1(113).._._0x1(117).._._0x1(97).._._0x1(114).._._0x1(101))
    healthBarBorder.Visible = false
    healthBarBorder.Color = Color3.new(1, 1, 1)
    healthBarBorder.Thickness = 1
    healthBarBorder.Filled = false

    local healthText = Drawing.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116))
    healthText.Visible = false
    healthText.Color = getgenv().HealthTextColor
    healthText.Size = 14
    healthText.Font = Drawing.Fonts.Monospace
    healthText.Outline = true
    healthText.OutlineColor = Color3.new(0, 0, 0)

    local nameText = Drawing.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116))
    nameText.Visible = false
    nameText.Color = getgenv().NameColor
    nameText.Size = 16
    nameText.Font = Drawing.Fonts.Monospace
    nameText.Outline = true
    nameText.OutlineColor = Color3.new(0, 0, 0)

    local distanceText = Drawing.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116))
    distanceText.Visible = false
    distanceText.Color = getgenv().DistanceColor
    distanceText.Size = 14
    distanceText.Font = Drawing.Fonts.Monospace
    distanceText.Outline = true
    distanceText.OutlineColor = Color3.new(0, 0, 0)

    local weaponText = Drawing.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116))
    weaponText.Visible = false
    weaponText.Color = getgenv().WeaponColor
    weaponText.Size = 14
    weaponText.Font = Drawing.Fonts.Monospace
    weaponText.Outline = true
    weaponText.OutlineColor = Color3.new(0, 0, 0)

    local tracer = Drawing.new(_._0x1(76).._._0x1(105).._._0x1(110).._._0x1(101))
    tracer.Visible = false
    tracer.Color = getgenv().TracerColor
    tracer.Thickness = getgenv().TracerThickness

    local arrow = Drawing.new(_._0x1(84).._._0x1(114).._._0x1(105).._._0x1(97).._._0x1(110).._._0x1(103).._._0x1(108).._._0x1(101))
    arrow.Visible = false
    arrow.Color = getgenv().ArrowColor
    arrow.Filled = true
    arrow.Thickness = 1

    local skeletonLines = {}
    local skeletonPoints = {}

    local function createSkeleton()
        for i = 1, 15 do
            skeletonLines[i] = Drawing.new(_._0x1(76).._._0x1(105).._._0x1(110).._._0x1(101))
            skeletonLines[i].Visible = false
            skeletonLines[i].Color = getgenv().SkeletonColor
            skeletonLines[i].Thickness = getgenv().SkeletonThickness
        end

        skeletonPoints[_._0x1(72).._._0x1(101).._._0x1(97).._._0x1(100)] = Drawing.new(_._0x1(67).._._0x1(105).._._0x1(114).._._0x1(99).._._0x1(108).._._0x1(101))
        skeletonPoints[_._0x1(72).._._0x1(101).._._0x1(97).._._0x1(100)].Visible = false
        skeletonPoints[_._0x1(72).._._0x1(101).._._0x1(97).._._0x1(100)].Color = Color3.new(1, 0.5, 0)
        skeletonPoints[_._0x1(72).._._0x1(101).._._0x1(97).._._0x1(100)].Thickness = 2
        skeletonPoints[_._0x1(72).._._0x1(101).._._0x1(97).._._0x1(100)].Filled = true
        skeletonPoints[_._0x1(72).._._0x1(101).._._0x1(97).._._0x1(100)].Radius = 4
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
        if not getgenv().ESPEnabled or not player.Character or not player.Character:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) or not player.Character:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100)) or player == LocalPlayer then
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
        local rootPart = character:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116))
        local humanoid = character:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100))

        if rootPart and humanoid and humanoid.Health > 0 then
            local rootPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            local headPos, _ = Camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 3, 0))
            local legPos, _ = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))

            local weaponName = _._0x1(230).._._0x1(151).._._0x1(160).._._0x1(230).._._0x1(173).._._0x1(166).._._0x1(229).._._0x1(153).._._0x1(168)
            for _, tool in ipairs(character:GetChildren()) do
                if tool:IsA(_._0x1(84).._._0x1(111).._._0x1(111).._._0x1(108)) then
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
                healthText.Text = math.floor(humanoid.Health) .. _._0x1(47) .. math.floor(humanoid.MaxHealth)
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
                    distanceText.Text = math.floor(distance) .. _._0x1(109)
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
                local head = character:FindFirstChild(_._0x1(72).._._0x1(101).._._0x1(97).._._0x1(100))
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
                local head = character:FindFirstChild(_._0x1(72).._._0x1(101).._._0x1(97).._._0x1(100))
                local torso = character:FindFirstChild(_._0x1(84).._._0x1(111).._._0x1(114).._._0x1(115).._._0x1(111)) or character:FindFirstChild(_._0x1(85).._._0x1(112).._._0x1(112).._._0x1(101).._._0x1(114).._._0x1(84).._._0x1(111).._._0x1(114).._._0x1(115).._._0x1(111))
                local leftArm = character:FindFirstChild(_._0x1(76).._._0x1(101).._._0x1(102).._._0x1(116).._._0x1(32).._._0x1(65).._._0x1(114).._._0x1(109)) or character:FindFirstChild(_._0x1(76).._._0x1(101).._._0x1(102).._._0x1(116).._._0x1(85).._._0x1(112).._._0x1(112).._._0x1(101).._._0x1(114).._._0x1(65).._._0x1(114).._._0x1(109))
                local rightArm = character:FindFirstChild(_._0x1(82).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116).._._0x1(32).._._0x1(65).._._0x1(114).._._0x1(109)) or character:FindFirstChild(_._0x1(82).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116).._._0x1(85).._._0x1(112).._._0x1(112).._._0x1(101).._._0x1(114).._._0x1(65).._._0x1(114).._._0x1(109))
                local leftLeg = character:FindFirstChild(_._0x1(76).._._0x1(101).._._0x1(102).._._0x1(116).._._0x1(32).._._0x1(76).._._0x1(101).._._0x1(103)) or character:FindFirstChild(_._0x1(76).._._0x1(101).._._0x1(102).._._0x1(116).._._0x1(85).._._0x1(112).._._0x1(112).._._0x1(101).._._0x1(114).._._0x1(76).._._0x1(101).._._0x1(103))
                local rightLeg = character:FindFirstChild(_._0x1(82).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116).._._0x1(32).._._0x1(76).._._0x1(101).._._0x1(103)) or character:FindFirstChild(_._0x1(82).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116).._._0x1(85).._._0x1(112).._._0x1(112).._._0x1(101).._._0x1(114).._._0x1(76).._._0x1(101).._._0x1(103))
                
                if head and torso and leftArm and rightArm and leftLeg and rightLeg then
                    local headPos = Camera:WorldToViewportPoint(head.Position)
                    local torsoPos = Camera:WorldToViewportPoint(torso.Position)
                    local leftArmPos = Camera:WorldToViewportPoint(leftArm.Position)
                    local rightArmPos = Camera:WorldToViewportPoint(rightArm.Position)
                    local leftLegPos = Camera:WorldToViewportPoint(leftLeg.Position)
                    local rightLegPos = Camera:WorldToViewportPoint(rightLeg.Position)

                    skeletonPoints[_._0x1(72).._._0x1(101).._._0x1(97).._._0x1(100)].Position = Vector2.new(headPos.X, headPos.Y)
                    skeletonPoints[_._0x1(72).._._0x1(101).._._0x1(97).._._0x1(100)].Visible = true

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
                    
                    if character:FindFirstChild(_._0x1(76).._._0x1(101).._._0x1(102).._._0x1(116).._._0x1(76).._._0x1(111).._._0x1(119).._._0x1(101).._._0x1(114).._._0x1(65).._._0x1(114).._._0x1(109)) then
                        local leftLowerArmPos = Camera:WorldToViewportPoint(character.LeftLowerArm.Position)
                        skeletonLines[6].From = Vector2.new(leftArmPos.X, leftArmPos.Y)
                        skeletonLines[6].To = Vector2.new(leftLowerArmPos.X, leftLowerArmPos.Y)
                        skeletonLines[6].Visible = true
                    end

                    if character:FindFirstChild(_._0x1(76).._._0x1(101).._._0x1(102).._._0x1(116).._._0x1(76).._._0x1(111).._._0x1(119).._._0x1(101).._._0x1(114).._._0x1(76).._._0x1(101).._._0x1(103)) then
                        local leftLowerLegPos = Camera:WorldToViewportPoint(character.LeftLowerLeg.Position)
                        skeletonLines[8].From = Vector2.new(leftLegPos.X, leftLegPos.Y)
                        skeletonLines[8].To = Vector2.new(leftLowerLegPos.X, leftLowerLegPos.Y)
                        skeletonLines[8].Visible = true
                    end

                    if character:FindFirstChild(_._0x1(82).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116).._._0x1(76).._._0x1(111).._._0x1(119).._._0x1(101).._._0x1(114).._._0x1(76).._._0x1(101).._._0x1(103)) then
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

local radar = Drawing.new(_._0x1(67).._._0x1(105).._._0x1(114).._._0x1(99).._._0x1(108).._._0x1(101))
radar.Visible = false
radar.Color = Color3.new(1, 1, 1)
radar.Thickness = 2
radar.Filled = false
radar.Radius = 100
radar.Position = Vector2.new(Camera.ViewportSize.X - 120, 120)

local radarCenter = Drawing.new(_._0x1(67).._._0x1(105).._._0x1(114).._._0x1(99).._._0x1(108).._._0x1(101))
radarCenter.Visible = false
radarCenter.Color = Color3.new(1, 1, 1)
radarCenter.Thickness = 2
radarCenter.Filled = true
radarCenter.Radius = 3
radarCenter.Position = radar.Position

local radarDirection = Drawing.new(_._0x1(76).._._0x1(105).._._0x1(110).._._0x1(101))
radarDirection.Visible = false
radarDirection.Color = Color3.new(1, 1, 1)
radarDirection.Thickness = 2

local radarGridLines = {}
for i = 1, 4 do
    radarGridLines[i] = Drawing.new(_._0x1(76).._._0x1(105).._._0x1(110).._._0x1(101))
    radarGridLines[i].Visible = false
    radarGridLines[i].Color = Color3.new(0.5, 0.5, 0.5)
    radarGridLines[i].Thickness = 1
end

local radarRangeText = Drawing.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116))
radarRangeText.Visible = false
radarRangeText.Color = Color3.new(1, 1, 1)
radarRangeText.Size = 14
radarRangeText.Font = Drawing.Fonts.Monospace
radarRangeText.Outline = true
radarRangeText.OutlineColor = Color3.new(0, 0, 0)
radarRangeText.Text = _._0x1(49).._._0x1(48).._._0x1(48).._._0x1(109)

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
        if player.Character and player.Character:FindFirstChild(_._0x1(72).._._0x1(117).._._0x1(109).._._0x1(97).._._0x1(110).._._0x1(111).._._0x1(105).._._0x1(100).._._0x1(82).._._0x1(111).._._0x1(111).._._0x1(116).._._0x1(80).._._0x1(97).._._0x1(114).._._0x1(116)) and player ~= LocalPlayer then
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
                    dot = Drawing.new(_._0x1(67).._._0x1(105).._._0x1(114).._._0x1(99).._._0x1(108).._._0x1(101)),
                    direction = Drawing.new(_._0x1(76).._._0x1(105).._._0x1(110).._._0x1(101)),
                    name = Drawing.new(_._0x1(84).._._0x1(101).._._0x1(120).._._0x1(116))
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
            if typeof(component) == _._0x1(116).._._0x1(97).._._0x1(98).._._0x1(108).._._0x1(101) then
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
    Title = _._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134).._._0x1(229).._._0x1(188).._._0x1(128).._._0x1(229).._._0x1(144).._._0x1(175), 
    Value = false, 
    Callback = function(Value)
        getgenv().ESPEnabled = Value
    end
})

Toggle = TabHandles.W:Toggle({
    Title = _._0x1(230).._._0x1(168).._._0x1(161).._._0x1(229).._._0x1(158).._._0x1(139).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134), 
    Value = false, 
    Callback = function(Value)
        getgenv().ShowSkeleton = Value
    end
})

Toggle = TabHandles.W:Toggle({
    Title = _._0x1(230).._._0x1(150).._._0x1(185).._._0x1(230).._._0x1(161).._._0x1(134).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134), 
    Value = false, 
    Callback = function(Value)
        getgenv().ShowBox = Value
    end
})



Toggle = TabHandles.W:Toggle({
    Title = _._0x1(229).._._0x1(176).._._0x1(132).._._0x1(231).._._0x1(186).._._0x1(191).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134), 
    Value = false, 
    Callback = function(Value)
        getgenv().ShowTracer = Value
    end
})

local bulletTrackingEnabled = true  
local oldHook = nil

Toggle = TabHandles.W:Toggle({
    Title = _._0x1(229).._._0x1(144).._._0x1(141).._._0x1(229).._._0x1(173).._._0x1(151).._._0x1(233).._._0x1(128).._._0x1(143).._._0x1(232).._._0x1(167).._._0x1(134), 
    Value = false, 
    Callback = function(Value)
        getgenv().ShowName = Value
    end
})
      end
})
local Section = Tab:Section({
    Title = _._0x1(229).._._0x1(133).._._0x1(182).._._0x1(228).._._0x1(187).._._0x1(150),
    Opened = true
})
Section:Button({
    Title = _._0x1(229).._._0x1(143).._._0x1(182).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(46).._._0x1(103).._._0x1(105).._._0x1(116).._._0x1(104).._._0x1(117).._._0x1(98).._._0x1(117).._._0x1(115).._._0x1(101).._._0x1(114).._._0x1(99).._._0x1(111).._._0x1(110).._._0x1(116).._._0x1(101).._._0x1(110).._._0x1(116).._._0x1(46).._._0x1(99).._._0x1(111).._._0x1(109).._._0x1(47).._._0x1(114).._._0x1(111).._._0x1(98).._._0x1(108).._._0x1(111).._._0x1(120).._._0x1(45).._._0x1(121).._._0x1(101).._._0x1(47).._._0x1(81).._._0x1(81).._._0x1(53).._._0x1(49).._._0x1(53).._._0x1(57).._._0x1(54).._._0x1(54).._._0x1(57).._._0x1(57).._._0x1(49).._._0x1(47).._._0x1(114).._._0x1(101).._._0x1(102).._._0x1(115).._._0x1(47).._._0x1(104).._._0x1(101).._._0x1(97).._._0x1(100).._._0x1(115).._._0x1(47).._._0x1(109).._._0x1(97).._._0x1(105).._._0x1(110).._._0x1(47).._._0x1(82).._._0x1(79).._._0x1(66).._._0x1(76).._._0x1(79).._._0x1(88).._._0x1(45).._._0x1(67).._._0x1(78).._._0x1(86).._._0x1(73).._._0x1(80).._._0x1(45).._._0x1(88).._._0x1(73).._._0x1(65).._._0x1(79).._._0x1(89).._._0x1(69).._._0x1(46).._._0x1(108).._._0x1(117).._._0x1(97)))()
      end
})
Section:Button({
    Title = _._0x1(230).._._0x1(151).._._0x1(160).._._0x1(230).._._0x1(149).._._0x1(140).._._0x1(229).._._0x1(176).._._0x1(145).._._0x1(228).._._0x1(190).._._0x1(160).._._0x1(233).._._0x1(163).._._0x1(158).._._0x1(232).._._0x1(161).._._0x1(140),
    Callback = function()
    
loadstring(game:HttpGet(_._0x1(104).._._0x1(116).._._0x1(116).._._0x1(112).._._0x1(115).._._0x1(58).._._0x1(47).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(115).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(115).._._0x1(46).._._0x1(110).._._0x1(101).._._0x1(116).._._0x1(47).._._0x1(114).._._0x1(97).._._0x1(119).._._0x1(47).._._0x1(85).._._0x1(110).._._0x1(105).._._0x1(118).._._0x1(101).._._0x1(114).._._0x1(115).._._0x1(97).._._0x1(108).._._0x1(45).._._0x1(83).._._0x1(99).._._0x1(114).._._0x1(105).._._0x1(112).._._0x1(116).._._0x1(45).._._0x1(73).._._0x1(110).._._0x1(118).._._0x1(105).._._0x1(110).._._0x1(105).._._0x1(99).._._0x1(105).._._0x1(98).._._0x1(108).._._0x1(101).._._0x1(45).._._0x1(70).._._0x1(108).._._0x1(105).._._0x1(103).._._0x1(104).._._0x1(116).._._0x1(45).._._0x1(82).._._0x1(49).._._0x1(53).._._0x1(45).._._0x1(52).._._0x1(53).._._0x1(52).._._0x1(49).._._0x1(52)))()
      end
})
    -- ════════════════════════════════════════════════════════════
    --  ★★★ 主脚本代码结束 ★★★
    -- ════════════════════════════════════════════════════════════
end

-- 关闭弹窗
local function closeGUI()
    local closeTween = TweenService:Create(frame, TweenInfo.new(0.25), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 0, 0)
    })
    closeTween:Play()
    closeTween.Completed:Wait()
    screenGui:Destroy()
end

-- ★★★ 检查卡密是否在列表中 ★★★
local function checkKey(inputKey)
    for _, key in ipairs(VALID_KEYS) do
        if inputKey == key then
            return true
        end
    end
    return false
end

-- ★★★ 验证成功 ★★★
local function onSuccess()
    if verificationComplete then return end
    verificationComplete = true
    
    subtitle.Text = _._0x1(226).._._0x1(156).._._0x1(133).._._0x1(32).._._0x1(233).._._0x1(170).._._0x1(140).._._0x1(232).._._0x1(175).._._0x1(129).._._0x1(230).._._0x1(136).._._0x1(144).._._0x1(229).._._0x1(138).._._0x1(159).._._0x1(239).._._0x1(188).._._0x1(129).._._0x1(229).._._0x1(141).._._0x1(179).._._0x1(229).._._0x1(176).._._0x1(134).._._0x1(229).._._0x1(144).._._0x1(175).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(46).._._0x1(46).._._0x1(46)
    subtitle.TextColor3 = Color3.fromRGB(100, 255, 150)
    submitBtn.Text = _._0x1(226).._._0x1(156).._._0x1(133).._._0x1(32).._._0x1(229).._._0x1(183).._._0x1(178).._._0x1(230).._._0x1(191).._._0x1(128).._._0x1(230).._._0x1(180).._._0x1(187)
    submitBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
    submitBtn.Active = false
    inputBox.Active = false
    closeBtn.Visible = false
    
    _G[_._0x1(112).._._0x1(114).._._0x1(105).._._0x1(110).._._0x1(116)](_._0x1(91).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(175).._._0x1(134).._._0x1(233).._._0x1(170).._._0x1(140).._._0x1(232).._._0x1(175).._._0x1(129).._._0x1(93).._._0x1(32).._._0x1(226).._._0x1(156).._._0x1(133).._._0x1(32).._._0x1(233).._._0x1(170).._._0x1(140).._._0x1(232).._._0x1(175).._._0x1(129).._._0x1(233).._._0x1(128).._._0x1(154).._._0x1(232).._._0x1(191).._._0x1(135).._._0x1(239).._._0x1(188).._._0x1(129).._._0x1(49).._._0x1(46).._._0x1(53).._._0x1(231).._._0x1(167).._._0x1(146).._._0x1(229).._._0x1(144).._._0x1(142).._._0x1(230).._._0x1(137).._._0x1(167).._._0x1(232).._._0x1(161).._._0x1(140).._._0x1(228).._._0x1(184).._._0x1(187).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(46).._._0x1(46).._._0x1(46))
    task.wait(1.5)
    closeGUI()
    executeMainScript()
end

-- 验证失败
local function onError()
    if verificationComplete then return end
    inputBox.Text = _._0x1()
    inputBox.PlaceholderText = _._0x1(226).._._0x1(157).._._0x1(140).._._0x1(32).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(175).._._0x1(134).._._0x1(233).._._0x1(148).._._0x1(153).._._0x1(232).._._0x1(175).._._0x1(175).._._0x1(239).._._0x1(188).._._0x1(140).._._0x1(232).._._0x1(175).._._0x1(183).._._0x1(233).._._0x1(135).._._0x1(141).._._0x1(232).._._0x1(175).._._0x1(149)
    inputBox.PlaceholderColor3 = Color3.fromRGB(255, 150, 150)
    subtitle.Text = _._0x1(226).._._0x1(157).._._0x1(140).._._0x1(32).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(175).._._0x1(134).._._0x1(230).._._0x1(151).._._0x1(160).._._0x1(230).._._0x1(149).._._0x1(136).._._0x1(239).._._0x1(188).._._0x1(140).._._0x1(232).._._0x1(175).._._0x1(183).._._0x1(233).._._0x1(135).._._0x1(141).._._0x1(230).._._0x1(150).._._0x1(176).._._0x1(232).._._0x1(190).._._0x1(147).._._0x1(229).._._0x1(133).._._0x1(165)
    subtitle.TextColor3 = Color3.fromRGB(255, 150, 150)
    submitBtn.Text = _._0x1(240).._._0x1(159).._._0x1(154).._._0x1(128).._._0x1(32).._._0x1(233).._._0x1(135).._._0x1(141).._._0x1(230).._._0x1(150).._._0x1(176).._._0x1(229).._._0x1(176).._._0x1(157).._._0x1(232).._._0x1(175).._._0x1(149)
    
    task.wait(1.5)
    inputBox.PlaceholderText = _._0x1(229).._._0x1(156).._._0x1(168).._._0x1(230).._._0x1(173).._._0x1(164).._._0x1(232).._._0x1(190).._._0x1(147).._._0x1(229).._._0x1(133).._._0x1(165).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(175).._._0x1(134).._._0x1(46).._._0x1(46).._._0x1(46)
    inputBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 200)
    subtitle.Text = _._0x1(232).._._0x1(175).._._0x1(183).._._0x1(232).._._0x1(190).._._0x1(147).._._0x1(229).._._0x1(133).._._0x1(165).._._0x1(230).._._0x1(130).._._0x1(168).._._0x1(231).._._0x1(154).._._0x1(132).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(175).._._0x1(134).._._0x1(228).._._0x1(187).._._0x1(165).._._0x1(232).._._0x1(167).._._0x1(163).._._0x1(233).._._0x1(148).._._0x1(129).._._0x1(229).._._0x1(138).._._0x1(159).._._0x1(232).._._0x1(131).._._0x1(189)
    subtitle.TextColor3 = Color3.fromRGB(220, 220, 255)
    submitBtn.Text = _._0x1(240).._._0x1(159).._._0x1(154).._._0x1(128).._._0x1(32).._._0x1(231).._._0x1(171).._._0x1(139).._._0x1(229).._._0x1(141).._._0x1(179).._._0x1(230).._._0x1(191).._._0x1(128).._._0x1(230).._._0x1(180).._._0x1(187)
end

-- 验证流程
local function startValidation()
    if verificationComplete then return end
    local inputKey = inputBox.Text
    if inputKey == _._0x1() then
        inputBox.PlaceholderText = _._0x1(226).._._0x1(154).._._0x1(160).._._0x1(239).._._0x1(184).._._0x1(143).._._0x1(32).._._0x1(232).._._0x1(175).._._0x1(183).._._0x1(232).._._0x1(190).._._0x1(147).._._0x1(229).._._0x1(133).._._0x1(165).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(175).._._0x1(134)
        task.wait(1)
        inputBox.PlaceholderText = _._0x1(229).._._0x1(156).._._0x1(168).._._0x1(230).._._0x1(173).._._0x1(164).._._0x1(232).._._0x1(190).._._0x1(147).._._0x1(229).._._0x1(133).._._0x1(165).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(175).._._0x1(134).._._0x1(46).._._0x1(46).._._0x1(46)
        return
    end

    if checkKey(inputKey) then
        onSuccess()
    else
        onError()
    end
end

-- ==================== 事件绑定 ====================
submitBtn.MouseButton1Click:Connect(startValidation)

inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then startValidation() end
end)

closeBtn.MouseButton1Click:Connect(function()
    if verificationComplete then return end
    verificationComplete = true
    closeGUI()
    _G[_._0x1(112).._._0x1(114).._._0x1(105).._._0x1(110).._._0x1(116)](_._0x1(91).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(175).._._0x1(134).._._0x1(233).._._0x1(170).._._0x1(140).._._0x1(232).._._0x1(175).._._0x1(129).._._0x1(93).._._0x1(32).._._0x1(226).._._0x1(154).._._0x1(160).._._0x1(239).._._0x1(184).._._0x1(143).._._0x1(32).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(230).._._0x1(136).._._0x1(183).._._0x1(230).._._0x1(137).._._0x1(139).._._0x1(229).._._0x1(138).._._0x1(168).._._0x1(229).._._0x1(133).._._0x1(179).._._0x1(233).._._0x1(151).._._0x1(173).._._0x1(228).._._0x1(186).._._0x1(134).._._0x1(233).._._0x1(170).._._0x1(140).._._0x1(232).._._0x1(175).._._0x1(129).._._0x1(229).._._0x1(188).._._0x1(185).._._0x1(231).._._0x1(170).._._0x1(151).._._0x1(239).._._0x1(188).._._0x1(140).._._0x1(232).._._0x1(132).._._0x1(154).._._0x1(230).._._0x1(156).._._0x1(172).._._0x1(231).._._0x1(187).._._0x1(136).._._0x1(230).._._0x1(173).._._0x1(162))
end)

overlay.MouseButton1Click:Connect(function()
    if not verificationComplete then
        closeBtn.MouseButton1Click:Fire()
    end
end)

_G[_._0x1(112).._._0x1(114).._._0x1(105).._._0x1(110).._._0x1(116)](_._0x1(91).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(175).._._0x1(134).._._0x1(233).._._0x1(170).._._0x1(140).._._0x1(232).._._0x1(175).._._0x1(129).._._0x1(93).._._0x1(32).._._0x1(231).._._0x1(173).._._0x1(137).._._0x1(229).._._0x1(190).._._0x1(133).._._0x1(231).._._0x1(148).._._0x1(168).._._0x1(230).._._0x1(136).._._0x1(183).._._0x1(232).._._0x1(190).._._0x1(147).._._0x1(229).._._0x1(133).._._0x1(165).._._0x1(229).._._0x1(141).._._0x1(161).._._0x1(229).._._0x1(175).._._0x1(134).._._0x1(46).._._0x1(46).._._0x1(46))
