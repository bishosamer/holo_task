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
import 'package:holo_task/features/plp/presentation/bloc/plp_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(ProductModelAdapter());

  // Open boxes
  final productBox = await Hive.openBox<ProductModel>('products');

  // External dependencies
  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        baseUrl: 'https://fakestoreapi.com', // Using fakestoreapi for demo
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      )));

  // Data sources
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(box: productBox));
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(dio: sl()));

  // Repositories
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        local: sl(),
        remote: sl(),
      ));

  // Use cases
  sl.registerFactory<GetProducts>(() => GetProducts(sl()));

  // Blocs
  sl.registerFactory<PlpBloc>(() => PlpBloc(getProducts: sl()));
}
