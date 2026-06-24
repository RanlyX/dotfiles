local wezterm = require 'wezterm'
local config = wezterm.config_builder()
-- =========================================================
-- 1. Tab Bar 圖示與變數定義
-- =========================================================
local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
local SOLID_LEFT_MOST = utf8.char(0x2588)
local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)
local ADMIN_ICON = utf8.char(0xf49c)
local CMD_ICON = utf8.char(0xe62a)
local NU_ICON = utf8.char(0xe7a8)
local PS_ICON = utf8.char(0xe70f)
local ELV_ICON = utf8.char(0xfc6f)
local WSL_ICON = utf8.char(0xf83c)
local YORI_ICON = utf8.char(0xf1d4)
local NYA_ICON = utf8.char(0xf61a)
local VIM_ICON = utf8.char(0xe62b)

local SUP_IDX = {"¹","²","³","⁴","⁵","⁶","⁷","⁸","⁹","¹⁰",
                 "¹¹","¹²","¹³","¹⁴","¹⁵","¹⁶","¹⁷","¹⁸","¹⁹","²⁰"}
local SUB_IDX = {"₁","₂","₃","₄","₅","₆","₇","₈","₉","₁₀",
                 "₁₁","₁₂","₁₃","₁₄","₁₅","₁₆","₁₇","₁₈","₁₉","₂₀"}

-- =========================================================
-- 2. Tab Bar 標題格式化邏輯
-- =========================================================
wezterm.on("format-tab-title", function(tab, tabs, panes, conf, hover, max_width)
  local edge_background = "#121212"
  local background = "#4E4E4E"
  local foreground = "#1C1B19"
  local dim_foreground = "#3A3A3A"

  if tab.is_active then
    background = "#FBB829"
    foreground = "#1C1B19"
  elseif hover then
    background = "#FF8700"
    foreground = "#1C1B19"
  end

  local edge_foreground = background
  local shell_cmd, shell_name
  
  if tab.active_pane.title:find("nvim") then
    shell_cmd = ""
    shell_name = VIM_ICON .. tab.active_pane.title:gsub("^(%S+)%s+(%d+/%d+) %- nvim", " %2 %1")
  elseif tab.active_pane.title:find("NYAGOS") then
    shell_cmd = tab.active_pane.title
    shell_name = NYA_ICON .. " " .. shell_cmd:gsub(".*: (.+) %- .+", "%1")
  elseif tab.active_pane.title:find("Yori") then
    shell_cmd = tab.active_pane.title:gsub(" %- Yori", "")
    shell_name = YORI_ICON .. " " .. shell_cmd
  else
    -- 擷取程式名稱 (保留原本作者對 Windows .exe 的判斷邏輯)
    shell_cmd, shell_name = tab.active_pane.title:match("^(.*\\(%w+)%.exe)")
    
    -- 若沒有抓到 .exe，就直接拿當前的標題當作 shell_name (相容 Linux)
    if not shell_name then
        shell_name = tab.active_pane.title
    end
  end
  
  local real_title = tab.active_pane.title:match(".*\\cmd%.exe %- (.+)$") or "CMD"
  local clean_title

  if shell_name == "nu" then
    clean_title = NU_ICON .. " NuShell"
  elseif shell_name == "pwsh" then
    clean_title = PS_ICON .. " PS"
  elseif shell_name == "cmd" then
    clean_title = CMD_ICON .. " " .. real_title
  elseif shell_name == "elvish" then
    clean_title = ELV_ICON .. " Elvish"
  elseif shell_name == "wsl" then
    clean_title = WSL_ICON .. " WSL"
  else
    clean_title = shell_name
  end
  
  if shell_cmd and shell_cmd:match("Administrator: ") then
    clean_title = clean_title .. " " .. ADMIN_ICON
  end
  
  local left_arrow = SOLID_LEFT_ARROW
  if tab.tab_index == 0 then
    left_arrow = SOLID_LEFT_MOST
  end
  
  local id = SUB_IDX[tab.tab_index+1] or ""
  local pid = SUP_IDX[tab.active_pane.pane_index+1] or ""
  local title = " " .. wezterm.truncate_right(clean_title, max_width-6) .. " "

  return {
    {Attribute={Intensity="Bold"}},
    {Background={Color=edge_background}},
    {Foreground={Color=edge_foreground}},
    {Text=left_arrow},
    {Background={Color=background}},
    {Foreground={Color=foreground}},
    {Text=id},
    {Text=title},
    {Foreground={Color=dim_foreground}},
    {Text=pid},
    {Background={Color=edge_background}},
    {Foreground={Color=edge_foreground}},
    {Text=SOLID_RIGHT_ARROW},
    {Attribute={Intensity="Normal"}},
  }
end)

-- =========================================================
-- 3. WezTerm 核心設定 (在這裡放入你的客製化參數)
-- =========================================================

-- Tab Bar 相關設定 (必須保留以確保顏色正確)
config.tab_max_width = 60
config.use_fancy_tab_bar = false
config.enable_scroll_bar = true
-- config.colors = {
--   tab_bar = {
--     background = "#121212",
--     new_tab = {bg_color = "#121212", fg_color = "#FCE8C3", intensity = "Bold"},
--     new_tab_hover = {bg_color = "#121212", fg_color = "#FBB829", intensity = "Bold"},
--     active_tab = {bg_color = "#121212", fg_color = "#FCE8C3"},
--   }
-- }

config.colors = require("cyberdream")
-- 其他基本設定 (你可以隨意修改這區)
-- config.color_scheme = "srcery"
config.font = wezterm.font("Meslo LGM Nerd Font")
config.font_size = 10.0
config.window_background_opacity = 0.94

-- 建議設定一個 Nerd Font 以確保剛才的特殊圖示能正常顯示
-- config.font = wezterm.font("JetBrainsMono NF")

-- =========================================================
-- 檔案最末端必須回傳 config (這是解決你報錯的關鍵)
-- =========================================================
return config
