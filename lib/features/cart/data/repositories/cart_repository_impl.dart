import 'package:holo_task/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:holo_task/features/cart/domain/entities/cart.dart';
import 'package:holo_task/features/cart/domain/repositories/cart_repository.dart';
import 'package:holo_task/features/plp/domain/entities/product.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource local;

  CartRepositoryImpl({required this.local});

  @override
  Future<Cart> getCart() async {
    return await local.getCart();
  }

  @override
  Future<void> addToCart(Product product, [int quantity = 1]) async {
    return await local.addToCart(product, quantity);
  }

  @override
  Future<void> removeFromCart(int productId) async {
    return await local.removeFromCart(productId);
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    return await local.updateQuantity(productId, quantity);
  }

  @override
  Future<void> clearCart() async {
    return await local.clearCart();
  }
}
