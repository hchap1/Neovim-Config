return {
	'nvimdev/galaxyline.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function ()
		vim.g.screenkey_statusline_component = true
		local galaxyline = require('galaxyline')
		local vcs = require('galaxyline.provider_vcs')
		local fileinfo = require('galaxyline.provider_fileinfo')
		galaxyline.section.left[0] = {
			GitBranch = {
				provider = function()
					local branch_name = vcs.get_git_branch()
					if branch_name then
						return "  " .. branch_name
					else
						return "  NONE"
					end
				end,
				separator = "█ ",
				icon = " ",
				highlight = { "#9d7cd8", "#3b4261" },
				separator_highlight = { "#3b4261" }
			}
		}
		galaxyline.section.left[1] = {
			BufferNumber = {
				provider = "BufferNumber"
			},
			FileName = {
				provider = "FileName",
			},
			BufferIcon = {
				provider = "BufferIcon"
			}
		}
		galaxyline.section.left[2] = {
			LineColumn = {
				provider = "LineColumn"
			}
		}
		galaxyline.section.mid[0] = {
			Mode = {
				provider = function()
					local mode = vim.fn.mode()
					return " MODE " .. mode
				end,
				highlight = function()
					local mode = vim.fn.mode()
					if mode == 'n' then
						return { "#c0caf5"}
					elseif mode == 'i' then
						return { "#c3e88d"}
					elseif mode == 'v' then
						return { "#bb9af7"}
					elseif mode == 'V' then
						return { "#bb9af7"}
					else
						return { "#c53b53"}
					end
				end
			},
			-- ScreenKey = {
				-- provider = { function() return require("screenkey").get_keys() end },
			-- }
		}
		galaxyline.section.right[0] = {
			LinePercent = {
				provider = "LinePercent"
			}
		}
		galaxyline.section.right[1] = {
			Size = {
				provider = "FileSize",
				separator = "█",
				highlight = { "#9d7cd8", "#3b4261" },
				separator_highlight = { "#3b4261" }
			},
		}
		galaxyline.section.right[2] = {
			Encoding = {
				provider = function()
					local FileEncode = fileinfo.get_file_encode()
					return FileEncode .. " "
				end,
				separator = "█",
				highlight = { "#c3e88d", "#3b4261" },
				separator_highlight = { "#3b4261" }
			}
		}
	end,
}
