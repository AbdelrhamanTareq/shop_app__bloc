import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '/bloc/cuibts/home_cuibt.dart';
import '/bloc/states/home_state.dart';
import '/screens/product_details_screen.dart';
import '/shared/component.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String title;
  CategoryDetailsScreen(this.title);

  @override
  Widget build(BuildContext context) {
    final _darkTheme = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is GetProductDetailsLoadingState) {
          EasyLoading.show();
        }
      },
      builder: (context, state) {
        final _categoryDetailsData =
            HomeCubit.get(context).categoreyDetailsModel;
        return Scaffold(
          // backgroundColor: Colors.white70,
          appBar: AppBar(
            title: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: InkWell(
            child: GridView.builder(
                itemCount: _categoryDetailsData!.data!.dataModel!.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // crossAxisSpacing:1.0,
                  childAspectRatio: 1 / 1.8,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                  // mainAxisExtent: 1,
                ),
                itemBuilder: (ctx, i) => Padding(
                      padding: EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          HomeCubit.get(context)
                              .getProductDetails(
                                  _categoryDetailsData.data!.dataModel![i].id)
                              .then((value) {
                            navTo(
                                context,
                                ProductDetailsScreen(_categoryDetailsData
                                    .data!.dataModel![i].id!));
                            EasyLoading.dismiss();
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    Hero(
                                      tag: _categoryDetailsData
                                          .data!.dataModel![i].id!,
                                      child: CachedNetworkImage(
                                        imageUrl: _categoryDetailsData
                                            .data!.dataModel![i].image!,
                                        // fit: BoxFit.cover,
                                        width: double.infinity,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          "assets/images/placeholder.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    (_categoryDetailsData
                                                .data!.dataModel![i].discount ==
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
                                                    BorderRadius.circular(3),
                                              ),
                                              child: Text(
                                                '%${_categoryDetailsData.data!.dataModel![i].discount}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              Text(
                                _categoryDetailsData.data!.dataModel![i].name!,
                                style: (_darkTheme)
                                    ? Theme.of(context).textTheme.bodyText2!
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              (_categoryDetailsData
                                          .data!.dataModel![i].discount ==
                                      0)
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                          '\$${_categoryDetailsData.data!.dataModel![i].oldPrice}',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationThickness: 1.0,
                                              color: Colors.white)),
                                    ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                            '\$${_categoryDetailsData.data!.dataModel![i].price!}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                        Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            HomeCubit.get(context)
                                                .addOrRemvoeFavorites(
                                                    productId:
                                                        _categoryDetailsData
                                                            .data!
                                                            .dataModel![i]
                                                            .id!);
                                          },
                                          icon: Icon(
                                            (HomeCubit.get(context).favorites[
                                                        _categoryDetailsData
                                                            .data!
                                                            .dataModel![i]
                                                            .id] ??
                                                    false)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: (HomeCubit.get(context)
                                                            .favorites[
                                                        _categoryDetailsData
                                                            .data!
                                                            .dataModel![i]
                                                            .id] ??
                                                    false)
                                                ? Theme.of(context).primaryColor
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
                      ),
                    )),
          ),
        );
      },
    );
  }
}
