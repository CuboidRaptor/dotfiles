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
    
    return "<Esc>:'<<CR>0<C-v>" .. jstring .. "I##<Esc>"
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
    
    return "<Esc>:'<<CR>0<C-v>l" .. jstring .. ":s/##/<CR>"
end

leader_1 = "," -- leader key go brrrr

vim.keymap.set("n", "x", "\"_x", { remap=false, desc="Delete" }) -- the x key no longer goes to any register
vim.keymap.set("v", "x", "\"_x", { remap=false, desc="Delete" })

vim.keymap.set("n", "<C-a>", "gg_vG$", { remap=true, desc="Select All" })
vim.keymap.set("i", "<C-a>", "<Esc>gg_vG$", { remap=true, desc="Select All" })

vim.keymap.set("v", leader_1 .. "c", function() return comment() end, { remap=true, desc="Block Comment", expr=true })
vim.keymap.set("v", leader_1 .. "u", function() return uncomment() end, { remap=true, desc="Block Uncomment", expr=true })

vim.keymap.set("n", "<Home>", "^", { remap=true, desc="Go home, after indents" })
vim.keymap.set("i", "<Home>", "<Esc>^i", { remap=true, desc="Go home, after indents" })
vim.keymap.set("v", "<Home>", "^", { remap=true, desc="Go home, after indents" })

-- code runner!
vim.keymap.set("n", "<F5>", ":w<CR>:RunCode<CR>i", { remap=true, desc="Run Code" })
vim.keymap.set("i", "<F5>", "<Esc>:w<CR>:RunCode<CR>i", { remap=true, desc="Run Code" })

-- allow Esc in terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { remap=true, desc="Escape in Terminal Mode" })