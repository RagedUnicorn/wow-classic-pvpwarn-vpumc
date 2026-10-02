--[[
  Writable globals: the voice pack namespace and the tables its own files define.
  PVPWarn's rgpvpw namespace and the WoW API (in each file's inline
  `-- luacheck: read globals` header) are read-only, so an accidental assignment
  is reported.
]]--
globals = {
  "rgpvpwvpumc",
  "RGPVPW_VP_UMC_CONSTANTS",
  "RGPVPW_VP_UMC_ENVIRONMENT"
}

read_globals = {
  "rgpvpw"
}

files = {
  ["code"] = {std = "lua51"},
  ["localization"] = {std = "lua51"}
}

exclude_files = {
  ".luacheckrc",
  "target/"
}
