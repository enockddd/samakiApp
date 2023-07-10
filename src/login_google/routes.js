const { Router } = require('express');
const controller = require('./controller');

const router = Router();

router.post('/google', controller.googleSignIn);

module.exports = router;

