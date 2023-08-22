import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseCubit, BaseStates>(
      listener: (context, state) {
        print('🇩🇿🇩🇿🇩🇿 state is $state');
        if (state is BaseGetUserDataErrorState) {
          errorToast(state.error).show(context);
        }
        if (state is BaseGetPopularItemsErrorState) {
          errorToast(state.error).show(context);
        }
        if (state is BaseGetItemsErrorState) {
          errorToast(state.error).show(context);
        }
      },
      builder: ((context, state) {
        var cubit = BaseCubit.get(context);

        List<ItemObject>? popularItems = cubit.popularItems;
        List<ItemObject>? items = cubit.items;
        return getHomeScreen(context, cubit, state, popularItems, items);
        // return (state is BaseGetUserDataLoadingState ||
        //         state is GetLocationNameLoadingState ||
        //         state is GetCurrentLocationLoadingState ||
        //         state is BaseGetItemsLoadingState ||
        //         state is BaseGetPopularItemsLoadingState ||
        //         state is GetIsStoreOpenLoadingState ||
        //         items.isEmpty && popularItems.isEmpty ||
        //         cubit.customerObject == null ||
        //         cubit.placeName == null)
        //     ? loadingScreen()
        //     : (state is BaseGetUserDataErrorState ||
        //             state is GetCurrentLocationErrorState ||
        //             state is BaseGetItemsErrorState ||
        //             state is BaseGetPopularItemsErrorState ||
        //             state is GetIsStoreOpenErrorState)
        //         ? errorScreen(context)
        //         : cubit.isStoreOpen == false
        //             ? closedScreen()
        //             : homeScreen(context, popularItems, cubit);
        // CustomerObject? userData = cubit.customerObject;
        // userData == null ? cubit.getUserData(userUid!, context) : null;
        // state is BaseGetUserDataErrorState || state is BaseGetPopularItemsErrorState || state is BaseGetItemsErrorState
        //     ? errorScreen(context)
        //     : (state is BaseGetPopularItemsLoadingState ||
        //             items.isEmpty && popularItems.isEmpty ||
        //             cubit.customerObject == null ||
        //             cubit.placeName == null
        //         ? loadingScreen()
        //         : homeScreen(context, popularItems, cubit));
      }),
    );
  }

  Widget getHomeScreen(
      BuildContext context, BaseCubit cubit, BaseStates state, List<ItemObject> popularItems, List<ItemObject> items) {
    // loading state :
    if (state is BaseGetUserDataLoadingState ||
        state is GetLocationNameLoadingState ||
        state is GetCurrentLocationLoadingState ||
        state is BaseGetItemsLoadingState ||
        state is BaseGetPopularItemsLoadingState ||
        state is GetIsStoreOpenLoadingState ||
        items.isEmpty && popularItems.isEmpty ||
        cubit.customerObject == null ||
        cubit.placeName == null) return loadingScreen();

    // error state :
    if (state is BaseGetUserDataErrorState ||
        state is GetCurrentLocationErrorState ||
        state is BaseGetItemsErrorState ||
        state is BaseGetPopularItemsErrorState ||
        state is GetIsStoreOpenErrorState) return errorScreen(context);
    if (!cubit.isStoreOpen) return closedScreen();

    // Success state :
    if (state is BaseGetUserDataSuccessState ||
        state is GetLocationNameSuccessState ||
        state is GetCurrentLocationSuccessState ||
        state is BaseGetItemsSuccessState ||
        state is BaseGetPopularItemsSuccessState ||
        state is GetIsStoreOpenSuccessState ||
        items.isNotEmpty && popularItems.isNotEmpty ||
        cubit.customerObject != null ||
        cubit.placeName != null) return homeScreen(context, popularItems, cubit);

    return loadingScreen();
  }

  Container homeScreen(BuildContext context, List<ItemObject> popularItems, BaseCubit cubit) {
    return Container(
      // color: ColorManager.whiteGrey.withOpacity(0.7),
      color: Theme.of(context).primaryColor,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: kBottomNavigationBarHeight / 2),
            SizedBox(height: MediaQuery.of(context).viewPadding.top * 0.8),
            appBar(context, cubit.placeName!, cubit),
            SizedBox(height: AppPadding.p12.sp),
            titleWidget(AppStrings.category),
            SizedBox(height: AppPadding.p12.sp),
            allCategories(context),
            SizedBox(height: AppPadding.p12.sp),
            titleWidget(AppStrings.popularItems),
            SizedBox(height: AppPadding.p12.sp),
            populatItemList(popularItems),
            SizedBox(height: AppPadding.p12.sp),
            titleWidget(AppStrings.more),
            SizedBox(height: AppPadding.p12.sp),
            moreItemsGridView(cubit, context),
          ],
        ),
      ),
    );
  }

  Widget appBar(BuildContext context, String location, BaseCubit cubit) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.p16.sp, horizontal: AppPadding.p10.sp).copyWith(bottom: 0),
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
                  Icon(
                    Icons.location_on,
                    size: AppSize.s20.sp,
                  ),
                  InkWell(
                    onTap: () => cubit.openMap(),
                    child: Text(
                      location,
                      style: getMeduimStyle(color: ColorManager.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              if ((cubit.customerObject?.uid ?? 'null') == AppStrings.adminID)
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.admin);
                  },
                  icon: const Icon(
                    Icons.admin_panel_settings_outlined,
                  ),
                ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.favorite);
                },
                icon: const Icon(
                  Icons.favorite_border,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  SizedBox allCategories(BuildContext context) {
    return SizedBox(
      height: AppSize.s80.sp,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          categoryContainer(context, ImageAsset.pizzaImage, AppStrings.pizza),
          categoryContainer(context, ImageAsset.burgerImage, AppStrings.burger),
          categoryContainer(context, ImageAsset.friesImage, AppStrings.snack),
          categoryContainer(context, ImageAsset.sodaImage, AppStrings.drink),
          categoryContainer(context, ImageAsset.cake2Image, AppStrings.dessert),
          categoryContainer(context, ImageAsset.hotdogImage, AppStrings.hotdog),
        ],
      ),
    );
  }

  Widget categoryContainer(BuildContext context, String image, String title) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p6),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.mealsByCategory, arguments: getItemCategory(title));
        },
        child: Container(
          height: AppSize.s80.sp,
          width: AppSize.s80.sp,
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

  ItemCategory getItemCategory(String title) {
    if (title == AppStrings.fastFood) return ItemCategory.FASTFOOD;
    if (title == AppStrings.drink) return ItemCategory.DRINK;
    if (title == AppStrings.dessert) return ItemCategory.DESSERT;
    if (title == AppStrings.pizza) return ItemCategory.PIZZA;
    if (title == AppStrings.burger) return ItemCategory.BURGER;
    if (title == AppStrings.hotdog) return ItemCategory.HOTDOG;
    if (title == AppStrings.snack) {
      return ItemCategory.SNACK;
    } else {
      return ItemCategory.FASTFOOD;
    }
  }

  Widget populatItemList(List<ItemObject> items) {
    return SizedBox(
      height: AppSize.s200.sp,
      width: double.infinity,
      child: ListView.builder(
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          ItemObject item = items[index];

          return popularItemContainer(context, item);
        },
      ),
    );
  }

  Padding popularItemContainer(BuildContext context, ItemObject item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p8.sp, vertical: AppPadding.p6.sp),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.mealDetail, arguments: item);
        },
        child: Container(
          width: AppSize.s200.sp,
          padding: EdgeInsets.all(AppPadding.p10.sp),
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
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: item.image,
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s20.sp),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      // height: AppSize.s150,
                      // width: AppSize.s150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(AppSize.s20.sp),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      // height: AppSize.s150,
                      // width: AppSize.s150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(AppSize.s20.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSize.s10.sp),
              Text(
                item.title.isEmpty ? 'Meal' : item.title,
                style: getMeduimStyle(color: ColorManager.black),
              ),
              SizedBox(
                width: AppSize.s200.sp,
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
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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
  }

  Widget moreItemsGridView(BaseCubit cubit, BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cubit.items.length,
      padding: const EdgeInsets.all(0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: getGridViewNumOfItem(context)),
      itemBuilder: (context, index) {
        ItemObject item = cubit.items[index];
        return itemContainer(context, item);
      },
    );
  }

  Widget titleWidget(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p10.sp),
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
