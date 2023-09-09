#!/bin/env lua

local h_ok, h = pcall(require, "helpers")
if not h_ok then
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
        discharge = tonumber(discharge)
        charge = tonumber(charge)
            if discharge then
                table.insert(t, discharge)
            elseif charge then
                os.exit(0, true)
           end
        battery:close()
            if discharge == nil then
                h.check(1, "Could not populate table with Discharge value ")
            elseif discharge < 15 then
                h.check(1, "Charge Me!!")
            end
        return t
    end
end

