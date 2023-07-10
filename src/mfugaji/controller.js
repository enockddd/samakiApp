
const pool = require('../../db');
const queries = require('./queries');


const getWafugaji = (req,res)=>{
   pool.query(queries.getWafugajii,(error,results)=>{
    if (error)throw error;
    res.status(200).json(results.rows)
   }) };

   const getMfugajiById = (req,res)=> {
    const id = parseInt(req.params.id);
    pool.query(queries.getMfugajiById,[id],(error,results)=>{
        if (error) throw error;
        res.status(200).json(results.rows);
    })
   };

   const addmfugaji = (req,res)=> {
    const {name , email ,age,dob }= req.body;
    //chek if email exist
    pool.query(queries.checkEmailExists,[email],(error,results)=>{
        if(results.rows.length){
            res.send("email aready exists");
        } 

        pool.query(queries.addmfugaji,[name,email,age,dob],(error,results)=>{
            if (error) throw error;
            res.status(201).send("mfugaji created successfully!");
            console.log("mfugaji created successfuly! ");
        });
    });
   };

   const removeMfugaji = (req, res) => {
    const id = parseInt(req.params.id);
  
    pool.query(queries.getMfugajiById, [id], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).send("Error fetching mfugaji from database");
        return;
      }
  
      if (!results.rows.length) {
        res.status(404).send("Mfugaji not found in the database");
        return;
      }
  
      pool.query(queries.removeMfugaji, [id], (error, results) => {
        if (error) {
          console.error(error);
          res.status(500).send("Error deleting mfugaji from database");
          return;
        }
  
        res.status(200).send("Mfugaji deleted successfully from database");
        console.log("Mfugaji deleted successfully!");
      });
    });


  };

  const updateMfugaji = (req, res) => {
    const id = parseInt(req.params.id);
    const { name } = req.body;
  
    // validate input
    if (!name) {
      res.status(400).send("Please provide a name for the Mfugaji");
      return;
    }
  
    pool.query(
      queries.getMfugajiById,
      [id],
      (error, results) => {
        if (error) {
          console.error(error);
          res.status(500).send("Error fetching Mfugaji from database");
          return;
        }
  
        const noMfugajiFound = !results.rows.length;
        if (noMfugajiFound) {
          res.status(404).send("Mfugaji not found in the database");
          return;
        }
  
        // update Mfugaji name in the database
        pool.query(
          queries.updateMfugaji,
          [name, id],
          (error, results) => {
            if (error) {
              console.error(error);
              res.status(500).send("Error updating Mfugaji in database");
              return;
            }
  
            res.status(200).send("Mfugaji updated successfully");
            console.log("Mfugaji updated successfully!");
          }
        );
      }
    );
  };
module.exports= {
    getWafugaji,
    getMfugajiById,
    addmfugaji,
    removeMfugaji,
    updateMfugaji
   
}