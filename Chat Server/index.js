const app = require('express')()
const bodyParser = require('body-parser')
const http = require('http').Server(app)
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: true}))

// Port to listen on
const port = 3000

// TODO move secret key to an independent file
const secretKey = 'ABCDEF'

const registeredIDs = {}
const history = []

// Returns true of the body contains a secret key and it corresponds with ours
function isSecretKeyValid(body){
  return 'secretKey' in body && body.secretKey === secretKey
}

// Returns true if the body contains everything required for a registration of a client
function isRegistrationValid(body){
  return 'uniqueID' in body && 'steamID' in body && 'steamName' in body
}

// Returns true if the body contains uniqueID which is currently registered
function isUniqueIDValid(body){
  return 'uniqueID' in body && body.uniqueID in registeredIDs
}

// ----------------------------- Requests handling -----------------------------

// Registration request from the server
app.post('/registration', function(req, res){
  if (!isSecretKeyValid(req.body)){
    console.error('No or invalid secret key received during uniqueID registration - ignoring.')
    res.sendStatus(400)
    return
  }
  if(!isRegistrationValid(req.body)){
    console.error('Valid secretKey, but missing data during uniqueID registration - ignoring.')
    res.sendStatus(400)
    return
  }
  // Register the client as authorized
  registeredIDs[req.body.uniqueID] = {
    'steamName': req.body.steamName,
    'steamID': req.body.steamID,
  }
  console.log(`Registered new client: <${req.body.steamID}> ${req.body.steamName}, token: ${req.body.uniqueID}`)
  res.sendStatus(200)
})

// Retrieve current chat history
app.post('/history', function(req, res){
  if(!('uniqueID' in req.body || !(req.body.uniqueID in registeredIDs))){
    console.error('No or invalid uniqueID while trying to retrieve history - ignoring.')
    res.sendStatus(400)
    return
  }
  res.send(JSON.stringify(history))
})

// Reset - clear registeredIDs and history
app.post('/reset', function(req, res){
  if (!isSecretKeyValid(req.body)){
    console.error('No or invalid secret key during reset request - ignoring.')
    res.sendStatus(400)
    return
  }
  registeredIDs.clear()
  history.clear()
  console.log('Chat history and registrations cleared by request.')
  res.sendStatus(200)
})

// Send message
app.post('/send', function(req, res){
  if(!isUniqueIDValid(req.body)){
    console.error('Trying to send message with no or invalid uniqueID - ignoring.')
    res.sendStatus(400)
    return
  }
  if(!('message' in req.body)){
    console.error('No message in "send" request - ignoring.')
    res.sendStatus(400)
    return
  }
  // Add the message to chat history
  const user = registeredIDs[req.body.uniqueID]
  history.push(
    {
      'steamID': user['steamID'],
      'steamName': user['steamName'],
      'message': req.body.message
    }
  )
  console.log('Received chat message from <' + user['steamID'] + '> ' + user['steamName'] + ': ' + req.body.message)
  res.sendStatus(200)
})

http.listen(port, function(){
  console.log('GChat server listening on *:' + port)
})
