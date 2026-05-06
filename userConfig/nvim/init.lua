#!/usr/bin/lua

-- for local config params
local config = {}
config.plugins = {}
config.plugins.isLspConfigPermitted = true -- should lspconfig plugin be downloaded and some configurations loaded
config.plugins.isNvimTreesitterPermitted = true -- should nvim treesitter plugin be downloaded

-- options
vim.o.autoindent = true
vim.o.autoread = true
vim.o.autowrite = true
vim.o.background = "dark"
vim.opt.backspace = {"indent","eol","start"}
vim.opt.belloff = {"all"}
-- vim.o.binary = true -- if editing bin files
vim.o.breakindent = true -- every wrapped line will continue visualy indented
vim.opt.clipboard:append("unnamedplus")
vim.o.completeopt = "menuone,preview,noinsert"
vim.o.showfulltag = true
vim.o.confirm = true
vim.o.cursorline = true
vim.o.cursorcolumn = false
vim.o.expandtab = true
vim.o.fixendofline = false
--vim.o.foldclose = "all"
--vim.o.foldmethod = "syntax"
--vim.o.formatexpr = ""
--vim.o.formatprg = "fmt"
vim.o.incsearch = true
vim.o.linespace = 0 -- change if font uses full char cell height
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.shiftwidth = 4
vim.o.showbreak = ">> "
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = 4
vim.o.title = true
vim.o.virtualedit = "block"
vim.o.wrap = true
--vim.o.complete = ".,w,b,u,t" -- standart
vim.o.complete = ".,w,b,u,i,t,d" -- for .c files
vim.opt.cino:append("l1")
--vim.opt.cino:append("=0")
vim.opt.cino:append("b1")
vim.opt.cino:append("g0")
vim.opt.cino:append("N-s")
vim.opt.cino:append("p0")
vim.opt.cino:append("t0")
vim.opt.cino:append("cs")
vim.opt.cino:append("C1")
vim.opt.cino:append("j1")
vim.opt.cino:append("J1")
vim.opt.cinkeys:append("0=break")

vim.o.statusline = "%f:%l:%c%( t:%Y%) [%p%%]%( %m%) %= %h"

-- variables
vim.g.c_syntax_for_h = true
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- plugins

if config.plugins.isLspConfigPermitted then
    vim.pack.add{
        { src = 'https://github.com/neovim/nvim-lspconfig' },
    }

    vim.lsp.enable('clangd')
    vim.lsp.enable('csharp_ls')
    vim.lsp.enable('jdtls')
    vim.lsp.enable('lua_ls')
end

if config.plugins.isNvimTreesitterPermitted then
    vim.pack.add{
        {src = 'https://github.com/nvim-treesitter/nvim-treesitter.git'},
    }
end


local hooks = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind

    if name == 'nvim-treesitter' and kind == 'update' then
        if not ev.data.active then
            vim.cmd.packadd('nvim-treesitter')
        end
        vim.cmd('TSUpdate')
    end
end

vim.api.nvim_create_autocmd('PackChanged', { callback = hooks })

-- filetypes

vim.filetype.add({
  extension = {
    c3 = "c3",
    c3i = "c3",
    c3t = "c3",
  },
})

------- keymaps

vim.keymap.set('', '<F5>', '<Escape><Escape>:make<Enter>')
vim.keymap.set('t', "<Esc><Esc>", "<C-\\><C-n>")

------- auto commands

-- vim.api.nvim_create_autocmd("BufWinEnter", {
--     callback = function(args)
--         parser_lang = vim.treesitter.language.get_lang(vim.bo.filetype)
--         if parser_lang ~= nil then
--             parser_file = io.open(os.getenv('XDG_CONFIG_HOME').."/nvim/parser/"..parser_lang..".so");
--             if parser_file ~= nil then
--                 io.close(parser_file)
--                 vim.treesitter.start()
--                 vim.opt_local.completefunc = "v:lua.vim.treesitter.query.omnifunc"
--             end
--         end
--     end
-- })
--
-- vim.api.nvim_create_autocmd("BufWinLeave", {
--     callback = function(args)
--         vim.treesitter.stop()
--     end
-- })

------ defined user commands

vim.api.nvim_create_user_command('ShowLineActions', 'lua vim.lsp.buf.code_action()', {})

vim.api.nvim_create_user_command('DiffOrig', 'vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis', {})

vim.api.nvim_create_user_command('ShowLineDiagnostics', 
    function(opts)
        vim.diagnostic.open_float()
    end, {})

vim.api.nvim_create_user_command('ShowFileDiagnostics', 
    function(opts)
        vim.diagnostic.setqflist()
    end, {})

vim.api.nvim_create_user_command('LoadFileDiagnostics', 
    function(opts)
        vim.diagnostic.setqflist({open = false})
    end, {})

vim.api.nvim_create_user_command('GotoNextFileDiagnostic', 
    function(opts)
        local next_diagnostic = vim.diagnostic.get_next()
        vim.diagnostic.jump({diagnostic = next_diagnostic})
    end, {})

vim.api.nvim_create_user_command('GotoPrevFileDiagnostic', 
    function(opts)
        local prev_diagnostic = vim.diagnostic.get_next()
        vim.diagnostic.jump({diagnostic = prev_diagnostic})
    end, {})

-- colorscheme

vim.cmd.colorscheme("falcon")

-- Platform-dependent

if vim.fn.has("win32") == 1 then
    -- Check if 'pwsh' is executable and set the shell accordingly
    if vim.fn.executable('pwsh') == 1 then
        vim.o.shell = 'pwsh'
    else
        vim.o.shell = 'powershell'
    end

    -- Setting shell command flags
    vim.o.shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[\'Out-File:Encoding\']=\'utf8\';'

    -- Setting shell redirection
    vim.o.shellredir = '2>&1 | %%{ "$PSItem" } | Out-File %s; exit $LastExitCode'

    -- Setting shell pipe
    vim.o.shellpipe = '2>&1 | %%{ "$PSItem" } | Tee-Object %s; exit $LastExitCode'

    -- Setting shell quote options
    vim.o.shellquote = ''
    vim.o.shellxquote = ''
end

