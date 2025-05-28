const express = require('express');
const router = express.Router();
const { registerUser, loginUser } = require('../controllers/authController');
const validateInput = require('../middlewares/validateInput');
const { registerSchema, loginSchema } = require('../validations/authValidation');

router.post('/register', validateInput(registerSchema), registerUser);
router.post('/login', validateInput(loginSchema), loginUser);

module.exports = router;