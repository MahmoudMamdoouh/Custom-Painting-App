import 'package:custom_paint/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_painter_brain.dart';

class CustomPaintWidget extends GetView<HomeController> {
  const CustomPaintWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        controller.isPageViewOpen
            ? null
            : controller.creatList(details.localPosition);
      },
      onPanUpdate: (details) {
        controller.isPageViewOpen
            ? null
            : controller.updateList(details.localPosition);
      },
      onPanEnd: (details) {
        controller.isPageViewOpen ? null : controller.addList();
      },
      child: Obx(
        () => GridPaper(
          interval: 1024,
          child: CustomPaint(
            size: Size.infinite,
            painter: CustomPainterBrain(
              isPageViewopen: controller.isPageViewOpen,
              offsets: controller.groub[controller.currentPageIndex].toList(),
              backgrounColor: controller.backgrounColor,
            ),
            willChange: true,
          ),
        ),
      ),
    );
  }
}
