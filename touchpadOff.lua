#!/bin/env lua


local status_ok, h = pcall(require, "helpers")
if not status_ok then
    return
end

local t = {}
local search = "Trackpad"
local command = 'xinput'


local function disable(int)
   local run = os.execute('xinput set-prop "'..int..'" "Device Enabled" 0 &')
    if run then
        h.check(0, "Touchpad Disabled")
    else
        h.check(1, "Touchpad still Disabled")
    end
end

local function trackpad()
   local handle = io.popen(command, 'r')
    if handle then
        for lines in handle:lines() do
            if lines:match(search) then
                table.insert(t, lines)
            end
        end
    else
        h.check(1, 'Could not find "'..search..'"')
    end
    return t
end

local function match(tbl)
local id_tab = {}
    for _, v in ipairs(tbl) do
        local id =string.match(v, "id=(%d)")
        if id then
            table.insert(id_tab, id)
        end
    end
    return id_tab[1]
end

disable(match(trackpad()))
