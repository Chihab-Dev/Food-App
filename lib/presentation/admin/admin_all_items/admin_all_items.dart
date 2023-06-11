import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/admin/admin_all_orders/admin_cubit/admin_states.dart';
import 'package:food_app/presentation/main/base_cubit/cubit.dart';
import 'package:food_app/presentation/main/base_cubit/states.dart';
import 'package:food_app/presentation/resources/widgets.dart';

import '../../resources/appsize.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/styles_manager.dart';

class AdminAllItems extends StatelessWidget {
  const AdminAllItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseCubit, BaseStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var cubit = BaseCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.adminAllItemsScreen.toUpperCase()),
          ),
          body: state is GetOrdersFromFirebaseLoadingState
              ? loadingScreen()
              : ListView.builder(
                  itemCount: cubit.items.length,
                  itemBuilder: (context, index) {
                    return orderContainer(context, cubit.items[index], cubit);
                  },
                ),
        );
      },
    );
  }

  Widget orderContainer(BuildContext context, ItemObject item, BaseCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) {
                cubit.deleteItem(item.id);
                cubit.getItems();
                cubit.getPopularItems();
              },
              icon: Icons.delete,
              backgroundColor: ColorManager.red,
              borderRadius: BorderRadius.circular(AppSize.s20),
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          height: AppSize.s200,
          padding: const EdgeInsets.all(AppPadding.p10),
          decoration: BoxDecoration(
            color: ColorManager.white,
            boxShadow: [
              BoxShadow(
                color: ColorManager.ligthGrey.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 4,
                offset: const Offset(4, 8),
              ),
            ],
            borderRadius: BorderRadius.circular(AppSize.s20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s20),
                    image: DecorationImage(
                      image: NetworkImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.mealTitle,
                      style: getRegularStyle(color: ColorManager.black),
                    ),
                    Text(
                      item.title,
                      style: getlargeStyle(color: ColorManager.orange),
                    ),
                    Text(
                      AppStrings.mealPrice,
                      style: getRegularStyle(color: ColorManager.black),
                    ),
                    Text(
                      "\$${item.price}",
                      style: getlargeStyle(color: ColorManager.orange),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
