const express = require("express")
const dotenv = require('dotenv')
const bodyParser = require('body-parser')


const app = express()
app.use(bodyParser.urlencoded({extended:false}))
app.use(express.json())

dotenv.config()

const authRoutes = require('./routes/authRoutes')

app.get('/test',(req,res)=>{
    return res.send("Hello")
})
app.use('/api/auth',authRoutes)

module.exports = app