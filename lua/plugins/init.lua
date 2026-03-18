return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  --
  -- -- Function folding extensions
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = "kevinhwang91/promise-async",
  --   config = function()
  --     require("ufo").setup()
  --   end,
  -- },
  --

  {
  'vyfor/cord.nvim',
  event = 'VeryLazy',           -- recommended so it loads early but doesn't block startup
  opts = {
    display = {
      theme = 'minecraft',      -- blocky pixel-art Minecraft style (based on Datapack Icons)
      flavor = 'dark',          -- or 'light' / 'accent' if you want
    },
    -- optional: other nice defaults
    editor = {
      client = 'neovim', -- shows "NvChad" instead of generic Neovim
      tooltip = '👁️',
    },
  },
},

  -- -- Discord plugin for rich rich presence
  -- {
  --   "IogaMaster/neocord",
  --   event = "VeryLazy",
  --   config = {
  --     main_image = "logo",
  --     logo = "https://files.catbox.moe/b79s9f.png",
  --     logo_tooltip = "👁️",
  --     show_time = true,
  --     log_level = "debug",
  --     workspace_text = function ()
  --       return "The void stares back"
  --     end,
  --   },
  -- },
  --
  -- Vim game to solve skill issues
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
  },

  -- Plugin to show keypresses
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      position = "top-right",--"bottom-left",
      timeout = 1,
      maxkeys = 3,
    },
  },


  -- Plugin for mcp servers
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    --build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
    config = function()
        require("mcphub").setup({
            --- `mcp-hub` binary related options-------------------
            config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Absolute path to MCP Servers config file (will create if not exists)
            port = 37373, -- The port `mcp-hub` server listens to
            shutdown_delay = 5 * 60 * 000, -- Delay in ms before shutting down the server when last instance closes (default: 5 minutes)
            use_bundled_binary = false, -- Use local `mcp-hub` binary (set this to true when using build = "bundled_build.lua")
            mcp_request_timeout = 60000, --Max time allowed for a MCP tool or resource to execute in milliseconds, set longer for long running tasks
            global_env = {}, -- Global environment variables available to all MCP servers (can be a table or a function returning a table)
            workspace = {
                enabled = true, -- Enable project-local configuration files
                look_for = { ".mcphub/servers.json", ".vscode/mcp.json", ".cursor/mcp.json" }, -- Files to look for when detecting project boundaries (VS Code format supported)
                reload_on_dir_changed = true, -- Automatically switch hubs on DirChanged event
                port_range = { min = 40000, max = 41000 }, -- Port range for generating unique workspace ports
                get_port = nil, -- Optional function returning custom port number. Called when generating ports to allow custom port assignment logic
            },

            ---Chat-plugin related options-----------------
            auto_approve = true, -- Auto approve mcp tool calls
            auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically
            extensions = {
                avante = {
                    make_slash_commands = true, -- make /slash commands from MCP server prompts
                }
            },

            --- Plugin specific options-------------------
            native_servers = {}, -- add your custom lua native servers here
            builtin_tools = {
                edit_file = {
                    parser = {
                        track_issues = true,
                        extract_inline_content = true,
                    },
                    locator = {
                        fuzzy_threshold = 0.8,
                        enable_fuzzy_matching = true,
                    },
                    ui = {
                        go_to_origin_on_complete = true,
                        keybindings = {
                            accept = ".",
                            reject = ",",
                            next = "n",
                            prev = "p",
                            accept_all = "ga",
                            reject_all = "gr",
                        },
                    },
                },
            },
            ui = {
                window = {
                    width = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
                    height = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
                    align = "center", -- "center", "top-left", "top-right", "bottom-left", "bottom-right", "top", "bottom", "left", "right"
                    relative = "editor",
                    zindex = 50,
                    border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
                },
                wo = { -- window-scoped options (vim.wo)
                    winhl = "Normal:MCPHubNormal,FloatBorder:MCPHubBorder",
                },
            },
            json_decode = nil, -- Custom JSON parser function (e.g., require('json5').parse for JSON5 support)
            on_ready = function(hub)
                -- Called when hub is ready
            end,
            on_error = function(err)
                -- Called on errors
            end,
            log = {
                level = vim.log.levels.WARN,
                to_file = false,
                file_path = nil,
                prefix = "MCPHub",
            },
        })
    end
},
  -- Agentic Workflow 

 {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  commit = "216ba4a8b2b75", -- Revert to a previous commit if needed
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- add any opts here
    -- --MCPHub fix
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub and hub:get_active_servers_prompt() or ""
    end,
    -- Custom tools for MCP integration
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,
    --end of fix
    behaviour = {
        auto_suggestions = false, -- Disable if you don't want inline completion
        auto_apply_diff_after_generation = false, -- Ask before applying changes "Legacy mode only :P"
      },
    web_search_engine = {
        provider = "brave",
        proxy = nil
      },
    file_selector = {
        provider = "telescope",
      },
    mode = "agentic",
    -- this file can contain specific instructions for your project
    instructions_file = "avante.md",
    -- -- stop native tools to start using mcp 
    -- disabled_tools = {
    --   "list_files", "search_files", "read_file",
    --   "create_file", "rename_file", "delete_file",
    --   "create_dir", "rename_dir", "delete_dir", "bash",
    -- },
    -- -- for example
    provider = "grok",
    providers = {
      grok = {
        __inherited_from = "openai",
        api_key_name = "GROK_API_KEY",
        endpoint = "https://api.x.ai/v1",
        model = "grok-code-fast-1",
        timeout = 30000, -- Timeout in milliseconds
        disable_tools = false,
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 32768,
            stream = true,
          },
      },
      lmstudio = {
        __inherited_from = "openai",
        api_key_name = "",
        endpoint = "http://localhost:1111/v1",
        model = "qwen3-8b",
        timeout = 30000, -- Timeout in milliseconds
        disable_tools = false,
        extra_request_body = {
          temperature = 0.7,
          max_tokens = 8000,
          stream = true,
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-mini/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
},











  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
