import 'package:equatable/equatable.dart';

abstract class PlpEvent extends Equatable {
  const PlpEvent();

  @override
  List<Object?> get props => [];
}

class PlpRequested extends PlpEvent {
  const PlpRequested();
}
