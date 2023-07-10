// Import database pool and queries
const pool = require('../../db');


// Get all users
const searchUsers = (req, res) => {
  const { query } = req.query;

  pool.query(
    `SELECT *
     FROM users
     WHERE username LIKE '%${query}%'`,
    (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }

      res.status(200).json(results);
      console.log('Search results:', results);
    }
  );
};

      module.exports = {
      searchUsers,
      };
