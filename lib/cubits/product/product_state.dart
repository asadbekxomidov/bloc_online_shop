import 'package:equatable/equatable.dart';
import 'package:vazifa_16/data/models/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> favorites;

  const ProductLoaded(this.products, this.favorites);

  @override
  List<Object> get props => [products, favorites];
}
