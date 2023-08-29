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
  w = 'Whatsapp',
  i = 'Viber',
  d = 'Discord',
  c = 'Calendar',
  n = 'Notes',
  g = 'Telegram',
  a = 'Alfred'
}
for key, app in pairs(applicationHotkeys) do
  hs.hotkey.bind(hyper, key, function()
      hs.application.launchOrFocus(app)
  end)
end

-- Windows Management

local cmdOption = { '⌘', '⌥' }

local function getWindowInfo()
  local window = hs.window.focusedWindow() or hs.window.frontmostWindow()
  local windowFrame = window:frame()
  local screenFrame = window:screen():frame()
  return window, windowFrame, screenFrame
end

local function moveWindow(X, Y, W, H)
  local window, windowFrame, screenFrame = getWindowInfo()
  windowFrame.x = screenFrame.x + (screenFrame.w * X)
  windowFrame.y = screenFrame.y + (screenFrame.h * Y)
  windowFrame.w = screenFrame.w * W
  windowFrame.h = screenFrame.h * H
  window:setFrame(windowFrame)
end

-- Reminder

function addReminder()
  hs.osascript.javascript([[
      var current = Application.currentApplication();
      current.includeStandardAdditions = true;
      var app = Application('Reminders');
      app.includeStandardAdditions = true;

      var td = new Date(); 

      var dateMap = {
          'Tonight': (function() { var d = new Date(); d.setHours(19, 0, 0, 0); return d; })(),
          'Tomorrow morning': (function() { var d = new Date(); d.setHours(10, 0, 0, 0); d.setHours(d.getHours() + 24); return d; })(),
          'Tomorrow night': (function() { var d = new Date(); d.setHours(19, 0, 0, 0); d.setHours(d.getHours() + 24); return d; })(),
          'This saturday': new Date(td.getFullYear(), td.getMonth(), td.getDate() + (6 - td.getDay()), 10, 0, 0, 0),
          'This sunday': new Date(td.getFullYear(), td.getMonth(), td.getDate() + (7 - td.getDay()), 10, 0, 0, 0) 
      };

      try {
          var content = current.displayDialog('Create a new Reminder', {
              defaultAnswer: '',
              buttons: ['Next', 'Cancel'],
              defaultButton: 'Next',
              cancelButton: 'Cancel',
              withTitle: 'New Reminder',
              withIcon: Path('/Applications/Reminders.app/Contents/Resources/icon.icns')
          });
          
          var list = current.chooseFromList(['Personal', 'Work'], {
              withTitle: 'List Selection',
              withPrompt: 'Which list?',
              defaultItems: ['TO DO'],
              okButtonName: 'Next',
              cancelButtonName: 'Cancel',
              multipleSelectionsAllowed: false,
              emptySelectionAllowed: false
          })[0];
          
          var remindDate = current.chooseFromList(Object.keys(dateMap), {
              withTitle: 'Due Date Selection',
              withPrompt: 'When?',
              okButtonName: 'OK',
              cancelButtonName: 'Cancel',
              multipleSelectionsAllowed: false,
              emptySelectionAllowed: true
          });
          var remindMeDate = remindDate.length === 1 ? dateMap[ remindDate[0] ] : null;
          
          var entry = app.Reminder({
              name: content.textReturned,
              remindMeDate: remindMeDate
          });
          
          app.lists[list].reminders.push(entry);
          
      } catch (err) {}
  ]])
end

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
  -- Windows Management
  -- Move window to the left
  { cmdOption, 'H', function() moveWindow(0, 0, 0.5, 1) end },
  { cmdOption, 'left', function() moveWindow(0, 0, 0.5, 1) end },
  -- Move window to the right
  { cmdOption, 'L', function() moveWindow(0.5, 0, 0.5, 1) end },
  { cmdOption, 'right', function() moveWindow(0.5, 0, 0.5, 1) end },
  -- Move window to upper right
  { cmdOption, 'I', function() moveWindow(0.5, 0, 0.5, 0.5) end },
  -- Move window to lower right
  { cmdOption, 'K', function() moveWindow(0.5, 0.5, 0.5, 0.5) end },
  -- Move window to upper left
  { cmdOption, 'U', function() moveWindow(0, 0, 0.5, 0.5) end },
  -- Move window to lower left
  { cmdOption, 'J', function() moveWindow(0, 0.5, 0.5, 0.5) end },
  -- Maximize window
  { cmdOption, 'return', function() hs.window.focusedWindow():maximize() end },
  { hyper, 'return', function() hs.window.focusedWindow():maximize() end },
  -- Fullscreen window
  { cmdOption, 'up', function() hs.window.focusedWindow():toggleFullScreen() end },
  -- Open New Finder
  { cmdOption, "f", function() hs.application.find("Finder"):selectMenuItem({"File", "New Finder Window"}) end },
  -- Add Reminder
  { hyper, "R", addReminder },
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