-- Takes in hjkl
local M = {}

-- Convert from vim movement keys to Up, Left ... for tmux
local tmux_map = { h = "L", j = "D", k = "U", l = "R" }

local function tmux_move(direction)
    -- tmux select pane
    local tmux_direction = tmux_map[direction]
    vim.fn.system({ "tmux", "select-pane", "-" .. tmux_direction })
end

local function move(direction)
    -- Try to move to vim split
    local win_num_before = vim.fn.winnr()
    vim.cmd("wincmd " .. direction)
    if vim.fn.winnr() == win_num_before then
        -- If the command did nothing, that means the current split
        -- is at the edge and we need to select the tmux pane
        tmux_move(direction)
    else
        vim.cmd.startinsert()
    end
end

function M.move_left()
    move("h")
end

function M.move_down()
    move("j")
end

function M.move_right()
    move("l")
end

function M.move_up()
    move("k")
end

return M
