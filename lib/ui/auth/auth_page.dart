import 'package:flutter/material.dart';
import 'package:univa_task/app/core/di/service_locator.dart';
import 'package:univa_task/data/remote/auth_service.dart';
import 'package:univa_task/ui/auth/auth_view_model.dart';
import 'package:univa_task/ui/base/base_view.dart';
import 'package:univa_task/ui/widgets/action_button.dart';
import 'package:univa_task/ui/widgets/app_logo.dart';
import 'package:univa_task/ui/widgets/custome_text_input.dart';
import 'package:univa_task/ui/widgets/unfocus_widget.dart';
import 'package:univa_task/utils/app_colors.dart';
import 'package:univa_task/utils/app_text_style.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _HomePageState();
}

class _HomePageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseView<AuthViewModel>(
        model: AuthViewModel(sl.get<AuthService>()),
        builder: (context, model, _) {
          return Scaffold(
              body: UnfocusWidget(
            child: Container(
              color: AppColors.primary,
              height: size.height,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: size.height,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * .11),
                        const AppLogo(),
                      ],
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * .05),
                      height: size.height * .75,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                SizedBox(height: size.height * .04),
                                Text(
                                  "Login",
                                  style: AppTextStyle.title(
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: size.height * .04),
                                const CustumeTextInput(
                                  labelText: "Email",
                                ),
                                SizedBox(height: size.height * .02),
                                CustumeTextInput(
                                  labelText: "Password",
                                  obscureText: true,
                                  suffixIcon: Icon(
                                    Icons.visibility,
                                    color: AppColors.grey,
                                  ),
                                ),
                                SizedBox(height: size.height * .06),
                                ActionButton(title: "Continue", onTap: () {}),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              children: [
                                const Text("Don't have an account? Sign Up"),
                                SizedBox(height: size.height * .05),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ));
        });
  }
}
