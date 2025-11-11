th.git = th.git or {}

th.git.modified = ui.Style():fg("blue")
th.git.deleted = ui.Style():fg("red"):bold()
th.git.modified_sign = "M"
th.git.deleted_sign = "D"

require("full-border"):setup()
require("git"):setup()
require("relative-motions"):setup({
  ["only_motions"] = false,
  ["show_motion"] = false,
  ["show_numbers"] = "relative_absolute"
})
