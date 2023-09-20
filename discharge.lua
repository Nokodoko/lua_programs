#!/bin/env lua

local h_ok, h = pcall(require, "helpers")
if not h_ok then
    return
end

local target = 15

local function charge_notice()
    os.execute('notify-send -u normal "Charging"')
    return nil
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
                table.insert(t, discharge)
            end
            if full then
                os.exit(0, true)
            end
            if charge then
                while charge == charge do
                    charge_notice()
                    h.dunst_close()
                    os.execute('loop ~/programming/lua_projects/charge.lua')
                    os.exit(0, true)
                end
            end
        battery:close()
           if discharge == nil then
           --     h.check(1, "Could not populate table with Discharge value ")
            elseif discharge < target then
                h.check(1, "Charge Me!!")
            end
        return t
    end
end

