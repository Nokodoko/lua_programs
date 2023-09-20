#!/bin/env lua


local status_ok, h = pcall(require, "helpers")
if not status_ok then
    return
end

while true do
    local t = {}

    local battery = io.popen('acpi', 'r')
        if not battery then
            h.check(1, "Could not run the acpi command")
        else
        local output = battery:read("*all")
        local discharge = output:match( "Discharging, (%d+)" )
        local charge = output:match( "Charging, (%d+)" )
        local full = output:match( "Full" )
        discharge = tonumber(discharge)
        charge = tonumber(charge)
            if discharge then
                os.execute('loop ~/programming/lua_projects/discharge.lua')
            end
            if full then
                os.exit(0, true)
            end
            if charge then
                while charge == charge do
                    os.exit(0, true)
                end
            end
        battery:close()
        return t
    end
end


