import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_learn/data/cart_items.dart';
import 'package:bloc_learn/data/product_data.dart';
import 'package:bloc_learn/data/wishlist_items.dart';
import 'package:bloc_learn/features/home/model/home_product_data_model.dart';
import 'package:flutter/foundation.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedevent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadingSuccessState(
        products: ProductData.productData
            .map((e) => ProductDataModel(
                id: e['id'],
                name: e['name'],
                description: e['title'],
                price: e['price'],
                imageUrl: e['image']))
            .toList()));
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    if (kDebugMode) {
      print("Wishlist Product Clicked");
    }
    wishlistItems.add(event.clickedProduct);
    emit(HomeProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedevent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    if (kDebugMode) {
      print("Cart product Clicked");
    }
    cartItems.add(event.clickedProduct);
    emit(HomeProductCartItemActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    if (kDebugMode) {
      print("Cart Navigate Clicked");
    }
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    if (kDebugMode) {
      print("Wishlist Naviagte Clicked");
    }
    emit(HomeNaviagteToWishlistPageActionState());
  }
}
