package = "giturlparser"
version = "0.0.1"
source = {
   url = "https://github.com/linrongbin16/giturlparser.lua"
}
description = {
   summary = "Git URL parsing library for Lua, e.g. the output of `git remote get-url origin`.",
   homepage = "https://github.com/linrongbin16/giturlparser.lua",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1"
}
build = {
   type = "builtin",
   modules = {
      giturlparser = "src/giturlparser.lua",
}