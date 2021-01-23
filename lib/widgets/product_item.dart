import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(
      context,
      listen: false,
    );
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetail.routeName,
              arguments: productData.id,
            );
          },
          child: Image.network(
            productData.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
              builder: (ctx, productData, child) => IconButton(
                    icon: Icon(
                      productData.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      productData.toggleFavoriteStatus();
                    },
                  )),
          title: Text(
            productData.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(
                productData.id,
                productData.price,
                productData.title,
              );
              // hide one snackbar before another , prevents waiting
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Added Item to cart!',
                ),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.removeSingleItem(productData.id);
                  },
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
