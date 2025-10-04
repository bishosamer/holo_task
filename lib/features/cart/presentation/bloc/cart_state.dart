part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  final Cart cart;

  const CartState({required this.cart});

  @override
  List<Object> get props => [cart];
}

class CartInitial extends CartState {
  const CartInitial({required super.cart});
}

class CartLoading extends CartState {
  const CartLoading({required super.cart});
}

class CartLoaded extends CartState {
  const CartLoaded({required super.cart});
}

class CartError extends CartState {
  final String message;

  const CartError({required super.cart, required this.message});

  @override
  List<Object> get props => [cart, message];
}
