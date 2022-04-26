import 'package:custom_paint/app/modules/home/controllers/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedPaintingsCard extends GetView<HomeController> {
  //*================================ Properties ===============================
  final String paintingName;

  //*================================ Constructor ==============================
  const SavedPaintingsCard({required this.paintingName, Key? key})
      : super(key: key);

  //*================================= Methods =================================
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          Get.back();
          await controller.applyPainting(paintingName);
        },
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[500]!,
                  blurRadius: 15,
                  offset: const Offset(2, 2),
                  spreadRadius: 1,
                ),
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 15,
                  spreadRadius: 1,
                  offset: Offset(-2, -2),
                )
              ]),
          child: Center(child: Text(paintingName)),
        ),
      ),
    );
  }
  //*===========================================================================
}
