// index.js
// where your node app starts

// init project
var express = require('express');
var app = express();

// enable CORS (https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)
// so that your API is remotely testable by FCC 
var cors = require('cors');
const { redirect } = require('express/lib/response');
app.use(cors({optionsSuccessStatus: 200}));  // some legacy browsers choke on 204

// http://expressjs.com/en/starter/static-files.html
app.use(express.static('public'));

// http://expressjs.com/en/starter/basic-routing.html
app.get("/", function (req, res) {
  res.sendFile(__dirname + '/views/index.html');
});


// your first API endpoint... 
app.get("/api/hello", function (req, res) {
  res.json({greeting: 'hello API'});
});



// Listen on port set in environment variable or default to 3000
var listener = app.listen(process.env.PORT || 3000, function () {
  console.log('Your app is listening on port ' + listener.address().port);
});

// Timestamp API
app.get("/api/:date?", function (req, res) {
  console.log(req.params);
  try {
    const getDate = () => {
      if (req.params.date === undefined) {
        return new Date();
      } else if (req.params.date.match(/^\d+$/g) !== null) {
        return new Date(Number(req.params.date));
      } else {
        return new Date(req.params.date);
      }
    };
    const date = getDate();
    let unixDate = date.valueOf();
    let utcDate = date.toUTCString();
    if (utcDate === "Invalid Date") {
      throw "Invalid Date";
    }
    res.json({unix: unixDate, utc: utcDate});
  }
  catch (err) {
    res.json({error : "Invalid Date"});
  }
});