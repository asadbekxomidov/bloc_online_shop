import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String? image;
  final bool isFavorite;

  Product({
    required this.id,
    required this.title,
    this.image,
    this.isFavorite = false,
  });

  Product copyWith({
    String? id,
    String? title,
    String? image,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [id, title, image, isFavorite];
}
