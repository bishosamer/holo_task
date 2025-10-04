import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:holo_task/features/main/presentation/pages/main_page.dart';
import 'package:holo_task/features/profile/presentation/pages/profile_page.dart';
import 'package:holo_task/features/plp/presentation/pages/plp_page.dart';
import 'package:holo_task/features/pdp/presentation/pages/pdp_page.dart';
import 'package:holo_task/features/plp/presentation/bloc/plp_bloc.dart';
import 'package:holo_task/features/plp/presentation/bloc/plp_event.dart';
import 'package:holo_task/di/injection_container.dart';

class AppRoutes {
  static const String products = '/products';
  static const String profile = '/profile';
  static const String pdp = '/pdp/:id';

  static final GoRouter router = GoRouter(
    initialLocation: products,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            path: products,
            builder: (context, state) => BlocProvider<PlpBloc>(
              create: (_) => sl<PlpBloc>()..add(const PlpRequested()),
              child: const PlpPage(),
            ),
          ),
          GoRoute(
            path: profile,
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
      GoRoute(
        path: pdp,
        builder: (context, state) {
          final productId =
              int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
          return PdpPage(args: PdpArgs(productId: productId));
        },
      ),
    ],
  );
}
