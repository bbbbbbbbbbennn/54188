loadstring([==[local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 等待玩家数据完全加载
repeat task.wait() until LocalPlayer and LocalPlayer.Name ~= nil

-- 增强版白名单列表(确保都是小写无空格)
local whitelist = {
    "fifkchxuc",    -- 确保这些是准确的Roblox用户名
    "greenbag119",   -- 注意大小写
    -- 最多可添加50个用户名
}

-- 调试打印白名单
print("当前白名单列表:")
for i, name in ipairs(whitelist) do
    print(i..": "..name)
end

-- 增强的白名单有效性检查
local function isWhitelistValid()
    -- 检查白名单是否为空
    if #whitelist == 0 then
        warn("白名单为空!")
        return false
    end
    
    -- 检查每个条目是否有效
    local validCount = 0
    for _, name in ipairs(whitelist) do
        -- 确保是字符串且不是空值或占位符
        if type(name) == "string" and name ~= "" and name ~= "YourUsernameHere" then
            validCount = validCount + 1
        else
            warn("发现无效的白名单条目: "..tostring(name))
        end
    end
    
    -- 至少需要一个有效条目
    if validCount == 0 then
        warn("没有有效的白名单条目!")
        return false
    end
    
    return true
end

-- 增强的白名单检查(不区分大小写和空格)
local function isPlayerWhitelisted(playerName)
    -- 标准化玩家名(去空格+转小写)
    local normalizedPlayerName = string.lower(string.gsub(playerName or "", "%s+", ""))
    
    -- 检查每个白名单条目
    for _, allowedName in ipairs(whitelist) do
        -- 标准化白名单名
        local normalizedAllowedName = string.lower(string.gsub(allowedName or "", "%s+", ""))
        
        -- 调试打印比较
        print("比较: '"..normalizedPlayerName.."' vs '"..normalizedAllowedName.."'")
        
        if normalizedPlayerName == normalizedAllowedName then
            return true
        end
    end
    
    return false
end

-- 主检查逻辑(添加更多错误处理)
local function checkWhitelist()
    -- 检查白名单有效性
    if not isWhitelistValid() then
        local msg = "白名单配置无效，请联系管理员"
        warn(msg)
        LocalPlayer:Kick(msg)
        return false
    end
    
    -- 获取当前玩家名(带错误处理)
    local currentPlayerName
    pcall(function()
        currentPlayerName = LocalPlayer.Name
    end)
    
    if not currentPlayerName then
        local msg = "无法获取玩家名称"
        warn(msg)
        LocalPlayer:Kick(msg)
        return false
    end
    
    print("当前玩家: "..currentPlayerName)
    
    -- 检查白名单
    if not isPlayerWhitelisted(currentPlayerName) then
        local msg = "您不在白名单中 ("..currentPlayerName..")"
        warn(msg)
        
        -- 显示通知
        pcall(function()
            game.StarterGui:SetCore("SendNotification", {
                Title = "白名单限制",
                Text = msg,
                Duration = 5
            })
        end)
        
        task.wait(1)
        LocalPlayer:Kick("快去找BEN买白名单 qq联系2321221466购买")
        return false
    end
    
    -- 白名单验证通过
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "验证通过",
            Text = "欢迎 "..currentPlayerName.."，可以使用BEN自动脚本",
            Duration = 5
        })
    end)
    
    return true
end

-- 执行白名单检查
if not checkWhitelist() then
    return -- 终止脚本执行
end

-- 以下是您原有的脚本内容...
local player = game:GetService("Players").LocalPlayer
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local character = player.Character or player.CharacterAdded:Wait()
local HumanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local scriptStartTime = os.time()
local forbiddenZoneCenter = Vector3.new(352.884155, 13.0287256, -1353.05396)
local forbiddenRadius = 80
local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100"))
local currentJobId = game.JobId
local availableServers = {}

-- 初始化角色位置
local epoh1 = CFrame.new(998.4656372070312, 15, 395.9789733886719)
HumanoidRootPart.CFrame = epoh1

-- 所有需要捡起的物品列表
local targetItems = {
    "Money Printer",
    "Blue Candy Cane",
    "Bunny Balloon",
    "Ghost Balloon",
    "Clover Balloon",
    "Bat Balloon",
    "Gold Clover Balloon",
    "Golden Rose",
    "Black Rose",
    "Heart Balloon",
    "Diamond Ring",
    "Diamond",
    "Void Gem",
    "Dark Matter Gem",
    "Rollie"
}

local function ShowNotification(text)
    game.StarterGui:SetCore("SendNotification", {
        Title = "自动脚本",
        Text = text,
        Duration = 5
    })
