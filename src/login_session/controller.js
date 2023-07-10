const jwt = require('jsonwebtoken');
const pool = require('../../db');
const queries = require('./queries');
const bcrypt = require('bcrypt');
require('dotenv').config();

const loginUser = (req, res) => {
  const { email, password } = req.body;

  // Check if email and password are provided
  if (!email || !password) {
    return res.status(400).json({ error: 'Email and password are required' });
  }

  pool.query(queries.getUserByEmail, [email], (error, results) => {
    if (error) {
      console.error(error);
      return res.status(500).json({ error: 'Internal server error' });
    }

    if (!results || results === 0) {
      return res.status(404).json({ error: 'Invalid login credentials' });
    }

    const user = results[0];
    console.log(user);

    console.log('Password:', password);
    console.log('User password:', user.password_hash);

    bcrypt.compare(password, user.password_hash, (err, isMatch) => { // Changed user.password_hash to user.password
      if (err) {
        console.error(err);
        return res.status(500).json({ error: 'Internal server error' });
      }

      if (!isMatch) {
        return res.status(401).json({ error: 'Invalid login credentials' });
      }

      const jwtPayload = {
        user_id: user.user_id,
        email: user.email,
      };

      const token = jwt.sign(jwtPayload, process.env.JWT_SECRET, { expiresIn: '1h' });
      console.log(jwtPayload);

      return res.status(200).json({ message: 'Logged in successfully', token }); // Sending the response to the client
    });
  });
};

module.exports = {
  loginUser,
};
