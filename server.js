const express = require("express");
const usersRoute = require('./src/users/routes');
const postsRoute = require('./src/posts/routes');
const app = express();
const port = 7000;

 app.use(express.json());

//app.get("/", (req, res) => {
//    res.send("Hello newPostEnock");
//});

app.use('/api/v1/users', usersRoute);
app.use('/api/v1/posts', postsRoute);
 

app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
}).on("error", err => {
    console.error("Server failed to start:", err);
});