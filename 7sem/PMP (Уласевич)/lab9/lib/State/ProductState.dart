import 'package:equatable/equatable.dart';
import 'package:lab9/Product.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}