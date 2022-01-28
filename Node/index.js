const express = require('express');
const app = express();
const mongoose = require('mongoose');
//const { MONGO_DB_CONFIG } = require('./config/app.config');
const connecDB = require('./config/db')
const errors = require('./middleware/errors');

mongoose.Promise = global.Promise;
connecDB();
// mongoose.connect(MONGO_DB_CONFIG.DB, {
//     useNewUrlParser: true,
//     useUnifiedTopology: true
// }).then(() => {
//     console.log('database connected')
// }, (error) => {
//     console.log(`database cant connected: ${error}`);
// });

app.use(express.json());
app.use('/uploads', express.static('uploads'));
app.use('/api', require('./routes/app.routes'));
app.use(errors.errorHandler);

app.listen(process.env.PORT || 5000, function () {
    console.log('ready to go');
});