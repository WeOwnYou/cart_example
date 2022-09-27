part of 'bottom_nav_bar_bloc.dart';

abstract class BottomNavBarEvent {
  const BottomNavBarEvent();
}

class LoadDataEvent extends BottomNavBarEvent {}

class AddProductToCartEvent extends BottomNavBarEvent{
  final Product product;
  const AddProductToCartEvent(this.product);
}

class RemoveProductFromCartEvent extends BottomNavBarEvent{
  final Product product;
  const RemoveProductFromCartEvent(this.product);
}

class RemoveProductAt extends BottomNavBarEvent {
  final int index;
  const RemoveProductAt(this.index);
}

class ClearProductCartEvent extends BottomNavBarEvent {}
