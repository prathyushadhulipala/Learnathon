var http = require("http");
var port = process.env.PORT || 8080;
var express = require('express');
var app = express();
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});
app.use(express.bodyParser());
var db = require('./core/db.js');

app.post('/card', function(request, response){
        console.log("Server.js invoked with card url");
		console.log("from request",request.body);
    
    //TODO OCR Integration and hardcode the authentication to true.
    
        db.retrieveCardDetails(request.body, function(err, rows, fields) {
            if(!err)
                {
        console.log('retrieveCardDetails invoked');
            var partyId = request.body.partyId;
                console.log(rows);
            if(partyId == rows[0].Party_Id && rows[0].Notification_Status == 'Not Sent'
              && rows[0].Card_Activation_Status == 'Ready' && rows[0].Card_Dispatch_Status == 'Dispatched')
                {
                    //TODO Integrate activate card service
                   
                    db.updateCardActivationStatus(rows[0].Card_No, function(err, data)
                    {
                        if(err) throw err;
                        response.send('Card Activation Successful'); 
                    });
                }
                }
    
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