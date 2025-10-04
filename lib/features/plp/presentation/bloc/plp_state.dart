import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

abstract class PlpState extends Equatable {
  const PlpState();

  @override
  List<Object?> get props => [];
}

class PlpInitial extends PlpState {
  const PlpInitial();
}

class PlpLoading extends PlpState {
  const PlpLoading();
}

class PlpSuccess extends PlpState {
  final List<Product> products;

  const PlpSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class PlpFailure extends PlpState {
  final String message;

  const PlpFailure(this.message);

  @override
  List<Object?> get props => [message];
}
