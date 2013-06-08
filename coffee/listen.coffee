
delay = (t, f) -> setTimeout f, t

global =
  hostname: "localhost"
  port: 7776
  ws: undefined
  status: on

try config = JSON.parse localStorage.getItem("config")
config ?= {}
if config.hostname? then global.hostname = config.hostname
if config.port? then global.port = config.port
if config.filter? then global.filter = config.filter

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
    global.ws = null
    console.log 'closed'

reload = ->
  if global.status is on
    chrome.tabs.getSelected (tab) ->
      if tab.url.indexOf(global.filter) < 0 then return
      chrome.tabs.reload tab.id
      # console.log tab.id

do reconnect = ->
  if global.status is on
    if (not global.ws)
      connect()
      console.log "connecting..."
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