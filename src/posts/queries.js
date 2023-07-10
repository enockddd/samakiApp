// /*************POSTS**********/
 const getAllPosts = "SELECT * FROM posts";
 const getPostById = "SELECT * FROM posts WHERE post_id =?";
 const addPost = "INSERT INTO posts (user_id, username, post_type, content_url, description, tags) VALUES (?,?,?,?,?,?)";
 const removePostById= "DELETE FROM posts WHERE post_id=?";
 const updatePostById = "UPDATE posts SET description = ?, content_url = ? WHERE post_id = ?";


module.exports={
   getAllPosts,
    addPost,
    getPostById,
    removePostById,
    updatePostById
}