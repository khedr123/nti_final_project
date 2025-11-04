import 'package:nti_final_project/features/home/data/model/product.dart';

class CartItem {
  final ProductModel product;
  final int quantity;

  CartItem({required this.product, required this.quantity});

  CartItem copyWith({int? quantity}) {
    return CartItem(product: product, quantity: quantity ?? this.quantity);
  }
}

class CartState {
  final Map<String, CartItem> items;

  const CartState(this.items);

  factory CartState.initial() => const CartState({});

  double get subtotal =>
      items.values.fold(0.0, (s, i) => s + (i.product.price * i.quantity));
}
