import 'package:holo_task/core/usecase/usecase.dart';
import 'package:holo_task/features/plp/domain/entities/product.dart';
import 'package:holo_task/features/plp/domain/repositories/product_repository.dart';

class GetProduct implements UseCase<Product?, int> {
  final ProductRepository repository;

  GetProduct(this.repository);

  @override
  Future<Product?> call(int id) {
    return repository.getProductById(id);
  }
}

class GetProductParams {
  final int id;

  const GetProductParams({required this.id});
}
