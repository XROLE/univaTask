import 'package:flutter/material.dart';
import 'package:univa_task/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      color: AppColors.primary,
      height: size.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
              height: size.height * .75,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0), // Adjust radius as needed
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: const Center(
                child: Text("I am a chosen one"),
              )),
        ],
      ),
    ));
  }
}
