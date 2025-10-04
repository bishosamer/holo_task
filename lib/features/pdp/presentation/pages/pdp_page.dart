import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holo_task/core/design_system/app_colors.dart';
import 'package:holo_task/core/design_system/app_spacing.dart';
import 'package:holo_task/features/pdp/presentation/bloc/pdp_bloc.dart';
import 'package:holo_task/di/injection_container.dart';

class PdpArgs {
  final int productId;
  const PdpArgs({required this.productId});
}

class PdpPage extends StatelessWidget {
  final PdpArgs args;
  const PdpPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PdpBloc>(
      create: (context) => sl<PdpBloc>()..add(PdpRequested(id: args.productId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Product Details')),
        body: BlocBuilder<PdpBloc, PdpState>(
          builder: (context, state) {
            return switch (state) {
              PdpInitial() => const Center(child: CircularProgressIndicator()),
              PdpLoading() => const Center(child: CircularProgressIndicator()),
              PdpSuccess(product: final product) => SingleChildScrollView(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: AppColors.grey100,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusLg),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusLg),
                          child: Image.network(
                            product.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: AppColors.grey200,
                              child: Icon(
                                Icons.image_not_supported,
                                color: AppColors.grey400,
                                size: AppSpacing.iconXxl,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: AppSpacing.xl),
                      // Product Title
                      Text(
                        product.title,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      SizedBox(height: AppSpacing.md),
                      // Product Category
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusSm),
                        ),
                        child: Text(
                          product.category,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      SizedBox(height: AppSpacing.lg),
                      // Product Price
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: AppSpacing.lg),
                      // Product Description
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(height: AppSpacing.sm),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              height: 1.6,
                            ),
                      ),
                      SizedBox(height: AppSpacing.xxxl),
                      // Add to Cart Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement add to cart
                          },
                          style: ElevatedButton.styleFrom(
                            padding:
                                EdgeInsets.symmetric(vertical: AppSpacing.lg),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              PdpFailure(message: final message) => Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: AppSpacing.iconXxl,
                          color: AppColors.error,
                        ),
                        SizedBox(height: AppSpacing.lg),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: AppSpacing.lg),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<PdpBloc>()
                                .add(PdpRequested(id: args.productId));
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
