-- NOTE: Capslock bound to cmd+alt+ctrl+shift via Hyper.app
local hyper = { '⌘', '⌥', '⌃', '⇧' }

-- Launch Applications

local applicationHotkeys = {
  t = 'iTerm',
  s = 'Safari',
  b = 'Brave Browser',
  f = 'Finder',
  p = '1Password',
  l = 'Slack',
  v = 'Visual Studio Code',
  i = 'Viber',
  c = 'Calendar',
  n = 'Notes',
  a = 'Authy Desktop',
  r = 'RescueTime',
  w = 'WhatsApp',
  d = 'Obsidian',
  e = 'Telegram',
  o = 'Ferdium',
}

for key, app in pairs(applicationHotkeys) do
  hs.hotkey.bind(hyper, key, function()
      hs.application.launchOrFocus(app)
  end)
end

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

local cmdOptionHotKeys = {
  -- Ping Network
  { hyper, "9", function() hs.network.ping.ping("8.8.8.8", 1, 0.01, 1.0, "any", pingResult) end },
  -- We use 0 to reload the configuration
  {
    hyper,
    "0",
    function()
      hs.reload()
      hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()
    end
  }
}

for i, mapping in ipairs(cmdOptionHotKeys) do
  hs.hotkey.bind(mapping[1], mapping[2], mapping[3])
end

-- The below code automatically reloads this hammer configuration file
-- whenever a file in the ~/.hammerspoon directory is changed
-- Shows the alert "Config reloaded", whenever it does
-- uncomment this code when debugging.

-- hs.loadSpoon('ReloadConfiguration')
-- spoon.ReloadConfiguration:start()
-- hs.alert.show('Config reloaded')