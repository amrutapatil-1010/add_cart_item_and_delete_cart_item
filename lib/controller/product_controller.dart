import 'package:add_cart_test/api_provider.dart';

import 'package:get/get.dart';

import '../model/get_add_to_cart_items.dart';
import '../model/get_product_model.dart';

class ProductScreenController extends GetxController {
  bool isShowDialog = false;

  ///To save the all product data
  List<ProductData> productList = [];

  ///To save the cart items
  List<AddToCarts> cartList = [];
  List<AddToCarts> _listCartItems = [];
  int totalProductsInCart = 0;
  @override
  onInit() async {
    //Call API  get the cart list and product list
    await callCartListApi();
    await callProductListApi();

    super.onInit();
  }

  callProductListApi() async {
    List<ProductData> _productList = [];
    await ApiProvider().getProductList().then((value) {
      _productList = value ?? [];
    });

    for (int i = 0; i < _productList.length; i++) {
      _productList[i].productCount = cartList
          .firstWhereOrNull(
              (element) => element.productId == _productList[i].sId)
          ?.countOfTheProduct;
      productList.add(_productList[i]);
    }
    update();
  }

//API call for add to cart
  void addToCartItem(String productId, int index) async {
    //to show the loader
    isShowDialog = true;
    String? response = '';
    await ApiProvider().addToCartAPI(productId).then((value) {
      response = value;
    });
    //Need to update the cart list once product is added to cart,So calling cartListAPi
    await callCartListApi(index: index, productId: productId);
  }

  callCartListApi(
      {int? index, String? productId, bool? isDeleteFromCart}) async {
    isShowDialog = true;
    update();
    await ApiProvider().getCartItems().then((value) {
      _listCartItems = value ?? [];
    });
    //Need to update the cartItem count in Product screen - This condition is added
    if (productId != null) {
      int changeProductCountIndex =
          productList.indexWhere((element) => element.sId == productId);
      //To add or delete the cart items count in product screen
      if (isDeleteFromCart == true) {
        productList[changeProductCountIndex].productCount =
            (productList[changeProductCountIndex].productCount ?? 0) - 1;
      } else {
        productList[changeProductCountIndex].productCount =
            (productList[changeProductCountIndex].productCount ?? 0) + 1;
      }
    } else if (index != null) {
      productList[index].productCount =
          (productList[index].productCount ?? 0) + 1;
    }

    setCartItems();
  }

//delete API call
  void deleteDartItem(String productId, int index,
      {bool? isDeleteFromCart = false}) async {
    isShowDialog = true;
    var getCartItem = _listCartItems
            .firstWhere((element) => element.productId == productId)
            .sId ??
        '';

    String status = '';
    await ApiProvider()
        .deleteCartItemAPI(cartItemId: getCartItem)
        .then((value) => status = value);

    if (status == "addToCart deleted successfully") {
      if (isDeleteFromCart == true) {
        //if you are deleting item from cart screen, productId and isDeleteFromCart value should be passed in callCartListApi()
        callCartListApi(
            productId: productId, isDeleteFromCart: isDeleteFromCart);
      } else if (productList[index].productCount! > 0) {
        callCartListApi();
        productList[index].productCount = productList[index].productCount! - 1;
      }
    }

    update();
  }

//Set the values (cart item list)
  void setCartItems() {
    totalProductsInCart = 0;
    cartList.clear();
    for (AddToCarts newItem in _listCartItems) {
      totalProductsInCart = totalProductsInCart + (newItem.quantity ?? 0);
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
    update();
  }
}
