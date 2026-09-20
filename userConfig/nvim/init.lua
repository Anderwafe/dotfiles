#!/usr/bin/lua

-- for local config params
-- TODO: rework config table:
-- 1. config is global-local table with entities
-- 1. in config table we have various categories: plugins, colorschemes, etc
-- 1. in categories we have items: lsp_config plugin, etc
-- 1. every item should contain required fields: isEnabled, settings, uri
-- 1. if the middle of the init.lua we should iterate on config categories items and operate on them
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

config.colorschemes = {}
config.colorschemes.kanagawa_paper = {}
config.colorschemes.kanagawa_paper.isEnabled = true
config.colorschemes.rasmus = {}
config.colorschemes.rasmus.isEnabled = true
config.colorschemes.no_clown_fiesta = {}
config.colorschemes.no_clown_fiesta.isEnabled = true

-- options
vim.o.autoindent     = true
vim.o.autoread       = true
vim.o.autowrite      = true
vim.o.background     = "dark"
vim.opt.backspace    = {"indent","eol","start"}
vim.opt.belloff      = {"all"}
vim.o.breakindent    = true -- every wrapped line will continue visualy indented
vim.opt.clipboard:append("unnamedplus")
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
vim.o.autocomplete   = false
vim.o.complete       = ".,w,b,u,i,t,d" -- for .c files
vim.o.completeopt    = "fuzzy,menuone,noinsert,noselect,popup"
vim.o.winblend       = 15
vim.o.winborder      = 'single'
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
    float = { source = 'if_many', scope = 'cursor' },
    underline = { severity = { min = vim.diagnostic.severity.ERROR } },

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
        mappings = {
            around_next = '<Leader>an',
            inside_next = '<Leader>in',
            around_last = '<Leader>al',
            inside_last = '<Leader>il',
        },
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

if config.colorschemes.kanagawa_paper.isEnabled then
    vim.pack.add{
        { src = 'https://github.com/thesimonho/kanagawa-paper.nvim' },
    }
end

if config.colorschemes.rasmus.isEnabled then
    vim.pack.add{
        { src = 'https://github.com/kvrohit/rasmus.nvim' },
    }
end

if config.colorschemes.no_clown_fiesta.isEnabled then
    vim.pack.add{
        { src = 'https://github.com/aktersnurra/no-clown-fiesta.nvim' },
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
    msg = {
        -- targets = {
        --     [""] = "msg",
        --     empty = "cmd",
        --     help ui-messages for more targets
        -- },
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

do
    -- sets msg buffer style to floating window
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "msg",
        callback = function()
            local ui2 = require("vim._core.ui2")
            local win = ui2.wins and ui2.wins.msg
            if win and vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_set_option_value(
                    "winhighlight",
                    "Normal:NormalFloat,FloatBorder:FloatBorder",
                    { scope = "local", win = win }
                )
            end
        end,
    })

    -- sets msg floating windows buffer position to right upper corner
    local ui2 = require("vim._core.ui2")
    local msgs = require("vim._core.ui2.messages")
    local orig_set_pos = msgs.set_pos
    msgs.set_pos = function(tgt)
        orig_set_pos(tgt)
        if (tgt == "msg" or tgt == nil) and vim.api.nvim_win_is_valid(ui2.wins.msg) then
            pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
                relative = "editor",
                anchor = "NE",
                row = 1,
                col = vim.o.columns - 1,
            })
        end
    end
end

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd('LspProgress', {
  callback = function(ev)
    local data = ev.data
    local value = data.params.value

    local progressMessage = nil
    local progressStatus = nil
    local progressTitle = value.title or 'Generic LSP work'

    if value.kind == 'begin' then
        progressMessage = value.message or 'start'
        progressStatus = 'running'
    elseif value.kind == 'report' then
        progressMessage = value.message or 'step'
        progressStatus = 'running'
    elseif value.kind == 'end' then
        progressMessage = value.message or 'done'
        progressStatus = 'success'
    else
        vim.print({message = 'unknown progress kind', body = data})
        progressMessage = value.message or 'nil message'
        progressStatus = 'failed'
    end

    vim.api.nvim_echo({ { progressMessage } }, true, {
      id = 'lsp.' .. data.client_id .. "." .. progressTitle,
      kind = 'progress',
      source = 'vim.lsp',
      title = progressTitle,
      status = progressStatus,
      percent = value.percentage,
    })
  end,
})

-- do
--     -- has potential to fix problem with wrong lines wrap in signature-help window
--     -- but closes window on signatures cycling for now
--     local openFloatingPreviewBackup = vim.lsp.util.open_floating_preview
--     vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
--         local contentsMaxWidth = 0
--         for idx,content in ipairs(contents) do
--             if contentsMaxWidth < string.len(content) then
--                 contentsMaxWidth = string.len(content)
--             end
--         end
--         local contentsMaxHeight = #contents
--         opts.width = contentsMaxWidth
--         opts.height = contentsMaxHeight
--         local result = openFloatingPreviewBackup(contents, syntax, opts)
--         return result
--     end
-- end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- 'fixes' the problem with not visible ultra-wide signatures
        local sighelpbackup = vim.lsp.buf.signature_help
        vim.lsp.buf.signature_help = function (conf)
            conf = conf or {}
            -- uncomment height and width to see all and always ☺  
            conf.max_height = math.floor(vim.o.lines*0.8)
            -- conf.height = conf.max_height
            conf.max_width = math.floor(vim.o.columns*0.8)
            -- conf.width = conf.max_width
            conf.wrap = false
            sighelpbackup(conf)
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

vim.api.nvim_create_user_command('DiffOrig', 'vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis', {})

vim.api.nvim_create_user_command('ShowLineActions', 'lua vim.lsp.buf.code_action()', {})

vim.api.nvim_create_user_command('ShowLineDiagnostics',
    function()
        vim.diagnostic.open_float()
    end, {})

vim.api.nvim_create_user_command('ShowFileDiagnostics',
    function()
        vim.diagnostic.setqflist()
    end, {})

vim.api.nvim_create_user_command('LoadFileDiagnostics',
    function()
        vim.diagnostic.setqflist({open = false})
    end, {})

vim.api.nvim_create_user_command('GotoNextFileDiagnostic',
    function()
        local next_diagnostic = vim.diagnostic.get_next()
        vim.diagnostic.jump({diagnostic = next_diagnostic})
    end, {})

vim.api.nvim_create_user_command('GotoPrevFileDiagnostic',
    function()
        local prev_diagnostic = vim.diagnostic.get_next()
        vim.diagnostic.jump({diagnostic = prev_diagnostic})
    end, {})

-- colorscheme


-- vim.cmd.colorscheme('kanagawa-paper-ink')
-- vim.cmd.colorscheme("falcon")
-- vim.cmd.colorscheme("slate")
-- vim.cmd.colorscheme("rasmus")
vim.cmd.colorscheme("no-clown-fiesta-dark")

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

