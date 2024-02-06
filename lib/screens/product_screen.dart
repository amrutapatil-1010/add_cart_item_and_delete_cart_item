import 'package:add_cart_test/controller/product_controller.dart';
import 'package:add_cart_test/model/get_add_to_cart_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cart_screen.dart';

class ProductScreen extends GetView<ProductScreenController> {
  ProductScreenController controller = Get.put(ProductScreenController());
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
                  Get.to(CartScreen());
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
                        top: 35,
                        child: Text(
                          "10",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 15, height: 0.5),
                        ))
                  ],
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: SingleChildScrollView(
              child: controller.isShowDialog == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.productList.length,
                            itemBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return Container(
                                height: 300,
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
                                    Image.network(
                                      controller.productList[index].productImage
                                              ?.first ??
                                          "",
                                      height: 200,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        if (controller.productList[index]
                                                    .productCount !=
                                                0 &&
                                            controller.productList[index]
                                                    .productCount !=
                                                null)
                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: InkWell(
                                                    onTap: () {
                                                      controller.addToCartItem(
                                                          controller
                                                                  .productList[
                                                                      index]
                                                                  .sId ??
                                                              '',
                                                          index);
                                                    },
                                                    child:
                                                        const Icon(Icons.add),
                                                  ),
                                                ),
                                                Text(
                                                    "${controller.productList[index].productCount}"),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: InkWell(
                                                    onTap: () {
                                                      controller.deleteDartItem(
                                                          controller
                                                                  .productList[
                                                                      index]
                                                                  .sId ??
                                                              '',
                                                          index);
                                                    },
                                                    child: const Icon(
                                                        Icons.remove),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        InkWell(
                                          onTap: () {
                                            controller.addToCartItem(
                                                controller.productList[index]
                                                        .sId ??
                                                    '',
                                                index);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            child: Text('Add to cart'),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            })
                      ],
                    ),
            ),
          ));
    });
  }
}
