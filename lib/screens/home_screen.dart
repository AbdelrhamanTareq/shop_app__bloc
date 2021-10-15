import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/screens/search_screen.dart';
import 'package:shop_app_bloc/shared/component.dart';
import 'package:shop_app_bloc/shared/drawer.dart';

import '/bloc/cuibts/home_cuibt.dart';
import '/bloc/states/home_state.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // final cartData = HomeCubit.get(context).cartModel;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Shop',
            ),
            actions: [
              buildCartBadge(context),
              IconButton(
                onPressed: () {
                  // HomeCubit.get(context).search();
                  navTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          drawer: AppDrawer(),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: HomeCubit.get(context).currentIndex,
            onTap: (int index) {
              HomeCubit.get(context).changeCurrentIndex(index);
            },
          ),
          body: HomeCubit.get(context)
              .screens[HomeCubit.get(context).currentIndex],
        );
      },
    );
  }

  Padding buildCartBadge(context) {
    final data = HomeCubit.get(context).cartModel;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Stack(
        children: [
          IconButton(
            onPressed: () {
              navTo(context, CartScreen());
            },
            icon: Icon(
              Icons.shopping_cart,
              // color: Theme.of(context).primaryColor,
            ),
          ),
          Positioned(
            top: 0.0,
            right: 5,
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.redAccent,
              ),
              constraints: BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: Text(
                '${(data == null) ? 0 : HomeCubit.get(context).cartModel!.data!.cartItem!.length}',
                style: TextStyle(color: Colors.white, fontSize: 8),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
