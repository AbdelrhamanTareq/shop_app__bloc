import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/localiziation/localizatrion_constant.dart';

import '/bloc/cuibts/home_cuibt.dart';
import '/bloc/states/home_state.dart';
import '/shared/component.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _sarechController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _darkTheme = Theme.of(context).brightness == Brightness.dark;
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final _searchData = HomeCubit.get(context).seacrhModel;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                getTranslated(context, 'search_title'),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: buildTextFiled(
                      controller: _sarechController,
                      hintText: getTranslated(context, 'search_hint'),
                      preixIcon: Icon(Icons.search),
                      validatorFunction: (val) {
                        if (val!.isEmpty) {
                          return getTranslated(context, 'search_error');
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      onFieldSubmittedFunction: (val) {
                        HomeCubit.get(context).search(val!);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  if (state is SearchLoadingState) LinearProgressIndicator(),
                  if (_searchData != null || state is SearchSuccsesState)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        _searchData!.data!.dataModel[i].image!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    placeholder: (context, url) => Image.asset(
                                      "assets/images/placeholder.png",
                                      fit: BoxFit.cover,
                                    ),
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
                                        _searchData.data!.dataModel[i].name!,
                                        style: TextStyle(
                                            color: (_darkTheme)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      '\$ ${_searchData.data!.dataModel[i].price!}',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, i) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: _searchData!.data!.dataModel.length,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
