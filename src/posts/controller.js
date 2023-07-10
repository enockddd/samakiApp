// Import database pool and queries
const pool = require('../../db');
const queries = require('./queries');

// Get all posts
const getAllPosts = (req, res) => {
  pool.query(queries.getAllPosts, (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.status(200).json(results.rows);
    console.log('Retrieved all posts');
  });
};

// Get post by id
const getPostById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getPostById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (!results.rows.length) {
      res.status(404).json({ error: 'Post not found' });
      return;
    }
    res.status(200).json(results.rows);
    console.log(`Retrieved post with id: ${id}`);
  });
};

// Add new post
const addPost = (req, res) => {
  const { user_id, username, post_type, content_url, description, tags } = req.body;
  pool.query(queries.addPost, [user_id, username, post_type, content_url, description, tags], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ 
        message: 'Internal server error', 
        error: error.toString()
      });
      return;
    }
    res.status(201).json({ 
      message: 'Post created successfully',
      error: null
    });
    console.log(`Post ${post_type} created successfully`);
  });
};



// Remove post by id
const removePostById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getPostById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (!results.rows.length) {
      res.status(404).json({ error: 'Post not found' });
      return;
    }
    pool.query(queries.removePostById, [id], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      res.status(200).json({ message: 'Post deleted successfully' });
      console.log(`Post with id: ${id} deleted successfully`);
    });
  });
};

// Update post by id
const updatePostById = (req, res) => {
    const id = parseInt(req.params.id);
    const { description, content_url } = req.body;
  
    // validate input
    if (!description) {
      res.status(400).send("Please provide a description for the post");
      return;
    } else if (!content_url) {
      res.status(400).send("Please provide a Content_url for the post");
      return;
    }
  
    pool.query(
      queries.getPostById,
      [id],
      (error, results) => {
        if (error) {
          console.error(error);
          res.status(500).send("Error fetching post from database");
          return;
        }
  
        const noPostFound = !results.rows.length;
        if (noPostFound) {
          res.status(404).send("Post not found in the database");
          return;
        }
  
        // update post description and content_url in the database
        pool.query(
          queries.updatePostById,
          [description, content_url, id],
          (error, results) => {
            if (error) {
              console.error(error);
              res.status(500).send("Error updating post in database");
              return;
            }
  
            res.status(200).send("Post updated successfully");
            console.log("Post updated successfully!");
          }
        );
      }
    );
  };     
                module.exports = {
                getAllPosts,
                getPostById,
                addPost,
                removePostById,
                updatePostById,
                };
                
                
                
                
                
                
                