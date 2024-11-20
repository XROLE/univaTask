import 'package:flutter/material.dart';
import 'package:univa_task/utils/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height * .09,
        width: size.height * .09,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.height * .02),
            bottomLeft: Radius.circular(size.height * .02),
            bottomRight: Radius.circular(size.height * .02),
          ),
        ),
        child: Center(
          child: Icon(
            Icons.chat_bubble,
            size: size.height * .04,
          ),
        ));
  }
}
