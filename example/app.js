var express = require('express'), app = express();

app.get('/genres/', function(req, res){
    res.send(['comedy', 'action', 'sitcom']);
});

app.get('/movies/', function(req, res){
    var movies = {
        'comedy': ['Movie A', 'Movie B'],
        'sitcom': ['Movie E', 'Movie X'],
        'action': ['Action movie 5']
    };
    var genre = req.query.genre;
    if (genre) {
        res.send(movies[genre]);
    } else {
        var all = [];
        for (var key in movies) {
            all = all.concat(movies[key]);
        }
        res.send(all);
    }
});

app.use(express.static(__dirname + '/public'));

app.listen(3000);
