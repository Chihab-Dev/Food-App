// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/main/base_cubit/cubit.dart';
import 'package:food_app/presentation/main/base_cubit/states.dart';
import 'package:food_app/presentation/resources/appsize.dart';
import 'package:food_app/presentation/resources/assets_manager.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:food_app/presentation/resources/styles_manager.dart';
import 'package:food_app/presentation/resources/widgets.dart';

class MealDetailScreen extends StatefulWidget {
  MealDetailScreen(this.item, {super.key});

  ItemObject item;

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  int quentity = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseCubit, BaseStates>(
      listener: (context, state) {
        if (state is BaseAddOrderToCartSuccessState) {
          successToast(AppStrings.orderAdded).show(context);
        }
        if (state is BaseAddOrderToCartErrorState) {
          errorToast(state.error).show(context);
        }
        if (state is AddItemToFavoriteErrorState) {
          errorToast(state.error).show(context);
        }
        if (state is RemoveItemFromFavoriteErrorState) {
          errorToast(state.error).show(context);
        }
      },
      builder: (context, state) {
        BaseCubit cubit = BaseCubit.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   iconTheme: IconThemeData(color: ColorManager.orange),
          //   elevation: 0,
          //   // title: Text(
          //   //   "Detail",
          //   //   style: getRegularStyle(color: ColorManager.orange),
          //   // ),
          //   actions: [
          //     Icon(
          //       Icons.favorite_border,
          //       color: ColorManager.orange,
          //     ),
          //   ],
          // ),
          body: Stack(
            children: [
              // SingleChildScrollView(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       // const SizedBox(height: kBottomNavigationBarHeight),
              //       showImageContainer(),
              //       const SizedBox(height: AppSize.s15),
              //       showMealDetails(widget.item),
              //     ],
              //   ),
              // ),
              customScrollViewSliver(context, cubit, state),
              Align(
                alignment: Alignment.bottomCenter,
                child: addToCartBottomContainer(cubit),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget customScrollViewSliver(BuildContext context, BaseCubit cubit, BaseStates state) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          iconTheme: IconThemeData(
            color: ColorManager.orange,
            size: AppSize.s30,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          pinned: false,
          centerTitle: false,
          expandedHeight: 300,
          stretch: true,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
            ],
            background: showImageContainer(),
          ),
        ),
        SliverToBoxAdapter(
          child: showMealDetails(widget.item, cubit, state),
        ),
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: cubit.getItemsByCategoryWithoutItemItSelf(widget.item).length,
          itemBuilder: (context, index) {
            return itemContainer(context, cubit.getItemsByCategoryWithoutItemItSelf(widget.item)[index]);
          },
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: AppSize.s80)),
      ],
    );
  }

  Container showImageContainer() {
    return Container(
      // width: double.infinity,
      // height: 350,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.item.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget showMealDetails(ItemObject item, BaseCubit cubit, BaseStates state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSize.s20),
          titleText(
            item.title,
            () {
              cubit.addItemToFavoriteList(item.id);
            },
            () {
              cubit.removeItemFromFavoriteList(item.id);
            },
            cubit.customerObject!.favoriteItems.contains(item.id),
            state,
          ),
          const SizedBox(height: AppSize.s20),
          itemDetails(item),
          const SizedBox(height: AppSize.s20),
          descriptionText(),
          const SizedBox(height: AppSize.s20),
          quantityContainer(),
          const SizedBox(height: AppSize.s20),
          text("Ingredinats"),
          const SizedBox(height: AppSize.s20),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ingrediantsContainer(ImageAsset.bread),
                ingrediantsContainer(ImageAsset.beef),
                ingrediantsContainer(ImageAsset.cheese),
                ingrediantsContainer(ImageAsset.tomato),
                ingrediantsContainer(ImageAsset.ketchup),
              ],
            ),
          ),
          const SizedBox(height: AppSize.s20),
          if (cubit.getItemsByCategoryWithoutItemItSelf(item).isNotEmpty) ...[
            text("More"),
          ]
        ],
      ),
    );
  }

  Container addToCartBottomContainer(BaseCubit cubit) {
    return Container(
      width: double.infinity,
      height: AppSize.s100,
      color: ColorManager.white.withOpacity(0.7),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "Price",
                  style: getRegularStyle(color: ColorManager.grey),
                ),
                Text(
                  "💲${widget.item.price * quentity}",
                  style: getRegularStyle(color: ColorManager.black),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                cubit.addOrder(Order(widget.item, quentity));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s25),
                  color: ColorManager.orange,
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.orange.withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: ColorManager.white,
                      ),
                      const SizedBox(width: AppSize.s15),
                      Text(
                        "Add to Cart",
                        style: getRegularStyle(color: ColorManager.white),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding ingrediantsContainer(
    String image,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p6),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: AppSize.s60,
          width: AppSize.s60,
          decoration: BoxDecoration(
            color: ColorManager.whiteGrey.withOpacity(0.7),
            borderRadius: BorderRadius.circular(AppSize.s20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p2),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(image),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleText(String text, Function() onTapIsLiked, Function() onTapIsNotLiked, bool isLiked, BaseStates state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: getRegularStyle(color: ColorManager.black),
        ),
        state is AddItemToFavoriteLoadingState || state is RemoveItemFromFavoriteLoadingState
            ? Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: ColorManager.orange,
                  ),
                ),
              )
            : isLiked
                ? IconButton(
                    onPressed: onTapIsNotLiked,
                    icon: const Icon(
                      Icons.favorite_outlined,
                    ),
                  )
                : IconButton(
                    onPressed: onTapIsLiked,
                    icon: const Icon(
                      Icons.favorite_border,
                    ),
                  ),
      ],
    );
  }

  Text text(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: getRegularStyle(color: ColorManager.black),
    );
  }

  Row itemDetails(ItemObject item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        itemDetailContainer(
          Text(
            "⭐️",
            style: getRegularStyle(color: ColorManager.darkGrey),
          ),
          Colors.yellow,
          widget.item.stars.toString(),
        ),
        itemDetailContainer(
          Text(
            "🔥",
            style: getRegularStyle(color: ColorManager.darkGrey),
          ),
          ColorManager.orange,
          "${item.calories} Calories",
        ),
        itemDetailContainer(
          Text(
            "⏰",
            style: getRegularStyle(color: ColorManager.darkGrey),
          ),
          ColorManager.orange,
          "${item.preparationTime}min",
        )
      ],
    );
  }

  Row quantityContainer() {
    return Row(
      children: [
        Text(
          "Quantity",
          overflow: TextOverflow.ellipsis,
          style: getRegularStyle(color: ColorManager.black),
        ),
        const SizedBox(width: AppSize.s20),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.whiteGrey.withOpacity(0.7),
            borderRadius: BorderRadius.circular(AppSize.s10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p6, horizontal: AppPadding.p6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      if (quentity > 1) {
                        quentity--;
                      }
                    });
                  },
                  icon: Icon(
                    Icons.remove,
                    color: ColorManager.black,
                    size: AppSize.s25,
                  ),
                ),
                const SizedBox(width: AppSize.s8),
                Text(
                  quentity.toString(),
                  style: getMeduimStyle(color: ColorManager.black),
                ),
                const SizedBox(width: AppSize.s8),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      if (quentity < 10) {
                        quentity++;
                      }
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: ColorManager.black,
                    size: AppSize.s25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Text descriptionText() {
    return Text(
      widget.item.description,
      overflow: TextOverflow.ellipsis,
      style: getMeduimStyle(color: ColorManager.ligthGrey),
      maxLines: 4,
    );
  }

  Container itemDetailContainer(Widget icon, Color? color, String title) {
    return Container(
      // width: 50,
      decoration: BoxDecoration(
        color: ColorManager.whiteGrey.withOpacity(0.7),
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            icon,
            const SizedBox(width: AppSize.s8),
            Text(
              title,
              style: getMeduimStyle(color: ColorManager.darkGrey),
            ),
          ],
        ),
      ),
    );
  }
}
