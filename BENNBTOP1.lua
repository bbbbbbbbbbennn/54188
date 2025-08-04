local _9a0x1 = game:GetService("\80\108\97\121\101\114\115").LocalPlayer
local _b3f7y = game:GetService("\84\101\108\101\112\111\114\116\83\101\114\118\105\99\101")
local _c8e2z = game:GetService("\72\116\116\112\83\101\114\118\105\99\101")
local _d4g3a = _9a0x1.Character or _9a0x1.CharacterAdded:Wait()
local _e5h4b = _d4g3a:WaitForChild("\72\117\109\97\110\111\105\100\82\111\111\116\80\97\114\116")
local _f6i5c = _d4g3a:WaitForChild("\72\117\109\97\110\111\105\100")
local _g7j6d = os.time()
local _h8k7e = Vector3.new(352.884155,13.0287256,-1353.05396)
local _i9l8f = 80
local _j0m9g = _c8e2z:JSONDecode(game:HttpGet("\104\116\116\112\115\58\47\47\103\97\109\101\115\46\114\111\98\108\111\120\46\99\111\109\47\118\49\47\103\97\109\101\115\47"..game.PlaceId.."\47\115\101\114\118\101\114\115\47\80\117\98\108\105\99\63\108\105\109\105\116\61\49\48\48"))
local _k1n0h = game.JobId
local _l2o1i = {}
local _m3p2j = CFrame.new(998.4656372070312,15,395.9789733886719)
_e5h4b.CFrame = _m3p2j
local _n4q3k = {
    "\77\111\110\101\121\32\80\114\105\110\116\101\114",
    "\66\108\117\101\32\67\97\110\100\121\32\67\97\110\101",
    "\66\117\110\110\121\32\66\97\108\108\111\111\110",
    "\71\104\111\115\116\32\66\97\108\108\111\111\110",
    "\67\108\111\118\101\114\32\66\97\108\108\111\111\110",
    "\66\97\116\32\66\97\108\108\111\111\110",
    "\71\111\108\100\32\67\108\111\118\101\114\32\66\97\108\108\111\111\110",
    "\71\111\108\100\101\110\32\82\111\115\101",
    "\66\108\97\99\107\32\82\111\115\101",
    "\72\101\97\114\116\32\66\97\108\108\111\111\110",
    "\68\105\97\109\111\110\100\32\82\105\110\103",
    "\68\105\97\109\111\110\100",
    "\86\111\105\100\32\71\101\109",
    "\68\97\114\107\32\77\97\116\116\101\114\32\71\101\109",
    "\82\111\108\108\105\101"
}

local function _o5r4l(_p6s5m)
    game.StarterGui:SetCore("\83\101\110\100\78\111\116\105\102\105\99\97\116\105\111\110", {
        Title = "\232\135\170\229\138\168\232\132\154\230\156\172",
        Text = _p6s5m,
        Duration = 5
    })
end

local function _q7t6n()
    return (os.time() - _g7j6d) >= 120
end

