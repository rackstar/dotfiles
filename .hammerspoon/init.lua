-- Caps Lock → Hyper key, done entirely in Hammerspoon (no Hyperkey/Karabiner).
-- hidutil remaps Caps Lock → F18 at the HID layer — below macOS's caps-lock
-- debounce, so it's reliable, unlike event-tap remappers. Hammerspoon tracks F18
-- as the hyper key: hold + mapped key = launch app, tap = Escape.
-- Re-applied on every config load. To undo (get Caps Lock back):
--   hidutil property --set '{"UserKeyMapping":[]}'
-- ponytail: remap lives in Hammerspoon's lifecycle, not a LaunchAgent — hotkeys
-- need Hammerspoon running anyway, so a separate persistence file buys nothing.
hs.execute([[/usr/bin/hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x70000006D}]}']])

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

-- What each hyper + key does.
local hyperActions = {}
for key, app in pairs(applicationHotkeys) do
  hyperActions[key] = function() hs.application.launchOrFocus(app) end
end
-- Ping network
hyperActions["9"] = function() hs.network.ping.ping("8.8.8.8", 1, 0.01, 1.0, "any", pingResult) end
-- Reload the Hammerspoon config
hyperActions["0"] = function()
  hs.reload()
  hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()
end

-- Hyper state, driven by F18 (the remapped Caps Lock).
local hyperDown = false
local hyperUsed = false

-- While F18 is held, a mapped key runs its action and is swallowed (not typed).
-- An eventtap is used rather than modal hotkeys because modifier-less letter
-- hotkeys via the system hotkey API don't reliably capture — the raw event
-- stream does.
-- NOTE: global (not local) on purpose — Hammerspoon garbage-collects an eventtap
-- with no live reference, which silently kills it after the config finishes loading.
hyperTap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
  if not hyperDown then return false end
  hyperUsed = true  -- any key during the hold means it wasn't a bare tap
  local action = hyperActions[hs.keycodes.map[event:getKeyCode()]]
  if action then
    action()
    return true  -- consume the key so the letter isn't typed
  end
  return false
end)
hyperTap:start()

local f18DownAt = 0
hs.hotkey.bind({}, 'f18',
  function()  -- F18 down: hyper active
    hyperDown = true
    hyperUsed = false
    f18DownAt = hs.timer.secondsSinceEpoch()
  end,
  function()  -- F18 up: Escape only on a genuine quick tap (no key used, released <1s)
    hyperDown = false
    if not hyperUsed and (hs.timer.secondsSinceEpoch() - f18DownAt) < 1.0 then
      hs.eventtap.keyStroke({}, 'escape')
    end
  end)
