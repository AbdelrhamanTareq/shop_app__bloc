import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/localiziation/localizatrion_constant.dart';

import '/bloc/cuibts/home_cuibt.dart';
import '/bloc/states/home_state.dart';
import '/shared/component.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final _data = HomeCubit.get(context).cartModel;
        final int subTotal = _data!.data!.subTotal!;
        final double tax = ((_data.data!.subTotal!) * 0.14);
        final double total = subTotal - tax;
        if (state is GetCartDataLoadingState) {
          return buildProgressIndicator();
        }
        return Scaffold(
            appBar: AppBar(
              title: Text(
                getTranslated(context, 'cart_heading'),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 100,
                            height: 150,
                            child: Image.network(
                              _data.data!.cartItem![i].product!.image!,
                              height: 150,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 200,
                                  child: Text(
                                      _data.data!.cartItem![i].product!.name!)),
                              Text(
                                '${_data.data!.cartItem![i].product!.price!}',
                              ),
                              Row(
                                children: [
                                  Text(
                                    getTranslated(
                                        context, 'cart_free_shipping'),
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      HomeCubit.get(context).updateCart(
                                          productId:
                                              _data.data!.cartItem![i].id!,
                                          quantity: _data.data!.cartItem![i]
                                                  .quantity! +
                                              1);
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                  Text('${_data.data!.cartItem![i].quantity}'),
                                  IconButton(
                                    onPressed: () {
                                      if (_data.data!.cartItem![i].quantity! >
                                          0) {
                                        HomeCubit.get(context).updateCart(
                                            productId:
                                                _data.data!.cartItem![i].id!,
                                            quantity: _data.data!.cartItem![i]
                                                    .quantity! -
                                                1);
                                      }
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 100,
                                height: 40,
                                color: Theme.of(context).primaryColor,
                                child: TextButton(
                                  onPressed: () {
                                    HomeCubit.get(context).addOrRemvoeCart(
                                        productId: _data
                                            .data!.cartItem![i].product!.id!);
                                  },
                                  child: Text(
                                    getTranslated(context, 'cart_remove'),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      separatorBuilder: (context, i) => Divider(),
                      itemCount: _data.data!.cartItem!.length,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(getTranslated(context, 'cart_price_details'),
                        style: Theme.of(context).textTheme.headline4),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            buildRow(getTranslated(context, 'cart_sub_total'),
                                '$subTotal', context),
                            buildRow(getTranslated(context, 'cart_tax'), '$tax',
                                context),
                            Divider(),
                            buildRow(
                              getTranslated(context, 'cart_total'),
                              '$total',
                              context,
                              isBlack: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: buildButton(
                        context,
                        function: () {},
                        child: buildButtonText(
                            text: getTranslated(context, 'cart_checkout')),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  Row buildRow(String text, String value, context, {isBlack = false}) {
    return Row(
      children: [
        Text(
          text,
          style: isBlack
              ? TextStyle(color: Theme.of(context).dividerColor)
              : Theme.of(context).textTheme.bodyText2,
        ),
        Spacer(),
        Text(
          value,
          style: isBlack
              ? TextStyle(color: Theme.of(context).dividerColor)
              : Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
