-- Debugging: debugpy (Python) + codelldb (C/C++), UI mit nvim-dap-ui
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        opts = {},
      },
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          -- Mason-Installation von debugpy nutzen
          require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
        end,
      },
    },
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Weiter" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Breakpoint umschalten" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Bedingung: ")) end, desc = "Bedingter Breakpoint" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug-UI umschalten" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Debug-REPL" },
      { "<leader>dx", function() require("dap").terminate() end, desc = "Debug beenden" },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      -- UI automatisch öffnen/schließen
      dap.listeners.after.event_initialized.dapui = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui = function() dapui.close() end
      dap.listeners.before.event_exited.dapui = function() dapui.close() end

      -- C/C++ über codelldb (liegt via Mason im PATH)
      dap.adapters.codelldb = {
        type = "executable",
        command = "codelldb",
      }
      dap.configurations.cpp = {
        {
          name = "Programm starten",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Binary: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp

      -- Hübsche Breakpoint-Zeichen
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual" })
    end,
  },
}
