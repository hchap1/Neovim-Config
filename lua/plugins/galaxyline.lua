return {
	'nvimdev/galaxyline.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function ()
		vim.g.screenkey_statusline_component = true
		require('galaxyline').section.left[0] = {
			GitBranch = {
				provider = "GitBranch",
				separator = "  "
			}
		}
		require('galaxyline').section.left[1] = {
			FileSize = {
				provider = "FileSize",
				highlight = { "#9d7cd8", "#3b4261" },
				separator = "  ",
				separator_highlight = { "#3b4261" }
			},
			FileName = {
				provider = "FileName"
			},
			BufferIcon = {
				provider = "BufferIcon"
			}
		}
		require('galaxyline').section.left[2] = {
			Add = {
				provider = "DiffAdd"
			},
			Mod = {
				provider = "DiffModified"
			},
			Rem = {
				provider = "DiffRemove"
			}
		}
		require('galaxyline').section.right[0] = {
			ScreenKey = {
				provider = { function() return require("screenkey").get_keys() end },
			}
		}
		require('galaxyline').section.right[1] = {
			LspClient = {
				provider = "GetLspClient",
				separator = "  "
			}
		}
		require('galaxyline').section.right[2] = {
			LinePercent = {
				provider = "LinePercent",
				separator = "  "
			}
		}
	end
}
