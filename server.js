const express = require('express');
const bodyParser = require('body-parser');
const usersRoute = require('./src/users/routes');
const postsRoute = require('./src/posts/routes');
const registrationRoute = require('./src/registration/routes');
const loginsessionRoute = require('./src/login_session/routes');
const searchRoute = require('./src/search/routes');


const app = express();
const port = 5900;

// Middleware
app.use(bodyParser.json());

// Routes
app.get('/', (req, res) => {
  res.send('Hello newPostEnock');
});

app.use('/api/v1/users', usersRoute);
app.use('/api/v1/posts', postsRoute);
app.use('/api/v1/registration', registrationRoute);
app.use('/api/v1/login_session', loginsessionRoute);
app.use('/api/v1/search',searchRoute);


// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send({ message: 'Something went wrong!' });
});

app.listen(port, () => {
  console.log(`Server is listening on port ${port}`);
}).on('error', err => {
  console.error('Server failed to start:', err);
});
