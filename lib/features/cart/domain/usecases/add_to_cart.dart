import 'package:holo_task/features/cart/domain/repositories/cart_repository.dart';
import 'package:holo_task/features/plp/domain/entities/product.dart';

class AddToCartParams {
  final Product product;
  final int quantity;

  AddToCartParams({
    required this.product,
    this.quantity = 1,
  });
}

class AddToCart {
  final CartRepository repository;

  AddToCart(this.repository);

  Future<void> call(AddToCartParams params) async {
    return await repository.addToCart(params.product, params.quantity);
  }
}