local function _r8u7o()
    _j0m9g = _c8e2z:JSONDecode(game:HttpGet("\104\116\116\112\115\58\47\47\103\97\109\101\115\46\114\111\98\108\111\120\46\99\111\109\47\118\49\47\103\97\109\101\115\47"..game.PlaceId.."\47\115\101\114\118\101\114\115\47\80\117\98\108\105\99\63\108\105\109\105\116\61\49\48\48"))
    _l2o1i = {}
    
    for _s9v8p, _t0w9q in ipairs(_j0m9g.data) do
        if _t0w9q.playing < _t0w9q.maxPlayers and _t0w9q.id ~= _k1n0h then
            table.insert(_l2o1i, _t0w9q.id)
        end
    end
    
    if #_l2o1i > 0 then
        _o5r4l("\230\173\163\229\156\168\229\136\135\230\141\162\229\136\176\230\150\176\230\156\141\229\138\161\229\153\168...")
        _b3f7y:TeleportToPlaceInstance(game.PlaceId, _l2o1i[math.random(1, #_l2o1i)])
    else
        _o5r4l("\230\178\161\230\156\137\229\143\175\231\148\168\230\156\141\229\138\161\229\153\168\239\188\140\231\173\137\229\190\1335\231\167\146\229\144\142\233\135\141\232\175\149")
        task.wait(5)
        _r8u7o()
    end
end

local function _u1x0r()
    while true do
        if _d4g3a and _e5h4b and _f6i5c.Health > 0 then
            local _v2y1s = _e5h4b.CFrame.LookVector
            _f6i5c:Move(_v2y1s)
        end
        task.wait(3)
    end
end

coroutine.wrap(_u1x0r)()

local function _w3z2t()
    _o5r4l("\230\173\163\229\156\168\229\175\188\230\137\190\231\137\169\229\147\129...")
    
    local _x4a3u = false
    for _y5b4v, _z6c5w in pairs(game:GetService("\87\111\114\107\115\112\97\99\101").Game.Entities.ItemPickup:GetChildren()) do
        for _a7d6x, _b8e7y in pairs(_z6c5w:GetChildren()) do
            if _b8e7y:IsA("\77\101\115\104\80\97\114\116") or _b8e7y:IsA("\80\97\114\116") then
                local _c9f8z = _b8e7y.Position
                local _d0g9a = (_c9f8z - _h8k7e).Magnitude
    
                if _d0g9a > _i9l8f then
                    for _e1h0b, _f2i1c in pairs(_b8e7y:GetChildren()) do
                        if _f2i1c:IsA("\80\114\111\120\105\109\105\116\121\80\114\111\109\112\116") then
                            for _g3j2d, _h4k3e in pairs(_n4q3k) do
                                if _f2i1c.ObjectText == _h4k3e then
                                    _x4a3u = true
                                    _f2i1c.RequiresLineOfSight = false
                                    _f2i1c.HoldDuration = 0
                                    _f6i5c:Move(Vector3.new(1, 0, 0))
                                    _e5h4b.CFrame = _b8e7y.CFrame * CFrame.new(0, 2, 0)
                                    fireproximityprompt(_f2i1c)
                                    
                                    local _i5l4f = tick()
                                    local _j6m5g = 5
                                    local _k7n6h
                                    _k7n6h = game:GetService("\82\117\110\83\101\114\118\105\99\101").Heartbeat:Connect(function()
                                        if not _b8e7y or not _b8e7y.Parent then
                                            _k7n6h:Disconnect()
                                            return
                                        end
                                        
                                        if tick() - _i5l4f >= _j6m5g then
                                            _b8e7y:Destroy()
                                            _k7n6h:Disconnect()
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

    return not _x4a3u
end

local function _l8o7i()
    _o5r4l("\230\173\163\229\156\168\230\140\145\229\138\168\233\147\182\232\161\140...")

    local _m9p8j = workspace.BankRobbery.VaultDoor
    local _n0q9k = workspace.BankRobbery.BankCash

    while task.wait(0.1) do
        if _q7t6n() then
            _r8u7o()
            return
        end

        if _m9p8j.Door.Attachment.ProximityPrompt.Enabled == true and _n0q9k.Cash:FindFirstChild("\66\117\110\100\108\101") then
            _e5h4b.CFrame = CFrame.new(1078.08093,6.24685,-343.95758)
            _m9p8j.Door.Attachment.ProximityPrompt.HoldDuration = 0
            fireproximityprompt(_m9p8j.Door.Attachment.ProximityPrompt)
            task.wait(0.5)
        elseif not _m9p8j.Door.Attachment.ProximityPrompt.Enabled and _n0q9k.Cash:FindFirstChild("\66\117\110\100\108\101") then
            local _o1r0l = _n0q9k.Cash:FindFirstChild("\66\117\110\100\108\101"):GetPivot().Position
            local _p2s1m = Vector3.new(_o1r0l.X,_o1r0l.Y-5,_o1r0l.Z)
            local _q3t2n = (_o1r0l - _p2s1m).Unit
            _e5h4b.CFrame = CFrame.new(_p2s1m,_p2s1m+_q3t2n)
            _n0q9k.Main.Attachment.ProximityPrompt.RequiresLineOfSight = false
            _n0q9k.Main.Attachment.ProximityPrompt.HoldDuration = 0
            fireproximityprompt(_n0q9k.Main.Attachment.ProximityPrompt)
            task.wait(0.5)
        else
            _o5r4l("\230\140\145\229\138\168\233\147\182\232\161\140\229\174\140\230\136\144\239\188\1401\231\167\146\229\144\142\230\141\162\230\156\141")
            task.wait(1)
            _r8u7o()
            return
        end
    end
end

while true do
    _d4g3a = _9a0x1.Character or _9a0x1.CharacterAdded:Wait()
    _e5h4b = _d4g3a:WaitForChild("\72\117\109\97\110\111\105\100\82\111\111\116\80\97\114\116")
    _f6i5c = _d4g3a:WaitForChild("\72\117\109\97\110\111\105\100")
    _g7j6d = os.time()
    
    local _r4u3o = _w3z2t()
    
    if _r4u3o then
        _l8o7i()
    end
    
    task.wait(5)
end
