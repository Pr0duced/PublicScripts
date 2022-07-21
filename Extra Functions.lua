local r = {}

r.findservice = function(entity)
    for _,v in pairs(game:GetChildren()) do 
        if entity:IsDescendantOf(v) then 
            return v
        end
    end
end

r.iscore() = function()
    local ignore = {
        "CorePackages",
        "Chat"
    }

    local service = r.findservice(getfenv(0).script) 
    if not table.find(ignore, tostring(service)) then 
        return false
    elseif table.find(ignore, tostring(service)) then 
        return true
    end
end

return r
