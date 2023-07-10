const { Router } = require('express');
const controller = require('./controller');

const routerq = Router();

// routerq.get("/",(req,res)=>{
//     res.send("using api routPost");
// });
/*********USERS********** */

 routerq.get('/',controller.getAllPosts);
 routerq.post('/',controller.addPost);
 routerq.get('/:id',controller.getPostById);
 routerq.delete("/:id",controller.removePostById);
 routerq.put("/:id",controller.updatePostById);

module.exports= routerq;