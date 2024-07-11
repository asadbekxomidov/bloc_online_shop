import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa_16/cubits/product/product_cubit.dart';
import 'package:vazifa_16/cubits/product/product_state.dart';
import 'package:vazifa_16/views/ui/widgets/product_add_dialog_widget.dart';
import 'dart:math';

class ProductListScreen extends StatefulWidget {
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Mahsulotlar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                final Color randomColor = _getRandomColor();
                return ListTile(
                  title: Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  leading: product.image != null && product.image!.isNotEmpty
                      ? SizedBox(
                          width: 60,
                          height: 45,
                          child: Image.network(
                            product.image!,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60,
                                height: 45,
                                color: randomColor,
                                child: Icon(Icons.error),
                              );
                            },
                          ),
                        )
                      : Container(
                          width: 60,
                          height: 45,
                          decoration: BoxDecoration(
                            color: randomColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: product.isFavorite
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 20,
                              )
                            : Icon(
                                Icons.favorite_border,
                                size: 20,
                              ),
                        onPressed: () {
                          context
                              .read<ProductCubit>()
                              .toggleFavorite(product.id);
                        },
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(Icons.edit, size: 20, color: Colors.blue),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AddProductDialog(product: product);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  onLongPress: () {
                    context.read<ProductCubit>().deleteProduct(product.id);
                  },
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.teal, Colors.blue, Colors.purple.shade500])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  // Navigator.pushReplacementNamed(context, '/productScreen');
                },
                icon: Icon(
                  Icons.home,
                  size: 25,
                  color: Colors.white,
                )),
            IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {},
                icon: Icon(
                  Icons.person_2_outlined,
                  size: 25,
                  color: Colors.white,
                )),
            IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/favoriteScreen');
                },
                icon: Icon(
                  Icons.favorite_outline,
                  size: 25,
                  color: Colors.white,
                )),
            IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/settingsScreen');
                },
                icon: Icon(
                  Icons.settings,
                  size: 25,
                  color: Colors.white,
                )),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Color.fromARGB(255, 30, 175, 175),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddProductDialog();
            },
          );
        },
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }

  static Color _getRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }
}
