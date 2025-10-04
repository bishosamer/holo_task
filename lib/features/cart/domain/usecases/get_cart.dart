import 'package:holo_task/core/usecase/usecase.dart';
import 'package:holo_task/features/cart/domain/entities/cart.dart';
import 'package:holo_task/features/cart/domain/repositories/cart_repository.dart';

class GetCart implements UseCase<Cart, NoParams> {
  final CartRepository repository;

  GetCart(this.repository);

  @override
  Future<Cart> call(NoParams params) async {
    return await repository.getCart();
  }
}
