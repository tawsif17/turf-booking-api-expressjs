const Joi = require('joi');

const phoneRegex = /^01\d{9}$/;
const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;

const registerSchema = Joi.object({
  name: Joi.string().required(),
  phone_number: Joi.string().pattern(phoneRegex).required(),
  email: Joi.string().email().optional().allow(null, ''),
  password: Joi.string().pattern(passwordRegex).required(),
  bkash_number: Joi.string().optional().allow(null, ''),
});

const loginSchema = Joi.object({
  phone_number: Joi.string().pattern(phoneRegex).required(),
  password: Joi.string().required(),
});

module.exports = {
  registerSchema,
  loginSchema,
};