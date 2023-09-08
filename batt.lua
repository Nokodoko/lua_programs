#!/bin/env lua

local h_ok, h = pcall(require, "helpers")
if not h_ok then
    return
end

local t = {}

local battery = io.popen('acpi', 'r')
    if not battery then
        h.check(1, "Could not run the acpi command")
    else
    local output = battery:read("*all")
    local percentage = output:match( "Discharging, (%d+)" )
    percentage = tonumber(percentage)
        if percentage then
            table.insert(t, percentage)
       end
    battery:close()
        if percentage == nil then
            h.check(1, "Could not populate table with Discharge value ")
        elseif percentage < 70 then
            h.check(1, "Charge Me!!")
        end
    return t
end
