// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/resources/appsize.dart';
import 'package:food_app/presentation/resources/assets_manager.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/styles_manager.dart';

class AdminMealDetail extends StatefulWidget {
  AdminMealDetail(this.item, this.imageFile, {super.key});

  ItemObject item;
  File imageFile;

  @override
  State<AdminMealDetail> createState() => _AdminMealDetailState();
}

class _AdminMealDetailState extends State<AdminMealDetail> {
  int quentity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   iconTheme: IconThemeData(color: ColorManager.orange),
      //   elevation: 0,
      // ),
      body: Container(
        color: ColorManager.white.withOpacity(0.7),
        height: double.infinity,
        child: Stack(
          children: [
            // SingleChildScrollView(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       showImageContainer(widget.imageFile),
            //       const SizedBox(height: AppSize.s15),
            //       showMealDetails(widget.item),
            //     ],
            //   ),
            // ),
            customScrollViewSliver(context),
            Align(
              alignment: Alignment.bottomCenter,
              child: addToCartBottomContainer(),
            ),
          ],
        ),
      ),
    );
  }

  CustomScrollView customScrollViewSliver(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          expandedHeight: 300,
          floating: true,
          iconTheme: IconThemeData(color: ColorManager.orange, size: AppSize.s30),
          pinned: false,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
            ],
            background: showImageContainer(widget.imageFile),
          ),
        ),
        SliverToBoxAdapter(
          child: showMealDetails(widget.item),
        ),
      ],
    );
  }

  Container addToCartBottomContainer() {
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
              onTap: () {},
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

  Container showImageContainer(File file) {
    return Container(
      width: double.infinity,
      height: 350,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(file),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget showMealDetails(ItemObject item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSize.s20),
          titleText(widget.item.title),
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
          )
        ],
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

  Widget titleText(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: getRegularStyle(color: ColorManager.black),
        ),
        IconButton(
          onPressed: () {},
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
          "${item.preparationTime} min",
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
