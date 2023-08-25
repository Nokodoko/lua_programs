#!/bin/env lua

local pass = os.getenv("PASS")

local function choice_table(file)
   local t = {}
   local cat = io.open(file, 'r')
    if cat then
        for line in cat:lines() do
            if string.find(line, '_') then
                table.insert(t, line)
            end
        end
        cat:close()
    else
        print("Could not open file")
        return nil
    end
    return t
end

local function select_command(list)
    local cmd = 'echo "'..list..'" | rofi -theme sidebar -font "VictorMono 20" -dmenu -p "myPass"'
    local handle = io.popen(cmd)
    if handle then
        local result = handle:read("*a")
        handle:close()
        return result
    else
        print("Could not open "..list)
        return nil
    end
end

--helper function to return the actual iterated values over the table instead of just the table
local function loop(tbl)
    local result = ""
   for _, v in ipairs(tbl)do
        result = result ..v.. "\n"
   end
    return result
end

local choice = select_command(loop(choice_table(pass)))

-- get rid of trailing newline
if choice then
    choice = choice:sub(1, -2)
end

--clean table with all values to run  the password retrieval against against
local function pass_table(file)
    local t = {}
    local handle = io.open(file, 'r')
    if handle then
        for lines in handle:lines() do
           table.insert(t, lines)
        end
        handle:close()
        return t
    else
        print("Could not open file")
        return nil
    end
end


local function next_line(prog, qry)
    local found = false
    if prog then
        for _,v in ipairs(prog) do
            if found then
                os.execute('echo "'..v..'" | xclip -sel c')
                return v
            end
            if string.find(v, qry) then
                found = true
            end
        end
    else
        print("Could not find table", prog)
        return nil
    end
end

next_line(pass_table(pass), choice)
