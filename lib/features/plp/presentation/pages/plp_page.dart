import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:holo_task/core/design_system/app_spacing.dart';
import 'package:holo_task/features/plp/presentation/bloc/plp_bloc.dart';
import 'package:holo_task/features/plp/presentation/bloc/plp_state.dart';
import 'package:holo_task/features/plp/presentation/widgets/product_shimmer.dart';
import 'package:holo_task/features/plp/presentation/widgets/product_tile.dart';

class PlpPage extends StatelessWidget {
  const PlpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: BlocBuilder<PlpBloc, PlpState>(
        builder: (context, state) {
          return switch (state) {
            PlpInitial() => const ProductShimmer(),
            PlpLoading() => const ProductShimmer(),
            PlpSuccess(products: final products) => GridView.builder(
                padding: const EdgeInsets.all(AppSpacing.lg),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: AppSpacing.sm,
                  mainAxisSpacing: AppSpacing.lg,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductTile(product: product);
                },
              ),
            PlpFailure(message: final message) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
