

vim.diagnostic.config({
    virtual_text = false,
    float = true,
});

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'c,cpp,objc,objcpp',
    callback = function(args)
        vim.lsp.start({
            name = 'parfait-lsp',
            cmd = {'parfait-lsp', '-v', '--parfait', '-W', '-I', '-p', '-e', 'all', '-llibparfait-rdbms' },
            root_dir = vim.fs.root(args.buf, {'compile_commands.json', 'cmake-build-debug/compile_commands.json', 'cmake-build-release/compile_commands.json', '.vim/', '.git/', '.hg/'}),
        })
    end,
})

vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {scope='cursor', focus=false})]]

-- Disable logs, because it grows indefinitely
-- vim.lsp.set_log_level("off")
