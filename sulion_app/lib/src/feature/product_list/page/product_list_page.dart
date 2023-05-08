import 'package:flutter/material.dart';
import 'package:sulion_app/src/shared/base/page/base_page.dart';
import 'package:sulion_app/src/feature/product_detail/page/product_detail_page.dart';

import '../../../core/shared/data/model/product_model.dart';

class ProductListPage extends BasePage {
  const ProductListPage({
    super.key,
    required this.getProducts,
    required this.state,
  });

  final Function() getProducts;
  final Stream<List<Product>> state;
  // Future<void> _getProducts() async {
  //   final productResponse = await ClientImpl().products();
  // final List<dynamic> productList = jsonDecode(productResponse.body);
  //   final products = List<Product>.from(productList.map((product) {
  //     final Product p = Product(
  //       name: product['name'],
  //       description: product['description'],
  //       image: product['image'],
  //     );
  //     return p;
  //   }));
  //   log(productList.toString());
  //   _productList = products;
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   _getProducts();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    getProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      floatingActionButton: ElevatedButton(
        child: const Text('Siguiente página'),
        onPressed: getProducts,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<List<Product>>(
          stream: state,
          builder: (context, snapshot) {
            List<Product> productList = [];
            if (snapshot.hasData) {
              productList = snapshot.data!;
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  // childAspectRatio: 4 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: productList.length,
              itemBuilder: ((context, index) {
                final product = productList[index];
                if (product != null) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailPage(product: product),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: product.image != null
                            ? DecorationImage(
                                image: NetworkImage(product.image ??
                                    'http://192.168.50.221/8080/images/no_photo.png'),
                                fit: BoxFit.cover)
                            : null,
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
            );
          },
        ),
      ),
    );
  }
}
