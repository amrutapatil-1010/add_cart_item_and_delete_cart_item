import 'package:add_cart_test/controller/product_controller.dart';
import 'package:add_cart_test/model/get_add_to_cart_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  ProductScreenController controller = Get.put(ProductScreenController());
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductScreenController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Welcome to Cart"),
            // actions: [
            //   Stack(
            //     children: [
            //       const Align(
            //         alignment: Alignment.center,
            //         child: Icon(
            //           Icons.shopping_bag_outlined,
            //           size: 60,
            //         ),
            //       ),
            //       Positioned(
            //           bottom: 0,
            //           right: 20,
            //           left: 20,
            //           top: 35,
            //           child: Text(
            //             "10",
            //             style: Theme.of(context)
            //                 .primaryTextTheme
            //                 .bodyLarge
            //                 ?.copyWith(fontSize: 15, height: 0.5),
            //           ))
            //     ],
            //   )
            // ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.cartList.length,
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
                              // Image.network(
                              //   // controller.cartList[index].productImage?.first
                              //   //        ??
                              //   "",
                              //   height: 200,
                              // ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                  index);
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
                      })
                ],
              ),
            ),
          ));
    });
  }
}
