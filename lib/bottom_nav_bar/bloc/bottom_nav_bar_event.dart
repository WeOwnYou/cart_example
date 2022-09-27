part of 'bottom_nav_bar_bloc.dart';

abstract class BottomNavBarEvent {
  const BottomNavBarEvent();
}

class LoadDataEvent extends BottomNavBarEvent {}

class AddProductToCartEvent extends BottomNavBarEvent {
  final Product product;
  const AddProductToCartEvent(this.product);
}

class CartStatusChangedEvent extends BottomNavBarEvent {
  final CartStorageStatus status;
  const CartStatusChangedEvent(this.status);
}

class CartEntriesRemoved extends BottomNavBarEvent {}
