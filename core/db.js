var mysql = require('mysql');
var connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'mysql',
  database:'learnathon'
});

function createConnection()
{
connection.connect();
};

exports.retrieveCardDetails = function(data, callback)
{
    var cardNumber = data.cardNumber;
    var query = 'select a.Party_Id, b.Notification_Status, c.Card_Activation_Status, c.Card_No, c.Card_Dispatch_Status from Member_Info a, Batch_Info b, Card_Info c where c.Card_Id = b.Card_Id && c.Party_Id = a.Party_id && c.Card_No=?';
    connection.query(query, cardNumber, function(err, rows, fields){
       if(err) throw err;
        
        console.log('The partyId is', rows[0].Party_Id);
        callback(err, rows);
    });
}

exports.updateCardActivationStatus = function(data, callback)
{
    var cardNumber = data;
    var query = "update card_info set Card_Activation_Status = 'Active' where Card_no = ?";
    connection.query(query, cardNumber, function(err){
       if(err) throw err;
        console.log('Activation Completed Successfully');
        closeConnection();
        callback(err);
    });
}

function closeConnection()
{
    connection.end();
}