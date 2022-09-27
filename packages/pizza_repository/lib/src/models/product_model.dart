import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

///Product in repo
@HiveType(typeId: 0)
class Product extends Equatable{
  @HiveField(0)
  final String name;
  const Product(this.name);
  @override
  List<Object?> get props => [name];
}
