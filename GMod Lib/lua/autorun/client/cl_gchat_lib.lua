gchat = gchat or {}
gchat.Settings = gchat.Settings or {}

//Retrive the chat
function gchat.retriveChat(uniqID)
	local responseText = ""
	http.Post( (gchat.Settings.ServerURL..gchat.Settings.RegistrationUrl), {uniqueID = uniqID}, 
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
	return responseText
end

//Send Message
function gchat.SendMessage(uniqID ,msg)
	local dataTable = {
		uniqueID = uniqID,
		message = msg
	}

	http.Post( (gchat.Settings.ServerURL..gchat.Settings.RegistrationUrl), dataTable, 
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

net.Receive( "gchat_send_Settings_to_clients", function( len, pl )
	gchat.Settings = net.ReadTable()
end )