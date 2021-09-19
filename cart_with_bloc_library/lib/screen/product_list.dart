import 'package:cart_with_bloc_library/bloc/cart_bloc.dart';
import 'package:cart_with_bloc_library/data/dummy_product_list.dart';
import 'package:cart_with_bloc_library/screen/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        actionsIconTheme: IconThemeData(
          color: Colors.black87,
        ),
        title: Text(
          "Products",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_basket),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cart(),
                        maintainState: true,
                      ));
                },
              ),
              Positioned(
                right: 8,
                top: 4,
                child: BlocBuilder<CartBloc, CartState>(
                    bloc: BlocProvider.of<CartBloc>(context),
                    builder: (context, cartState) {
                      if (cartState is CartOperationSuccess &&
                          cartState.cartItems.length > 0)
                        return Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${cartState.cartItems.length}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        );
                      else {
                        return Container();
                      }
                    }),
              ),
            ],
          )
        ],
      ),
      body: ListView.builder(
          itemCount: DummyProductList.products.length,
          itemBuilder: (context, index) {
            final product = DummyProductList.products[index];
            return ListTile(
              leading: Container(
                height: 50,
                width: 50,
                child: CircleAvatar(
                  radius: double.infinity,
                  backgroundImage: NetworkImage(product.image),
                ),
              ),
              title: Text(product.name),
              subtitle: Text("\$${product.price}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(AddItemOrIncreaseQuantity(product));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.black12,
                      ),
                      child: Icon(
                        Icons.add,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(RemoveItemOrDecreaseQuantity(product));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.black12,
                      ),
                      child: Icon(
                        Icons.remove,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
