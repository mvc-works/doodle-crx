
window.onload = ->
  try
    config = JSON.parse localStorage.getItem("config")
  if not config then config = {}
    
  config.hostname ?= "localhost"
  config.port ?= 7776

  q = (query) -> document.querySelector query

  console.log config

  q("#hostname").value = config.hostname
  q("#port").value = config.port

  window.onbeforeunload = ->
    hostname = q("#hostname").value
    port = parseInt q("#port").value

    if hostname?.length >= 4 then config.hostname = hostname
    if (typeof port is "number") then config.port = port

    localStorage.setItem("config", JSON.stringify config)

    data =
      update: {hostname, port}

    chrome.extension.sendRequest data, (ret) ->
      console.log ret