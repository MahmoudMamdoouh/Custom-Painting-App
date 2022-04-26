import 'package:custom_paint/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import 'custom_button.dart';

class CustomAppBar extends GetView<HomeController>
    implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomPopUpButton(
            title: const Text('font color'),
            icon: const Icon(Icons.colorize),
            content: ColorPicker(
                pickerColor: controller.fontColor,
                onColorChanged: (Color color) {
                  controller.fontColor = color;
                }),
          ),
          CustomPopUpButton(
            heightFactor: 0.4,
            title: const Text('pen size'),
            icon: const Icon(Icons.text_fields_outlined),
            content: Obx(
              () => Slider(
                label: '${controller.fontSize}',
                value: controller.fontSize,
                onChanged: (newValue) {
                  controller.fontSize = newValue;
                },
                min: 1.0,
                max: 10.0,
              ),
            ),
          ),
          CustomPopUpButton(
            icon: const Icon(Icons.clear_rounded),
            buttonOnPressed: () {
              controller.clear();
            },
          ),
          CustomPopUpButton(
            icon: const Icon(Icons.undo),
            buttonOnPressed: () {
              controller.undo();
            },
          ),
          CustomPopUpButton(
            icon: const Icon(Icons.redo),
            buttonOnPressed: () {
              // controller.applyPainting();
              controller.redo();
            },
          ),
          Draggable(
            child: const Icon(Icons.auto_fix_high),
            feedback: const Icon(
              Icons.circle_outlined,
            ),
            onDragUpdate: (details) {
              controller.reomvePoints(details.localPosition);
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xff5e85e8),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Get.height * 0.07);
}
