import 'package:flutter/material.dart';

import '/app/core/values/app_colors.dart';
import '/app/core/values/app_values.dart';
import '/app/core/values/text_styles.dart';

class DialogPattern extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget child;

  const DialogPattern({
    required this.title,
    required this.subTitle,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20,
      ),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        width: double.infinity,
        //height: 300,
        child: child,
      ),
    );
  }
}
