import 'package:flutter/material.dart';
import 'package:my_shop/screens/splash_screen.dart';
import 'package:provider/provider.dart';

// Screens
import './screens/product_overview.dart';
import './screens/product_detail.dart';
import './screens/cart.dart';
import './screens/orders.dart';
import './screens/user_products.dart';
import './screens/manage_product.dart';
import './screens/auth_screen.dart';

// Provider Class
import './providers/auth.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previousProducts) => Products(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items,
            ),
            create: null,
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrders) => Orders(
              auth.token,
              auth.userId,
              previousOrders == null ? [] : previousOrders.orders,
            ),
            create: null,
          ),
        ],
        //value: Products(),
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: auth.isAuth
                ? ProductsOverview()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, snapShot) =>
                        snapShot.connectionState == ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              ProductDetail.routeName: (ctx) => ProductDetail(),
              ShowCart.routeName: (ctx) => ShowCart(),
              ShowOrders.routeName: (ctx) => ShowOrders(),
              UserProducts.routeName: (ctx) => UserProducts(),
              ManageProduct.routeName: (ctx) => ManageProduct(),
            },
          ),
        ));
  }
}
