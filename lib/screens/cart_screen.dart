import 'package:fashionstore/Providers/Cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart_screen";
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 22,
                    )),
                const Text(
                  "Your Cart",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Expanded(
              child: CartItemsList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Price",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  Text(
                      "\$${Provider.of<Cart>(context).totalAmount.roundToDouble()}",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const FullSizeButton(),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class FullSizeButton extends StatelessWidget {
  const FullSizeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(7),
        ),
        child: const Center(
          child: Text(
            "Payment",
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class CartItemsList extends StatelessWidget {
  const CartItemsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Cart>(context);
    final cart = data.items();

    return ListView.builder(
        itemCount: cart.length,
        padding: const EdgeInsets.only(bottom: 20),
        itemBuilder: ((context, index) => CartItemWidget(
            index: index,
            id: cart[index].productId,
            quantity: cart[index].quantity,
            title: cart[index].title,
            size: cart[index].size,
            price: cart[index].price,
            color: cart[index].color,
            imageUrl: cart[index].imageUrl)));
  }
}

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    Key? key,
    required this.index,
    required this.id,
    required this.title,
    required this.size,
    required this.quantity,
    required this.price,
    required this.color,
    required this.imageUrl,
  }) : super(key: key);
  final int index;
  final String id;
  final String title;
  final int quantity;
  final String size;
  final double price;
  final Color color;
  final String imageUrl;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  bool showSizeOptions = false;
  bool showColorOptions = false;
  @override
  Widget build(BuildContext context) {
    int count = Provider.of<Cart>(context).items()[widget.index].quantity;
    return Dismissible(
      // Dismissible is used to provide delete by swipe option
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          // delete operation
        } else if (direction == DismissDirection.startToEnd) {
          //add to wishlist operation
        } else {}
        Provider.of<Cart>(context, listen: false).removeItem(widget.id);
      },
      key: ValueKey(widget.id),
      secondaryBackground: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.centerRight,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[200],
          child: const Icon(
            Icons.delete,
            color: Colors.black,
            size: 20,
          ),
        ),
      ),
      background: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.centerLeft,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[200],
          child: const Icon(
            Icons.favorite,
            color: Colors.black,
            size: 20,
          ),
        ),
      ),

      //  before deleting the product or adding to wishlist, we will confirm it by opening a dialog box
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          //if swiped to delete
          return dialogBox(context);
        }

        //if swiped to add to wishlist, we will not show dialog box
        return Future(
          () => true,
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      color: Colors.brown[50],
                      margin: const EdgeInsets.only(right: 18),
                      padding: const EdgeInsets.all(10),
                      child: Image.network(
                        widget.imageUrl,
                        color: Colors.brown[50],
                        colorBlendMode: BlendMode.multiply,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 160,
                                    child: Text(
                                      widget.title,
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 12.4,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.6),
                                    ),
                                  ),
                                  Text(
                                    "\$ ${widget.price}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Size:  ",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showSizeOptions = !showSizeOptions;
                                          });
                                        },
                                        child: Text(
                                          widget.size,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Color:  ",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showColorOptions =
                                                !showColorOptions;
                                          });
                                        },
                                        child: Container(
                                          height: 16,
                                          width: 16,
                                          decoration: BoxDecoration(
                                              color: widget.color,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                  width: 0.3,
                                                  color: Colors.black)),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          if (count > 1) {
                                            count--;
                                            Provider.of<Cart>(context,
                                                    listen: false)
                                                .quantityMinus(widget.id);
                                          }
                                          if (count == 1) {
                                            //remove the product if user decreases the quantiy below 1
                                            bool? l = await dialogBox(context);
                                            //show confirmation dialog box before removing
                                            if (l != null && l == true) {
                                              Provider.of<Cart>(context,
                                                      listen: false)
                                                  .removeItem(widget.id);
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 23,
                                          width: 23,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 0.5,
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(1)),
                                          child: const Center(child: Text("-")),
                                        ),
                                      ),
                                      Container(
                                        width: 30,
                                        child: Center(
                                          child: Text(
                                            "${widget.quantity}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          count++;
                                          Provider.of<Cart>(context,
                                                  listen: false)
                                              .quantityPlus(widget.id);
                                        },
                                        child: Container(
                                          height: 23,
                                          width: 23,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 0.5,
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(1)),
                                          child: const Center(child: Text("+")),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                showSizeOptions
                    ? Container(
                        padding: EdgeInsets.only(left: 100, top: 15),
                        child: Row(children: [
                          sizeChangeButton("S", widget.id),
                          sizeChangeButton("M", widget.id),
                          sizeChangeButton("L", widget.id),
                          sizeChangeButton("XL", widget.id),
                        ]),
                      )
                    : Container(),
                showColorOptions
                    ? Container(
                        padding: EdgeInsets.only(left: 100, top: 15),
                        child: Row(children: [
                          colorChangeButton(Color(0XFF033213), widget.id),
                          colorChangeButton(Color(0XFF770623), widget.id),
                          colorChangeButton(Color(0XFF060677), widget.id),
                          colorChangeButton(Colors.white, widget.id),
                          colorChangeButton(Colors.black, widget.id),
                        ]),
                      )
                    : Container(),
              ],
            ),
          ),
          Divider(
            thickness: 0.4,
            color: Colors.grey[400],
          )
        ],
      ),
    );
  }

  GestureDetector sizeChangeButton(String size, String id) {
    return GestureDetector(
        onTap: () {
          Provider.of<Cart>(context, listen: false).changeSize(id, size);
          setState(() {
            showSizeOptions = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 14,
            child: Text(
              size,
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
        ));
  }

  GestureDetector colorChangeButton(Color color, String id) {
    return GestureDetector(
        onTap: () {
          Provider.of<Cart>(context, listen: false).changeColor(id, color);
          setState(() {
            showColorOptions = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 0.4, color: Colors.blueGrey)),
          ),
        ));
  }

  Future<bool?> dialogBox(BuildContext context) {
    return showDialog(
      barrierColor: Colors.black54,
      context: context,
      builder: (ctx) => AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        content: Container(
          height: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Move from Bag",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Are you sure you want to move this item from bag?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: Container(
                        width: (double.infinity / 2),
                        color: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        child: const Center(
                          child: Text(
                            "REMOVE",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: Container(
                        width: (double.infinity / 2),
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 9),
                        child: const Center(
                          child: Text(
                            "ADD TO WISHLIST",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
