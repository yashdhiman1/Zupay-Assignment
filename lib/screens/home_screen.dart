import 'package:fashionstore/Providers/products.dart';
import 'package:fashionstore/screens/cart_screen.dart';
import 'package:fashionstore/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SizedBox(
          height: height,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 2,
                              width: 20,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 2,
                              width: 10,
                              color: Colors.black,
                            )
                          ],
                        ),
                        const Icon(
                          Icons.search,
                          size: 25,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "New Arrival",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Expanded(
                      child: ProductsGrid(),
                    ),
                    Container(
                      height: 110,
                    )
                  ],
                ),
              ),
              BottomNavBar(width: width)
            ],
          ),
        ));
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      width: width,
      height: 110,
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        color: Colors.white,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 110,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.home_outlined,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Home")
                ]),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
                child: Container(
                  height: 45,
                  width: 100,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.grey,
                        ),
                        // Text("Home")
                      ]),
                ),
              )
            ]),
      ),
    );
  }
}

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  late Future _productsFuture;
  @override
  void initState() {
    _productsFuture =
        Provider.of<Products>(context, listen: false).fetchAndSetProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _productsFuture,
        builder: (ctx, snapshotData) {
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else {
            if (snapshotData.error != null) {
              return const Center(
                child: Text("An error occured!"),
              );
            } else {
              final productsData = Provider.of<Products>(context);
              final products = productsData.items;
              return GridView.builder(
                  itemCount: products.length,
                  padding: const EdgeInsets.only(bottom: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 1 / 1.6),
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: products[index],
                      child: const ProductItem(),
                    );
                  });
            }
          }
        });
  }
}
