local geto = {}

--[[
FindPlayer(str) -- str is the name to look for when finding the player. FindPlayer('DogMan') | Returns: Player | 
FindPart(str, p) -- str is the name to look for for finding the part. p is the instance to search in. FindPart('Part', game.Workspace | Returns part if true otherwise returns nil |
DoesExist(str, p) -- p is the instance to search for the thing that exists, str is the name to look for. if DoesExist('Part', game.Workspace) then | Returns true if it exists otherwise returns false |
GetNil() -- Returns Nil Instances. local nil = GetNil() | Returns TABLE with all the nil instances |
Move(p,p2) -- Moves all children from p to p2. Move(game.Workspace, game.Lighting) | Returns Nothing |
SearchAndDestroy(str, p) --str is the name to look for, p is the instance to search in. | Returns Nothing |

Created by pr0duced.

This will be updated every day.


SCRIPT TO ADD TO YOUR SCRIPT:
loadstring(game:HttpGet('https://raw.githubusercontent.com/Pr0duced/PublicScripts/main/GETO%20library.lua'))()
]]

function geto.FindPlayer(str)
    if type(str) == 'string' then
        for _,v in pairs(game:GetService('Players'):GetPlayers()) do 
            if v.Name:lower():sub(1,#str) == str:lower() then 
                return v
            end
        end
        return nil
    else 
        error('Argument Error, 1 Arguments needed. (Current Arguments: '..str..') '..debug.traceback())
    end
end

function geto.FindPart(str, p) 
    if type(p) == 'userdata' and type(str) == 'string' then 
        for _,v in pairs(p:GetDescendants()) do
            if v.Name:lower():sub(1,#str) == str:lower() then 
                return v
            end
        end
        return nil
    else 
        error('Argument Error, 1 Arguments needed. (Current Arguments: '..tostring(str)..', '..tostring(p)..') '..debug.traceback())
    end
end

function geto.DoesExist(str, p)
    if type(p) == 'userdata' and type(str) == 'string' then
        for _,v in pairs(p:GetDescendants()) do 
            if v.Name:lower():sub(1,#str) == str:lower() then 
                return true
            end
        end
        return false
    else 
        error('Argument Error, 1 Arguments needed. (Current Arguments: '..tostring(p)..', '..tostring(str)..') ', debug.traceback())
    end
end

function geto.GetNil()
    local output = {}
    for i,v in pairs(game:GetDescendants()) do 
        if v.Parent == nil then 
            table.insert(output, v)
        end
    end
    return output
end 

function geto.Move(p,p2) 
    if type(p) == 'userdata' and type(p2) == 'userdata' then 
        for _,v in pairs(p:GetChildren()) do 
            v.Parent = p2
        end
    else 
        error('Argument Error, 2 Arguments needed. (Current Arguments: '..tostring(p1)..', '..tostring(p2)..') '..debug.traceback())
    end
end

function geto.SearchAndDestroy(str, p) 
    if type(p) == 'userdata' and type(str) == 'string' then 
        for _,v in pairs(p:GetDescendants()) do 
            if v.Name:lower():sub(1,#str) == str:lower() then 
                v:Destroy()
            end
        end
    else 
        error('Argument Error, 1 Argument needed. (Current Arguments: '..tostring(str)..', '..tostring(p)..' ) '..debug.traceback())
    end
end

function geto.ClearAll(str) 
    if type(str) == 'string' then 
        for _,v in pairs(game:GetDescendants()) do
            if v.Name:lower():sub(1,#str) == str:lower() then 
                v:Destroy()
            end
        end
    else 
        error('Argument Error, 1 Arguments needed. (Current Arguments: '..tostring(str)..') '..debug.traceback())
    end
end

for i,v in pairs(geto) do 
    getgenv()[i] = v
end
