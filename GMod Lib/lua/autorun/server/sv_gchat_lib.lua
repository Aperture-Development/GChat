gchat = gchat or {}
gchat.RegistrationUrl = "register"
gchat.SendUrl = "send"
gchat.ResetUrl = "reset"
gchat.RecieveChat = "history"
gchat.ServerURL = "http://80.188.186.251:3000/"

//Create a Random String
function gchat.RandomID(ply)
	return util.CRC(ply:SteamID() + os.time())
end

//Register new Client
function gchat.RegisterClient(secKey ,uniqID ,SID ,SName)
	local dataTable = {
		secretKey = secKey,
		uniqueID = uniqID,
		steamID = SID,
		steamName= SName
	}

	http.Post( (gchat.ServerURL..gchat.RegistrationUrl), dataTable, 
		function(responseText,contentLength,responseHeaders,statusCode )
			if statusCode == 200 then
				print( "Everything is OK and responseText contains the response" )
			elseif statusCode == 400 then
				print( "Something was wrong with the request" )
			end
		end, 
		function( errorMessage )
			print( errorMessage )
		end )
end
 
//Serverside Function to reset the messages
function gchat.ResetChat(secKey)
	local dataTable = {
		secretKey = secKey
	}

	http.Post( (gchat.ServerURL..gchat.ResetUrl), dataTable, 
		function( responseText, contentLength, responseHeaders, statusCode )
			if statusCode == 200 then
				print( "Everything is OK and responseText contains the response" )
			elseif statusCode == 400 then
				print( "Something was wrong with the request" )
			end
		end, 
		function( errorMessage )
			print( errorMessage )
		end )
end

//Send the settings to the client
function gchat.SendSettings(ply)
	net.Start("gchat_send_Settings_to_clients")
		net.WriteTable({
			SendUrl = gchat.SendUrl,
			RecieveChat = gchat.RecieveChat,
			ServerURL = gchat.ServerURL
		})
	net.Send(ply)
end


gchat.RegisterClient("ABCDEF","testUniqID","testSteamID","YOLO")
util.AddNetworkString("gchat_send_Settings_to_clients")