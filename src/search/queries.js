
/*************USERS**********/
 const searchUsersQuery =  `SELECT *
  FROM users
  WHERE username LIKE '%${query}%'`;




module.exports={
    searchUsersQuery,
    
}