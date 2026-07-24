local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
        Title = "XY脚本付费版<font color='#00FF00'>V2</font>",
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
    Title = "V2XY脚本",
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
    Main = Window:Section({ Title = "自然灾害", Opened = true }),
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