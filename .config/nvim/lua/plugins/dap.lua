-- Debugging: debugpy (Python) + codelldb (C/C++), UI via nvim-dap-ui
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
          -- Use the Mason installation of debugpy
          require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
        end,
      },
    },
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional breakpoint" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle debug UI" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Debug-REPL" },
      { "<leader>dx", function() require("dap").terminate() end, desc = "Stop debugging" },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      -- Open/close the UI automatically
      dap.listeners.after.event_initialized.dapui = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui = function() dapui.close() end
      dap.listeners.before.event_exited.dapui = function() dapui.close() end

      -- C/C++ via codelldb (on PATH through Mason)
      dap.adapters.codelldb = {
        type = "executable",
        command = "codelldb",
      }
      dap.configurations.cpp = {
        {
          name = "Launch program",
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

      -- Pretty breakpoint signs
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual" })
    end,
  },
}
