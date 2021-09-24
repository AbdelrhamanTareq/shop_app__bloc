import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shop_app_bloc/bloc/cuibts/category_cuibt.dart';
import 'package:shop_app_bloc/bloc/cuibts/home_cuibt.dart';
import 'package:shop_app_bloc/bloc/states/category_states.dart';
import 'package:shop_app_bloc/bloc/states/home_state.dart';
import 'package:shop_app_bloc/screens/product_details_screen.dart';
import 'package:shop_app_bloc/shared/component.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String title;
  CategoryDetailsScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is GetProductDetailsLoadingState) {
          EasyLoading.show();
        } else if (state is GetProductDetailSuccsesState) {
          EasyLoading.dismiss();
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
                          print('state1 $state');
                          HomeCubit.get(context)
                              .getProductDetails(
                                  _categoryDetailsData.data!.dataModel![i].id)
                              .then((value) {
                            // print('سليلسيل');
                            print('state $state');

                            if (state is GetProductDetailSuccsesState) {
                              navTo(
                                  context,
                                  ProductDetailsScreen(_categoryDetailsData
                                      .data!.dataModel![i].id!));
                              print('asdasdasdasdasdasd');
                            }
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
                                      child: Image.network(
                                        _categoryDetailsData
                                            .data!.dataModel![i].image!,
                                        // fit: BoxFit.cover,
                                        width: double.infinity,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
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
