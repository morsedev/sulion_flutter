import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sulion_app/src/shared/infra/client.dart';
import 'package:sulion_app/src/feature/product_detail/page/product_detail_page.dart';

import '../../../core/shared/data/model/product_model.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product>? _productList;

  Future<void> _getProducts() async {
    final productResponse = await ClientImpl().products();
    final List<dynamic> productList = jsonDecode(productResponse.body);
    final products = List<Product>.from(productList.map((product) {
      final Product p = Product(
        name: product['name'],
        description: product['description'],
        image: product['image'],
      );
      return p;
    }));
    log(productList.toString());
    _productList = products;
    setState(() {});
  }

  @override
  void initState() {
    _getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              // childAspectRatio: 4 / 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: _productList?.length,
          itemBuilder: ((context, index) {
            final product = _productList?[index];
            if (product != null) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: product),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(product.image), fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 60,
                        child: ColoredBox(
                          color: Colors.black12,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  product.description,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return null;
          }),
        ),
      ),
    );
  }
}
