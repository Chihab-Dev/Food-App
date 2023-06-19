import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/main/base_cubit/cubit.dart';
import 'package:food_app/presentation/main/base_cubit/states.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/widgets.dart';

class MealsByCategoryScreen extends StatelessWidget {
  const MealsByCategoryScreen(this._itemCategory, {super.key});

  final ItemCategory _itemCategory;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseCubit, BaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BaseCubit.get(context);
        List<ItemObject> itemsList = cubit.getItemsByCategory(_itemCategory);
        return Scaffold(
          backgroundColor: ColorManager.whiteGrey,
          appBar: AppBar(
            title: Text(
              _itemCategory.toString().split('.').last,
              style: getMeduimStyle(color: ColorManager.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: ColorManager.orange),
          ),
          body: itemsList.isEmpty
              ? emptyScreen()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: itemsList.length,
                  itemBuilder: (context, index) {
                    return itemContainer(context, itemsList[index]);
                  },
                ),
        );
      },
    );
  }
}
