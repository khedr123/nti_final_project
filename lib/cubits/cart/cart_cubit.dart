import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_final_project/features/home/data/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  static const _cartKey = 'cart_items';
  final SharedPreferences _prefs;

  CartCubit(this._prefs) : super(CartState.initial()) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    try {
      final String? jsonStr = _prefs.getString(_cartKey);
      if (jsonStr != null) {
        final Map<String, dynamic> json = jsonDecode(jsonStr);
        final items = Map<String, CartItem>.from(
          json.map(
            (key, value) => MapEntry(
              key,
              CartItem(
                product: ProductModel.fromJson(value['product']),
                quantity: value['quantity'],
              ),
            ),
          ),
        );
        emit(CartState(items));
      }
    } catch (e) {
      print('Error loading cart: $e');
    }
  }

  Future<void> _saveCart() async {
    try {
      final json = state.items.map(
        (key, item) => MapEntry(key, {
          'product': {
            'id': item.product.id,
            'name': item.product.name,
            'description': item.product.description,
            'imageUrl': item.product.imageUrl,
            'price': item.product.price,
            'stock': item.product.stock,
          },
          'quantity': item.quantity,
        }),
      );
      await _prefs.setString(_cartKey, jsonEncode(json));
    } catch (e) {
      print('Error saving cart: $e');
    }
  }

  void addProduct(ProductModel p) {
    final items = Map<String, CartItem>.from(state.items);
    if (items.containsKey(p.id)) {
      items[p.id] = items[p.id]!.copyWith(quantity: items[p.id]!.quantity + 1);
    } else {
      items[p.id] = CartItem(product: p, quantity: 1);
    }
    emit(CartState(items));
    _saveCart();
  }

  void removeProduct(String id) {
    final items = Map<String, CartItem>.from(state.items);
    items.remove(id);
    emit(CartState(items));
    _saveCart();
  }

  void increment(String id) {
    final items = Map<String, CartItem>.from(state.items);
    if (!items.containsKey(id)) return;
    items[id] = items[id]!.copyWith(quantity: items[id]!.quantity + 1);
    emit(CartState(items));
    _saveCart();
  }

  void decrement(String id) {
    final items = Map<String, CartItem>.from(state.items);
    if (!items.containsKey(id)) return;
    final current = items[id]!;
    if (current.quantity > 1) {
      items[id] = current.copyWith(quantity: current.quantity - 1);
    } else {
      items.remove(id);
    }
    emit(CartState(items));
    _saveCart();
  }

  void clear() {
    emit(const CartState({}));
    _saveCart();
  }

  int get itemCount =>
      state.items.values.fold(0, (sum, item) => sum + item.quantity);
}
