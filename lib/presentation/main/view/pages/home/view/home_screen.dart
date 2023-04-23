import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/main/base_cubit/cubit.dart';
import 'package:food_app/presentation/main/base_cubit/states.dart';
import 'package:food_app/presentation/resources/appsize.dart';
import 'package:food_app/presentation/resources/assets_manager.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/routes_manager.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:food_app/presentation/resources/styles_manager.dart';
import 'package:food_app/presentation/resources/widgets.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseCubit, BaseStates>(
      listener: (context, state) {
        if (state is BaseGetUserDataErrorState) {
          errorToast(state.error);
        }
        if (state is BaseGetPopularItemsErrorState) {
          errorToast(state.error);
        }
        if (state is BaseGetItemsErrorState) {
          errorToast(state.error);
        }
      },
      builder: ((context, state) {
        var cubit = BaseCubit.get(context);
        // CustomerObject? userData = cubit.customerObject;
        // userData == null ? cubit.getUserData(userUid!, context) : null;
        List<ItemObject>? popularItems = cubit.popularItems;
        List<ItemObject>? items = cubit.items;
        return state is BaseGetPopularItemsLoadingState || items.isEmpty && popularItems.isEmpty
            ? loadingScreen()
            : homeScreen(popularItems, cubit);
      }),
    );
  }

  Container homeScreen(List<ItemObject> popularItems, BaseCubit cubit) {
    return Container(
      color: ColorManager.whiteGrey.withOpacity(0.7),
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kBottomNavigationBarHeight),
            appBar("Khenchela kais"),
            const SizedBox(height: AppPadding.p25),
            titleWidget(AppStrings.category),
            const SizedBox(height: AppPadding.p12),
            allCategories(),
            const SizedBox(height: AppPadding.p12),
            titleWidget(AppStrings.popularItems),
            const SizedBox(height: AppPadding.p12),
            populatItemList(popularItems),
            const SizedBox(height: AppPadding.p12),
            titleWidget(AppStrings.more),
            const SizedBox(height: AppPadding.p12),
            moreItemsGridView(cubit),
          ],
        ),
      ),
    );
  }

  Container loadingScreen() {
    return Container(
      color: ColorManager.whiteGrey.withOpacity(0.7),
      child: Center(
        child: Lottie.asset(LottieAsset.loading),
      ),
    );
  }

  SizedBox allCategories() {
    return SizedBox(
      height: AppSize.s80,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          categoryContainer(ImageAsset.pizzaImage, AppStrings.pizza),
          categoryContainer(ImageAsset.burgerImage, AppStrings.burger),
          categoryContainer(ImageAsset.friesImage, AppStrings.snack),
          categoryContainer(ImageAsset.sodaImage, AppStrings.drink),
          categoryContainer(ImageAsset.cake2Image, AppStrings.dessert),
          categoryContainer(ImageAsset.hotdogImage, AppStrings.hotdog),
        ],
      ),
    );
  }

  Widget moreItemsGridView(BaseCubit cubit) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cubit.items.length,
      padding: const EdgeInsets.all(0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        ItemObject item = cubit.items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.mealDetail, arguments: item);
            },
            child: Container(
              // width: AppSize.s200,
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
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s20),
                        image: DecorationImage(
                          image: NetworkImage(item.image),
                          fit: BoxFit.fitHeight,
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
                    width: AppSize.s200,
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
          ),
        );
      },
    );
  }

  Widget categoryContainer(String image, String title) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p6),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: AppSize.s80,
          width: AppSize.s80,
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
            padding: const EdgeInsets.all(AppPadding.p6),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(image),
                ),
                Text(
                  title,
                  style: getSmallStyle(color: ColorManager.darkGrey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBar(String location) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p16, horizontal: AppPadding.p10)
          .copyWith(bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.deliveryTo,
                style: getMeduimStyle(color: ColorManager.grey),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: AppSize.s20,
                  ),
                  Text(
                    location,
                    style: getMeduimStyle(color: ColorManager.black),
                  ),
                ],
              ),
            ],
          ),
          const Icon(
            Icons.favorite_border,
          )
        ],
      ),
    );
  }

  Widget populatItemList(List<ItemObject> items) {
    return SizedBox(
      height: AppSize.s200,
      width: double.infinity,
      child: ListView.builder(
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemBuilder: (context, index) {
          ItemObject item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.mealDetail, arguments: item);
              },
              child: Container(
                width: AppSize.s200,
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
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s20),
                          image: DecorationImage(
                            image: NetworkImage(item.image),
                            fit: BoxFit.fitHeight,
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
                      width: AppSize.s200,
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
            ),
          );
        },
      ),
    );
  }

  Widget titleWidget(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
      child: Text(
        text,
        style: getRegularStyle(color: ColorManager.black),
      ),
    );
  }

  int starsCalculator(int starsNum) {
    if (starsNum > 5) {
      return 5;
    } else if (starsNum < 1) {
      return 1;
    } else {
      return starsNum;
    }
  }
}
