const productServices = require('../services/products.services');
const upload = require('../middleware/upload');

exports.create = (req, res, next) => {
    upload(req, res, function (err) {
        if (err) {
            next(err);
        }
        else {
            const url = req.protocol + '://' + req.get('host');
            const path = req.file != undefined ? req.file.path.replace(/\\/g, '/') : '';

            var model = {
                productName: req.body.productName,
                productDesc: req.body.productDesc,
                productPrice: req.body.productPrice,
                productImage: path != '' ? url + '/' + path : '',
            };

            productServices.createProduct(model, (error, result) => {
                if (error) {
                    return next(error);
                } else {
                    return res.status(200).send({
                        msg: 'success',
                        data: result,
                    });
                }
            })
        }
    })
};

exports.findAll = (req, res, next) => {

    var model = {
        productName: req.query.productName,
    };

    productServices.getProducts(model, (error, result) => {
        if (error) {
            return next(error);
        } else {
            return res.status(200).send({
                msg: 'success',
                data: result,
            });
        }
    })
};

exports.findOne = (req, res, next) => {

    var model = {
        productId: req.params.id,
    };

    productServices.getProductById(model, (error, result) => {
        if (error) {
            return next(error);
        } else {
            return res.status(200).send({
                msg: 'success',
                data: result,
            });
        }
    })
};

exports.update = (req, res, next) => {
    upload(req, res, function (err) {
        if (err) {
            next(err);
        }
        else {
            const url = req.protocol + '://' + req.get('host');
            const path = req.file != undefined ? req.file.path.replace(/\\/g, '/') : '';

            var model = {
                productId: req.params.id,
                productName: req.body.productName,
                productDesc: req.body.productDesc,
                productPrice: req.body.productPrice,
                productImage: req.file != undefined ? (path != '' ? url + '/' + path : '') : req.body.productImage,
            };

            productServices.updateProduct(model, (error, result) => {
                if (error) {
                    return next(error);
                } else {
                    return res.status(200).send({
                        msg: 'success',
                        data: result,
                    });
                }
            })
        }
    })
};

exports.delete = (req, res, next) => {

    var model = {
        productId: req.params.id,
    };

    productServices.deleteProduct(model, (error, result) => {
        if (error) {
            return next(error);
        } else {
            return res.status(200).send({
                msg: 'success',
                data: result,
            });
        }
    })
};