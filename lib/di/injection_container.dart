import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:holo_task/features/plp/data/datasources/product_local_datasource.dart';
import 'package:holo_task/features/plp/data/datasources/product_remote_datasource.dart';
import 'package:holo_task/features/plp/data/models/product_model.dart';
import 'package:holo_task/features/plp/data/repositories/product_repository_impl.dart';
import 'package:holo_task/features/plp/domain/repositories/product_repository.dart';
import 'package:holo_task/features/plp/domain/usecases/get_products.dart';
import 'package:holo_task/features/plp/domain/usecases/get_product.dart';
import 'package:holo_task/features/plp/presentation/bloc/plp_bloc.dart';
import 'package:holo_task/features/pdp/presentation/bloc/pdp_bloc.dart';

// Cart dependencies
import 'package:holo_task/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:holo_task/features/cart/data/models/cart_item_model.dart';
import 'package:holo_task/features/cart/data/models/cart_model.dart';
import 'package:holo_task/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:holo_task/features/cart/domain/repositories/cart_repository.dart';
import 'package:holo_task/features/cart/domain/usecases/get_cart.dart';
import 'package:holo_task/features/cart/domain/usecases/add_to_cart.dart';
import 'package:holo_task/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:holo_task/features/cart/domain/usecases/update_quantity.dart';
import 'package:holo_task/features/cart/domain/usecases/clear_cart.dart';
import 'package:holo_task/features/cart/presentation/bloc/cart_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(CartItemModelAdapter());
  Hive.registerAdapter(CartModelAdapter());

  // Open boxes
  final productBox = await Hive.openBox<ProductModel>('products');
  final cartBox = await Hive.openBox<CartModel>('cart');

  // External dependencies
  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        baseUrl: 'https://fakestoreapi.com',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      )));

  // Data sources
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(box: productBox));
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<CartLocalDataSource>(
      () => CartLocalDataSourceImpl(box: cartBox));

  // Repositories
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        local: sl(),
        remote: sl(),
      ));
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(
        local: sl(),
      ));

  // Use cases
  sl.registerFactory<GetProducts>(() => GetProducts(sl()));
  sl.registerFactory<GetProduct>(() => GetProduct(sl()));
  sl.registerFactory<GetCart>(() => GetCart(sl()));
  sl.registerFactory<AddToCart>(() => AddToCart(sl()));
  sl.registerFactory<RemoveFromCart>(() => RemoveFromCart(sl()));
  sl.registerFactory<UpdateQuantity>(() => UpdateQuantity(sl()));
  sl.registerFactory<ClearCart>(() => ClearCart(sl()));

  // Blocs
  sl.registerFactory<PlpBloc>(() => PlpBloc(getProducts: sl()));
  sl.registerFactory<PdpBloc>(() => PdpBloc(getProduct: sl()));
  sl.registerLazySingleton<CartBloc>(() => CartBloc(
        getCart: sl(),
        addToCart: sl(),
        removeFromCart: sl(),
        updateQuantity: sl(),
        clearCart: sl(),
      ));
}
