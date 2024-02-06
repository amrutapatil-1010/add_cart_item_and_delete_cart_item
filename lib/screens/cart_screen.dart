import 'package:add_cart_test/controller/product_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  final ProductScreenController controller =
      Get.find<ProductScreenController>();
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductScreenController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Welcome to Cart"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: controller.isShowDialog
                ? const Align(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 40),
                    itemCount: controller.cartList.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      //Note
                      //Image Url is not coming properly from cart API, thus displaying description instead of Image
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text("${controller.cartList[index].description}"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 30,
                                  width: 100,
                                  margin: const EdgeInsets.only(
                                      top: 20, bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: InkWell(
                                          onTap: () {
                                            controller.addToCartItem(
                                                controller.cartList[index]
                                                        .productId ??
                                                    "",
                                                index);
                                          },
                                          child: const Icon(Icons.add),
                                        ),
                                      ),
                                      Text(
                                          "${controller.cartList[index].countOfTheProduct}"),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: InkWell(
                                          onTap: () {
                                            controller.deleteDartItem(
                                                controller.cartList[index]
                                                        .productId ??
                                                    '',
                                                index,
                                                isDeleteFromCart: true);
                                          },
                                          child: const Icon(Icons.remove),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
          ));
    });
  }
}
