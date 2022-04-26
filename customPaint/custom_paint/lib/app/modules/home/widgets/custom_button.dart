import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPopUpButton extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final Icon icon;
  final Function()? buttonOnPressed;
  final double heightFactor;
  final Color? backgroundColor;
  const CustomPopUpButton({
    this.title,
    this.content,
    this.buttonOnPressed,
    required this.icon,
    this.heightFactor = 0.6,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: buttonOnPressed ??
          () async {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: backgroundColor,
                  contentPadding: EdgeInsets.zero,
                  title: title,
                  content: SizedBox(
                    height: Get.height * heightFactor,
                    child: content,
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('Got it'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                );
              },
            );
          },
      icon: icon,
    );
  }
}
