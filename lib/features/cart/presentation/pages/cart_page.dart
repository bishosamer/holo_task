import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holo_task/core/design_system/app_colors.dart';
import 'package:holo_task/core/design_system/app_spacing.dart';
import 'package:holo_task/di/injection_container.dart';
import 'package:holo_task/features/cart/domain/entities/cart.dart';
import 'package:holo_task/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:holo_task/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:holo_task/features/cart/presentation/widgets/empty_cart_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return switch (state) {
            CartInitial() => const Center(child: CircularProgressIndicator()),
            CartLoading() => const Center(child: CircularProgressIndicator()),
            CartLoaded(cart: final cart) => cart.items.isEmpty
                ? const EmptyCartWidget()
                : Column(
                    children: [
                      // Cart Items
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          itemCount: cart.items.length,
                          itemBuilder: (context, index) {
                            final cartItem = cart.items[index];
                            return CartItemWidget(cartItem: cartItem);
                          },
                        ),
                      ),
                      // Cart Summary
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        decoration: const BoxDecoration(
                          color: AppColors.surface,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadow,
                              offset: Offset(0, -2),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Total
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total (${cart.itemCount} items)',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  '\$${cart.totalPrice.toStringAsFixed(2)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            // Checkout Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Checkout functionality coming soon!'),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: AppSpacing.lg),
                                ),
                                child: Text(
                                  'Proceed to Checkout',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: AppColors.textOnPrimary,
                                        //    fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            CartError(message: final message) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: AppSpacing.iconXxl,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      ElevatedButton(
                        onPressed: () {
                          sl<CartBloc>().add(CartRequested());
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
    );
  }
}
