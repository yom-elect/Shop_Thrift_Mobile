import 'package:flutter/material.dart';
// import 'package:my_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../screens/cart.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';

import '../providers/cart.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverview extends StatefulWidget {
  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  var _showOnlyFavoriteData = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavoriteData = true;
                } else {
                  _showOnlyFavoriteData = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
            icon: Icon(
              Icons.more_vert,
            ),
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) => Badge(
              child: ch,
              value: cartData.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(ShowCart.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: SideDrawer(),
      body: ProductsGrid(_showOnlyFavoriteData),
    );
  }
}
