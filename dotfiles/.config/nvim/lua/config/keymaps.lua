-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- funni visual selection go brrrr
local function comment() -- block commenting code -- language-specific
    local s_start = vim.fn.getpos("v")[2]
    local s_end = vim.fn.getpos(".")[2]
    local js = math.abs(s_end - s_start)
    local jstring
    
    if (js == 0)
    then
        jstring = ""
    else
        jstring = tostring(js) .. "j"
    end
    
    return "<Esc>:'<<Enter>0<C-v>" .. jstring .. "I##<Esc>"
end

local function uncomment() -- uncomment
    local s_start = vim.fn.getpos("v")[2]
    local s_end = vim.fn.getpos(".")[2]
    local js = math.abs(s_end - s_start)
    local jstring
    
    if (js == 0)
    then
        jstring = ""
    else
        jstring = tostring(js) .. "j"
    end
    
    return "<Esc>:'<<Enter>0<C-v>l" .. jstring .. ":s/##/<Enter>"
end

local function bracket(str) -- auto go in to parentheses -- language-specific
    bracket_map = {
        [")"] = "(",
        ["]"] = "[",
        ["}"] = "{",
        ["\""] = "\"" -- not using this one because of python """ gets messed up but I mean you could
    }
    _line, cursorpos = unpack(vim.api.nvim_win_get_cursor(0))
    
    if (cursorpos <= 0)
    then
        return str
    end
    
    before_cursor = vim.api.nvim_get_current_line():sub(cursorpos, cursorpos)
    
    if (before_cursor ~= bracket_map[str])
    then
        return str
    else
        return str .. "<Left>"
    end
end

leader_1 = "," -- leader key go brrrr

vim.keymap.set("n", "x", "\"_x", {remap=false, desc="Delete"}) -- the x key no longer goes to any register
vim.keymap.set("v", "x", "\"_x", {remap=false, desc="Delete"})

vim.keymap.set("n", "<C-a>", "gg_vG$", {remap=true, desc="Select All"})
vim.keymap.set("i", "<C-a>", "<Esc>gg_vG$", {remap=true, desc="Select All"})

-- these are disabled because of semicolon concerns and I just generally don't like them
--vim.keymap.set("i", ")", function() return bracket(")") end, {remap=true, expr=true}) -- auto go into parentheses/bracket/braces
--vim.keymap.set("i", "]", function() return bracket("]") end, {remap=true, expr=true})
--vim.keymap.set("i", "}", function() return bracket("}") end, {remap=true, expr=true})
--vim.keymap.set("i", "\"", function() return bracket("\"") end, {remap=true, expr=true})
-- ^ this one screws up python """

vim.keymap.set("v", leader_1 .. "c", function() return comment() end, {remap=true, desc="Block Comment", expr=true})
vim.keymap.set("v", leader_1 .. "u", function() return uncomment() end, {remap=true, desc="Block Uncomment", expr=true})

vim.keymap.set("n", "<Home>", "_", {remap=true, desc="Go home, after indents"})
vim.keymap.set("i", "<Home>", "<Esc>_i", {remap=true, desc="Go home, after indents"})
vim.keymap.set("v", "<Home>", "_", {remap=true, desc="Go home, after indents"})

-- language-specific
vim.keymap.set("n", "<F5>", ":w<Enter>:RunCode<Enter>", {remap=true, desc="Run Code"})
vim.keymap.set("i", "<F5>", "<Esc>:w<Enter>:RunCode<Enter>a", {remap=true, desc="Run Code"})