end

local function checkTimeout()
    return (os.time() - scriptStartTime) >= 120
end

local function TPServer()
    -- 重新获取服务器列表
    servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100"))
    availableServers= {}
    
    for _, server in ipairs(servers.data) do
        if server.playing < server.maxPlayers and server.id ~= currentJobId then
            table.insert(availableServers, server.id)
        end
    end
    
    if #availableServers > 0 then
        ShowNotification("正在切换到新服务器...")
        TeleportService:TeleportToPlaceInstance(game.PlaceId, availableServers[math.random(1, #availableServers)])
    else
        ShowNotification("没有可用服务器，等待5秒后重试")
        task.wait(5)
        TPServer()
    end
end

-- 自动移动功能
local function autoMove()
    while true do
        if character and HumanoidRootPart and humanoid.Health > 0 then
            -- 获取当前朝向向量并向前移动
            local moveDirection = HumanoidRootPart.CFrame.LookVector
            humanoid:Move(moveDirection)
        end
        task.wait(3) -- 控制移动更新的频率
    end
end

-- 启动自动移动
coroutine.wrap(autoMove)()

local function AutoPickItem()
    ShowNotification("正在寻找物品...")
    
    local foundItem = false
    for _, itemFolder in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
        for _, item in pairs(itemFolder:GetChildren()) do
            if item:IsA("MeshPart") or item:IsA("Part") then
                local itemPos = item.Position
                local distance = (itemPos - forbiddenZoneCenter).Magnitude
    
                if distance > forbiddenRadius then
                    for _, child in pairs(item:GetChildren()) do
                        if child:IsA("ProximityPrompt") then
                            for _, targetName in pairs(targetItems) do
                                if child.ObjectText == targetName then
                                    foundItem = true
                                    child.RequiresLineOfSight = false
                                    child.HoldDuration = 0
                                    humanoid:Move(Vector3.new(1, 0, 0))
                                    HumanoidRootPart.CFrame = item.CFrame * CFrame.new(0, 2, 0)
                                    fireproximityprompt(child)
                                    
                                    local startTime = tick()
                                    local timeout = 5
                                    local connection
                                    connection = game:GetService("RunService").Heartbeat:Connect(function()
                                        if not item or not item.Parent then
                                            connection:Disconnect()
                                            return
                                        end
                                        
                                        if tick() - startTime >= timeout then
                                            item:Destroy()
                                            connection:Disconnect()
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return not foundItem -- 返回是否应该执行银行抢劫
end

local function AutoFarmBank()
    ShowNotification("正在抢劫银行...")

    local BankDoor = workspace.BankRobbery.VaultDoor
    local BankCashs = workspace.BankRobbery.BankCash

    while task.wait(0.1) do
        if checkTimeout() then
            TPServer()
            return
        end

        if BankDoor.Door.Attachment.ProximityPrompt.Enabled == true and BankCashs.Cash:FindFirstChild("Bundle") then
            HumanoidRootPart.CFrame = CFrame.new(1078.08093, 6.24685, -343.95758)
            BankDoor.Door.Attachment.ProximityPrompt.HoldDuration = 0
            fireproximityprompt(BankDoor.Door.Attachment.ProximityPrompt)
            task.wait(0.5)
        elseif not BankDoor.Door.Attachment.ProximityPrompt.Enabled and BankCashs.Cash:FindFirstChild("Bundle") then
            local targetPos = BankCashs.Cash:FindFirstChild("Bundle"):GetPivot().Position
            local basePosition = Vector3.new(targetPos.X, targetPos.Y - 5, targetPos.Z)
            local lookVector = (targetPos - basePosition).Unit
            HumanoidRootPart.CFrame = CFrame.new(basePosition, basePosition + lookVector)
            BankCashs.Main.Attachment.ProximityPrompt.RequiresLineOfSight = false
            BankCashs.Main.Attachment.ProximityPrompt.HoldDuration = 0
            fireproximityprompt(BankCashs.Main.Attachment.ProximityPrompt)
            task.wait(0.5)
        else
            ShowNotification("抢劫银行完成，1秒后换服")
            task.wait(1)
            TPServer()
            return
        end
    end
end

-- 主循环
while true do
    -- 确保角色存在
    character = player.Character or player.CharacterAdded:Wait()
    HumanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoid = character:WaitForChild("Humanoid")
    scriptStartTime = os.time()
    
    local shouldRobBank = AutoPickItem()
    
    if shouldRobBank then
        AutoFarmBank()
    end
    
    -- 等待一段时间再检查，避免过于频繁
    task.wait(5)
end]==])()
