import 'package:hive/hive.dart';

import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getCachedProducts();
  Future<Product?> getCachedProductById(int id);
  Future<void> cacheProducts(List<Product> products);
  Future<void> cacheProduct(Product product);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Box<ProductModel> box;

  ProductLocalDataSourceImpl({required this.box});

  @override
  Future<List<Product>> getCachedProducts() async {
    return box.values.map((productModel) => productModel.toEntity()).toList();
  }

  @override
  Future<Product?> getCachedProductById(int id) async {
    final productModel = box.get(id);
    return productModel?.toEntity();
  }

  @override
  Future<void> cacheProducts(List<Product> products) async {
    final productModels =
        products.map((product) => ProductModel.fromEntity(product)).toList();

    final Map<int, ProductModel> productsMap = {
      for (final product in productModels) product.id: product,
    };

    await box.putAll(productsMap);
  }

  @override
  Future<void> cacheProduct(Product product) async {
    final productModel = ProductModel.fromEntity(product);
    await box.put(product.id, productModel);
  }
}
