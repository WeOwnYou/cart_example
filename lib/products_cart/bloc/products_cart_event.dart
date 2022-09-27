part of 'products_cart_bloc.dart';

abstract class ProductCartEvent {
  const ProductCartEvent();
}

class CartStatusChangedEvent extends ProductCartEvent {
  final CartStorageStatus status;
  const CartStatusChangedEvent(this.status);
}

class RemoveProductFromCartEvent extends ProductCartEvent {
  final Product product;
  const RemoveProductFromCartEvent(this.product);
}

class RemoveProductAt extends ProductCartEvent {
  final int index;
  const RemoveProductAt(this.index);
}

class ClearProductCartEvent extends ProductCartEvent {}
