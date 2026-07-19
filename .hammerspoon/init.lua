-- Caps Lock → Hyper key via Karabiner-Elements (see ~/.config/karabiner/karabiner.json).
-- Karabiner remaps Caps Lock at the driver level (virtual HID) — BELOW macOS
-- Secure Input, so it works everywhere, even in password fields, unlike an
-- event tap. Hold Caps = the four modifiers ⌘⌃⌥⇧ (hyper); tap Caps = Escape.
-- Hammerspoon only binds hyper + key to launch apps. These are Carbon hotkeys,
-- which Secure Input also doesn't block — so the whole path is immune.
local hyper = {'cmd', 'alt', 'ctrl', 'shift'}

-- Launch Applications (hyper + key)
local applicationHotkeys = {
  t = 'iTerm',
  s = 'Safari',
  b = 'Brave Browser',
  f = 'Finder',
  p = '1Password',
  l = 'Slack',
  v = 'Visual Studio Code',
  i = 'Viber',
  c = 'Claude',
  g = 'ChatGPT',
  n = 'Notes',
  r = 'RescueTime',
  w = 'WhatsApp',
  d = 'Calendar',
  e = 'Telegram',
  o = 'Ferdium',
  z = 'zoom.us.app',
}

-- TODO: add todoist / rescuetime workflows

function pingResult(object, message, seqnum, error)
  if message == "didFinish" then
      avg = tonumber(string.match(object:summary(), '/(%d+.%d+)/'))
      if avg == 0.0 then
          hs.alert.show("No network")
      elseif avg < 200.0 then
          hs.alert.show("Network good (" .. avg .. "ms)")
      elseif avg < 500.0 then
          hs.alert.show("Network poor(" .. avg .. "ms)")
      else
          hs.alert.show("Network bad(" .. avg .. "ms)")
      end
  end
end

for key, app in pairs(applicationHotkeys) do
  hs.hotkey.bind(hyper, key, function() hs.application.launchOrFocus(app) end)
end

-- Ping network
hs.hotkey.bind(hyper, '9', function()
  hs.network.ping.ping("8.8.8.8", 1, 0.01, 1.0, "any", pingResult)
end)

-- Reload the Hammerspoon config
hs.hotkey.bind(hyper, '0', function()
  hs.reload()
  hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()
end)
