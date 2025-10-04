import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource local;
  final ProductRemoteDataSource remote;

  ProductRepositoryImpl({
    required this.local,
    required this.remote,
  });

  @override
  Future<List<Product>> getProducts() async {
    try {
      // Try to get from remote first
      final products = await remote.getProducts();
      // Cache the products
      await local.cacheProducts(products);
      return products;
    } catch (e) {
      // If remote fails, try to get from cache
      final cachedProducts = await local.getCachedProducts();
      if (cachedProducts.isNotEmpty) {
        return cachedProducts;
      }
      // If no cache available, rethrow the error
      rethrow;
    }
  }

  @override
  Future<Product?> getProductById(int id) async {
    try {
      // Try cache first
      final cachedProduct = await local.getCachedProductById(id);
      if (cachedProduct != null) {
        return cachedProduct;
      }

      // If not in cache, try remote
      final product = await remote.getProductById(id);
      // Cache the product
      await local.cacheProduct(product);
      return product;
    } catch (e) {
      // If both fail, return null
      return null;
    }
  }
}
