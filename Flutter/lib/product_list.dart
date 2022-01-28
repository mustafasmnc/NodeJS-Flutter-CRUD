import 'package:flutter/material.dart';
import 'package:flutter_crud_api/api_service.dart';
import 'package:flutter_crud_api/models/product_model.dart';
import 'package:flutter_crud_api/product_item.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  //List<ProductModel> products = List<ProductModel>.empty(growable: true);
  bool isAPICallProcess = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // products.add(ProductModel(
    //     id: "1",
    //     productName: "Black Coffee",
    //     productImage:
    //         "https://cdn.shopify.com/s/files/1/0956/1562/t/4/assets/feature1.jpg?v=5414907588513961946",
    //     productPrice: 14.9));
    // products.add(ProductModel(
    //     id: "2",
    //     productName: "Turkish Coffee",
    //     productImage:
    //         "https://www.vartur.com/files/How-to-make-Turkish-Coffee-2-11158-Edit-3.jpg",
    //     productPrice: 19.9));
  }

  Widget loadProducts() {
    return FutureBuilder(
      future: APIService.getProducts(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<ProductModel>?> model,
      ) {
        if (model.hasData) {
          return productList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget productList(products) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: Colors.green,
                minimumSize: Size(88, 36),
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/add-product");
              },
              child: Text("Add Product")),
          ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              //scrollDirection: Axis.vertical,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductItem(
                    model: products[index],
                    onDelete: (ProductModel model) {
                      setState(() {
                        isAPICallProcess = true;
                      });
                      APIService.deleteProduct(model.id).then((response) {
                        setState(() {
                          isAPICallProcess = false;
                        });
                      });
                    });
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NodeJS MongoDB CRUD'),
        elevation: 0,
        backgroundColor: Colors.grey[600],
      ),
      body: ProgressHUD(
        opacity: 0.3,
        key: UniqueKey(),
        inAsyncCall: isAPICallProcess,
        child: loadProducts(),
      ),
    );
  }
}
