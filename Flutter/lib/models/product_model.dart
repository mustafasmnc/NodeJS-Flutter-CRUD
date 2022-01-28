List<ProductModel> productsFromJson(dynamic str) =>
    List<ProductModel>.from((str).map((x) => ProductModel.fromJson(x)));

class ProductModel {
  late String? id;
  late String? productName;
  late String? productDesc;
  late int? productPrice;
  late String? productImage;

  ProductModel({
    this.id,
    this.productName,
    this.productDesc,
    this.productPrice,
    this.productImage,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    productName = json['productName'];
    productDesc = json['productDesc'];
    productPrice = json['productPrice'];
    productImage = json['productImage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['productName'] = productName;
    _data['productDesc'] = productDesc;
    _data['productPrice'] = productPrice;
    _data['productImage'] = productImage;
    return _data;
  }
}