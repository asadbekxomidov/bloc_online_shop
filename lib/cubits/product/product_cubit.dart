import 'package:bloc/bloc.dart';
import 'package:vazifa_16/data/models/product.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  void loadProducts() {
    final products = <Product>[
      Product(
        id: '1',
        title: 'krasovka',
        image: 'https://www.jizzaxstat.uz/images/12111.png',
      ),
      Product(
        id: '2',
        title: 'kurtka',
        image: 'https://devel.prom.uz/upload/category_logos/202309/pic687.png',
      ),
      Product(
        id: '3',
        title: 'plash',
        image:
            'https://images2.zoodmall.uz/cdn-cgi/image/w=500,fit=contain,f=auto/https%3A%2F%2Fimg.joomcdn.net%2F2a0c3ad91fe34bdfb6115d9aa2f4cc5b2d4c7690_original.jpeg',
      ),
      Product(
        id: '4',
        title: 'Kastyum shim',
        image:
            'https://static.ayol.uz/crop/8/4/730_485_80_84da652d902cee3d3bc1c6cdfd6c303c.jpg',
      ),
      Product(
        id: '5',
        title: 'Mahsulot 5',
      ),
      Product(
        id: '6',
        title: 'Mahsulot 6',
      ),
    ];
    emit(ProductLoaded(products, products.where((p) => p.isFavorite).toList()));
  }

  void addProduct(Product product) {
    if (state is ProductLoaded) {
      final loadedState = state as ProductLoaded;
      final updatedProducts = List<Product>.from(loadedState.products)
        ..add(product);
      emit(ProductLoaded(updatedProducts, loadedState.favorites));
    }
  }

  void updateProduct(Product product) {
    if (state is ProductLoaded) {
      final loadedState = state as ProductLoaded;
      final updatedProducts = loadedState.products.map((existingProduct) {
        return existingProduct.id == product.id ? product : existingProduct;
      }).toList();
      final updatedFavorites =
          updatedProducts.where((product) => product.isFavorite).toList();
      emit(ProductLoaded(updatedProducts, updatedFavorites));
    }
  }

  void toggleFavorite(String id) {
    if (state is ProductLoaded) {
      final loadedState = state as ProductLoaded;
      final updatedProducts = loadedState.products.map((product) {
        return product.id == id
            ? product.copyWith(isFavorite: !product.isFavorite)
            : product;
      }).toList();
      final updatedFavorites =
          updatedProducts.where((product) => product.isFavorite).toList();
      emit(ProductLoaded(updatedProducts, updatedFavorites));
    }
  }

  void deleteProduct(String id) {
    if (state is ProductLoaded) {
      final loadedState = state as ProductLoaded;
      final updatedProducts =
          loadedState.products.where((product) => product.id != id).toList();
      emit(ProductLoaded(updatedProducts,
          updatedProducts.where((p) => p.isFavorite).toList()));
    }
  }
}
