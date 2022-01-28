const mongoose = require('mongoose');

const product = mongoose.model(
    "products",
    mongoose.Schema({
        productName: String,
        productDesc: String,
        productPrice: Number,
        productImage: String,
    },
        {
            timestamps: true
        })
);

module.exports={
    product
}