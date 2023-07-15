import 'package:bloc_learn/features/cart/ui/cart_page.dart';
import 'package:bloc_learn/features/home/bloc/home_bloc.dart';
import 'package:bloc_learn/features/home/ui/widgets/product_tile.dart';
import 'package:bloc_learn/features/wishlist/ui/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      buildWhen: (previous, current) => current is! HomeActionState,
      listenWhen: (previous, current) => current is HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartPage()));
        } else if (state is HomeNaviagteToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WishlistPage()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadingSuccessState:
            final successState = state as HomeLoadingSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: const Text('Product Store'),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.shopping_bag_outlined))
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTile(
                        productDataModel: successState.products[index]);
                  }),
            );

          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('error'),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
