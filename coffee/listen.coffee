
delay = (t, f) -> setTimeout f, t

global =
  hostname: "localhost"
  port: 7776
  ws: undefined
  status: on

config = {}
try config = localStorage.getItem("config")
if config.hostname? then global.hostname = config.hostname
if config.port? then global.port = config.port

connect = ->
  h = global.hostname
  p = global.port
  console.log global
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
  if global.status is on
    chrome.tabs.getSelected (tab) ->
      chrome.tabs.reload tab.id
      # console.log tab.id

do reconnect = ->
  if global.status is on
    if (not global.ws) then connect()
  console.log "trying..."
  delay 4000, reconnect

chrome.browserAction.onClicked.addListener (tab) ->
  console.log tab

  if global.status is on
    chrome.browserAction.setIcon path: "img/d-off.png"
    global.status = off
  else
    chrome.browserAction.setIcon path: "img/d-on.png"
    global.status = on

chrome.extension.onRequest.addListener (req, sender, res) ->
  {hostname, port} = req.update
  global.hostname = hostname
  global.port = port

  global.ws?.close()