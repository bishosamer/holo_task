import 'package:holo_task/features/cart/domain/repositories/cart_repository.dart';

class ClearCart {
  final CartRepository repository;

  ClearCart(this.repository);

  Future<void> call() async {
    return await repository.clearCart();
  }
}
