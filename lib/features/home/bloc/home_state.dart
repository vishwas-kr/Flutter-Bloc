part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class LoadingSuccessState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeNaviagteToWishlistPageActionState extends HomeActionState {}

class NavigateToCartPageActionState extends HomeActionState {}
