-- Jump to the last position when reopening a file
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    group = vim.api.nvim_create_augroup("jump_last_position", { clear = true }),
    callback = function()
        local row, col = unpack(vim.api.nvim_buf_get_mark(0, "\""))
        if {row, col} ~= {0, 0} then
            vim.api.nvim_win_set_cursor(0, {row, 0})
        end
    end,
})

-- Remove traling whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Higlight when yanking (copying) text
--  Try with `yap` in normal mode
--  See: :help vim.highlight.on_yank()
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
