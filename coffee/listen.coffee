
# init data here

global =
  hostname: "localhost"
  port: 7776
  ws: undefined
  status: on
  target: 'localhost'

try config = JSON.parse localStorage.getItem("config")
config ?= {}
if config.hostname? then global.hostname = config.hostname
if config.port? then global.port = config.port
if config.target? then global.target = config.target

# way to reload

time = -> (new Date).getTime()
lastTime = time()

reload = ->
  if (time() - lastTime) > 1000
    lastTime = time()
    if global.status is on
      chrome.tabs.getSelected (tab) ->
        console.info 'reload', global.target
        if global.target? and tab.url.indexOf(global.target) >= 0
          chrome.tabs.reload tab.id
    else
      console.info 'status is off, will not reload'
  else
    console.warn 'too frequent, not reload'

# way to open websocket

openSocket = ->
  h = global.hostname
  p = global.port
  global.ws = new WebSocket "ws://#{h}:#{p}"

  global.ws.onmessage = (message) ->
    if global.status
      do reload # if message.data is 'reload'
    else
      console.info 'disabled in status'

  global.ws.onclose = ->
    delete global.ws.onclose
    delete global.ws
    # console.clear()
    console.log 'connection closed, calling connect'
    do connect

  global.ws.onopen = -> console.info 'connection established'

connect = ->
  if global.status is on
    if global.ws
      console.info 'connected'
    else
      console.log "connecting..."
      setTimeout openSocket, 1000

# chrome listeners

chrome.browserAction.onClicked.addListener (tab) ->

  if global.status is on
    console.info 'status disabled'
    global.ws.close()
    chrome.browserAction.setIcon path: "img/d-off.png"
    global.status = off
  else
    chrome.browserAction.setIcon path: "img/d-on.png"
    global.status = on
    console.info 'status enabled, will call connect'
    do connect

chrome.extension.onRequest.addListener (req, sender, res) ->
  {hostname, port} = req.update
  global.hostname = hostname
  global.port = port

  global.ws?.close()

# start script

chrome.browserAction.setIcon path: "img/d-on.png"
console.clear()
console.log 'starting data:', global

do connect