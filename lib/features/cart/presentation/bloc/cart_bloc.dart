import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holo_task/core/usecase/usecase.dart';
import 'package:holo_task/features/cart/domain/entities/cart.dart';
import 'package:holo_task/features/cart/domain/usecases/get_cart.dart';
import 'package:holo_task/features/cart/domain/usecases/add_to_cart.dart';
import 'package:holo_task/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:holo_task/features/cart/domain/usecases/update_quantity.dart';
import 'package:holo_task/features/cart/domain/usecases/clear_cart.dart';
import 'package:holo_task/features/plp/domain/entities/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCart getCart;
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final UpdateQuantity updateQuantity;
  final ClearCart clearCart;

  CartBloc({
    required this.getCart,
    required this.addToCart,
    required this.removeFromCart,
    required this.updateQuantity,
    required this.clearCart,
  }) : super(const CartInitial(cart: Cart())) {
    on<CartRequested>(_onCartRequested);
    on<AddToCartRequested>(_onAddToCartRequested);
    on<RemoveFromCartRequested>(_onRemoveFromCartRequested);
    on<UpdateQuantityRequested>(_onUpdateQuantityRequested);
    on<ClearCartRequested>(_onClearCartRequested);
  }

  Future<void> _onCartRequested(
      CartRequested event, Emitter<CartState> emit) async {
    emit(CartLoading(cart: state.cart));
    try {
      final cart = await getCart(NoParams());
      emit(CartLoaded(cart: cart));
    } catch (e) {
      emit(CartError(cart: state.cart, message: e.toString()));
    }
  }

  Future<void> _onAddToCartRequested(
      AddToCartRequested event, Emitter<CartState> emit) async {
    try {
      await addToCart(AddToCartParams(
        product: event.product,
        quantity: event.quantity,
      ));
      final cart = await getCart(NoParams());
      emit(CartLoaded(cart: cart));
    } catch (e) {
      emit(CartError(cart: state.cart, message: e.toString()));
    }
  }

  Future<void> _onRemoveFromCartRequested(
      RemoveFromCartRequested event, Emitter<CartState> emit) async {
    try {
      await removeFromCart(event.productId);
      final cart = await getCart(const NoParams());
      emit(CartLoaded(cart: cart));
    } catch (e) {
      emit(CartError(cart: state.cart, message: e.toString()));
    }
  }

  Future<void> _onUpdateQuantityRequested(
      UpdateQuantityRequested event, Emitter<CartState> emit) async {
    try {
      await updateQuantity(UpdateQuantityParams(
        productId: event.productId,
        quantity: event.quantity,
      ));
      final cart = await getCart(NoParams());
      emit(CartLoaded(cart: cart));
    } catch (e) {
      emit(CartError(cart: state.cart, message: e.toString()));
    }
  }

  Future<void> _onClearCartRequested(
      ClearCartRequested event, Emitter<CartState> emit) async {
    try {
      await clearCart();
      final cart = await getCart(NoParams());
      emit(CartLoaded(cart: cart));
    } catch (e) {
      emit(CartError(cart: state.cart, message: e.toString()));
    }
  }
}
