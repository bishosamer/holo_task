import 'package:holo_task/features/cart/domain/repositories/cart_repository.dart';

class UpdateQuantityParams {
  final int productId;
  final int quantity;

  UpdateQuantityParams({
    required this.productId,
    required this.quantity,
  });
}

class UpdateQuantity {
  final CartRepository repository;

  UpdateQuantity(this.repository);

  Future<void> call(UpdateQuantityParams params) async {
    return await repository.updateQuantity(params.productId, params.quantity);
  }
}
