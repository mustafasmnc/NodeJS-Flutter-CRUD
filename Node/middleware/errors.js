function errorHandler(err, req, res, next) {
    if (typeof err === 'string') {
        return res.status(400).json({ msg: err });
    }
    if (err.name === 'ValidationError') {
        return res.status(400).json({ msg: err.message });
    }

    return res.status(500).json({ msg: err.message });
}

module.exports = {
    errorHandler,
};