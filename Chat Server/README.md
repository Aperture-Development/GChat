# GChat server
The chat server side of GChat. Receives registration requests from Gmod server and messages from client, which are then sent to other clients.

## REST API description

* ### Register new player
Used by Gmod server to register a uniqueID (token) for a player. This token is then used by the client for authentication with the chat server. Requests to retrieve history or send messages containing no or unregistered uniqueID are ignored.
  * URL: `/register`
  * Method: `POST`
  * Params:

    |  Parameter  |   Type   | Required |                  Description                  |
    |:-----------:|:--------:|:--------:|:---------------------------------------------:|
    | `secretKey` | `string` |  `true`  | The secret key shared by Gmod and chat server |
    | `uniqueID`  | `string` |  `true`  | Unique ID (token) of the player to register   |
    | `steamID`   | `string` |  `true`  | Steam ID of the player                        |
    | `steamName` | `string` |  `true`  | Steam name (nick) of the player               |
  * Response code: `200` on successful registration, `400` on failure
  * Response data: `none`

* ### Retrieve chat history
Used by clients to retrieve chat history.
  * URL: `/history`
  * Method: `POST`
  * Params:

    |  Parameter  |   Type   | Required |                  Description                  |
    |:-----------:|:--------:|:--------:|:---------------------------------------------:|
    | `uniqueID`  | `string` |  `true`  | Unique ID (token) of the player to register   |
  * Response code: `200` on success, `400` on failure
  * Response data: JSON array of chat messages sorted by the oldest message in the following format:
    ```
    [
      {
        "steamID": "SomeSteamID",
        "steamName": "Steve",
        "message": "Hello World!"
      },
      ...
    ]
    ```

* ### Clear chat history and registered players
Used by Gmod server to completely "reset" the chat server - all current uniqueIDs become invalid and the chat history is cleared.
  * URL: `/reset`
  * Method: `POST`
  * Params:

    |  Parameter  |   Type   | Required |                  Description                  |
    |:-----------:|:--------:|:--------:|:---------------------------------------------:|
    | `secretKey` | `string` |  `true`  | The secret key shared by Gmod and chat server |
    * Response code: `200` on success, `400` on failure
    * Response data: `none`

* ### Send message
Used by clients to send messages. Requests with unregistered uniqueID are ignored.
  * URL: `/reset`
  * Method: `POST`
  * Params:

    |  Parameter |   Type   | Required |                   Description                  |
    |:----------:|:--------:|:--------:|:----------------------------------------------:|
    | `uniqueID` | `string` |  `true`  | The registered unique ID (token) of the player |
    | `message`  | `string` |  `true`  |           The content of the message           |
    * Response code: `200` on success, `400` on failure
    * Response data: `none`
