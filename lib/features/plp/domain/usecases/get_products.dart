import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts implements UseCase<List<Product>, NoParams> {
  final ProductRepository repository;
  GetProducts(this.repository);

  @override
  Future<List<Product>> call(NoParams params) {
    return repository.getProducts();
  }
}
