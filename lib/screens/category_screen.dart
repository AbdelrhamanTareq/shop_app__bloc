import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/bloc/cuibts/category_cuibt.dart';
import 'package:shop_app_bloc/bloc/states/category_states.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final _categoreyModel = CategoryCubit.get(context).categoreyModel;
        if (state is CategoryLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: Text('${_categoreyModel!.data!.dataModel![0].name}'),
        );
      },
    );
  }
}
