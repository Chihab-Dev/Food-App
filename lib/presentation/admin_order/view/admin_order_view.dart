import 'package:flutter/material.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:food_app/presentation/resources/widgets.dart';

import '../../resources/appsize.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class AdminOrderView extends StatelessWidget {
  final ClientAllOrders clientAllOrders;
  const AdminOrderView({super.key, required this.clientAllOrders});

  @override
  Widget build(BuildContext context) {
    List<Order> orders = clientAllOrders.orders;
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 100,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
                child: Row(
                  children: [
                    orderStateContainer(AppStrings.startPreparring, () {}),
                    orderStateContainer(AppStrings.startDelivering, () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderStateContainer(String name, Function function) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
        child: InkWell(
          onTap: () => function,
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.orange,
              borderRadius: BorderRadius.circular(AppSize.s20),
            ),
            child: Center(
              child: Text(
                name,
                style: getRegularStyle(color: ColorManager.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget clientInformation(String phoneNumber, String location, int numOfItems, String totalPrice, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
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
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
          child: Column(
            children: [
              clientInformationText(AppStrings.clientNumber, phoneNumber),
              clientInformationText(AppStrings.clientLocation, location),
              clientInformationText(AppStrings.orderDate, date),
              clientInformationText(AppStrings.numOfItems, numOfItems.toString()),
              clientInformationText(AppStrings.totalPrice, "$totalPrice\$"),
            ],
          ),
        ),
      ),
    );
  }

  Widget clientInformationText(String itemName, String itemInformation) {
    return Row(
      children: [
        Text(
          itemName,
          style: getRegularStyle(color: ColorManager.black),
        ),
        const SizedBox(width: AppSize.s10),
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
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                item.id.toString(),
                style: getlargeStyle(color: ColorManager.black),
              ),
            ),
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
            const SizedBox(height: AppSize.s10),
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
                        size: AppSize.s18,
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
