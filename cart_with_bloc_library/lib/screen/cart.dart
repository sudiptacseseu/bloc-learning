import 'package:cart_with_bloc_library/bloc/cart_bloc.dart';
import 'package:cart_with_bloc_library/model/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        actionsIconTheme: IconThemeData(
          color: Colors.black87,
        ),
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        title: Text(
          "Cart",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.delete_forever),
        //     onPressed: () {
        //       BlocProvider.of<CartBloc>(context)
        //           .add(DeleteCart());
        //       Fluttertoast.showToast(
        //           msg: "Cart removed!",
        //           toastLength: Toast.LENGTH_SHORT,
        //           gravity: ToastGravity.BOTTOM,
        //           backgroundColor: Colors.yellow.shade800,
        //           textColor: Colors.white,
        //           fontSize: 15.0);
        //     },
        //   ),
        // ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        bloc: BlocProvider.of<CartBloc>(context),
        builder: (context, cartState) {
          if (cartState is CartOperationSuccess &&
              cartState.cartItems.length > 0) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartState.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartState.cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8.0),
                        child: Card(
                          elevation: 0.5,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      cartItem.product.name,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<CartBloc>(context)
                                            .add(DeleteItem(cartItem.product));
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.black45,
                                        size: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${cartItem.quantity}x\$${cartItem.product.price}",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black45,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 2.0,
                                        ),
                                        Text(
                                          "\$${cartItem.quantity * cartItem.product.price}",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<CartBloc>(context)
                                                .add(
                                                    RemoveItemOrDecreaseQuantity(
                                                        cartItem.product));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              color: Colors.black26,
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              size: 23,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.only(
                                              bottom: 2, right: 12, left: 12),
                                          child: Text(
                                            "${cartItem.quantity}",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<CartBloc>(context)
                                                .add(AddItemOrIncreaseQuantity(
                                                    cartItem.product));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              color: Colors.black26,
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              size: 23,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  "Total Price :  \$${calculatePrice(cartState.cartItems)}",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 24.0),
              ],
            );
          } else if (cartState is CartLoading) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text("No items in the cart yet! Please add first!"),
              ),
            );
          }
        },
      ),
    );
  }

  int calculatePrice(List<CartItem> cartItems) {
    int result = 0;
    cartItems.forEach((element) {
      result += (element.quantity * element.product.price);
    });
    return result;
  }
}
