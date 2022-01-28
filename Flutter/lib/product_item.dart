import 'package:flutter/material.dart';
import 'package:flutter_crud_api/models/product_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key, this.model, this.onDelete}) : super(key: key);

  final ProductModel? model;
  final Function? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        color: Colors.black12,
        child: ListTile(
          leading: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 70,
              minHeight: 70,
              maxWidth: 70,
              maxHeight: 70,
            ),
            child: Image.network(
              (model!.productImage == null || model!.productImage == "")
                  ? "https://www.ncenet.com/wp-content/uploads/2020/04/no-image-png-2.png"
                  : model!.productImage!,
              height: 70,
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
            ),
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model!.productName!,
                style: TextStyle(
                    color: Colors.white54, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "₺${model!.productPrice!}",
                style: TextStyle(color: Colors.white54),
              ),
              SizedBox(height: 10),
            ],
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Icon(
                  Icons.edit,
                  color: Colors.blueGrey,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/edit-product',
                    arguments: {'model': model},
                  );
                },
              ),
              GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
                onTap: () {
                  onDelete!(model);
                },
              ),
            ],
          ),
          // child: Padding(
          //   padding: const EdgeInsets.all(5.0),
          //   child: productWidget(context),
          // ),
        ),
      ),
    );
  }

  Widget productWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          alignment: Alignment.center,
          margin: EdgeInsets.all(5),
          child: Image.network(
            (model!.productImage == null || model!.productImage == "")
                ? "https://coffeecrew.com.tr/wp-content/uploads/2019/06/03_coffee.jpg"
                : model!.productImage!,
            height: 70,
            fit: BoxFit.scaleDown,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model!.productName!,
                  style: TextStyle(
                      color: Colors.white54, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "₺${model!.productPrice!}",
                  style: TextStyle(color: Colors.white54),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          height: 80,
          width: MediaQuery.of(context).size.width * 0.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                child: Icon(Icons.edit),
                onTap: () {},
              ),
              GestureDetector(
                child: Icon(Icons.delete),
                onTap: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
