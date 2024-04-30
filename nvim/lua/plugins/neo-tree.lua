return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function (_, opts)
    return require("astrocore").extend_tbl(opts, {
      filesystem = {
        -- show hidden items by default
        filtered_items = {
          visible = true,
          follow_current_file = { enabled = true },
          hide_dotfiles = false,
        }
      }
    }
    )
  end
}
