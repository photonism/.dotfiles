return {
  -- ┌─────────────┐
  -- │ Transparent │
  -- └─────────────┘
  {
    'xiyaowong/transparent.nvim',
    config = function()
      require('transparent').setup {
        groups = {
          'Normal',
          'NormalNC',
        },
        extra_groups = {},
        exclude_groups = {},
        on_clear = function() end,
      }
      vim.g.transparent_enabled = true
    end,
  },
  -- ┌─────────────┐
  -- │ Colorscheme │
  -- └─────────────┘
  {
    'ThorstenRhau/token',
    -- 'projekt0n/github-nvim-theme',
    -- 'Mofiqul/adwaita.nvim',

    lazy = false,
    priority = 1000,

    config = function()
      -- apply the colorscheme

      vim.cmd 'colorscheme token'
      -- vim.cmd 'colorscheme github_light'
      -- vim.cmd 'colorscheme adwaita'

      -- ┌────────┐
      -- │ Termux │
      -- └────────┘
      -- disable italic in termux-cli
      local is_termux = vim.fn.isdirectory '/data/data/com.termux/files/usr' == 1
      local no_gui = vim.fn.getenv 'DISPLAY' == vim.NIL and vim.fn.getenv 'WAYLAND_DISPLAY' == vim.NIL

      if is_termux and no_gui then
        vim.api.nvim_create_autocmd({ 'ColorScheme', 'UIEnter' }, {
          callback = function()
            for hlname, def in pairs(vim.api.nvim_get_hl(0, {})) do
              if def.italic or (def.cterm and def.cterm.italic) then
                local modified = vim.tbl_deep_extend('force', def, {
                  italic = false,
                  cterm = { italic = false },
                })
                vim.api.nvim_set_hl(0, hlname, modified)
              end
            end
          end,
        })
      end

      -- ┌─────────┐
      -- │ Neovide │
      -- └─────────┘
      -- neovide
      if vim.g.neovide then
        -- add frame = "none" to ~/.config/neovide/config.toml to remove the window frame
        vim.o.titlestring = '%t - Neovide'
        -- using adwaita mono as braille fallback (for mini.map)
        if vim.fn.has 'win32' == 1 then
          vim.o.guifont = 'IosevkaTermSlab Nerd Font,Noto Sans CJK JP:h11'
        else
          vim.o.guifont = 'IosevkaTermSlab Nerd Font,Adwaita Mono,Noto Sans CJK JP:h11'
        end
        vim.o.background = 'light'
        vim.g.neovide_opacity = 0.9
        vim.g.neovide_cursor_short_animation_length = 0.04
      end

      -- ┌──────────┐
      -- │ Terminal │
      -- └──────────┘
      -- https://gitlab.gnome.org/chergert/ptyxis/-/blob/main/src/palettes/Tomorrow.palette
      -- Ptyxis Tomorrow
      vim.g.terminal_color_0 = '#000000'
      vim.g.terminal_color_1 = '#C82828'
      vim.g.terminal_color_2 = '#718C00'
      vim.g.terminal_color_3 = '#EAB700'
      vim.g.terminal_color_4 = '#4171AE'
      vim.g.terminal_color_5 = '#8959A8'
      vim.g.terminal_color_6 = '#3E999F'
      vim.g.terminal_color_7 = '#FFFEFE'
      vim.g.terminal_color_8 = '#000000'
      vim.g.terminal_color_9 = '#C82828'
      vim.g.terminal_color_10 = '#708B00'
      vim.g.terminal_color_11 = '#E9B600'
      vim.g.terminal_color_12 = '#4170AE'
      vim.g.terminal_color_13 = '#8958A7'
      vim.g.terminal_color_14 = '#3D999F'
      vim.g.terminal_color_15 = '#FFFEFE'

      vim.api.nvim_create_autocmd({ 'ColorScheme', 'LspAttach' }, {
        callback = function()
          -- use underline to indicate document highlight
          vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = 'NONE', underline = true, force = true })
          vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = 'NONE', underline = true, force = true })
          vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = 'NONE', underline = true, force = true })
          vim.api.nvim_set_hl(0, 'LspDocumentHighlight', { bg = 'NONE', underline = true, force = true })
        end,
      })
    end,
  },
  -- ┌────────────┐
  -- │ Animations │
  -- └────────────┘
  {
    'sphamba/smear-cursor.nvim',
    config = function()
      if vim.g.neovide then
        require('smear_cursor').enabled = false
      else
        require('smear_cursor').setup {
          legacy_computing_symbols_support = true,
          min_horizontal_distance_smear = 3,
          min_vertical_distance_smear = 2,
        }
      end
      -- <leader>ts → toggle smear cursor
      vim.keymap.set('n', '<leader>ts', function()
        require('smear_cursor').enabled = not require('smear_cursor').enabled
        vim.notify(require('smear_cursor').enabled and 'Smear cursor: enabled' or 'Smear cursor: disabled', vim.log.levels.INFO)
      end, { desc = 'Smear', silent = true })
    end,
  },
  -- ┌───────────────┐
  -- │ TODO Comments │
  -- └───────────────┘
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
