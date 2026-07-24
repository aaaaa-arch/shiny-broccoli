local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TextChatService = game:GetService("TextChatService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = Workspace.CurrentCamera

local state = {
    collisionMode = 1,
    selfCollisionMode = 1,
    hitboxSize = 15,
    selfHitboxSize = 15,
    headSize = 15,
    selfHeadSize = 15,
    fov = 70,
    zoomDistance = 128,
    transparency = 0,
    gravity = nil,
    gravityLoop = false,
    spin = false,
    spinSpeed = 0,
    animationMultiplier = 5,
    fps = 144,
    knockbackDistance = 50,
    flySpeed = 50,
    cameraHeight = 50,
    cameraBrightness = 1,
    jumpHeight = 50,
    highJumpPower = 80,
    highJumpEnabled = false,
    airJumpCount = 5,
    airJumpEnabled = false,
    walkSpeed = 16,
    hipHeight = 0,
    maxHealth = 100,
    currentHealth = 100,
    teleportSpeed = 15,
    teleportSpeedEnabled = false,
    velocitySpeed = 15,
    velocitySpeedEnabled = false,
    godViewEnabled = false,
    selectedPlayer = nil,
    selectedObject = nil,
    objectTransparency = nil,
    objectCanCollide = nil,
    objectAnchored = nil,
    objectFire = false,
    objectSmoke = false,
    objectSparkles = false,
    objectMaterial = nil,
}

local connections = {}
local originalTransparency = {}
local originalObjectTransparency = {}
local originalCollide = {}
local originalAnchored = {}

local function disconnect(name)
    local c = connections[name]
    if c then
        c:Disconnect()
        connections[name] = nil
    end
end

local function notify(title, text)
    pcall(function()
        local channels = TextChatService:FindFirstChild("TextChannels")
        local general = channels and channels:FindFirstChild("RBXGeneral")
        if general then
            general:SendAsync(tostring(text))
            return
        end
        StarterGui:SetCore("SendNotification", {
            Title = tostring(title),
            Text = tostring(text),
            Duration = 2
        })
    end)
end

local function getCharacter(player)
    player = player or LocalPlayer
    local char = player.Character
    if char and char.Parent then
        return char
    end
    return nil
end

local function getHumanoid(player)
    local char = getCharacter(player)
    return char and char:FindFirstChildOfClass("Humanoid") or nil
end

local function getRoot(player)
    local char = getCharacter(player)
    return char and char:FindFirstChild("HumanoidRootPart") or nil
end

local function forEachDescendant(root, fn)
    if not root then
        return
    end
    local ok = pcall(function()
        fn(root)
        for _, obj in ipairs(root:GetDescendants()) do
            fn(obj)
        end
    end)
    if not ok then
        pcall(fn, root)
    end
end

local function applyCollision(character, mode)
    if not character then
        return
    end
    forEachDescendant(character, function(obj)
        if obj:IsA("BasePart") then
            obj.CanCollide = mode == 1
        end
    end)
end

local function applyHitboxToPlayer(player, size, useHead)
    local char = getCharacter(player)
    if not char then
        return
    end
    local partName = useHead and "Head" or "HumanoidRootPart"
    local part = char:FindFirstChild(partName)
    if part and part:IsA("BasePart") then
        pcall(function()
            part.Size = Vector3.new(size, size, size)
            part.Transparency = 0.7
            part.Material = Enum.Material.Neon
            part.CanCollide = false
            part.Massless = true
        end)
    end
end

local function applyWorldTransparency(value)
    state.transparency = math.clamp(tonumber(value) or 0, 0, 1)
    forEachDescendant(Workspace, function(obj)
        if obj:IsA("BasePart") then
            if originalTransparency[obj] == nil then
                originalTransparency[obj] = obj.Transparency
            end
            obj.Transparency = state.transparency
        end
    end)
    if not connections.transparency then
        connections.transparency = Workspace.DescendantAdded:Connect(function(obj)
            if state.transparency and obj:IsA("BasePart") then
                if originalTransparency[obj] == nil then
                    originalTransparency[obj] = obj.Transparency
                end
                obj.Transparency = state.transparency
            end
        end)
    end
end

local function restoreWorldTransparency()
    disconnect("transparency")
    for part, value in pairs(originalTransparency) do
        if part and part.Parent and part:IsA("BasePart") then
            part.Transparency = value
        end
    end
    table.clear(originalTransparency)
end

local function applyObjectSetting()
    local obj = state.selectedObject
    if not obj then
        return
    end
    forEachDescendant(obj, function(part)
        if part:IsA("BasePart") then
            if state.objectTransparency ~= nil then
                if originalObjectTransparency[part] == nil then
                    originalObjectTransparency[part] = part.Transparency
                end
                part.Transparency = state.objectTransparency
            end
            if state.objectCanCollide ~= nil then
                if originalCollide[part] == nil then
                    originalCollide[part] = part.CanCollide
                end
                part.CanCollide = state.objectCanCollide
            end
            if state.objectAnchored ~= nil then
                if originalAnchored[part] == nil then
                    originalAnchored[part] = part.Anchored
                end
                part.Anchored = state.objectAnchored
            end
            if state.objectFire then
                if not part:FindFirstChildOfClass("Fire") then
                    local fire = Instance.new("Fire")
                    fire.Name = "ObjectFire_" .. tostring(tick())
                    fire.Size = 5
                    fire.Heat = 10
                    fire.Parent = part
                end
            end
            if state.objectSmoke then
                if not part:FindFirstChildOfClass("Smoke") then
                    local smoke = Instance.new("Smoke")
                    smoke.Name = "ObjectSmoke_" .. tostring(tick())
                    smoke.Size = 5
                    smoke.Opacity = 0.3
                    smoke.Parent = part
                end
            end
            if state.objectSparkles then
                if not part:FindFirstChildOfClass("Sparkles") then
                    local sparkles = Instance.new("Sparkles")
                    sparkles.Name = "ObjectSparkles_" .. tostring(tick())
                    sparkles.SparkleColor = Color3.fromRGB(255, 255, 0)
                    sparkles.Parent = part
                end
            end
            if state.objectMaterial then
                pcall(function()
                    part.Material = Enum.Material[state.objectMaterial]
                end)
            end
        end
    end)
end

local function restoreObjectSettings()
    for part, value in pairs(originalObjectTransparency) do
        if part and part.Parent and part:IsA("BasePart") then
            part.Transparency = value
        end
    end
    for part, value in pairs(originalCollide) do
        if part and part.Parent and part:IsA("BasePart") then
            part.CanCollide = value
        end
    end
    for part, value in pairs(originalAnchored) do
        if part and part.Parent and part:IsA("BasePart") then
            part.Anchored = value
        end
    end
    table.clear(originalObjectTransparency)
    table.clear(originalCollide)
    table.clear(originalAnchored)
end

local function setGravity(value)
    state.gravity = tonumber(value)
    if not connections.gravityAdded then
        connections.gravityAdded = Workspace.DescendantAdded:Connect(function(obj)
            if state.gravity and obj:IsA("BasePart") and not obj.Anchored then
                if not obj:FindFirstChild("CustomGravity") then
                    local bf = Instance.new("BodyForce")
                    bf.Name = "CustomGravity"
                    bf.Force = Vector3.new(0, obj:GetMass() * state.gravity, 0)
                    bf.Parent = obj
                end
            end
        end)
    end
    forEachDescendant(Workspace, function(obj)
        if obj:IsA("BasePart") and not obj.Anchored then
            local old = obj:FindFirstChild("CustomGravity")
            if old then
                old:Destroy()
            end
            local bf = Instance.new("BodyForce")
            bf.Name = "CustomGravity"
            bf.Force = Vector3.new(0, obj:GetMass() * state.gravity, 0)
            bf.Parent = obj
        end
    end)
end

local function stopGravity()
    disconnect("gravityAdded")
    forEachDescendant(Workspace, function(obj)
        if obj:IsA("BodyForce") and obj.Name == "CustomGravity" then
            obj:Destroy()
        end
    end)
end

local function updateCharacterRefs(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    RootPart = char:WaitForChild("HumanoidRootPart")
end

LocalPlayer.CharacterAdded:Connect(updateCharacterRefs)
if LocalPlayer.Character then
    updateCharacterRefs(LocalPlayer.Character)
end

local function setCameraHeight(height)
    state.cameraHeight = tonumber(height) or state.cameraHeight
    disconnect("cameraHeight")
    connections.cameraHeight = RunService.RenderStepped:Connect(function()
        local char = getCharacter()
        local root = getRoot()
        if not char or not root then
            return
        end
        Camera.CFrame = CFrame.lookAt(root.Position + Vector3.new(0, state.cameraHeight, 0), root.Position)
        Camera.FieldOfView = 10000
    end)
end

local function resetCamera()
    disconnect("cameraHeight")
    local hum = getHumanoid()
    if hum then
        Camera.CameraSubject = hum
    end
    Camera.FieldOfView = 70
end

local function applyWalkSpeedMultiplier(mult)
    state.animationMultiplier = tonumber(mult) or state.animationMultiplier
    local hum = getHumanoid()
    if hum then
        hum.WalkSpeed = 16 * state.animationMultiplier
        hum.JumpPower = 50 * state.animationMultiplier
    end
end

local function setWalkSpeed(value)
    state.walkSpeed = tonumber(value) or state.walkSpeed
    local hum = getHumanoid()
    if hum then
        hum.WalkSpeed = state.walkSpeed
    end
end

local function setJumpPower(value)
    state.jumpHeight = tonumber(value) or state.jumpHeight
    local hum = getHumanoid()
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = state.jumpHeight
    end
end

local function setHipHeight(value)
    state.hipHeight = tonumber(value) or state.hipHeight
    local hum = getHumanoid()
    if hum then
        hum.HipHeight = state.hipHeight
    end
end

local function setMaxHealth(value)
    state.maxHealth = tonumber(value) or state.maxHealth
    local hum = getHumanoid()
    if hum then
        hum.MaxHealth = state.maxHealth
    end
end

local function setCurrentHealth(value)
    state.currentHealth = tonumber(value) or state.currentHealth
    local hum = getHumanoid()
    if hum then
        hum.Health = state.currentHealth
    end
end

local function setGravityValue(value)
    local n = tonumber(value)
    if n then
        Workspace.Gravity = n
    end
end

local function setLighting(value)
    local n = tonumber(value)
    if n then
        Lighting.Brightness = n
        Lighting.Ambient = Color3.new(n, n, n)
        Lighting.OutdoorAmbient = Color3.new(n, n, n)
    end
end

local function setFOV(value)
    state.fov = tonumber(value) or state.fov
    Camera.FieldOfView = state.fov
end

local function setZoomDistance(value)
    state.zoomDistance = tonumber(value) or state.zoomDistance
    LocalPlayer.CameraMaxZoomDistance = state.zoomDistance
end

local function setFps(value)
    state.fps = tonumber(value) or state.fps
    pcall(function()
        settings().Rendering.FrameRateManager.MaxFramerate = state.fps
    end)
    pcall(function()
        setfpscap(state.fps)
    end)
end

local function setSpin(enabled)
    state.spin = enabled and true or false
    disconnect("spin")
    if not state.spin then
        local root = getRoot()
        if root then
            local old = root:FindFirstChild("SpinVelocity")
            if old then
                old:Destroy()
            end
        end
        return
    end
    connections.spin = RunService.RenderStepped:Connect(function()
        local root = getRoot()
        if not root then
            return
        end
        local old = root:FindFirstChild("SpinVelocity")
        if old then
            old:Destroy()
        end
        local bav = Instance.new("BodyAngularVelocity")
        bav.Name = "SpinVelocity"
        bav.MaxTorque = Vector3.new(0, math.huge, 0)
        bav.AngularVelocity = Vector3.new(0, state.spinSpeed, 0)
        bav.Parent = root
    end)
end

local function stopSpin()
    state.spin = false
    disconnect("spin")
    local root = getRoot()
    if root then
        local old = root:FindFirstChild("SpinVelocity")
        if old then
            old:Destroy()
        end
    end
end

local function setSpinSpeed(value)
    state.spinSpeed = tonumber(value) or state.spinSpeed
    if state.spin then
        stopSpin()
        setSpin(true)
    end
end

local function setFly(enabled)
    disconnect("fly")
    local root = getRoot()
    local hum = getHumanoid()
    if not enabled or not root or not hum then
        if root then
            local bv = root:FindFirstChild("XA_FlyVelocity")
            if bv then bv:Destroy() end
            local bg = root:FindFirstChild("XA_FlyGyro")
            if bg then bg:Destroy() end
        end
        return
    end
    local bv = Instance.new("BodyVelocity")
    bv.Name = "XA_FlyVelocity"
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Velocity = Vector3.zero
    bv.Parent = root
    local bg = Instance.new("BodyGyro")
    bg.Name = "XA_FlyGyro"
    bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bg.P = 9e4
    bg.CFrame = root.CFrame
    bg.Parent = root
    connections.fly = RunService.RenderStepped:Connect(function()
        local rootNow = getRoot()
        local humNow = getHumanoid()
        if not rootNow or not humNow then
            return
        end
        local cam = Workspace.CurrentCamera
        bg.CFrame = cam.CFrame
        local move = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            move += cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            move -= cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            move -= cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            move += cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            move += Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            move -= Vector3.new(0, 1, 0)
        end
        if move.Magnitude > 0 then
            move = move.Unit * state.flySpeed
        end
        bv.Velocity = move
    end)
end

local function stopFly()
    disconnect("fly")
    local root = getRoot()
    if root then
        local bv = root:FindFirstChild("XA_FlyVelocity")
        if bv then bv:Destroy() end
        local bg = root:FindFirstChild("XA_FlyGyro")
        if bg then bg:Destroy() end
    end
end

local function applyTeleportSpeed(enabled, speed)
    state.teleportSpeedEnabled = enabled and true or false
    state.teleportSpeed = tonumber(speed) or state.teleportSpeed
    disconnect("teleportSpeed")
    if not state.teleportSpeedEnabled then
        return
    end
    connections.teleportSpeed = RunService.Heartbeat:Connect(function()
        local hum = getHumanoid()
        local root = getRoot()
        if hum and root then
            hum:TranslateBy(hum.MoveDirection * state.teleportSpeed / 30)
        end
    end)
end

local function applyVelocitySpeed(enabled, speed)
    state.velocitySpeedEnabled = enabled and true or false
    state.velocitySpeed = tonumber(speed) or state.velocitySpeed
    disconnect("velocitySpeed")
    if not state.velocitySpeedEnabled then
        return
    end
    connections.velocitySpeed = RunService.Heartbeat:Connect(function()
        local hum = getHumanoid()
        local root = getRoot()
        if hum and root then
            local move = hum.MoveDirection * state.velocitySpeed
            root.Velocity = Vector3.new(move.X, root.Velocity.Y, move.Z)
        end
    end)
end

local function setHighJump(enabled)
    state.highJumpEnabled = enabled and true or false
    disconnect("highJump")
    if not state.highJumpEnabled then
        return
    end
    connections.highJump = UserInputService.JumpRequest:Connect(function()
        local root = getRoot()
        if root then
            local vel = root.Velocity
            root.Velocity = Vector3.new(vel.X, state.highJumpPower, vel.Z)
        end
    end)
end

local function setHighJumpPower(value)
    state.highJumpPower = tonumber(value) or state.highJumpPower
end

local function setAirJump(enabled)
    state.airJumpEnabled = enabled and true or false
    disconnect("airJumpHeartbeat")
    disconnect("airJumpRequest")
    if not state.airJumpEnabled then
        return
    end
    state.airJumpRemaining = 0
    connections.airJumpHeartbeat = RunService.Heartbeat:Connect(function()
        local hum = getHumanoid()
        if hum and hum.FloorMaterial ~= Enum.Material.Air then
            state.airJumpRemaining = 0
        end
    end)
    connections.airJumpRequest = UserInputService.JumpRequest:Connect(function()
        local hum = getHumanoid()
        local root = getRoot()
        if not hum or not root then
            return
        end
        if hum.FloorMaterial == Enum.Material.Air then
            if state.airJumpRemaining < state.airJumpCount then
                local vel = root.Velocity
                root.Velocity = Vector3.new(vel.X, hum.JumpPower, vel.Z)
                state.airJumpRemaining += 1
            end
        else
            state.airJumpRemaining = 0
        end
    end)
end

local function setAirJumpCount(value)
    state.airJumpCount = math.max(0, math.floor(tonumber(value) or state.airJumpCount))
end

local function setSelectedPlayer(name)
    if name and name ~= "" then
        state.selectedPlayer = Players:FindFirstChild(name)
    else
        state.selectedPlayer = nil
    end
end

local function sitOnSelectedPlayer(looping)
    disconnect("sitHead")
    if not state.selectedPlayer then
        notify("选择玩家", "请先从下拉框选择玩家")
        return
    end
    local target = state.selectedPlayer
    local function hook()
        local char = getCharacter()
        local root = getRoot()
        local targetChar = getCharacter(target)
        local head = targetChar and targetChar:FindFirstChild("Head")
        if char and root and head then
            root.CFrame = head.CFrame * CFrame.new(0, 1.5, 0)
        end
    end
    hook()
    if looping then
        connections.sitHead = RunService.RenderStepped:Connect(hook)
        notify("循环坐头", "已开启")
    else
        notify("坐头", "已坐到 " .. target.Name .. " 头上")
    end
end

local function stopSitHead()
    disconnect("sitHead")
    notify("坐头", "已停止")
end

local function createWatermark(single)
    local guiParent = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
    if single then
        local old = guiParent:FindFirstChild("ChaosKiller_Watermark")
        if old then old:Destroy() end
        local gui = Instance.new("ScreenGui")
        gui.Name = "ChaosKiller_Watermark"
        gui.ResetOnSpawn = false
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.Parent = guiParent
        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.BorderSizePixel = 0
        label.Size = UDim2.new(0, 450, 0, 70)
        label.Position = UDim2.new(0.5, -225, 0.33, -35)
        label.Text = "XY脚本"
        label.TextColor3 = Color3.new(1, 1, 1)
        label.TextSize = 52
        label.TextTransparency = 0.5
        label.Font = Enum.Font.GothamBold
        label.Parent = gui
        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 2
        stroke.Color = Color3.new(0, 0, 0)
        stroke.Transparency = 0.6
        stroke.Parent = label
    else
        local old = guiParent:FindFirstChild("ChaosKiller_FullWatermark")
        if old then old:Destroy() end
        local gui = Instance.new("ScreenGui")
        gui.Name = "ChaosKiller_FullWatermark"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.Parent = guiParent
        for y = -3, 12 do
            for x = -2, 10 do
                local label = Instance.new("TextLabel")
                label.BackgroundTransparency = 1
                label.BorderSizePixel = 0
                label.Size = UDim2.new(0, 180, 0, 40)
                label.Position = UDim2.new(0, x * 200, 0, y * 70)
                label.Rotation = -25
                label.Text = "XY脚本"
                label.TextColor3 = Color3.new(1, 1, 1)
                label.TextSize = 22
                label.TextTransparency = 0.88
                label.Font = Enum.Font.GothamBold
                label.Parent = gui
                local stroke = Instance.new("UIStroke")
                stroke.Thickness = 1
                stroke.Color = Color3.new(0, 0, 0)
                stroke.Transparency = 0.92
                stroke.Parent = label
            end
        end
    end
end

local function destroyWatermark(single)
    local guiParent = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if not guiParent then
        return
    end
    local name = single and "ChaosKiller_Watermark" or "ChaosKiller_FullWatermark"
    local gui = guiParent:FindFirstChild(name)
    if gui then
        gui:Destroy()
    end
end

local function parseObject(text)
    local ok, result = pcall(function()
        return loadstring("return " .. text)()
    end)
    if ok then
        return result
    end
    return nil
end

local function setSelectedObject(text)
    local obj = parseObject(text)
    if obj then
        state.selectedObject = obj
        notify("物体选择", "已选择: " .. text)
    else
        state.selectedObject = nil
        notify("物体选择", "未找到指定物体")
    end
end

local function getPlayerNames()
    local list = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(list, player.Name)
        end
    end
    table.sort(list)
    return list
end

local function rebuildDropdown(tab, holder)
    if holder and holder.Destroy then
        holder:Destroy()
    end
end

local function refreshPlayerState()
    if state.selectedPlayer and not state.selectedPlayer.Parent then
        state.selectedPlayer = nil
    end
end

Players.PlayerRemoving:Connect(refreshPlayerState)

local function applyObjectOptions()
    restoreObjectSettings()
    if not state.selectedObject then
        return
    end
    applyObjectSetting()
end

local Window = WindUI.CreateWindow(WindUI, {
    Title = "XY通用",
    Icon = "home",
    Author = "Sentinel",
    Folder = "MyScript",
    Size = UDim2.fromOffset(680, 580),
    Theme = "Dark",
    SideBarWidth = 200,
    ScrollBarEnabled = true
})

WindUI.SetTheme(WindUI, "Dark")

local Section = Window.Section(Window, {
    Title = "功能分类",
    Opened = true
})

local TabMain = Section.Tab(Section, {
    Title = "通用",
    Icon = "home"
})

local TabChar = Section.Tab(Section, {
    Title = "角色",
    Icon = "user"
})

local TabOther = Section.Tab(Section, {
    Title = "其他",
    Icon = "settings"
})

TabMain.Button(TabMain, {
    Title = "开启穿墙",
    Icon = "chevrons-right",
    Variant = "Primary",
    Callback = function()
        local enabled = state.selfCollisionMode == 0
        state.selfCollisionMode = enabled and 1 or 0
        applyCollision(Character, state.selfCollisionMode)
        notify("穿墙", enabled and "已关闭" or "已开启")
    end
})

TabMain.Divider(TabMain)

TabMain.Input(TabMain, {
    Title = "碰撞值",
    Desc = "0-1 (0=全穿墙,1=正常)",
    Value = "",
    Callback = function(v)
        state.collisionMode = tonumber(v) or state.collisionMode
    end
})

TabMain.Button(TabMain, {
    Title = "应用碰撞值",
    Callback = function()
        if state.collisionMode ~= 0 and state.collisionMode ~= 1 then
            notify("错误", "请输入0-1之间的数值")
            return
        end
        applyCollision(Character, state.collisionMode)
        notify("穿墙V2", "已应用: " .. tostring(state.collisionMode))
    end
})

TabMain.Input(TabMain, {
    Title = "自己碰撞值",
    Desc = "0-1 (0是全穿墙,1是正常)",
    Value = "",
    Callback = function(v)
        state.selfCollisionMode = tonumber(v) or state.selfCollisionMode
    end
})

TabMain.Button(TabMain, {
    Title = "应用自己碰撞值",
    Callback = function()
        if state.selfCollisionMode ~= 0 and state.selfCollisionMode ~= 1 then
            notify("错误", "请输入0-1之间的数值")
            return
        end
        applyCollision(Character, state.selfCollisionMode)
        notify("自己穿墙", "已应用: " .. tostring(state.selfCollisionMode))
    end
})

TabMain.Input(TabMain, {
    Title = "碰撞箱大小",
    Desc = "输入尺寸",
    Value = "",
    Callback = function(v)
        state.hitboxSize = tonumber(v) or state.hitboxSize
    end
})

TabMain.Button(TabMain, {
    Title = "应用碰撞箱大小",
    Callback = function()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                applyHitboxToPlayer(player, state.hitboxSize, false)
            end
        end
        notify("碰撞箱", "已设为: " .. tostring(state.hitboxSize))
    end
})

TabMain.Input(TabMain, {
    Title = "自己碰撞箱大小",
    Desc = "输入尺寸",
    Value = "",
    Callback = function(v)
        state.selfHitboxSize = tonumber(v) or state.selfHitboxSize
    end
})

TabMain.Button(TabMain, {
    Title = "应用自己碰撞箱大小",
    Callback = function()
        applyHitboxToPlayer(LocalPlayer, state.selfHitboxSize, false)
        notify("自己碰撞箱", "已设为: " .. tostring(state.selfHitboxSize))
    end
})

TabMain.Input(TabMain, {
    Title = "广角设置",
    Desc = "视野值",
    Value = "",
    Callback = function(v)
        state.fov = tonumber(v) or state.fov
    end
})

TabMain.Button(TabMain, {
    Title = "应用广角",
    Callback = function()
        setFOV(state.fov)
        notify("广角", "已设为: " .. tostring(state.fov))
    end
})

TabMain.Input(TabMain, {
    Title = "视野距离",
    Desc = "相机最大距离",
    Value = "",
    Callback = function(v)
        state.zoomDistance = tonumber(v) or state.zoomDistance
    end
})

TabMain.Button(TabMain, {
    Title = "应用视野距离",
    Callback = function()
        setZoomDistance(state.zoomDistance)
        notify("视野距离", "已设为: " .. tostring(state.zoomDistance))
    end
})

TabMain.Divider(TabMain)

TabMain.Input(TabMain, {
    Title = "零件透明度",
    Desc = "0-1",
    Value = "",
    Callback = function(v)
        state.transparency = tonumber(v) or state.transparency
    end
})

TabMain.Button(TabMain, {
    Title = "应用透明度",
    Callback = function()
        applyWorldTransparency(state.transparency)
        notify("透明度", "已设为: " .. tostring(state.transparency))
    end
})

TabMain.Button(TabMain, {
    Title = "恢复透明度",
    Callback = function()
        restoreWorldTransparency()
        notify("透明度", "已恢复")
    end
})

TabMain.Divider(TabMain)

TabMain.Input(TabMain, {
    Title = "零件重力",
    Desc = "正数向下,负数向上",
    Value = "",
    Callback = function(v)
        state.gravity = tonumber(v) or state.gravity
    end
})

TabMain.Button(TabMain, {
    Title = "应用重力",
    Callback = function()
        if state.gravity == nil then
            return
        end
        setGravity(state.gravity)
        notify("重力", "已设为: " .. tostring(state.gravity))
    end
})

TabMain.Toggle(TabMain, {
    Title = "重力循环执行",
    Value = false,
    Callback = function(v)
        state.gravityLoop = v and true or false
        if not state.gravityLoop then
            stopGravity()
            notify("重力", "已强制关闭")
            return
        end
        setGravity(state.gravity or 0)
    end
})

TabMain.Button(TabMain, {
    Title = "强制关闭重力循环",
    Callback = function()
        stopGravity()
        state.gravityLoop = false
        notify("重力", "已恢复默认")
    end
})

TabMain.Divider(TabMain)

TabMain.Input(TabMain, {
    Title = "FPS",
    Desc = "帧率限制",
    Value = "",
    Callback = function(v)
        state.fps = tonumber(v) or state.fps
    end
})

TabMain.Button(TabMain, {
    Title = "应用FPS",
    Callback = function()
        setFps(state.fps)
        notify("FPS", "已设为: " .. tostring(state.fps))
    end
})

TabMain.Input(TabMain, {
    Title = "动画速度",
    Desc = "倍率",
    Value = "",
    Callback = function(v)
        state.animationMultiplier = tonumber(v) or state.animationMultiplier
    end
})

TabMain.Toggle(TabMain, {
    Title = "动画速度",
    Value = false,
    Callback = function(v)
        if v then
            applyWalkSpeedMultiplier(state.animationMultiplier)
            connections.animSpeed = RunService.RenderStepped:Connect(function()
                applyWalkSpeedMultiplier(state.animationMultiplier)
            end)
            notify("动画速度", "已开启")
        else
            disconnect("animSpeed")
            local hum = getHumanoid()
            if hum then
                hum.WalkSpeed = 16
                hum.JumpPower = 50
            end
            notify("动画速度", "已关闭")
        end
    end
})

TabMain.Divider(TabMain)

TabMain.Input(TabMain, {
    Title = "击飞距离",
    Desc = "数值",
    Value = "",
    Callback = function(v)
        state.knockbackDistance = tonumber(v) or state.knockbackDistance
    end
})

TabMain.Button(TabMain, {
    Title = "应用击飞距离",
    Callback = function()
        notify("击飞距离", "已设为: " .. tostring(state.knockbackDistance))
    end
})

TabMain.Toggle(TabMain, {
    Title = "击飞",
    Value = false,
    Callback = function(v)
        disconnect("knockback")
        if not v then
            notify("击飞", "已关闭")
            return
        end
        connections.knockback = RunService.Heartbeat:Connect(function()
            local root = getRoot()
            if not root then
                return
            end
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local targetRoot = getRoot(player)
                    if targetRoot then
                        local dir = (targetRoot.Position - root.Position)
                        if dir.Magnitude <= state.knockbackDistance then
                            targetRoot.Velocity = Vector3.new(0, 120, 0) + dir.Unit * 150
                        end
                    end
                end
            end
        end)
        notify("击飞", "已开启")
    end
})

TabChar.Input(TabChar, {
    Title = "跳跃高度",
    Desc = "JumpPower",
    Value = "",
    Callback = function(v)
        state.jumpHeight = tonumber(v) or state.jumpHeight
    end
})

TabChar.Button(TabChar, {
    Title = "应用跳跃高度",
    Callback = function()
        setJumpPower(state.jumpHeight)
        notify("跳跃高度", "已设为: " .. tostring(state.jumpHeight))
    end
})

TabChar.Input(TabChar, {
    Title = "高跳力量",
    Desc = "JumpRequest速度",
    Value = "",
    Callback = function(v)
        state.highJumpPower = tonumber(v) or state.highJumpPower
    end
})

TabChar.Button(TabChar, {
    Title = "应用高跳力量",
    Callback = function()
        setHighJumpPower(state.highJumpPower)
        notify("高跳力量", "已设为: " .. tostring(state.highJumpPower))
    end
})

TabChar.Toggle(TabChar, {
    Title = "高跳",
    Value = false,
    Callback = function(v)
        setHighJump(v)
        notify("高跳", v and "已开启" or "已关闭")
    end
})

TabChar.Input(TabChar, {
    Title = "空中跳跃",
    Desc = "次数",
    Value = "",
    Callback = function(v)
        state.airJumpCount = tonumber(v) or state.airJumpCount
    end
})

TabChar.Button(TabChar, {
    Title = "应用空中跳跃",
    Callback = function()
        notify("空中跳跃", "次数: " .. tostring(state.airJumpCount))
    end
})

TabChar.Toggle(TabChar, {
    Title = "空中跳跃",
    Value = false,
    Callback = function(v)
        setAirJump(v)
        notify("空中跳跃", v and "已开启" or "已关闭")
    end
})

TabChar.Divider(TabChar)

TabChar.Input(TabChar, {
    Title = "移动速度",
    Desc = "WalkSpeed",
    Value = "",
    Callback = function(v)
        state.walkSpeed = tonumber(v) or state.walkSpeed
    end
})

TabChar.Button(TabChar, {
    Title = "应用移动速度",
    Callback = function()
        setWalkSpeed(state.walkSpeed)
        notify("移动速度", "已设为: " .. tostring(state.walkSpeed))
    end
})

TabChar.Input(TabChar, {
    Title = "髋部高度",
    Desc = "HipHeight",
    Value = "",
    Callback = function(v)
        state.hipHeight = tonumber(v) or state.hipHeight
    end
})

TabChar.Button(TabChar, {
    Title = "应用髋部高度",
    Callback = function()
        setHipHeight(state.hipHeight)
        notify("髋部高度", "已设为: " .. tostring(state.hipHeight))
    end
})

TabChar.Input(TabChar, {
    Title = "游戏重力",
    Desc = "Workspace.Gravity",
    Value = "",
    Callback = function(v)
        state.gravity = tonumber(v) or state.gravity
    end
})

TabChar.Button(TabChar, {
    Title = "应用游戏重力",
    Callback = function()
        setGravityValue(state.gravity)
        notify("游戏重力", "已设为: " .. tostring(state.gravity))
    end
})

TabChar.Input(TabChar, {
    Title = "最大血量",
    Desc = "MaxHealth",
    Value = "",
    Callback = function(v)
        state.maxHealth = tonumber(v) or state.maxHealth
    end
})

TabChar.Button(TabChar, {
    Title = "应用最大血量",
    Callback = function()
        setMaxHealth(state.maxHealth)
        notify("最大血量", "已设为: " .. tostring(state.maxHealth))
    end
})

TabChar.Input(TabChar, {
    Title = "当前血量",
    Desc = "Health",
    Value = "",
    Callback = function(v)
        state.currentHealth = tonumber(v) or state.currentHealth
    end
})

TabChar.Button(TabChar, {
    Title = "应用当前血量",
    Callback = function()
        setCurrentHealth(state.currentHealth)
        notify("当前血量", "已设为: " .. tostring(state.currentHealth))
    end
})

TabChar.Divider(TabChar)

TabChar.Input(TabChar, {
    Title = "瞬移速度",
    Desc = "数值",
    Value = "",
    Callback = function(v)
        state.teleportSpeed = tonumber(v) or state.teleportSpeed
    end
})

TabChar.Toggle(TabChar, {
    Title = "瞬移式加速",
    Value = false,
    Callback = function(v)
        applyTeleportSpeed(v, state.teleportSpeed)
        notify("瞬移式加速", v and "已开启" or "已关闭")
    end
})

TabChar.Input(TabChar, {
    Title = "速度式速度",
    Desc = "数值",
    Value = "",
    Callback = function(v)
        state.velocitySpeed = tonumber(v) or state.velocitySpeed
    end
})

TabChar.Toggle(TabChar, {
    Title = "速度式加速",
    Value = false,
    Callback = function(v)
        applyVelocitySpeed(v, state.velocitySpeed)
        notify("速度式加速", v and "已开启" or "已关闭")
    end
})

TabChar.Divider(TabChar)

TabChar.Input(TabChar, {
    Title = "旋转速度",
    Desc = "Y轴角速度",
    Value = "",
    Callback = function(v)
        state.spinSpeed = tonumber(v) or state.spinSpeed
    end
})

TabChar.Button(TabChar, {
    Title = "应用旋转速度",
    Callback = function()
        if state.spin then
            stopSpin()
            setSpin(true)
        end
        notify("旋转速度", "已设为: " .. tostring(state.spinSpeed))
    end
})

TabChar.Toggle(TabChar, {
    Title = "旋转",
    Value = false,
    Callback = function(v)
        if v then
            setSpin(true)
            notify("旋转", "已开启，速度: " .. tostring(state.spinSpeed))
        else
            stopSpin()
            notify("旋转", "已关闭")
        end
    end
})

TabChar.Button(TabChar, {
    Title = "飞行",
    Callback = function()
        setFly(true)
        notify("飞行", "已开启")
    end
})

TabChar.Divider(TabChar)

TabChar.Input(TabChar, {
    Title = "头部",
    Desc = "尺寸",
    Value = "",
    Callback = function(v)
        state.headSize = tonumber(v) or state.headSize
    end
})

TabChar.Button(TabChar, {
    Title = "应用头部",
    Callback = function()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                applyHitboxToPlayer(player, state.headSize, true)
            end
        end
        notify("头部", "尺寸已应用: " .. tostring(state.headSize))
    end
})

TabChar.Toggle(TabChar, {
    Title = "循环坐头",
    Value = false,
    Callback = function(v)
        if v then
            sitOnSelectedPlayer(true)
        else
            stopSitHead()
            notify("循环坐头", "已关闭")
        end
    end
})

TabChar.Dropdown(TabChar, {
    Title = "选择玩家",
    Values = getPlayerNames(),
    Multi = false,
    Default = 1,
    Callback = function(v)
        if typeof(v) == "table" then
            for _, name in ipairs(v) do
                setSelectedPlayer(name)
                break
            end
        else
            setSelectedPlayer(v)
        end
    end
})

TabChar.Button(TabChar, {
    Title = "坐头",
    Callback = function()
        sitOnSelectedPlayer(false)
    end
})

TabChar.Button(TabChar, {
    Title = "停止坐头",
    Callback = function()
        stopSitHead()
    end
})

TabChar.Divider(TabChar)

TabChar.Input(TabChar, {
    Title = "视角高度",
    Desc = "相机高度",
    Value = "",
    Callback = function(v)
        state.cameraHeight = tonumber(v) or state.cameraHeight
    end
})

TabChar.Button(TabChar, {
    Title = "应用视角高度",
    Callback = function()
        setCameraHeight(state.cameraHeight)
        notify("视角设置", "视角高度已设为: " .. tostring(state.cameraHeight))
    end
})

TabChar.Button(TabChar, {
    Title = "视角重置",
    Callback = function()
        resetCamera()
        notify("视角重置", "视角已重置为默认")
    end
})

TabChar.Input(TabChar, {
    Title = "亮度设置",
    Desc = "游戏亮度",
    Value = "",
    Callback = function(v)
        state.cameraBrightness = tonumber(v) or state.cameraBrightness
    end
})

TabChar.Button(TabChar, {
    Title = "应用亮度",
    Callback = function()
        setLighting(state.cameraBrightness)
        notify("亮度设置", "游戏亮度已设为: " .. tostring(state.cameraBrightness))
    end
})

TabChar.Button(TabChar, {
    Title = "正常视角",
    Callback = function()
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        notify("视角设置", "已切换为正常视角")
    end
})

TabChar.Button(TabChar, {
    Title = "强制第一视角",
    Callback = function()
        LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
        notify("视角设置", "已切换为强制第一视角")
    end
})

TabChar.Button(TabChar, {
    Title = "强制第三视角",
    Callback = function()
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        notify("视角设置", "已切换为强制第三视角")
    end
})

TabOther.Button(TabOther, {
    Title = "水印",
    Callback = function()
        createWatermark(true)
        notify("水印", "水印已开启")
    end
})

TabOther.Button(TabOther, {
    Title = "关闭水印",
    Callback = function()
        destroyWatermark(true)
        notify("水印", "水印已关闭")
    end
})

TabOther.Button(TabOther, {
    Title = "水印二",
    Callback = function()
        createWatermark(false)
        notify("水印二", "已开启")
    end
})

TabOther.Button(TabOther, {
    Title = "关闭水印二",
    Callback = function()
        destroyWatermark(false)
        notify("水印二", "已关闭")
    end
})

TabOther.Divider(TabOther)

TabOther.Input(TabOther, {
    Title = "物体选择",
    Desc = "输入对象路径表达式",
    Value = "",
    Callback = function(v)
        state.selectedObject = parseObject(v)
    end
})

TabOther.Button(TabOther, {
    Title = "应用物体选择",
    Callback = function()
        if state.selectedObject then
            notify("物体选择", "已选择: " .. tostring(state.selectedObject:GetFullName()))
        else
            notify("物体选择", "未找到指定物体")
        end
    end
})

TabOther.Input(TabOther, {
    Title = "零件透明度",
    Desc = "对象透明度",
    Value = "",
    Callback = function(v)
        state.objectTransparency = tonumber(v)
    end
})

TabOther.Toggle(TabOther, {
    Title = "零件透明度",
    Value = false,
    Callback = function(v)
        if not v then
            state.objectTransparency = nil
            applyObjectOptions()
            return
        end
        applyObjectOptions()
    end
})

TabOther.Toggle(TabOther, {
    Title = "零件碰撞",
    Value = false,
    Callback = function(v)
        state.objectCanCollide = v and true or false
        applyObjectOptions()
    end
})

TabOther.Toggle(TabOther, {
    Title = "零件固定",
    Value = false,
    Callback = function(v)
        state.objectAnchored = v and true or false
        applyObjectOptions()
    end
})

TabOther.Toggle(TabOther, {
    Title = "火焰",
    Value = false,
    Callback = function(v)
        state.objectFire = v and true or false
        applyObjectOptions()
    end
})

TabOther.Toggle(TabOther, {
    Title = "烟雾",
    Value = false,
    Callback = function(v)
        state.objectSmoke = v and true or false
        applyObjectOptions()
    end
})

TabOther.Toggle(TabOther, {
    Title = "闪光",
    Value = false,
    Callback = function(v)
        state.objectSparkles = v and true or false
        applyObjectOptions()
    end
})

TabOther.Dropdown(TabOther, {
    Title = "材质",
    Values = {
        "Plastic",
        "Wood",
        "WoodPlanks",
        "Slate",
        "Concrete",
        "CorrodedMetal",
        "DiamondPlate",
        "Foil",
        "Grass",
        "Ice",
        "Marble",
        "Granite",
        "Brick",
        "Pebble",
        "Sand",
        "Fabric",
        "SmoothPlastic",
        "Metal",
        "WoodSeat",
        "RoundPlastic",
        "Neon",
        "Glass",
        "ForceField"
    },
    Multi = false,
    Default = 1,
    Callback = function(v)
        state.objectMaterial = typeof(v) == "table" and v[1] or v
        applyObjectOptions()
    end
})

TabOther.Button(TabOther, {
    Title = "恢复物体",
    Callback = function()
        state.objectTransparency = nil
        state.objectCanCollide = nil
        state.objectAnchored = nil
        state.objectFire = false
        state.objectSmoke = false
        state.objectSparkles = false
        state.objectMaterial = nil
        restoreObjectSettings()
    end
})

Window:SelectTab(1)

Window.OnClose = function()
    disconnect("transparency")
    disconnect("gravityAdded")
    disconnect("gravity")
    disconnect("spin")
    disconnect("fly")
    disconnect("teleportSpeed")
    disconnect("velocitySpeed")
    disconnect("highJump")
    disconnect("airJumpHeartbeat")
    disconnect("airJumpRequest")
    disconnect("sitHead")
    disconnect("cameraHeight")
    disconnect("knockback")
    disconnect("animSpeed")
    restoreWorldTransparency()
    restoreObjectSettings()
end
