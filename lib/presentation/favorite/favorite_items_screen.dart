import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/presentation/main/base_cubit/cubit.dart';
import 'package:food_app/presentation/main/base_cubit/states.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:food_app/presentation/resources/widgets.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class FavoriteItemsScreen extends StatefulWidget {
  const FavoriteItemsScreen({super.key});

  @override
  State<FavoriteItemsScreen> createState() => _FavoriteItemsScreenState();
}

class _FavoriteItemsScreenState extends State<FavoriteItemsScreen> {
  @override
  void initState() {
    BaseCubit.get(context).getFavoriteItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseCubit, BaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BaseCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppStrings.favorite.toUpperCase(),
              style: getMeduimStyle(color: ColorManager.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: ColorManager.orange),
          ),
          body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: cubit.favoriteItems.length,
            itemBuilder: (context, index) {
              return itemContainer(context, cubit.favoriteItems[index]);
            },
          ),
        );
      },
    );
  }
}
