import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:holo_task/features/cart/domain/entities/cart_item.dart';
import 'package:holo_task/features/plp/data/models/product_model.dart';

part 'cart_item_model.freezed.dart';
part 'cart_item_model.g.dart';

@freezed
@HiveType(typeId: 2)
class CartItemModel with _$CartItemModel {
  const factory CartItemModel({
    @HiveField(0) required ProductModel product,
    @HiveField(1) required int quantity,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  factory CartItemModel.fromEntity(CartItem cartItem) => CartItemModel(
        product: ProductModel.fromEntity(cartItem.product),
        quantity: cartItem.quantity,
      );
}

extension CartItemModelX on CartItemModel {
  CartItem toEntity() => CartItem(
        product: product.toEntity(),
        quantity: quantity,
      );
}
