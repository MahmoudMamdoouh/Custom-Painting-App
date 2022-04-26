import 'package:custom_paint/app/modules/home/widgets/custom_appbar.dart';
import 'package:custom_paint/app/modules/home/widgets/custom_button.dart';
import 'package:custom_paint/app/modules/home/widgets/custom_speed_dial.dart';
import 'package:custom_paint/app/modules/home/widgets/page_view_child.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.backgrounColor,
        appBar: controller.isPageViewOpen
            ? AppBar(
                title: SizedBox(
                  child: Text(
                    controller.paintingName.isEmpty ||
                            controller.paintingName[
                                    controller.currentPageIndex] ==
                                ''
                        ? 'painting no.${controller.currentPageIndex + 1}'
                        : controller.paintingName[controller.currentPageIndex],
                  ),
                ),
                actions: [
                  CustomPopUpButton(
                    title: const Text('enter painting name'),
                    heightFactor: 0.2,
                    icon: const Icon(Icons.save),
                    content: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter painting name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onSubmitted: (value) {
                            controller.savePainting(value);
                          },
                        ),
                      ),
                    ),
                  )
                ],
                centerTitle: true,
                backgroundColor: Colors.transparent,
              )
            : const CustomAppBar(),
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return Obx(
              () => PageView.builder(
                itemCount: controller.numberOfPageView,
                controller: controller.pageController,
                physics: !controller.isPageViewOpen
                    ? const NeverScrollableScrollPhysics()
                    : null,
                onPageChanged: (value) {
                  controller.currentPageIndex = value;
                },
                itemBuilder: (context, index) {
                  return const PageViewChild();
                },
              ),
            );
          },
        ),
        floatingActionButton: const CustomSpeedDial(),
      ),
    );
  }
}
