
delay = (t, f) -> setTimeout f, t

global =
  hostname: "localhost"
  port: 7776
  ws: undefined
  status: on

connect = ->
  h = global.hostname
  p = global.port
  global.ws = new WebSocket "ws://#{h}:#{p}"

  global.ws.onmessage = (message) ->
    # console.log 'message'
    if (global.status is on)
      if message.data is 'reload'
        # console.log 'reload event'
        do reload

  global.ws.onclose = ->
    global.ws = undefined
    console.log 'closed'

reload = ->
  chrome.tabs.getSelected (tab) ->
    chrome.tabs.reload tab.id
    # console.log tab.id

do reconnect = ->
  delay 6000, ->
    if (not global.ws) and (global.status is on)
      connect()

chrome.browserAction.onClicked.addListener (tab) ->
  console.log tab

  if global.status is on
    chrome.browserAction.setIcon path: "img/d-off.png"
    global.status = off
  else
    chrome.browserAction.setIcon path: "img/d-on.png"
    global.status = on
