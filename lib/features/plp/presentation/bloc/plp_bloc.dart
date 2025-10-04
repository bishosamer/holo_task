import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:holo_task/core/usecase/usecase.dart';
import 'package:holo_task/features/plp/domain/usecases/get_products.dart';

import 'plp_event.dart';
import 'plp_state.dart';

class PlpBloc extends Bloc<PlpEvent, PlpState> {
  final GetProducts getProducts;

  PlpBloc({required this.getProducts}) : super(const PlpInitial()) {
    on<PlpRequested>(_onPlpRequested);
  }

  Future<void> _onPlpRequested(
      PlpRequested event, Emitter<PlpState> emit) async {
    emit(const PlpLoading());
    try {
      final products = await getProducts(const NoParams());
      emit(PlpSuccess(products));
    } catch (e) {
      emit(PlpFailure(e.toString()));
    }
  }
}
