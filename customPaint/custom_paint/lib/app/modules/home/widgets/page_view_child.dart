import 'package:custom_paint/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_paint_widget.dart';

class PageViewChild extends GetView<HomeController> {
  const PageViewChild({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPadding(
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.all(controller.isPageViewOpen ? 50.0 : 0),
        child: GestureDetector(
          onTap: !controller.isPageViewOpen
              ? null
              : () {
                  controller.isPageViewOpen = false;
                },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: controller.isPageViewOpen
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
            child: const CustomPaintWidget(),
          ),
        ),
      ),
    );
  }
}
