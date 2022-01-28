import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_crud_api/api_service.dart';
import 'package:flutter_crud_api/config.dart';
import 'package:flutter_crud_api/models/product_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ProductAddEdit extends StatefulWidget {
  const ProductAddEdit({Key? key}) : super(key: key);

  @override
  _ProductAddEditState createState() => _ProductAddEditState();
}

class _ProductAddEditState extends State<ProductAddEdit> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAPICallProcess = false;
  ProductModel? productModel;
  bool isEditMode = false;
  bool isImageSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('NodeJS MongoDB CRUD'),
          elevation: 0,
        ),
        body: ProgressHUD(
          inAsyncCall: isAPICallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalKey,
            child: productForm(),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    isImageSelected = false;
    productModel = ProductModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

        productModel = arguments['model'];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget productForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: FormHelper.inputFieldWidget(
                context, Icon(Icons.adb_sharp), "ProductName", "Product Name",
                (onValidateValue) {
              if (onValidateValue.isEmpty) {
                return "Product name can't be empty";
              }
              return null;
            }, (onSaveValue) {
              productModel!.productName = onSaveValue;
            },
                initialValue: productModel!.productName ?? "",
                borderColor: Colors.grey,
                borderFocusColor: Colors.white,
                textColor: Colors.grey,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
                showPrefixIcon: false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: FormHelper.inputFieldWidget(
                context, Icon(Icons.adb_sharp), "ProductPrice", "Product Price",
                (onValidateValue) {
              if (onValidateValue.isEmpty) {
                return "Product price can't be empty";
              }
              return null;
            }, (onSaveValue) {
              productModel!.productPrice = int.parse(onSaveValue);
            },
                initialValue: productModel!.productPrice == null
                    ? ""
                    : productModel!.productPrice!.toString(),
                borderColor: Colors.grey,
                borderFocusColor: Colors.white,
                textColor: Colors.grey,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
                showPrefixIcon: false,
                suffixIcon: Icon(Icons.monetization_on)),
          ),
          imgPicker(
            isImageSelected,
            productModel!.productImage ?? "",
            (file) => {
              setState(
                () {
                  //model.productPic = file.path;
                  productModel!.productImage = file.path;
                  isImageSelected = true;
                },
              )
            },
          ),
          SizedBox(height: 20),
          Center(
              child: FormHelper.submitButton("Save", () {
            if (validateAndSave()) {
              //API Service
              setState(() {
                isAPICallProcess = true;
              });
              APIService.saveProduct(productModel!, isEditMode, isImageSelected)
                  .then((response) {
                setState(() {
                  isAPICallProcess = false;
                });
                if (response) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                } else {
                  FormHelper.showSimpleAlertDialog(
                    context,
                    Config.appName,
                    "Error occur",
                    "OK",
                    () {
                      Navigator.of(context).pop();
                    },
                  );
                }
              });
            }
          },
                  btnColor: HexColor("#283B71"),
                  borderColor: Colors.black12,
                  borderRadius: 10))
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  static Widget imgPicker(
      bool isImageSelected, String fileName, Function onFilePicked) {
    Future<XFile?> _imageFile;
    ImagePicker _picker = ImagePicker();

    return Column(
      children: [
        fileName.isNotEmpty
            ? isImageSelected
                ? Image.file(
                    File(fileName),
                    height: 150,
                    width: 150,
                  )
                : SizedBox(
                    child: Image.network(
                      fileName,
                      width: 150,
                      height: 150,
                      fit: BoxFit.scaleDown,
                    ),
                  )
            : SizedBox(
                child: Image.network(
                  "https://www.ncenet.com/wp-content/uploads/2020/04/no-image-png-2.png",
                  width: 150,
                  height: 150,
                  fit: BoxFit.scaleDown,
                ),
              ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 35,
                width: 35,
                child: IconButton(
                  onPressed: () {
                    _imageFile = _picker.pickImage(source: ImageSource.gallery);
                    _imageFile.then((file) async {
                      onFilePicked(file);
                    });
                  },
                  icon: Icon(
                    Icons.image,
                    size: 35,
                  ),
                  padding: EdgeInsets.all(0),
                ),
              ),
              SizedBox(
                height: 35,
                width: 35,
                child: IconButton(
                  onPressed: () {
                    _imageFile = _picker.pickImage(source: ImageSource.camera);
                    _imageFile.then((file) async {
                      onFilePicked(file);
                    });
                  },
                  icon: Icon(
                    Icons.camera,
                    size: 35,
                  ),
                  padding: EdgeInsets.all(0),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
