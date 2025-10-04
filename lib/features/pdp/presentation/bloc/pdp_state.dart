part of 'pdp_bloc.dart';

abstract class PdpState extends Equatable {
  const PdpState();

  @override
  List<Object> get props => [];
}

class PdpInitial extends PdpState {}

class PdpLoading extends PdpState {}

class PdpSuccess extends PdpState {
  final Product product;
  const PdpSuccess({required this.product});

  @override
  List<Object> get props => [product];
}

class PdpFailure extends PdpState {
  final String message;
  const PdpFailure({required this.message});

  @override
  List<Object> get props => [message];
}
