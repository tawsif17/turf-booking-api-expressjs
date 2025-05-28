const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const prisma = require('../prisma/client');

exports.registerUser = async (req, res) => {
  const { name, phone_number, email, password, bkash_number } = req.body;

  try {
    const existingUser = await prisma.user.findFirst({
      where: {
        OR: [
          { phone_number },
          { email: email || undefined },
        ],
      },
    });

    if (existingUser) {
      return res.status(400).json({ message: 'Phone number or email already exists.' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await prisma.user.create({
      data: {
        name,
        phone_number,
        email,
        password: hashedPassword,
        bkash_number,
        role: { connect: { role_id: 3 } } // default role: general
      },
    });

    res.status(201).json({ message: 'User registered successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Registration failed', error: error.message });
  }
};

exports.loginUser = async (req, res) => {
  console.log(req.body," Login Body")
  const { phone_number, password } = req.body;

  try {
    const user = await prisma.user.findUnique({
      where: { phone_number },
      include: { role: true }
    });

    if (!user) return res.status(401).json({ message: 'Invalid credentials' });

    const validPassword = await bcrypt.compare(password, user.password);
    if (!validPassword) return res.status(401).json({ message: 'Invalid credentials' });

    const token = jwt.sign(
      { user_id: user.user_id, role: user.role.name },
      process.env.JWT_SECRET,
      { expiresIn: '7d' }
    );

    res.json({
      message: 'Login successful',
      token,
      user: {
        user_id: user.user_id,
        name: user.name,
        role: user.role.name,
      },
    });
  } catch (error) {
    res.status(500).json({ message: 'Login failed', error: error.message });
  }
};