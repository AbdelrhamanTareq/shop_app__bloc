import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/bloc/cuibts/home_cuibt.dart';
import '/bloc/states/home_state.dart';
import '/models/product_details_model.dart';
import '/shared/component.dart';

class ProductDetailsScreen extends StatefulWidget {
  late final int productId;
  ProductDetailsScreen(this.productId);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    final _darkTheme = Theme.of(context).brightness == Brightness.dark;
    final CarouselController _carouselController = CarouselController();
    return
        // BlocProvider(
        //   create: (context) => HomeCubit()..getProductDetails(productId),
        //   child:
        BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is AddOrRemoveCartSuccsesState) {
          Fluttertoast.showToast(
              msg: state.data['message'], backgroundColor: Colors.green);
        }
      },
      builder: (context, state) {
        final ProductModel? _productModel = HomeCubit.get(context).productModel;
        return Scaffold(
          backgroundColor: (_darkTheme) ? Colors.black : Colors.grey[100],
          body: (state is GetProductDetailsLoadingState)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 2.5,
                        // color: Colors.grey,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            // topLeft: Radius.circular(10),
                            // topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                // width: double.infinity,
                                height: double.infinity,
                                // height: 300,
                                // color: Colors.red,
                                child: CarouselSlider.builder(
                                  carouselController: _carouselController,
                                  itemCount:
                                      _productModel!.data!.images!.length,
                                  itemBuilder: (ctx, index, i) => Image.network(
                                    _productModel.data!.images![index],
                                    width: double.infinity,
                                    // height: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                  options: CarouselOptions(
                                      viewportFraction: 1,
                                      autoPlay: true,
                                      initialPage: 0,
                                      height: double.infinity,
                                      onPageChanged: (index, _) {
                                        setState(() {
                                          _current = index;
                                        });
                                      }),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: _productModel.data!.images!
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      return GestureDetector(
                                        onTap: () => _carouselController
                                            .animateToPage(entry.key),
                                        child: Container(
                                          width: 20.0,
                                          height: 2.0,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 4.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: (Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black)
                                                  .withOpacity(
                                                      _current == entry.key
                                                          ? 0.9
                                                          : 0.4)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  // padding: const EdgeInsets.all(5),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.arrow_back_ios_new),
                                    iconSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                left: 10,
                                top: 35,
                              ),
                              Positioned(
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  // padding: const EdgeInsets.all(10),
                                  child: IconButton(
                                      onPressed: () {
                                        HomeCubit.get(context)
                                            .addOrRemvoeFavorites(
                                                productId:
                                                    _productModel.data!.id!);
                                      },
                                      icon: Icon(
                                          (HomeCubit.get(context).favorites[
                                                  _productModel.data!.id])!
                                              ? Icons.favorite
                                              : Icons.favorite_border),
                                      iconSize: 20,
                                      color: (HomeCubit.get(context).favorites[
                                              _productModel.data!.id])!
                                          ? Colors.redAccent
                                          : Colors.black),
                                ),
                                right: 10,
                                top: 35,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 250,
                              child: Text(
                                _productModel.data!.name!,
                                softWrap: true,
                                style: TextStyle(
                                  color: (_darkTheme)
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (_productModel.data!.discount! != 0)
                                    ? Text(
                                        '${_productModel.data!.discount!}% off',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      )
                                    : Container(),
                                // Spacer(),
                                Text(
                                  '\$${_productModel.data!.price!}',
                                  style: TextStyle(
                                    color: (_darkTheme)
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Product Details',
                          style: (_darkTheme)
                              ? Theme.of(context).textTheme.headline6!
                              : Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(_productModel.data!.description!,
                            style: TextStyle(
                                color:
                                    (_darkTheme) ? Colors.white : Colors.black)
                            //     Theme.of(context).textTheme.headline6,
                            ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          color: Theme.of(context).primaryColor,
                          child: (state is AddOrRemoveCartLoadingState)
                              ? buildProgressIndicator(isMainColor: false)
                              : TextButton(
                                  child: Text(
                                    'ADD TO CART',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    HomeCubit.get(context).addOrRemvoeCart(
                                        productId: _productModel.data!.id!);
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
      // ),
    );
  }
}
