import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/admin/admin_cubit/admin_cubit.dart';
import 'package:food_app/presentation/admin/admin_cubit/admin_states.dart';
import 'package:food_app/presentation/resources/assets_manager.dart';
import 'package:food_app/presentation/resources/routes_manager.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:food_app/presentation/resources/styles_manager.dart';

import '../../../resources/appsize.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/widgets.dart';

class AdminAllOrdersView extends StatelessWidget {
  const AdminAllOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit()..getOrdersFromFirebase(),
      child: BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AdminCubit.get(context);
          return Scaffold(
            appBar: AppBar(title: Text(AppStrings.adminOrdersScreen.toUpperCase())),
            body: state is GetOrdersFromFirebaseLoadingState ? loadingScreen() : streamOrders(cubit),
          );
        },
      ),
    );
  }

  StreamBuilder<List<ClientAllOrders>> streamOrders(AdminCubit cubit) {
    return StreamBuilder(
      stream: cubit.getRealtimeOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("error", style: getlargeStyle(color: ColorManager.orange)));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          List<ClientAllOrders> orders = snapshot.data!;
          return orders.isEmpty
              ? emptyScreen()
              : Center(
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) => orderContainer(context, cubit, orders[index]),
                  ),
                );
        }
      },
    );
  }

  Widget listViewOfOrders(List<ClientAllOrders> orders, AdminCubit cubit) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) => orderContainer(context, cubit, orders[index]),
    );
  }

  Padding orderContainer(BuildContext context, AdminCubit cubit, ClientAllOrders clientAllOrders) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p8.sp, vertical: AppPadding.p6.sp),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) {
                cubit.deleteOrder(clientAllOrders.orderId);
                AdminCubit.get(context).getOrdersFromFirebase();
              },
              icon: Icons.delete,
              backgroundColor: ColorManager.red,
              borderRadius: BorderRadius.circular(AppSize.s20.sp),
            ),
          ],
        ),
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, Routes.adminOrders, arguments: clientAllOrders),
          child: Container(
            width: double.infinity,
            height: AppSize.s200.sp,
            padding:EdgeInsets.all(AppPadding.p10.sp),
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
              borderRadius: BorderRadius.circular(AppSize.s20.sp),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s20.sp),
                      image: const DecorationImage(
                        image: AssetImage(ImageAsset.burgerImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.numOfItems,
                        style: getRegularStyle(color: ColorManager.black),
                      ),
                      Text(
                        calculateNumOfItems(clientAllOrders.orders).toString(),
                        style: getRegularStyle(color: ColorManager.orange),
                      ),
                      Text(
                        AppStrings.orderDate,
                        style: getRegularStyle(color: ColorManager.black),
                      ),
                      Text(
                        clientAllOrders.date,
                        style: getRegularStyle(color: ColorManager.orange),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
