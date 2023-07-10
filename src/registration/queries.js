const getUserByEmail = "SELECT * FROM users WHERE email = ?";
const getUserByEmailAndPassword = "SELECT * FROM users WHERE email = ? AND password = ?";
const registerUser = "INSERT INTO users(user_id ,username,email, profile_picture) VALUES (?,?,?,?)";

module.exports = {
  getUserByEmail,
  getUserByEmailAndPassword,
  registerUser,
};
