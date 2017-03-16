# GChat server
The chat server side of GChat. Receives registration requests from Gmod server and messages from client, which are then sent to other clients.

## REST API description

* ### Register new player
  * URL: `/register`
  * Method: `POST`
  * Params:

    |  Parameter  |   Type   | Required |                  Description                  |
    |:-----------:|:--------:|:--------:|:---------------------------------------------:|
    | `secretKey` | `string` |  `true`  | The secret key shared by Gmod and chat server |
    | `uniqueID`  | `string` |  `true`  | Unique ID (token) of the player to register   |
    | `steamID`   | `string` |  `true`  | Steam ID of the player                        |
    | `steamName` | `string` |  `true`  | Steam name (nick) of the player               |
  * Response code: `200` on successful reqistration, `400` on failure
  * Response data: `none`

* ### Retrieve chat history
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
  * URL: `/reset`
  * Method: `POST`
  * Params:

    |  Parameter  |   Type   | Required |                  Description                  |
    |:-----------:|:--------:|:--------:|:---------------------------------------------:|
    | `secretKey` | `string` |  `true`  | The secret key shared by Gmod and chat server |
    * Response code: `200` on success, `400` on failure
    * Response data: `none`

* ### Send message
  * URL: `/reset`
  * Method: `POST`
  * Params:

    |  Parameter |   Type   | Required |                   Description                  |
    |:----------:|:--------:|:--------:|:----------------------------------------------:|
    | `uniqueID` | `string` |  `true`  | The registered unique ID (token) of the player |
    | `message`  | `string` |  `true`  |           The content of the message           |
    * Response code: `200` on success, `400` on failure
    * Response data: `none`
