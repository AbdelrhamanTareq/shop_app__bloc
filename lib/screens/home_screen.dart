import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/localiziation/localizatrion_constant.dart';

import '/screens/search_screen.dart';
import '/shared/component.dart';
import '/shared/drawer.dart';
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
              getTranslated(context, 'home_title'),
            ),
            actions: [
              buildCartBadge(
                context,
              ),
              IconButton(
                onPressed: () {
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
                label: getTranslated(context, 'nav_home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: getTranslated(context, 'nav_category'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: getTranslated(context, 'nav_favorite'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: getTranslated(context, 'nav_setting'),
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

  Widget buildCartBadge(
    context,
  ) {
    final _data = HomeCubit.get(context).cartModel;

    // final data = HomeCubit.get(context).cartModel;
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
                '${(_data != null) ? _data.data?.cartItem?.length : 0}',
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
