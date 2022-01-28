import 'dart:convert';
import 'dart:io';
import 'package:flutter_crud_api/config.dart';
import 'package:flutter_crud_api/models/product_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  static Future<List<ProductModel>?> getProducts() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    var url = Uri.http(Config.apiUrl, Config.productAPI);

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return productsFromJson(data['data']);
    } else {
      return null;
    }
  }

  static Future<bool> saveProduct(
    ProductModel model,
    bool isEditMode,
    bool isImageSelected,
  ) async {
    var productURL = Config.productAPI;

    if (isEditMode) {
      productURL = productURL + "/" + model.id.toString();
    }

    var url = Uri.http(Config.apiUrl, productURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["productName"] = model.productName!;
    request.fields["productPrice"] = model.productPrice!.toString();

    if (model.productImage != null && isImageSelected == true) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'productImage',
        model.productImage!,
      );

      request.files.add(multipartFile);
    }
    if (model.productImage != null && isImageSelected == false) {
      request.fields["productImage"] = model.productImage!;
    }
    print('isImageSelected: $isImageSelected');
    print('request.fields: ${request.fields["productImage"]}');
    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteProduct(productId) async {
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};
    var url = Uri.http(Config.apiUrl, Config.productAPI + '/' + productId);
    var response = await client.delete(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
