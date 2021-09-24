import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shop_app_bloc/bloc/cuibts/category_cuibt.dart';
import 'package:shop_app_bloc/bloc/cuibts/home_cuibt.dart';
import 'package:shop_app_bloc/bloc/states/category_states.dart';
import 'package:shop_app_bloc/bloc/states/home_state.dart';
import 'package:shop_app_bloc/screens/category_details_screen.dart';
import 'package:shop_app_bloc/shared/component.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final _categoreyModel = HomeCubit.get(context).categoreyModel;
        // if (state is CategoryLoadingState) {
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        if (state is GetCategoryDetailsLoadingState) {
          print(state);
          EasyLoading.show();
        } else if (state is GetCategoryDetailsSuccsesState) {
          print(state);
          EasyLoading.dismiss();
        }
        return Container(
          color: Colors.grey[100],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Categoreis',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) => InkWell(
                    onTap: () {
                      print('abc');
                      HomeCubit.get(context)
                          .getCategoryDetails(
                              _categoreyModel!.data!.dataModel![i].id!)
                          .then((value) {
                        if (state is GetCategoryDetailsSuccsesState) {
                          navTo(
                              context,
                              CategoryDetailsScreen(
                                  _categoreyModel.data!.dataModel![i].name!));
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.17,
                      child: Stack(
                        children: [
                          Image.network(
                            _categoreyModel!.data!.dataModel![i].image!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
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
