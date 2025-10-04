import 'package:holo_task/features/cart/domain/entities/cart.dart';
import 'package:holo_task/features/plp/domain/entities/product.dart';

abstract class CartRepository {
  Future<Cart> getCart();
  Future<void> addToCart(Product product, [int quantity = 1]);
  Future<void> removeFromCart(int productId);
  Future<void> updateQuantity(int productId, int quantity);
  Future<void> clearCart();
}
