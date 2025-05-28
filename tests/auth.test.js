const request = require('supertest');
const app = require('../app');
const prisma = require('../prisma/client');

describe('Auth Routes Edge Cases', () => {
  const testUser = {
    name: 'Edge Case User',
    phone_number: '01719998888',
    email: 'edgecase@example.com',
    password: 'Edge1234',
    bkash_number: '01700001124',
  };

  beforeAll(async () => {
    await prisma.user.deleteMany({
      where: {
        OR: [
          { phone_number: testUser.phone_number },
          { email: testUser.email },
        ]
      }
    });
  });

  afterAll(async () => {
    await prisma.user.deleteMany({
      where: {
        OR: [
          { phone_number: testUser.phone_number },
          { email: testUser.email },
        ]
      }
    });
    await prisma.$disconnect();
  });

  it('should register a user successfully', async () => {
    const res = await request(app).post('/api/auth/register').send(testUser);
    expect(res.statusCode).toBe(201);
  });

  it('should fail registration with duplicate phone/email', async () => {
    const res = await request(app).post('/api/auth/register').send(testUser);
    expect(res.statusCode).toBe(400);
    expect(res.body.message).toMatch(/already exists/i);
  });

  it('should fail registration with weak password', async () => {
    const res = await request(app).post('/api/auth/register').send({
      ...testUser,
      phone_number: '01712223333',
      email: 'weakpass@example.com',
      password: '123',
    });
    expect(res.statusCode).toBe(400);
  });

  it('should fail registration with missing fields', async () => {
    const res = await request(app).post('/api/auth/register').send({
      phone_number: '01714445555',
    });
    expect(res.statusCode).toBe(400); // Could improve this with validation middleware
  });

  it('should fail login with wrong phone number', async () => {
    const res = await request(app).post('/api/auth/login').send({
      phone_number: '01700000000',
      password: testUser.password,
    });
    expect(res.statusCode).toBe(401);
  });

  it('should fail login with wrong password', async () => {
    const res = await request(app).post('/api/auth/login').send({
      phone_number: testUser.phone_number,
      password: 'WrongPass123',
    });
    expect(res.statusCode).toBe(401);
  });

  it('should register without email', async () => {
    const res = await request(app).post('/api/auth/register').send({
      name: 'No Email User',
      phone_number: '01716667777',
      password: 'Test1234',
      bkash_number: '01700001125',
    });
    expect(res.statusCode).toBe(201);
  });
});
