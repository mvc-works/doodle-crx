
# helper function

born = (baby, keys, model) ->
  keys.map (key) -> baby[key] = model[key] if model[key]
  baby

# init data here

configKeys = 'hostname port target'.split ' '

global =
  hostname: "localhost"
  port: 7776
  ws: undefined
  status: on
  target: 'localhost'

try config = JSON.parse localStorage.getItem("config")
config ?= {}

global = born global, configKeys, config
failedTimes = 0

# way to reload

time = -> (new Date).getTime()
lastTime = time()

reload = ->
  newTime = time()
  if (newTime - lastTime) > 1000
    lastTime = newTime
    if global.status is on
      console.log 'target', global.target
      chrome.tabs.query {}, (tabs) ->
        tabs.map (tab) ->
          ss = global.target
          if ss? and (tab.url.indexOf(ss) > 0)
            console.info 'reloading', tab.url
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
    console.log 'connection closed, calling connect', failedTimes
    if failedTimes < 10
      do connect
    else
      console.warn 'failedTimes > 10'
      chrome.browserAction.setIcon path: "img/d-off.png"
      global.status = off

  global.ws.onopen = ->
    console.info 'connected'
    failedTimes = 0

connect = ->
  if global.status is on
    unless global.ws?
      console.log "connecting..."
      failedTimes += 1
      setTimeout openSocket, 1000

# chrome listeners

chrome.browserAction.onClicked.addListener (tab) ->

  if global.status is on
    console.info 'status disabled'
    global.ws?.close()
    chrome.browserAction.setIcon path: "img/d-off.png"
    global.status = off
  else
    chrome.browserAction.setIcon path: "img/d-on.png"
    global.status = on
    console.info 'status enabled, will call connect'
    do connect

chrome.extension.onRequest.addListener (req, sender, res) ->
  global.ws?.close()
  global = born global, configKeys, req.update

# start script

chrome.browserAction.setIcon path: "img/d-on.png"
console.clear()
console.log 'starting data:', global

do connect