#GChat GMod Lib
The GMod lib for the GChat. Simplyfies the GChat connection.

#Functions

#Client Side

*Retrive the chat thet has been going on
gchat.retriveChat(uniqID)

*Arguments:
uniqID: the clients unique id

*returns:
responseText: the Chat from the server

*Send a message to the chat server
gchat.SendMessage(uniqID ,msg)

*Arguments:
uniqID: the clients unique ID
msg: the message to sent to the chat server

*returns:
nothing


#Server Side

*Generate a random ID based on the player and the time
gchat.RandomID(ply)

*Arguments:
ply: the player to generate a random ID for

*returns:
randomID: an Random ID based on the player and the current time

*Register a client on the chat server
gchat.RegisterClient(secKey ,uniqID ,SID ,SName)

*Arguments:
secKey: the secret server key
uniqID: the clients unique ID to register
SID: the clients SteamID
SName: the clients Steam name

*returns:
nothing

*Reset the chatserver ( means chat and registred clients)
gchat.ResetChat(secKey)

*Arguments:
secKey: the secret server key

*returns:
nothing

*Send the server settings to specified client
gchat.SendSettings(ply)

*Arguments:
ply: the player to send the settings to

*returns:
nothing