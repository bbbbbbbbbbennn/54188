loadstring([==[local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 白名单列表
local whitelist = {
    "YourUsernameHere",  -- 替换为你的用户名
    "fifkchxuc","greenbag119"     -- 最多支持50个用户名
}

-- 检查白名单是否为空或无效
local function isWhitelistValid()
    -- 检查是否有至少一个非空的有效用户名
    for _, name in ipairs(whitelist) do
        if type(name) == "string" and name ~= "" and name ~= "YourUsernameHere" then
            return true
        end
    end
    return false
end

-- 检查当前玩家是否在白名单中
local function isPlayerWhitelisted(playerName)
    -- 先去除两边空格再比较
    playerName = playerName:gsub("^%s*(.-)%s*$", "%1")
    
    for _, allowedName in ipairs(whitelist) do
        -- 也去除白名单名字的空格
        local trimmedName = allowedName:gsub("^%s*(.-)%s*$", "%1")
        if playerName == trimmedName then
            return true
        end
    end
    return false
end

-- 主检查逻辑
if not isWhitelistValid() then
    LocalPlayer:Kick("白名单配置无效，请联系管理员")
    return
end

if not isPlayerWhitelisted(LocalPlayer.Name) then
    game.StarterGui:SetCore("SendNotification", {
        Title = "白名单限制",
        Text = "您不在白名单中 ("..LocalPlayer.Name..")",
        Duration = 5
    })
    wait(1)
    LocalPlayer:Kick("快去找BEN买白名单 qq联系2321221466购买")
    return
else
    game.StarterGui:SetCore("SendNotification", {
        Title = "验证通过",
        Text = "欢迎 "..LocalPlayer.Name.."，可以使用BEN自动脚本",
        Duration = 5
    })
end
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
