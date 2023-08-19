import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/main/base_cubit/cubit.dart';
import 'package:food_app/presentation/main/base_cubit/states.dart';
import 'package:food_app/presentation/resources/appsize.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:food_app/presentation/resources/styles_manager.dart';
import 'package:food_app/presentation/resources/widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseCubit, BaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BaseCubit.get(context);
        List<ItemObject> list = cubit.searchedItem;
        return cubit.isStoreOpen == false ? closedScreen() : searchView(cubit, list, context);
      },
    );
  }

  Container searchView(BaseCubit cubit, List<ItemObject> list, BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorManager.whiteGrey.withOpacity(0.7)),
      padding: EdgeInsets.all(AppPadding.p14.sp),
      child: Column(
        children: [
          const SizedBox(height: kBottomNavigationBarHeight),
          Center(
            child: CupertinoSearchTextField(
              autofocus: false,
              controller: cubit.searchController,
              itemSize: AppSize.s25.sp,
              itemColor: ColorManager.orange,
              backgroundColor: ColorManager.white,
              borderRadius: BorderRadius.circular(AppMargin.m20),
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p10.sp, vertical: AppPadding.p14.sp),
              prefixIcon: Icon(
                Icons.search_outlined,
                color: ColorManager.orange,
              ),
              prefixInsets: EdgeInsets.only(left: AppPadding.p10.sp),
              suffixIcon: Icon(
                Icons.clear,
                color: ColorManager.orange,
              ),
              suffixInsets: EdgeInsets.only(right: AppPadding.p10.sp),
              style: getMeduimStyle(color: ColorManager.darkOrange),
              placeholder: AppStrings.searchLable,
              // on tap search
              // onSuffixTap: () {
              //   cubit.searchItemByName();
              // },
              // real time search
              onChanged: (value) {
                cubit.searchItemByName();
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: getGridViewNumOfItem(context)),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return itemContainer(context, list[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
