import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  final String productName;
  final String networkImageUrl;
  final int? itemCount;
  final Function callAddToCart;
  final Function callRemoveItem;
  const ProductItemWidget(
      {required this.productName,
      required this.networkImageUrl,
      required this.itemCount,
      required this.callAddToCart,
      required this.callRemoveItem,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              productName,
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Image.network(
            networkImageUrl,
            height: 200,
          ),
          const SizedBox(
            height: 20,
          ),
          if (itemCount != null && itemCount != 0) ...[
            Container(
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      onTap: () {
                        callAddToCart();
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                  Text("$itemCount"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      onTap: () {
                        callRemoveItem();
                      },
                      child: const Icon(Icons.remove),
                    ),
                  )
                ],
              ),
            )
          ] else ...[
            InkWell(
              onTap: () {
                callAddToCart();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: const Text('Add to cart'),
              ),
            )
          ]
        ],
      ),
    );
  }
}
