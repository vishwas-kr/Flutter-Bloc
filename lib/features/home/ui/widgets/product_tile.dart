import 'package:bloc_learn/features/home/model/home_product_data_model.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final ProductDataModel productDataModel;
  const ProductTile({super.key, required this.productDataModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(productDataModel.imageUrl),
                  fit: BoxFit.cover),
            ),
          ),
          Text(
            productDataModel.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(productDataModel.description),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$ ${productDataModel.price}'),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        // homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        //homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.shopping_bag_outlined))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
