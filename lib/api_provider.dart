import 'dart:convert';
import 'package:add_cart_test/access_token.dart';
import 'package:http/http.dart' as http;
import 'model/add_product_response.dart';
import 'model/get_add_to_cart_items.dart';
import 'model/get_product_model.dart';

class ApiProvider {
  Future<List<ProductData>?> getProductList() async {
    var response = await http.get(
        Uri.parse("http://103.160.107.21:3000/auth/products-getall"),
        headers: {"authorization": accessToken});

    return GetProductModel.fromJson(const JsonDecoder().convert(response.body))
        .data;
  }

  Future<String?> addToCartAPI(String productId) async {
    var response = await http.post(
        Uri.parse(
          "http://103.160.107.21:3000/auth/add-to-cart",
        ),
        headers: {
          "Content-Type": "application/json",
          "authorization": accessToken
        },
        body: json.encode({"product_id": productId, "quantity": 1}));
    if (response.statusCode == 200) {
      return AddProductResponse.fromJson(
                  const JsonDecoder().convert(response.body))
              .message ??
          '';
    }
    return null;
  }

  Future<List<AddToCarts>?> getCartItems() async {
    var response = await http.get(
      Uri.parse(
        "http://103.160.107.21:3000/auth/add-to-cart-get-all",
      ),
      headers: {
        "Content-Type": "application/json",
        "authorization": accessToken
      },
    );
    if (response.statusCode == 200) {
      return GetAddToCartItems.fromJson(JsonDecoder().convert(response.body))
              .addToCarts ??
          [];
    }
    return null;
  }

  Future<String> deleteCartItemAPI({required String cartItemId}) async {
    var response = await http.delete(
        Uri.parse(
          "http://103.160.107.21:3000/auth/add-to-cart-delete",
        ),
        headers: {
          "Content-Type": "application/json",
          "authorization": accessToken
        },
        body: json.encode({"addToCartId": "$cartItemId"}));

    return AddProductResponse.fromJson(
                const JsonDecoder().convert(response.body))
            .message ??
        "";
  }
}
