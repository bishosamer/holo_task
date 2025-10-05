import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holo_task/features/cart/domain/usecases/get_cart.dart';
import 'package:holo_task/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:holo_task/routes/app_routes.dart';
import 'package:holo_task/di/injection_container.dart';
import 'package:holo_task/core/design_system/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<CartBloc>()..add(CartRequested())),
      ],
      child: MaterialApp.router(
        title: 'Holo Task',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
