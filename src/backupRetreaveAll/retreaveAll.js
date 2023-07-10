// // Import database pool and queries
// const pool = require('../../db');
// const queries = require('./queries');
// const jwt = require('jsonwebtoken');

// // Get all users
// const getAllUsers = (req, res) => {
//   pool.query(queries.getAllUsers, (error, results) => {
//     if (error) {
//       console.error(error);
//       res.status(500).json({ error: 'Internal server error' });
//       return;
//     }

//     const token = jwt.sign({ users: results.rows }, 'tish1997!'); // Modify 'secretKey' with your own secret key

//     res.status(200).json({ token: token });
//     console.log('Retrieved all users and generated token');
//   });
// };

// // Get user by id
// const getUserById = (req, res) => {
//   const id = parseInt(req.params.id);
//   pool.query(queries.getUserById, [id], (error, results) => {
//     if (error) {
//       console.error(error);
//       res.status(500).json({ error: 'Internal server error' });
//       return;
//     }
//     if (!results.rows) {
//       res.status(404).json({ error: 'User not found' });
//       return;
//     }
//     res.status(200).json(results.rows);
//     console.log(`Retrieved user with id: ${id}`);
//   });
// };

// // Add new user
// const addUser = (req, res) => {
//   const { username, email, password_hash } = req.body;
//   pool.query(queries.checkEmailExists, [email], (error, results) => {
//     if (error) {
//       console.error(error);
//       res.status(500).json({ error: 'Internal server error' });
//       return;
//     }
//     if (results.rows) {
//       res.status(400).json({ error: 'Email already exists' });
//       return;
//     }
//     pool.query(queries.addUser, [username, email, password_hash], (error, results) => {
//       if (error) {
//         console.error(error);
//         res.status(500).json({ error: 'Internal server error' });
//         return;
//       }
//       res.status(201).json({ message: 'User created successfully' });
//       console.log(`User ${username} created successfully`);
//     });
//   });
// };

// // Remove user by id
// const removeUserById = (req, res) => {
//   const id = parseInt(req.params.id);
//   pool.query(queries.getUserById, [id], (error, results) => {
//     if (error) {
//       console.error(error);
//       res.status(500).json({ error: 'Internal server error' });
//       return;
//     }
//     if (!results.rows.length) {
//       res.status(404).json({ error: 'User not found' });
//       return;
//     }
//     pool.query(queries.removeUserById, [id], (error, results) => {
//       if (error) {
//         console.error(error);
//         res.status(500).json({ error: 'Internal server error' });
//         return;
//       }
//       res.status(200).json({ message: 'User deleted successfully' });
//       console.log(`User with id: ${id} deleted successfully`);
//     });
//   });
// };

// // Update user by id

// const updateUserById = (req, res) => {
//         const id = parseInt(req.params.id);
//         const { username } = req.body;
      
//         // validate input
//         if (!username) {
//           res.status(400).send("Please provide a name for the user");
//           return;
//         }
      
//         pool.query(
//           queries.getUserById,
//           [id],
//           (error, results) => {
//             if (error) {
//               console.error(error);
//               res.status(500).send("Error fetching User from database");
//               return;
//             }
      
//             const noUserFound = !results.rows.length;
//             if (noUserFound) {
//               res.status(404).send("User not found in the database");
//               return;
//             }
      
//             // update User name in the database
//             pool.query(
//                 queries.updateUserById,
//               [username, id],
//               (error, results) => {
//                 if (error) {
//                   console.error(error);
//                   res.status(500).send("Error updating User in database");
//                   return;
//                 }
      
//                 res.status(200).send("User updated successfully");
//                 console.log("User updated successfully!");
//               }
//             );
//           }
//         );
//       };

//       module.exports = {
//       getAllUsers,
//       getUserById,
//       addUser,
//       removeUserById,
//       updateUserById
//       };
