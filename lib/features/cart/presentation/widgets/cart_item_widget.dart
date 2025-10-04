import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holo_task/core/design_system/app_colors.dart';
import 'package:holo_task/core/design_system/app_spacing.dart';
import 'package:holo_task/di/injection_container.dart';
import 'package:holo_task/features/cart/domain/entities/cart_item.dart';
import 'package:holo_task/features/cart/presentation/bloc/cart_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.grey100,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                child: Image.network(
                  cartItem.product.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.grey200,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: AppColors.grey400,
                      size: AppSpacing.iconMd,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),

            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    cartItem.product.category,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${cartItem.totalPrice.toStringAsFixed(2)}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      // Quantity Controls
                      Row(
                        children: [
                          // Decrease Button
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.grey300),
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                            child: IconButton(
                              onPressed: cartItem.quantity > 1
                                  ? () {
                                      sl<CartBloc>().add(
                                        UpdateQuantityRequested(
                                          productId: cartItem.product.id,
                                          quantity: cartItem.quantity - 1,
                                        ),
                                      );
                                    }
                                  : null,
                              icon: Icon(
                                Icons.remove,
                                size: AppSpacing.iconSm,
                                color: cartItem.quantity > 1
                                    ? AppColors.textPrimary
                                    : AppColors.grey400,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: AppSpacing.iconLg,
                                minHeight: AppSpacing.iconLg,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          // Quantity
                          Text(
                            '${cartItem.quantity}',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          // Increase Button
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.grey300),
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                            child: IconButton(
                              onPressed: () {
                                sl<CartBloc>().add(
                                  UpdateQuantityRequested(
                                    productId: cartItem.product.id,
                                    quantity: cartItem.quantity + 1,
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.add,
                                size: AppSpacing.iconSm,
                                color: AppColors.textPrimary,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: AppSpacing.iconLg,
                                minHeight: AppSpacing.iconLg,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Remove Button
            IconButton(
              onPressed: () {
                var bloc = sl<CartBloc>();
                bloc.add(
                  RemoveFromCartRequested(productId: cartItem.product.id),
                );
              },
              icon: const Icon(
                Icons.delete_outline,
                color: AppColors.error,
                size: AppSpacing.iconMd,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
