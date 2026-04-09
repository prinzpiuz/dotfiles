return {
    "okuuva/auto-save.nvim",
    config = function()
        require("auto-save").setup({
            enabled = true,
            execution_message = {
                message = function() return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S")) end,
                dim = 0.18,
                cleaning_interval = 1250,
            },
            trigger_events = { "InsertLeave", "TextChanged" },
            -- This condition is important for your Home Lab configs (don't save git/tmp files)
            condition = function(buf)
                local fn = vim.fn
                local utils = require("auto-save.utils.data")

                if fn.getbufvar(buf, "&buftype") ~= "" then return false end
                return true
            end,
            write_all_buffers = false,
            debounce_delay = 1000,
        })
    end,
}
