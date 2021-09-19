part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddItemOrIncreaseQuantity extends CartEvent {
  final Product product;

  AddItemOrIncreaseQuantity(this.product);
}

class RemoveItemOrDecreaseQuantity extends CartEvent {
  final Product product;

  RemoveItemOrDecreaseQuantity(this.product);
}

class DeleteItem extends CartEvent {
  final Product product;

  DeleteItem(this.product);
}

class DeleteCart extends CartEvent {}
