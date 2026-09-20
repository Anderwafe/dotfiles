#!/usr/bin/lua

-- for local config params
local config = {}
config.plugins = {}

config.plugins.lsp_config = {}
config.plugins.lsp_config.isEnabled = true -- should lspconfig plugin be downloaded and some configurations loaded
config.plugins.lsp_config.defaultEnabledConfigs = {
    'clangd',
    'csharp_ls',
    'jdtls',
    'lua_ls',
}

config.plugins.nvimTreesitter = {}
config.plugins.nvimTreesitter.isEnabled = true -- should nvim treesitter plugin be downloaded
config.plugins.nvimTreesitter.defaultInstallParsers = {
    'html',
    'html_tags',
    'markdown',
    'markdown_inline',

    'xml',
    'ini',
    'json',

    'sxhkdrc',
    'luadoc',
    'diff',
    'make',
    'gitignore',

    'c',
    'cpp',
    'c_sharp',
    'lua',
    'python',
    'latex',
    'sql',
}

config.plugins.mini = {}
config.plugins.mini.ai = {}
config.plugins.mini.ai.isEnabled = true -- should mini.nvim-ai plugin be downloaded
config.plugins.mini.align = {}
config.plugins.mini.align.isEnabled = true -- should mini.nvim-align plugin be downloaded
config.plugins.mini.move = {}
config.plugins.mini.move.isEnabled = true -- should mini.nvim-move plugin be downloaded
config.plugins.mini.surround = {}
config.plugins.mini.surround.isEnabled = true -- should mini.nvim-surround plugin be downloaded
config.plugins.mini.jump = {}
config.plugins.mini.jump.isEnabled = true -- should mini.nvim-jump plugin be downloaded
config.plugins.mini.notify = {}
config.plugins.mini.notify.isEnabled = true -- should mini.nvim-jump plugin be downloaded

-- options
vim.o.autoindent     = true
vim.o.autoread       = true
vim.o.autowrite      = true
vim.o.background     = "dark"
vim.opt.backspace    = {"indent","eol","start"}
vim.opt.belloff      = {"all"}
vim.o.breakindent    = true -- every wrapped line will continue visualy indented
vim.opt.clipboard:append("unnamedplus")
vim.o.completeopt    = "menuone,preview,noinsert"
vim.o.showfulltag    = true
vim.o.confirm        = true
vim.o.cursorline     = true
vim.o.cursorcolumn   = false
vim.o.expandtab      = true
vim.o.fixendofline   = false
vim.o.incsearch      = true
vim.o.linespace      = 0 -- change if font uses full char cell height
vim.o.number         = true
vim.o.relativenumber = true
vim.o.scrolloff      = 8
vim.o.shiftwidth     = 4
vim.o.showbreak      = ">> "
vim.o.splitbelow     = true
vim.o.splitright     = true
vim.o.tabstop        = 4
vim.o.title          = true
vim.o.virtualedit    = "block"
vim.o.wrap           = true
vim.o.complete       = ".,w,b,u,i,t,d" -- for .c files
vim.opt.cino:append("l1")
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
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.c_syntax_for_h = true
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.diagnostic.config {
    -- update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many', scope = 'cursor' },
    -- underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    -- virtual_text = false, -- Text shows up at the end of the line
    -- virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
        on_jump = function(_, bufnr)
            vim.diagnostic.open_float {
                bufnr = bufnr,
                scope = 'cursor',
                focus = false,
            }
        end,
    },
}


-- plugins

if config.plugins.lsp_config.isEnabled then
    vim.pack.add{
        { src = 'https://github.com/neovim/nvim-lspconfig' },
    }

    vim.lsp.enable(config.plugins.lsp_config.defaultEnabledConfigs);
end

if config.plugins.nvimTreesitter.isEnabled then
    vim.pack.add{
        {src = 'https://github.com/nvim-treesitter/nvim-treesitter.git'},
    }

    require'nvim-treesitter'.install(config.plugins.nvimTreesitter.defaultInstallParsers)
end

if config.plugins.mini.ai.isEnabled then
    vim.pack.add{
        { src = 'https://github.com/nvim-mini/mini.ai' },
    }

    require('mini.ai').setup{
        search_method = 'cover_or_nearest',
    }
end

if config.plugins.mini.align.isEnabled then
    vim.pack.add{
        { src = 'https://github.com/nvim-mini/mini.align' },
    }

    require('mini.align').setup()
end

if config.plugins.mini.move.isEnabled then
    vim.pack.add{
        { src = 'https://github.com/nvim-mini/mini.move' },
    }

    require('mini.move').setup{
        mappings = {
            -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
            left  = '<M-Left>',
            right = '<M-Right>',
            down  = '<M-Down>',
            up    = '<M-Up>',

            -- Move current line in Normal mode
            line_left  = '<M-Left>',
            line_right = '<M-Right>',
            line_down  = '<M-Down>',
            line_up    = '<M-Up>',
        },
    }
end

if config.plugins.mini.surround.isEnabled then
    vim.pack.add{
        { src = 'https://github.com/nvim-mini/mini.surround' },
    }

    require('mini.surround').setup()
end

if config.plugins.mini.jump.isEnabled then
    vim.pack.add{
        { src = 'https://github.com/nvim-mini/mini.jump' },
    }

    require('mini.jump').setup()
end

if config.plugins.mini.notify.isEnabled then
    vim.pack.add{
        { src = 'https://github.com/nvim-mini/mini.notify' },
    }

    require('mini.notify').setup()
    vim.notify = MiniNotify.make_notify{
        ERROR = { duration = 5000 },
        WARN  = { duration = 4000 },
        INFO  = { duration = 3000 },
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

require('vim._core.ui2').enable({
    enable = true, -- Whether to enable or disable the UI.
    msg = { -- Options related to the message module.
        ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
        ---or table mapping |ui-messages| kinds, triggers and IDs to a target.
        ---Table keys are matched as a Lua pattern to the message ID. 'default'
        ---mapping applies to any omitted kind: { default = 'cmd', progress = 'msg' }.
        targets = 'cmd',
        dialog = { -- Options related to dialog window.
            height = 0.5, -- Maximum height.
        },
        msg = { -- Options related to msg window.
            height = 0.5, -- Maximum height.
        },
        pager = { -- Options related to message window.
            height = 0.999, -- Maximum height.
        },
    },
})

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

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
        end
    end,
})

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

