// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/about_us_controller.dart';
import '../../controller/controller.dart';
import '../../utils/color_category.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {

  void backClick() {
    Constant.backToFinish();
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: Scaffold(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            body: getDefaultWidget(Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                color: regularWhite,
                child: getCustumAppbar(
                    leftIcon: Get.isDarkMode
                        ? "left_arrow_white.svg"
                        : "back_arrow.svg",
                    rightPermission: false,
                    title: "About us",
                    leftFunction: () {
                      backClick();
                    },
                    givecolor: context.theme.focusColor,
                    titlecolor: context.theme.primaryColor),
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    GetBuilder<AboutUsController>(
                      init: AboutUsController(),
                      builder: (controller) {

                        return Container(
                          // color: context.theme.focusColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // getVerSpace(FetchPixels.getPixelHeight(16)),

                              (controller.model != null)

                                  ? (controller.model!.aboutUs!.isNotEmpty && controller.model!.aboutUs != null && !controller.model!.aboutUs.isBlank!)

                                  ? getHtmlWidget(
                                  context,
                                  controller.model!.aboutUs ?? "",
                                  18.sp)

                                  : getMultilineCustomFont(
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                  15,
                                  context.theme.primaryColor,
                                  fontWeight: FontWeight.w400)

                                  :
                              getMultilineCustomFont(
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                  18.sp,
                                  context.theme.primaryColor,
                                  fontWeight: FontWeight.w400)

                              // answer(removeAllHtmlTags(controller.model!.aboutUs ?? "")),
                            ],
                          ).paddingSymmetric(
                              horizontal: 20.h,
                              vertical: 20.h),
                        ).paddingSymmetric(
                            vertical: 10.h);
                      },
                    ),


                    // Container(
                    //   color: context.theme.focusColor,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       question('2. Use of your personal Data'),
                    //       getVerSpace(16.h),
                    //       answer(
                    //           "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                    //     ],
                    //   ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
                    // ).paddingSymmetric(vertical: 10.h),
                    // Container(
                    //   color: context.theme.focusColor,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       question('3. Disclosure of your personal Data'),
                    //       getVerSpace(16.h),
                    //       answer(
                    //           "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                    //     ],
                    //   ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
                    // ).paddingSymmetric(vertical: 10.h),
                  ],
                ),
              )
            ]))),
      ),
    );
  }

  question(String s) {
    return getMultilineCustomFont(
        s, 18.sp, context.theme.primaryColor, fontWeight: FontWeight.w700,
        txtHeight: 1.5.h);
  }

  answer(String s) {
    return getMultilineCustomFont(
        s, 18.sp, grey, fontWeight: FontWeight.w500, txtHeight: 1.5.h);
  }
}
