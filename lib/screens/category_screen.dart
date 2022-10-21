import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shop_app_bloc/localiziation/localizatrion_constant.dart';

import '/bloc/cuibts/home_cuibt.dart';
import '/bloc/states/home_state.dart';
import '/screens/category_details_screen.dart';
import '/shared/component.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final _categoreyModel = HomeCubit.get(context).categoreyModel;

        if (state is GetCategoryDetailsLoadingState) {
          print(state);
          EasyLoading.show();
        } else if (_categoreyModel == null ||
            state is GetCategoryLoadingState) {
          return buildProgressIndicator();
        }

        return Container(
          color: (Theme.of(context).brightness == Brightness.dark)
              ? Colors.black
              : Colors.grey[100],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    getTranslated(context, 'category_heading'),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) => InkWell(
                    onTap: () {
                      HomeCubit.get(context)
                          .getCategoryDetails(
                              _categoreyModel!.data!.dataModel![i].id!)
                          .then((value) {
                        navTo(
                            context,
                            CategoryDetailsScreen(
                                _categoreyModel.data!.dataModel![i].name!));
                        EasyLoading.dismiss();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.17,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                _categoreyModel!.data!.dataModel![i].image!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (context, url) => Image.asset("assets/images/placeholder.png",fit: BoxFit.cover,),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Container(
                              width: 150,
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.black54,
                              child: Text(
                                _categoreyModel.data!.dataModel![i].name!,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, i) => SizedBox(
                    height: 5,
                  ),
                  itemCount: _categoreyModel!.data!.dataModel!.length,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
