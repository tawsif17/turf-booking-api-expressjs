module.exports = (schema) => async (req, res, next) => {
  try {
    await schema.validateAsync(req.body);
    console.log(req.body," Validating Body")
    next();
  } catch (err) {
    console.log(err," Validation error")
    res.status(400).json({ message: 'Validation error', details: err.details });
  }
};