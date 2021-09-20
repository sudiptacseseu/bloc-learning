import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cart_with_bloc_library/model/cart_item.dart';
import 'package:cart_with_bloc_library/model/product.dart';
import 'package:cart_with_bloc_library/util/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartItem> _cartItem = List.unmodifiable([]);

  CartBloc(CartState initialState) : super(initialState);

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    // Add new item or increase the quantity if already exists
    if (event is AddItemOrIncreaseQuantity) {
      // yield CartLoading();
      // await Future.delayed(Duration(seconds: 1));
      List<CartItem> tempList = List<CartItem>.from(_cartItem);
      bool exists = false;
      int index = 0;
      for (var i = 0; i < _cartItem.length; i++) {
        if (event.product.name == _cartItem[i].product.name) {
          exists = true;
          index = i;
          break;
        }
      }
      if (exists) {
        tempList[index] = CartItem(
          product: event.product,
          quantity: tempList[index].quantity + 1,
        );
        showToast(
            "Product has been added to the cart!", Colors.yellow.shade800);
      } else {
        tempList.add(
          CartItem(
            quantity: 1,
            product: event.product,
          ),
        );
        showToast(
            "Product has been added to the cart!", Colors.yellow.shade800);
      }
      _cartItem = List.unmodifiable(tempList);
      yield CartOperationSuccess(_cartItem);
    }
    // Remove item if the quantity is 1 or decrease the quantity
    else if (event is RemoveItemOrDecreaseQuantity) {
      // yield CartLoading();
      // await Future.delayed(Duration(seconds: 1));
      List<CartItem> tempList = List<CartItem>.from(_cartItem);

      int index = 0;
      for (var i = 0; i < _cartItem.length; i++) {
        if (event.product.name == _cartItem[i].product.name) {
          index = i;
          break;
        }
      }
      if (tempList[index].quantity == 1) {
        tempList.removeAt(index);
      } else {
        tempList[index] = CartItem(
          product: event.product,
          quantity: tempList[index].quantity - 1,
        );
      }
      _cartItem = List.unmodifiable(tempList);
      yield CartOperationSuccess(_cartItem);
    }
    // Delete item from cart
    else if (event is DeleteItem) {
      List<CartItem> tempList = List<CartItem>.from(_cartItem);

      int index = 0;
      for (var i = 0; i < _cartItem.length; i++) {
        if (event.product.name == _cartItem[i].product.name) {
          index = i;
          break;
        }
      }
      tempList.removeAt(index);
      showToast("Item removed from the cart!", Colors.yellow.shade800);
      _cartItem = List.unmodifiable(tempList);
      yield CartOperationSuccess(_cartItem);
    }
    // Delete the whole cart
    else if (event is DeleteCart) {
      List<CartItem> tempList = List<CartItem>.from(_cartItem);
      tempList.clear();
      _cartItem = List.unmodifiable(tempList);
      yield CartOperationSuccess(_cartItem);
    }
  }
}
