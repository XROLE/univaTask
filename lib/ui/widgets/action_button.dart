import 'package:flutter/material.dart';
import 'package:univa_task/utils/app_colors.dart';
import 'package:univa_task/utils/app_text_style.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool isLoading;
  final Color? bgColor;
  const ActionButton(
      {required this.title,
      required this.onTap,
      this.isLoading = false,
      this.bgColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
            color: bgColor ?? AppColors.secondary,
            borderRadius: BorderRadius.circular(7)),
        child: Center(
            child: isLoading
                ? SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ))
                : Text(
                    title,
                    style: AppTextStyle.medium(color: AppColors.white, fontSize: 16),
                  )),
      ),
    );
  }
}
