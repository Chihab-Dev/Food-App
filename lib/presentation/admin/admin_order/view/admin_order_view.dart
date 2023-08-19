import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/admin/admin_cubit/admin_cubit.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:food_app/presentation/resources/widgets.dart';

import '../../../main/base_cubit/cubit.dart';
import '../../../resources/appsize.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../admin_cubit/admin_states.dart';

class AdminOrderView extends StatelessWidget {
  final ClientAllOrders clientAllOrders;
  const AdminOrderView({super.key, required this.clientAllOrders});

  @override
  Widget build(BuildContext context) {
    List<Order> orders = clientAllOrders.orders;
    return BlocProvider(
      create: (context) => AdminCubit(),
      child: BlocConsumer<AdminCubit, AdminStates>(
        listener: ((context, state) {}),
        builder: (context, state) {
          var cubit = AdminCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Stack(
              children: [
                Column(
                  children: [
                    clientInformation(
                      clientAllOrders.phoneNumber,
                      clientAllOrders.location,
                      calculateNumOfItems(clientAllOrders.orders),
                      calculateTotalPrice(clientAllOrders.orders).toString(),
                      clientAllOrders.date,
                      clientAllOrders.orderId,
                      BaseCubit.get(context),
                    ),
                    Expanded(
                      child: GridView.builder(
                        itemCount: clientAllOrders.orders.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return itemContainer(orders[index].itemObject, orders[index].quentity);
                        },
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar(cubit, clientAllOrders),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget bottomNavigationBar(AdminCubit cubit, ClientAllOrders clientAllOrders) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: ColorManager.white.withOpacity(0.5),
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
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppPadding.p8.sp, vertical: AppPadding.p6.sp),
          child: Row(
            children: [
              orderStateContainer(AppStrings.startPreparring, () {
                cubit.changeOrderState(clientAllOrders.orderId, clientAllOrders.orderToken, OrderState.PREPARING);
              }),
              orderStateContainer(AppStrings.startDelivering, () {
                cubit.changeOrderState(clientAllOrders.orderId, clientAllOrders.orderToken, OrderState.DELIVERING);
              }),
              orderStateContainer(AppStrings.orderDelivered, () {
                cubit.changeOrderState(clientAllOrders.orderId, clientAllOrders.orderToken, OrderState.FINISHED);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget orderStateContainer(String name, Function() function) {
    return Expanded(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: AppPadding.p8.sp, vertical: AppPadding.p6.sp),
        child: InkWell(
          onTap: function,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s25.sp),
              color: ColorManager.orange,
              boxShadow: [
                BoxShadow(
                  color: ColorManager.orange.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Center(
              child: Text(
                name,
                style: getMeduimStyle(color: ColorManager.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget clientInformation(String phoneNumber, String location, int numOfItems, String totalPrice, String date,
      String orderId, BaseCubit cubit) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: AppPadding.p8.sp, vertical: AppPadding.p6.sp),
      child: Container(
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p8.sp, vertical: AppPadding.p6.sp),
          child: Column(
            children: [
              clientInformationText(AppStrings.clientNumber, phoneNumber),
              clientInformationText(AppStrings.clientLocation, location),
              clientInformationText(AppStrings.orderDate, date),
              clientInformationText(AppStrings.numOfItems, numOfItems.toString()),
              clientInformationText(AppStrings.totalPrice, "$totalPrice\$"),
              // clientInformationText(AppStrings.mealState, state.toString().split('.').last),
              getOrderState(orderId, cubit),
            ],
          ),
        ),
      ),
    );
  }

  Widget getOrderState(String id, BaseCubit cubit) {
    return StreamBuilder(
      stream: cubit.getRealTimeOrderState(id),
      initialData: OrderState.WAITING.toString().split('.').last,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return clientInformationText(AppStrings.mealState, snapshot.data!);
        }
      },
    );
  }

  Widget clientInformationText(String itemName, String itemInformation) {
    return Row(
      children: [
        Text(
          itemName,
          style: getRegularStyle(color: ColorManager.black),
        ),
      SizedBox(width: AppSize.s10.sp),
        Flexible(
          child: Text(
            itemInformation,
            style: getRegularStyle(color: ColorManager.darkOrange),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Widget customClientInformationText(String itemName, String itemInformation) {
  //   return Row(
  //     children: [
  //       Text(
  //         itemName,
  //         style: getRegularStyle(color: ColorManager.black),
  //       ),
  //       const SizedBox(width: AppSize.s10),
  //       Expanded(
  //         child: FittedBox(
  //           child: Text(
  //             itemInformation,
  //             style: getRegularStyle(color: ColorManager.darkOrange),
  //             maxLines: 1,
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Padding itemContainer(ItemObject item, int quentity) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: AppPadding.p8.sp, vertical: AppPadding.p6.sp),
      child: Container(
        padding:  EdgeInsets.all(AppPadding.p10.sp),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                quentity.toString(),
                style: getlargeStyle(color: ColorManager.black),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s20.sp),
                  image: DecorationImage(
                    image: NetworkImage(item.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSize.s10.sp),
            Text(
              item.image.isEmpty ? 'meal' : item.title,
              style: getMeduimStyle(color: ColorManager.black),
            ),
            SizedBox(
              // width: AppSize.s200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      starsCalculator(item.stars),
                      (index) => Icon(
                        index < item.stars ? Icons.star : Icons.star_border,
                        color: Colors.yellowAccent[700],
                        size: AppSize.s18.sp,
                      ),
                    ),
                  ),
                  Text(
                    "\$${item.price}",
                    style: getMeduimStyle(color: ColorManager.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
