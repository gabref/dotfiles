local status, icons = pcall(require, 'nvim-web-devicons')
if (not status) then return end

icons.setup {
 -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
   default = true,
   color_icons = true,
   override_by_filename = {
       [".gitignore"] = {
           icon = "",
           color = "#f1502f",
           name = "Gitignore"
       },
       ["dockerfile"] = {
           icon = "",
           color = "#0088B3",
           name = "Dockerfile"
       }
   },
   override_by_extension = {
       ["log"] = {
           icon = "",
           color = "#81e043",
           name = "Log"
       },
       ["Dockerfile"] = {
           icon = "",
           color = "#0088B3",
           name = "Dockerfile"
       },
   };
}
