#!/bin/env lua

local status_ok, h = pcall(require, "helpers")
if not status_ok then
    return
end
local t = {}

local cmd = io.popen('fd -d1 . /home/n0ko/Pictures/ -e jpg -e png', 'r')
if cmd then
    for lines in cmd:lines() do
        table.insert(t, lines)
    end
    cmd:close()
end

local function sxiv(tbl)
    local output = 'sxiv -o -t'
    for _, v in ipairs(tbl) do
        output = output .. ' "' ..v .. '"'
    end
    local command = io.popen(output)
    if command then
        local list = command:read("*a")
        command:close()
        if list then
            if list == "" then
                h.check(1, "Could not send Pictures to sxiv")
            end
            list = list:gsub("\n", "")
            return list
        end
    end
end

local function feh(pic)
    local wallpaper = io.popen('feh --bg-scale "'..pic..'" ')
    if not wallpaper then
        h.check(1, "Could not updated wallpaper")
    else
        wallpaper:close()
    end
end

feh(sxiv(t))
