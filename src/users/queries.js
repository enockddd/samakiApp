
/*************USERS**********/
 const getAllUsers = "SELECT * FROM users";
 const getUserById = "SELECT * FROM users WHERE user_id =?";
 const checkEmailExists = "SELECT email FROM users WHERE email = ?";
 const addUser = "INSERT INTO users(user_id ,username,email, profile_picture) VALUES (?,?,?,?)";
 const removeUserById= "DELETE FROM users WHERE user_id=?";
 const updateUserById= "UPDATE users SET username = ? WHERE id = ?";



module.exports={
    getAllUsers,
    addUser,
    checkEmailExists,
    getUserById,
    removeUserById,
    updateUserById
}