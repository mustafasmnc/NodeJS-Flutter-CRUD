const multer = require('multer');
const Path = require('path');

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './uploads');
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + '--' + file.originalname);
    },
});

const fileFilter = (req, file, callback) => {
    const validExts = ['.png', '.jpg', '.jpeg'];
    if (!validExts.includes(Path.extname(file.originalname))) {
        return callback(new Error('only .png, .jpg, .jpeg  formats allowed'));
    }
    const fileSize = parseInt(req.headers["content-length"]);
    if (fileSize > 1048576) {
        return callback(new Error('file size is big'));
    }

    callback(null, true);
}

let upload = multer({
    storage: storage,
    fileFilter: fileFilter,
    fileSize: 1048576, //10 Mb
});

module.exports = upload.single('productImage')