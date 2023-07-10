const getWafugajii = "SELECT * FROM wafugaji";
const getMfugajiById = "SELECT * FROM wafugaji WHERE id =$1";
const checkEmailExists = "SELECT s FROM wafugaji s WHERE s.email=$1";
const addmfugaji = " INSERT INTO wafugaji (name,email,age,dob) VALUES ($1,$2,$3,$4) "
const removeMfugaji= "DELETE FROM wafugaji WHERE id=$1";
const updateMfugaji= "UPDATE wafugaji SET name = $1 WHERE id = $2"


module.exports={
    getWafugajii,
    getMfugajiById,
    checkEmailExists,
    addmfugaji,
    removeMfugaji,
    updateMfugaji
}