import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/view/screens/category/category_screen.dart';
import 'package:flutter_woocommerce/view/screens/category/controller/category_controller.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/screens/home/widget/category_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return GetBuilder<CategoryController>(builder: (categoryController) {
      return
        (categoryController.categoryList.length == 0) ? SizedBox() :
      Column(
        children: [
          SizedBox( height: Dimensions.PADDING_SIZE_SMALL ),
          Row(children: [
            Expanded(
              child: SizedBox(
                height: 90,
                child: categoryController.categoryList != null ? ListView.builder(
                  controller: _scrollController,
                  itemCount: categoryController.categoryList.length > 15 ? 15 : categoryController.categoryList.length,
                  padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onTap: () => Get.toNamed(RouteHelper.getCategoryProductRoute(categoryController.categoryList[index])),
                        child: SizedBox(
                          width: 60,
                          child: Column(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                              child: Container(
                                color: Theme.of(context).cardColor,
                                height: 57, width: 57,
                                margin: EdgeInsets.all(1),
                                child: CustomImage(
                                  image: categoryController.categoryList[index].image != null ? categoryController.categoryList[index].image.src : '',
                                  height: 57, width: 57, fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                            Padding(
                              padding: EdgeInsets.only(right: index == 0 ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0),
                              child: Text(
                                categoryController.categoryList[index].name,
                                style: robotoRegular.copyWith(fontSize: 11, color: Theme.of(context).primaryColor),
                                maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                            ),
                          ]),
                        ),
                      ),
                    );
                  },
                ) : CategoryShimmer(categoryController: categoryController),
              ),
            ),

            categoryController.categoryList != null ? Column(
                children: [
                  InkWell(
                    onTap: ()=> Get.to(()=> CategoryScreen()),
                    child: Padding(
                      padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                      child: Container(
                        child: Center(
                          //child: Image.asset(  Get.find<LocalizationController>().isLtr  ? Images.arrow : Images, height: 20, width: 20,),
                          child: Icon( Get.find<LocalizationController>().isLtr ? Icons.arrow_forward : Icons.arrow_forward, size: 20, color: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).primaryColorLight ),
                        ),
                        margin: EdgeInsets.all(2),
                        height: 50, width: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,)
                ],
              ) : SizedBox(),
            ],
          ),
        ],
      );
    });
  }
}




