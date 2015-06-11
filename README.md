# GCM_server

On that moment it is first and simple prototype of GCM server.
It has 2 main goals - 1) send  notifications to mobile users;
2) register registration_ids from clients.

Server can be controlled by 2 POST requests

##post request to add message to queue and start messaging
 post "/message" 
 with `params[:message]` `params[:url]`
 
 where message - is notifications text, url - link connected to this message.
 
 
##post request to add registration id
 post "/add" 
   with `params[:user_id] and params[:reg_id];`

   
 Server can be start from root folder - bundle exe ruby ./app/routes.rb
   ###TO DO
   
  1. Test on real net with android client
