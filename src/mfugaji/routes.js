const {Router} = require('express');
const controller = require('./controller');

const router = Router();

router.get('/',controller.getWafugaji);
router.post('/',controller.addmfugaji);
router.get('/:id',controller.getMfugajiById);
router.delete("/:id",controller.removeMfugaji);
router.put("/:id",controller.updateMfugaji);

module.exports= router;