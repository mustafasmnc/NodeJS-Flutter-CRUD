const mongoose = require('mongoose');
const { MONGO_DB_CONFIG } = require('./app.config')

const connectDB = async () => {
    try {
        const conn = await mongoose.connect(MONGO_DB_CONFIG.DB, {
            useNewUrlParser: true,
            useUnifiedTopology: true
        })
        console.log(`MongoDB Connected: ${conn.connection.host}`)
    } catch (error) {
        console.log(error)
        process.exit(1)
    }
}

module.exports = connectDB