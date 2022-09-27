import 'package:equatable/equatable.dart';

///Product in main
class Product extends Equatable{
  final String name;
  const Product(this.name);
  @override
  List<Object?> get props => [name];
}
