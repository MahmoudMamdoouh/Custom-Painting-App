import 'package:custom_paint/app/modules/home/controllers/home_controller.dart';
import 'package:custom_paint/app/modules/home/widgets/saved_paintings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

import 'custom_button.dart';

class CustomSpeedDial extends GetView<HomeController> {
  const CustomSpeedDial({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      onOpen: () => controller.getSavedPaintingsName(),
      overlayColor: Colors.transparent,
      children: [
        SpeedDialChild(
            child: const Icon(Icons.add),
            onTap: () {
              controller.addAnotherPainting();
            }),
        SpeedDialChild(
          child: CustomPopUpButton(
            backgroundColor: Colors.grey[300],
            icon: const Icon(Icons.format_paint),
            title: const Text('Choose the painting'),
            content: Center(
              child: Obx(
                () => SizedBox(
                  height: 300.0,
                  width: 200.0,
                  child: controller.savedPaintingsKeys.toList().isEmpty
                      ? const Center(child: Text('There is no saved paintings'))
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: controller.savedPaintingsKeys.length,
                          itemBuilder: (context, index) {
                            return SavedPaintingsCard(
                                paintingName:
                                    controller.savedPaintingsKeys[index]);
                          },
                        ),
                ),
              ),
            ),
          ),
        ),
        SpeedDialChild(
            child: const Icon(Icons.pages),
            onTap: () {
              controller.openPages();
            }),
        SpeedDialChild(
          child: CustomPopUpButton(
            title: const Text('BackGroundColor color'),
            icon: const Icon(Icons.color_lens),
            content: ColorPicker(
              pickerColor: controller.backgrounColor,
              onColorChanged: (Color color) {
                controller.backgrounColor = color;
              },
            ),
          ),
        )
      ],
      icon: Icons.settings,
    );
  }
}
