--[[
  MIT License

  Copyright (c) 2025 Michael Wiesendanger

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
]]--

-- luacheck: globals GetAddOnMetadata

--[[
  PVPWarn Voice Pack - Undead Male (Classic)

  Namespace: rgpvpwvpumc
  - rg: RagedUnicorn (developer prefix to avoid addon conflicts)
  - pvpw: PVPWarn (main addon)
  - vp: Voice Pack
  - umc: Undead Male Classic

  Pattern for other voice packs:
  - rgpvpwvpnfr: Nightelf Female Retail
  - rgpvpwvpnmc: Nightelf Male Classic
  - rgpvpwvphmf: Human Female
  - rgpvpwvpdwm: Dwarf Male
  etc.
]]--

rgpvpwvpumc = rgpvpwvpumc or {}
local voicePackUndeadMale = rgpvpwvpumc
local me = voicePackUndeadMale

me.tag = "Core"

--[[
  Show welcome message to user
]]--
local function ShowWelcomeMessage()
  print(
    string.format("|cFF00FFB0" .. "Loaded - " .. voicePackUndeadMale.L["addon_name"]
      .. voicePackUndeadMale.L["info_title"],
    GetAddOnMetadata(RGPVPW_VP_UMC_CONSTANTS.ADDON_NAME, "Version"))
  )
end

--[[
  Register addon events

  @param {table} self
]]--
local function RegisterEvents(self)
  -- Fired when the addon is loaded
  self:RegisterEvent("ADDON_LOADED")
end

--[[
  Init function
]]--
local function Initialize()
  me.logger.LogDebug(me.tag, "Initialize addon")

  ShowWelcomeMessage()

  local result = rgpvpw.voicePack.RegisterVoicePack(
    RGPVPW_VP_UMC_CONSTANTS.ADDON_NAME,
    RGPVPW_VP_UMC_CONSTANTS.DISPLAY_NAME,
    RGPVPW_VP_UMC_CONSTANTS.ASSET_PATH
  )

  if not result then
    me.logger.LogError(me.tag, "Failed to register voice pack")
    return
  end
end

--[[
  Addon load

  @param {table} self
]]--
function me.OnLoad(self)
  RegisterEvents(self)
end

--[[
  MainFrame OnEvent handler

  @param {string} event
]]--
function me.OnEvent(event, addonName)
  if event == "ADDON_LOADED" and addonName == RGPVPW_VP_UMC_CONSTANTS.ADDON_NAME then
    me.logger.LogEvent(me.tag, "ADDON_LOADED")
    Initialize()
  end
end
