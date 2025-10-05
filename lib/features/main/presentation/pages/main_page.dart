import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:holo_task/routes/app_routes.dart';
import 'package:holo_task/features/cart/domain/entities/cart.dart';
import 'package:holo_task/features/cart/presentation/bloc/cart_bloc.dart';

class MainPage extends StatelessWidget {
  final Widget child;

  const MainPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      //   floatingActionButton:
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCurrentIndex(context),
        onTap: (index) => _onTap(context, index),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                int itemCount = 0;
                itemCount = state.cart.itemCount;

                return Stack(
                  children: [
                    SizedBox(
                      width: 50,
                      //  height: ,
                      child: Icon(Icons.shopping_cart,
                          color: _getCurrentIndex(context) == 1
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).iconTheme.color),
                    ),
                    if (state is CartLoaded && state.cart.isNotEmpty)
                      Positioned(
                        right: 0,
                        top: -3,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 15,
                            minHeight: 15,
                          ),
                          child: Text(
                            '$itemCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            label: 'Cart',
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.products)) {
      return 0;
    } else if (location.startsWith(AppRoutes.cart)) {
      return 1;
    }
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.products);
        break;
      case 1:
        context.go(AppRoutes.cart);
        break;
    }
  }
}
