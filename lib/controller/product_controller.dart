import 'dart:convert';

import 'package:add_cart_test/model/add_product_response.dart';
import 'package:add_cart_test/screens/cart_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/get_add_to_cart_items.dart';
import '../model/get_product_model.dart';
import 'package:http/http.dart' as http;

class ProductScreenController extends GetxController {
  bool isShowDialog = false;
  List<ProductData> productList = [];
  String addResponseData = "";
  String deleteResponsedata = "";
  List<AddToCarts> cartList = [];
  List<AddToCarts> _listCartItems = [];
  @override
  onInit() async {
    await callCartListApi();

    await callProductListApi();

    super.onInit();
  }

  callProductListApi() async {
    var response = await http.get(
        Uri.parse("http://103.160.107.21:3000/auth/products-getall"),
        headers: {
          "authorization":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InBhdGlsYW1ydXRhMTA5OUBnbWFpbC5jb20iLCJyb2xlIjoidXNlciIsImlkIjoiNjVjMGU0NjNiMWQyNDU4ZDg3NTNmNWM4IiwibmFtZVVzZXIiOiJhbXJ1dGEiLCJpYXQiOjE3MDcxODc3MTgsImV4cCI6MTcwNzIxNjUxOH0.2ly3UarmZTzoRZRyhGrgwQGEuXnLzgt6OQbJFg_fKek"
        });
    print(response.body);
    var _productList =
        GetProductModel.fromJson(const JsonDecoder().convert(response.body))
                .data ??
            [];
    for (int i = 0; i < _productList.length; i++) {
      _productList[i].productCount = cartList
          .firstWhereOrNull(
              (element) => element.productId == _productList[i].sId)
          ?.countOfTheProduct;
      productList.add(_productList[i]);
    }
    update();
  }

  void addToCartItem(String productId, int index) async {
    isShowDialog = true;
    var response = await http.post(
        Uri.parse(
          "http://103.160.107.21:3000/auth/add-to-cart",
        ),
        headers: {
          "Content-Type": "application/json",
          "authorization":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InBhdGlsYW1ydXRhMTA5OUBnbWFpbC5jb20iLCJyb2xlIjoidXNlciIsImlkIjoiNjVjMGU0NjNiMWQyNDU4ZDg3NTNmNWM4IiwibmFtZVVzZXIiOiJhbXJ1dGEiLCJpYXQiOjE3MDcxODc3MTgsImV4cCI6MTcwNzIxNjUxOH0.2ly3UarmZTzoRZRyhGrgwQGEuXnLzgt6OQbJFg_fKek"
        },
        body: json.encode({"product_id": productId, "quantity": 1}));

    addResponseData =
        AddProductResponse.fromJson(const JsonDecoder().convert(response.body))
                .message ??
            '';
    callCartListApi(index: index);

    update();
  }

  callCartListApi({ProductData? productModel, int? index}) async {
    _listCartItems.clear();
    isShowDialog = true;
    var response = await http.get(
      Uri.parse(
        "http://103.160.107.21:3000/auth/add-to-cart-get-all",
      ),
      headers: {
        "Content-Type": "application/json",
        "authorization":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InBhdGlsYW1ydXRhMTA5OUBnbWFpbC5jb20iLCJyb2xlIjoidXNlciIsImlkIjoiNjVjMGU0NjNiMWQyNDU4ZDg3NTNmNWM4IiwibmFtZVVzZXIiOiJhbXJ1dGEiLCJpYXQiOjE3MDcxODc3MTgsImV4cCI6MTcwNzIxNjUxOH0.2ly3UarmZTzoRZRyhGrgwQGEuXnLzgt6OQbJFg_fKek"
      },
    );
    if (response.statusCode == 200) {
      _listCartItems =
          GetAddToCartItems.fromJson(JsonDecoder().convert(response.body))
                  .addToCarts ??
              [];
    }
    if (index != null) {
      productList[index].productCount = productList[index].productCount! + 1;
    }

    getListOfCartItems();

    update();
  }

  void deleteDartItem(String productId, int index) async {
    // callCartListApi();
    isShowDialog = true;
    var getCartItemTobeDeleted = _listCartItems
            .firstWhere((element) => element.productId == productId)
            .sId ??
        '';
    print(getCartItemTobeDeleted);

    var response = await http.delete(
        Uri.parse(
          "http://103.160.107.21:3000/auth/add-to-cart-delete",
        ),
        headers: {
          "Content-Type": "application/json",
          "authorization":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InBhdGlsYW1ydXRhMTA5OUBnbWFpbC5jb20iLCJyb2xlIjoidXNlciIsImlkIjoiNjVjMGU0NjNiMWQyNDU4ZDg3NTNmNWM4IiwibmFtZVVzZXIiOiJhbXJ1dGEiLCJpYXQiOjE3MDcxODc3MTgsImV4cCI6MTcwNzIxNjUxOH0.2ly3UarmZTzoRZRyhGrgwQGEuXnLzgt6OQbJFg_fKek"
        },
        body: json.encode({"addToCartId": "$getCartItemTobeDeleted"}));
    deleteResponsedata =
        AddProductResponse.fromJson(const JsonDecoder().convert(response.body))
                .message ??
            "";
    if (response.statusCode == 200) {
      callCartListApi();
      print("deleted success $index");
      if (productList[index].productCount! > 0) {
        productList[index].productCount = productList[index].productCount! - 1;
      }
    }
    isShowDialog = false;
    update();
  }

  void getListOfCartItems() {
    int sum = 0;
    cartList.clear();
    for (AddToCarts newItem in _listCartItems) {
      sum = sum + (newItem.quantity ?? 0);
      // Check if the product ID already exists in the cartList
      bool productExists = false;

      for (int i = 0; i < cartList.length; i++) {
        if (cartList[i].productId == newItem.productId) {
          // Product already exists, update the quantity
          cartList[i].updateQuantity(
              cartList[i].countOfTheProduct! + newItem.quantity!);
          productExists = true;
          break;
        }
      }

      // If the product does not exist in cartList, add it
      if (!productExists) {
        newItem.updateQuantity(newItem.countOfTheProduct! + newItem.quantity!);

        cartList.add(newItem);
      }
    }
    isShowDialog = false;
    print("total quantity--> $sum");

    update();
  }
}
