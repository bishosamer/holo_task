import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:holo_task/features/plp/presentation/pages/plp_page.dart';
import 'package:holo_task/features/pdp/presentation/pages/pdp_page.dart';
import 'package:holo_task/features/plp/presentation/bloc/plp_bloc.dart';
import 'package:holo_task/features/plp/presentation/bloc/plp_event.dart';
import 'package:holo_task/di/injection_container.dart';

class AppRoutes {
  static const String plp = '/plp';
  static const String pdp = '/pdp/:id';

  static final GoRouter router = GoRouter(
    initialLocation: plp,
    routes: <GoRoute>[
      GoRoute(
        path: plp,
        builder: (context, state) => BlocProvider<PlpBloc>(
          create: (_) => sl<PlpBloc>()..add(const PlpRequested()),
          child: const PlpPage(),
        ),
      ),
      GoRoute(
        path: pdp,
        builder: (context, state) {
          final productId = state.pathParameters['id'] ?? '';
          return PdpPage(args: PdpArgs(productId: int.parse(productId)));
        },
      ),
    ],
  );
}
