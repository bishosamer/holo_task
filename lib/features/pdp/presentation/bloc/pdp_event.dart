part of 'pdp_bloc.dart';

abstract class PdpEvent extends Equatable {
  const PdpEvent();

  @override
  List<Object> get props => [];
}

class PdpRequested extends PdpEvent {
  final int id;
  const PdpRequested({required this.id});

  @override
  List<Object> get props => [id];
}
