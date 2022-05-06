var express = require("express");
var app = express();
var _ = require("underscore");
const RutrackerApi = require('rutracker-api');
const rutracker = new RutrackerApi();


rutracker.login({ username: 'diesersamat1', password: 'Mother62' })
  .then(() => {
    console.log('Authorized');
  })
  .catch(err => console.error(err));


app.listen(process.env.PORT || 3000, () => {
 console.log("Server running.");
});

app.get("/search", (req, res, next) => {
    rutracker.search({ query: req.query.q, sort: 'size' }).then(
    torrents  => {
        var filtered = _.filter(torrents, function(torrent) { 
            return torrent.title.includes("[P]") || torrent.title.includes("[L]");});
      res.json(filtered);  
    })
});




