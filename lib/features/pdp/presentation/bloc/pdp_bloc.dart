import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holo_task/features/plp/domain/entities/product.dart';
import 'package:holo_task/features/plp/domain/usecases/get_product.dart';

part 'pdp_event.dart';
part 'pdp_state.dart';

class PdpBloc extends Bloc<PdpEvent, PdpState> {
  final GetProduct getProduct;

  PdpBloc({required this.getProduct}) : super(PdpInitial()) {
    on<PdpRequested>(_onPdpRequested);
  }

  Future<void> _onPdpRequested(
      PdpRequested event, Emitter<PdpState> emit) async {
    emit(PdpLoading());
    try {
      final product = await getProduct(event.id);
      if (product != null) {
        emit(PdpSuccess(product: product));
      } else {
        emit(const PdpFailure(message: 'Product not found'));
      }
    } catch (e) {
      emit(PdpFailure(message: e.toString()));
    }
  }
}
