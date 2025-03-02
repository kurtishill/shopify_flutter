import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopify_flutter/shopify_flutter.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);
  final Product product;

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  late Product product;

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  Future<void> fetchProductDetails() async {
    final shopifyStore = ShopifyStore.instance;
    final productDetails = await shopifyStore.getProductsByIds([product.id]);
    for (final Product productDetails in (productDetails ?? [])) {
      final variants = productDetails.productVariants;
      for (var variant in variants) {
        log('Variant SellingPlanAllocation: ${variant.sellingPlanAllocations}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          IconButton(
            onPressed: fetchProductDetails,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          product.images.isNotEmpty
              ? Image.network(
                  product.images.first.originalSrc,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.cover,
                )
              : Container(),
          Column(
            children: _buildProductVariants(),
          )
        ],
      ),
    );
  }

  List<Widget> _buildProductVariants() {
    List<Widget> widgetList = [];
    for (var variant in product.productVariants) {
      widgetList.add(
        ListTile(
          title: Text(variant.title),
          // trailing: Text(variant.price.amount.toString()),
          trailing: Text(variant.price.formattedPriceWithLocale('en_US')),
        ),
      );
    }
    return widgetList;
  }
}
