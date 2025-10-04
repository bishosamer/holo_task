import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:holo_task/features/plp/domain/entities/product.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required Product product,
    required int quantity,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

extension CartItemX on CartItem {
  double get totalPrice => product.price * quantity;
}
