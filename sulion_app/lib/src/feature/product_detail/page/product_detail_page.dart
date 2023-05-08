import 'package:flutter/material.dart';
import 'package:sulion_app/src/shared/widgets/widgets.dart';

import '../../../core/shared/data/model/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image(
                image: NetworkImage(widget.product.image ??
                    'http://192.168.50.221/8080/images/no_photo.png'),
                fit: BoxFit.cover),
            VerticalSpacer.medium(),
            Text(widget.product.description),
          ],
        ),
      ),
    );
  }
}
