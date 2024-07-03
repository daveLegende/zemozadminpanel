import 'package:admin/components/button.dart';
import 'package:admin/constants.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import 'constant.dart';

class MesFunctions {
  Future<dynamic> addDialog({
    required BuildContext context,
    required Widget child,
    required String title,
    required double height,
    required double width,
    Callback? onDismiss,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return DialogParentWidget(
          title: title,
          child: child,
          height: height,
          width: width,
        );
      },
    ).then((value) => onDismiss);
  }

  // delete or stop dialog
  Future<dynamic> deleteorStopDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String buttonText,
    required Callback? onDel,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height;
        return Align(
          alignment: Alignment.center,
          child: AnimatedContainer(
            width: width / 4,
            height: height / 4,
            duration: Duration(seconds: 1),
            curve: Curves.easeIn,
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: mwhite,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: StyleText().transStyle,
                ),
                Text(content, textAlign: TextAlign.center,),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedB(
                        text: "Annuler",
                        color: bgColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: CustomElevatedB(
                        text: buttonText,
                        color: mbSeconderedColorKbe,
                        onPressed: onDel,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DialogParentWidget extends StatelessWidget {
  const DialogParentWidget({
    super.key,
    required this.child,
    required this.title,
    required this.width,
    required this.height,
  });
  final Widget child;
  final String title;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: Duration(seconds: 2),
        curve: Easing.emphasizedAccelerate,
        padding: EdgeInsets.all(defaultPadding),
        margin: EdgeInsets.only(
          top: appBarHeight,
          bottom: appBarHeight,
          // left: width / 5,
          // right: 50,
        ),
        width: width, //width / 1.5,
        height: height,
        decoration: BoxDecoration(
          color: mwhite,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Material(
          color: mtransparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: StyleText().transStyle,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
