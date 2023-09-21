#!/bin/env lua

local t = {}

local target = arg[1]

local function git_list(target_dir)
    local dir_list = io.popen('fd -td -d1 . "'..target_dir..'"', 'r')
    if dir_list then
        for line in dir_list:lines() do
            table.insert(t, line)
        end
        dir_list:close()
        return t
    else
        Check(1, "Could not parse" .. target)
        return
    end
end

git_list(target)

local function sequence(value)
    os.execute('pushd "'..value..'" && git checkout master && git pull && popd')
end

local function git_pull(tbl)
   for _, v in ipairs(tbl) do
        sequence(v)
   end
end

git_pull(t)
