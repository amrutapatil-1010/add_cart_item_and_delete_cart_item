import 'package:add_cart_test/controller/product_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../product_item_widget.dart';
import 'cart_screen.dart';

class ProductScreen extends GetView<ProductScreenController> {
  @override
 final ProductScreenController controller = Get.put(ProductScreenController());
  ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductScreenController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Welcome to Amazon"),
            actions: [
              InkWell(
                onTap: () {
                  Get.to(() => CartScreen());
                },
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: 60,
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 20,
                        left: 20,
                        top: 20,
                        child: FittedBox(
                          child: Container(
                            child: Text(
                              "${controller.totalProductsInCart}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 15, height: 0),
                            ),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: controller.isShowDialog == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.productList.length,
                    padding: const EdgeInsets.only(bottom: 30),
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      return ProductItemWidget(
                        productName:
                            controller.productList[index].productsName ?? '',
                        networkImageUrl:
                            controller.productList[index].productImage?.first ??
                                '',
                        itemCount: controller.productList[index].productCount,
                        callAddToCart: () {
                          controller.addToCartItem(
                              controller.productList[index].sId ?? '', index);
                        },
                        callRemoveItem: () {
                          controller.deleteDartItem(
                              controller.productList[index].sId ?? '', index);
                        },
                      );
                    }),
          ));
    });
  }
}
