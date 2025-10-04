import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:holo_task/features/cart/domain/entities/cart.dart';
import 'cart_item_model.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
@HiveType(typeId: 3)
class CartModel with _$CartModel {
  const factory CartModel({
    @HiveField(0) @Default([]) List<CartItemModel> items,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  factory CartModel.fromEntity(Cart cart) => CartModel(
        items:
            cart.items.map((item) => CartItemModel.fromEntity(item)).toList(),
      );
}

extension CartModelX on CartModel {
  Cart toEntity() => Cart(
        items: items.map((item) => item.toEntity()).toList(),
      );
}
