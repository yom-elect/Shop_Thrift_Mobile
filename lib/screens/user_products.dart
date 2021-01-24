import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/manage_product.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

class UserProducts extends StatelessWidget {
  static const routeName = 'user-product';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(ManageProduct.routeName);
              })
        ],
        title: const Text('Your Products'),
      ),
      drawer: SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, i) => Column(
            children: <Widget>[
              UserProductItem(
                productsData.items[i].id,
                productsData.items[i].title,
                productsData.items[i].imageUrl,
              ),
              Divider(),
            ],
          ),
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
