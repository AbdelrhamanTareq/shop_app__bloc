import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/bloc/cuibts/home_cuibt.dart';
import 'package:shop_app_bloc/bloc/states/home_state.dart';

class FavoriteScreen extends StatelessWidget {
  // final UniqueKey _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final _favoriteData = HomeCubit.get(context).favoriteModel;
        if (state is GetFavoriteLoadingState || _favoriteData == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: EdgeInsets.all(10),
          child: ListView.separated(
              itemBuilder: (ctx, i) => Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      width: 120,
                      height: 120,
                      color: Theme.of(context).errorColor,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Icon(Icons.delete, size: 30, color: Colors.white),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 10),
                    ),
                    onDismissed: (direction) async {
                      print('xyz');
                      await HomeCubit.get(context)
                          .deleteFavorite(_favoriteData.data!.dataModel![i].id!,
                              _favoriteData.data!.dataModel![i].products!.id!)
                          .then((value) {
                        HomeCubit.get(context).getFavoriteData();
                        HomeCubit.get(context).getHomeData();
                      });
                    },
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            child: Image.network(
                              _favoriteData
                                  .data!.dataModel![i].products!.image!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                child: Text(
                                  _favoriteData
                                      .data!.dataModel![i].products!.name!,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                '\$ ${_favoriteData.data!.dataModel![i].products!.price!}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              separatorBuilder: (ctx, i) => SizedBox(
                    height: 10,
                  ),
              itemCount: _favoriteData.data!.dataModel!.length),
        );
      },
    );
  }
}
