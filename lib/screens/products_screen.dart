import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/screens/product_details_screen.dart';
import '/shared/component.dart';
import '/bloc/cuibts/home_cuibt.dart';
import '/bloc/states/home_state.dart';
import '/models/home_model.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final HomeModel? _homeData = HomeCubit.get(context).homeModel;

        // print(_homeData!.data);

        return Scaffold(
          // backgroundColor: Colors.grey,
          body: (state is HomeLoadingState)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // TextButton(
                      //     onPressed: () async {
                      //       CacheHelper.deletePref('token');
                      //       navAndFininsh(context, LoginScreen());
                      //     },
                      //     child: Text('asdasdasdasd')),
                      CarouselSlider.builder(
                        itemCount: 4
                        // _homeData!.data!.banners.length
                        ,
                        itemBuilder: (ctx, index, i) => Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: double.infinity,
                          child: Image(
                            image: NetworkImage(
                              _homeData!.data!.banners[index].image!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        options: CarouselOptions(
                          enlargeCenterPage: false,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          viewportFraction: 1,
                          autoPlay: true,
                        ),
                      ),
                      Text(
                        'Products',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: 10),
                      GridView.builder(
                          itemCount: _homeData!.data!.products.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            // mainAxisExtent: 1,
                          ),
                          itemBuilder: (ctx, i) => InkWell(
                                onTap: () {
                                  navTo(
                                      context,
                                      ProductDetailsScreen(
                                          _homeData.data!.products[i].id!));
                                },
                                child: Container(
                                  // color: Colors.grey,
                                  // height: 300,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 150,
                                        child: Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            Hero(
                                              tag: _homeData
                                                  .data!.products[i].id!,
                                              child: Image.network(
                                                _homeData
                                                    .data!.products[i].image!,
                                                // fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                            ),
                                            (_homeData.data!.products[i]
                                                        .discount ==
                                                    0)
                                                ? Container()
                                                : Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Container(
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      child: Text(
                                                        '%${_homeData.data!.products[i].discount}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        _homeData.data!.products[i].name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(color: Colors.black),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      (_homeData.data!.products[i].discount ==
                                              0)
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Text(
                                                '\$${_homeData.data!.products[i].oldPrice}',
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationThickness: 1.0),
                                              ),
                                            ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                    '\$${_homeData.data!.products[i].price!}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1),
                                                Spacer(),
                                                IconButton(
                                                  onPressed: () {
                                                    HomeCubit.get(context)
                                                        .addOrRemvoeFavorites(
                                                            productId: _homeData
                                                                .data!
                                                                .products[i]
                                                                .id!);
                                                  },
                                                  icon: Icon(
                                                    (HomeCubit.get(context)
                                                                    .favorites[
                                                                _homeData
                                                                    .data!
                                                                    .products[i]
                                                                    .id] ??
                                                            false)
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: (HomeCubit.get(
                                                                        context)
                                                                    .favorites[
                                                                _homeData
                                                                    .data!
                                                                    .products[i]
                                                                    .id] ??
                                                            false)
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
