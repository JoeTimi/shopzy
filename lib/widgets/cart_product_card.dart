import 'package:flutter/material.dart';
import 'package:shopzy/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopzy/models/models.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard({
    super.key,
    required this.product,
    required this.quantity,
  });

  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            product.imageUrl,
            width: 100,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '\$${product.price}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const CircularProgressIndicator();
              } else if (state is CartLoaded) {
                return Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () {
                        context.read<CartBloc>().add(
                              RemoveProduct(product),
                            );
                      },
                    ),
                    Text(
                      '$quantity',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      onPressed: () {
                        context.read<CartBloc>().add(
                              AddProduct(product),
                            );
                      },
                    ),
                  ],
                );
              } else {
                return const Text('Error loading cart');
              }
            },
          ),
        ],
      ),
    );
  }
}
