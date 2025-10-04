import 'package:hive/hive.dart';
import 'package:holo_task/features/cart/data/models/cart_model.dart';
import 'package:holo_task/features/cart/domain/entities/cart.dart';
import 'package:holo_task/features/cart/domain/entities/cart_item.dart';
import 'package:holo_task/features/plp/domain/entities/product.dart';

abstract class CartLocalDataSource {
  Future<Cart> getCart();
  Future<void> saveCart(Cart cart);
  Future<void> addToCart(Product product, int quantity);
  Future<void> removeFromCart(int productId);
  Future<void> updateQuantity(int productId, int quantity);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<CartModel> box;

  CartLocalDataSourceImpl({required this.box});

  @override
  Future<Cart> getCart() async {
    final cartModel = box.get('cart') ?? const CartModel();
    return cartModel.toEntity();
  }

  @override
  Future<void> saveCart(Cart cart) async {
    final cartModel = CartModel.fromEntity(cart);
    await box.put('cart', cartModel);
  }

  @override
  Future<void> addToCart(Product product, int quantity) async {
    final currentCart = await getCart();
    final existingItemIndex = currentCart.items.indexWhere(
      (item) => item.product.id == product.id,
    );

    List<CartItem> updatedItems = List.from(currentCart.items);

    if (existingItemIndex != -1) {
      // Update existing item quantity
      final existingItem = updatedItems[existingItemIndex];
      updatedItems[existingItemIndex] = CartItem(
        product: existingItem.product,
        quantity: existingItem.quantity + quantity,
      );
    } else {
      // Add new item
      updatedItems.add(CartItem(product: product, quantity: quantity));
    }

    final updatedCart = Cart(items: updatedItems);
    await saveCart(updatedCart);
  }

  @override
  Future<void> removeFromCart(int productId) async {
    final currentCart = await getCart();
    final updatedItems = currentCart.items
        .where(
          (item) => item.product.id != productId,
        )
        .toList();

    final updatedCart = Cart(items: updatedItems);
    await saveCart(updatedCart);
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    if (quantity <= 0) {
      return removeFromCart(productId);
    }

    final currentCart = await getCart();
    final updatedItems = currentCart.items.map((item) {
      if (item.product.id == productId) {
        return CartItem(product: item.product, quantity: quantity);
      }
      return item;
    }).toList();

    final updatedCart = Cart(items: updatedItems);
    await saveCart(updatedCart);
  }

  @override
  Future<void> clearCart() async {
    await box.delete('cart');
  }
}
