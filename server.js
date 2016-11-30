var http = require("http");
var port = process.env.PORT || 8080;
var express = require('express');
var app = express();
var req = require('request');
var fs = require('fs');
    var Client = require('node-rest-client').Client;
 
var client = new Client();
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});
app.use(express.bodyParser());
var db = require('./core/db.js');

app.post('/card', function(request, finalResponse){
        console.log("Server.js invoked with card url");
		console.log("from request",request.body);
        var url     = request.body.imageURL;
        var img;
        req(url, {encoding: 'binary'}, function(error, res, body) 
        {
            img = new Buffer(body, 'binary');
            console.log('image from url',img);
            
            // set content-type header and data as json in args parameter 
            var args = 
            {
            data: { image: img },
            headers: { "Content-Type": "application/json" }
            };
 
            client.post("http://demo2686732.mockable.io/cardnumber", args, function (data, response) 
            {
            // parsed response body as js object 
            console.log(data);
            
            db.retrieveCardDetails(request.body, function(err, rows, fields) {
            if(!err)
            {
                    console.log('retrieveCardDetails invoked');
                    var partyId = request.body.partyId;
                    console.log(rows);
                    if(partyId == rows[0].Party_Id && rows[0].Notification_Status == 'Not Sent'
                    && rows[0].Card_Activation_Status == 'Active' && rows[0].Card_Dispatch_Status == 'Dispatched')
                    {
                    //TODO Integrate activate card service
                   
                    db.updateCardActivationStatus(rows[0].Card_No, function(err, data)
                    {
                        if(err) throw err;
                        finalResponse.send('Card Activation Successful'); 
                    });
                }
                else
                {
                    finalResponse.send('Card Already Activated');
                }
            }
    
        });
            });
        });
});

app.post('/cards', function(request, response){
console.log("Server.js invoked with cards url");
		  db.updateCardActivationStatus(request.query.cno, function(err, data)
          {
              if(err) throw err;
             response.send('Card Activation Successful'); 
          });
    
});

app.listen(port, function(){
    console.log('Listening on port number'+port);
});