return function(rd)
    local function validateRange(arg, min, max)
        return arg >= min and arg <= max
    end

    local function validateSSID(ssid)
        return validateRange(#ssid, 1, 32)
    end

    local function validatePwd(pwd)
        return validateRange(#pwd, 8, 64)
    end

    local function validateHostname(hostname)
        if not validateRange(#hostname, 1, 32) then
            return false
        end

        local rem
        local nrep
        rem, nrep = hostname:gsub("[a-zA-Z0-9-]", "")
        if #rem ~= 0 then
            return false
        end

        if hostname:sub(1, 1) == "-" or hostname:sub(-1, -1) == "-" then
            return false
        end

        return true
    end


    local validatetable = {
            ["wifiConfig.accessPointConfig.ssid"] = validateSSID,
            ["wifiConfig.accessPointConfig.pwd"] = validatePwd,
            ["wifiConfig.stationPointConfig.ssid"] = validateSSID,
            ["wifiConfig.stationPointConfig.pwd"] =  validatePwd,
            ["wifiConfig.stationPointConfig.hostname"] = validateHostname,
    }
    
    local badvalues = {}
    for name, value in pairs(rd) do
        if validatetable[name] then
            if not validatetable[name](value) then
                badvalues[name] = value
            end
        end
    end

    return badvalues
end
