part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class RemoveCartItemEvent extends CartEvent {
  final ProductDataModel productDataModel;

  RemoveCartItemEvent({required this.productDataModel});
}
