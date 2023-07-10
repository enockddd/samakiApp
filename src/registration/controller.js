const jwt = require('jsonwebtoken');
const pool = require('../../db');
const queries = require('./queries');
const bcrypt = require('bcryptjs');
require('dotenv').config();

const registerUser = (req, res) => {
  const { user_id, username, email, profile_picture } = req.body;

  // Check if email is provided
  if (!email) {
    return res.status(400).json({ error: 'Email is required' });
  }

  pool.query(queries.getUserByEmail, [email], async (error, results) => {
    if (error) {
      console.error(error);
      return res.status(500).json({ error: 'Internal server error' });
    }

    // Check if user already exists
    if (results.length > 0) {
      return res.status(409).json({ error: 'User with this email already exists' });
    }

    pool.query(queries.registerUser, [user_id, username, email, profile_picture], (error, results) => {
      if (error) {
        console.error(error);
        return res.status(500).json({ error: 'Internal server error' });
      }

      const jwtPayload = {
        user_id: user_id,
        email: email,
        username: username,
        profile_picture: profile_picture,
      };

      console.log(jwtPayload);
      const token = jwt.sign(jwtPayload, process.env.JWT_SECRET, { expiresIn: '1h' });

      return res.status(201).json({ message: 'Registered successfully', token });
    });
  });
};

module.exports = {
  registerUser,
};
