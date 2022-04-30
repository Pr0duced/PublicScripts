--[[
    DOCUMENTATION:
        https://github.com/Pr0duced/PublicScripts/blob/main/BodyLibrary%20Documentation.txt
]]

local body = {}

function body.fastwait() 
    return game:GetService('RunService').Heartbeat:Wait()
end

function body.velocity(part,pos) 
    if part:IsA('Part') or part:IsA('BasePart') and type(pos) == 'vector' then 
        part.Velocity = pos -- [[ Sets velocity ]]
    else 
        warn(debug.traceback())
    end
end

function body.connect(part,t,t2) --[[ Too lazy to add notes here ]]
    local info = t 
    local info2 = t2
    if type(info) == 'Table' and type(info2) == 'Table' and part:IsA('Part') or part:IsA('BasePart') then 
        local pos = part.Position
        local cf = part.CFrame
        part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
        part.Massless = true
        part.CanCollide = false
        local bp = Instance.new('BodyPosition', part); local bg = Instance.new('BodyGyro', part)

        for i,v in pairs(info) do 
            bp[i] = v
        end

        for i,v in pairs(info2) do 
            bg[i] = v
        end

        bp.Position = part.Position
        bg.CFrame = part.CFrame

        part:BreakJoints()
    else 
        warn(debug.traceback('FATAL ERROR body.connect ', 3))
    end
end

function body.getbodyP(part) 
    if part:IsA('Part') or part:IsA('BasePart') then 
        for _,v in pairs(part:GetDescendants()) do 
            if v:Isa('BodyPosition') then 
                return v
            end
        end
    else 
        error(debug.traceback('Part is nil'))
    end
end

function body.getbodyG(part) 
    if part:IsA('Part') or part:IsA('BasePart') then 
        for _,v in pairs(part:GetDescendants()) do 
            if v:IsA('BodyGyro') then 
                return v -- [[ Returns bgyro ]]
            end
        end
    else 
        error(debug.traceback('Part is nil'))
    end
end

function body.getbodyP(part) 
    if part:IsA('Part') or part:IsA('BasePart') then 
        for _,v in pairs(part:GetDescendants()) do 
            if v:IsA('BodyPosition') then 
                return v -- [[ Returns bpos ]]
            end
        end
    else 
        error(debug.traceback('Part is nil')) -- [[ Showed which line errored ]]
    end
end

function body.setposition(part, pos)
    if part ~= nil and type(pos) == 'vector' and part:IsA('BasePart') or part:IsA('Part') then 
        body.getbodyP(part).Position = pos -- [[ Sets bodyposition Position to pos which is supposed to be a vector3 ]]
    else 
        error(debug.traceback('Position or part is nil')) -- [[ Showed which line errored ]]
    end
end

function body.setgyro(part, cf)
    if part ~= nil and type(cf) == 'userdata' and part:IsA('Part') or part:IsA('BasePart') then 
        body.getbodyG(part).CFrame = cf -- [[ Sets bgyro CFrame to cf which is supposed to be a cframe ]]
    else 
        error(debug.traceback('CFrame or Part is nil')) -- [[ Shows which line errored ]]
    end
end

function body.releasetools(t,t2) -- [[ Takes out tools and runs bodyposition and bodygyro ]]
    for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
        if v:IsA('Tool') and v:FindFirstChild('Handle') and not v.Handle:FindFirstChild('BodyPosition') then -- [[ Checks if its a tool and has handle ]]
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v) -- [[ Equips the tool ]]
            wait(.1)
            body.connect(v.Handle,t,t2) -- [[ Runs the function ]]
        end
    end
end


function body.releasehats(t,t2) -- [[ Takes out tools and runs bodyposition and bodygyro ]]
    for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do 
        if v:IsA('Hat') or v:IsA('Accessory') and v:FindFirstChild('Handle') and not v.Handle:FindFirstChild('BodyPosition') then -- [[ Checks if its a tool and has handle ]]
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v) -- [[ Equips the tool ]]
            body.connect(v.Handle,t,t2) -- [[ Runs the function ]]
        end
    end
end


function body.clean()
    for _,v in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do 
        if v:IsA('BodyPosition') or v:IsA('BodyGyro') then 
            v:Destroy() -- [[ Adds to garbage collection ]]
        end
    end
end

function body.autovelocitytools(pos)
    if type(pos) == 'vector' then 
        task.spawn(function()
            while true do
                for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA('Tool') and v:FindFirstChild('Handle') and v.Handle:FindFirstChild('BodyPosition') then 
                        body.velocity(v.Handle, pos)
                    end
                end
                if game.Players.LocalPlayer.Backpack:FindFirstChildOfClass('Tool') then 
                    break
                end
                body.fastwait()
            end
        end)
    end
end

function body.autovelocityhats(pos)
    if type(pos) == 'vector' then 
        task.spawn(function()
            while true do
                for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA('Hat') or v:IsA('Accessory') and v:FindFirstChild('Handle') and v.Handle:FindFirstChild('BodyPosition') then 
                        body.velocity(v.Handle, pos)
                    end
                end
                if not game.Players.LocalPlayer.Character:FindFirstChild('Humanoid') or game.Players.LocalPlayer.Character.Humanoid.Health < 1 then 
                    break
                end
                body.fastwait()
            end
        end)
    end
end

function body.autoclean()
    task.spawn(function()
        while true do 
            body.clean()
            body.fastwait()
        end
    end)
end

function body.toolamount()
    local amount = 0
    for _,v in pairs(gautoame.Players.LocalPlayer.Character:GetChildren()) do 
        if v:IsA('Tool') and v:FindFirstChild('Handle') then amount += 1 end
    end
    return amount
end

function body.hatamount()
    local amount = 0
    for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do 
        if v:IsA('Hat') or v:IsA('Accessory') and v:FindFirstChild('Handle') then amount += 1 end
    end
    return amount
end

return body
