import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/signIn/bloc/sign_in_bloc.dart';
import 'package:selling_food_store/modules/signIn/bloc/sign_in_event.dart';
import 'package:selling_food_store/modules/signIn/bloc/sign_in_state.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/image_constants.dart';
import '../../../shared/utils/show_dialog_utils.dart';
import '../../../shared/utils/strings.dart';
import '../../../shared/widgets/dialog/notify_dialog.dart';
import '../../../shared/widgets/general/general_button.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int role = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
        builder: (context, state) => Scaffold(
              backgroundColor: AppColor.whiteColor,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildFormUserSignIn(),
                  const SizedBox(height: 12.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          context.goNamed('forgotPassword');
                        },
                        child: Text(
                          'forgotPassword'.tr(),
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: AppColor.primaryAppColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GeneralButton(
                        title: 'textSignIn'.tr(),
                        radius: 100.0,
                        onClick: () {
                          context.read<SignInBloc>().add(OnUserSignInEvent(
                              emailController.text, passwordController.text));
                        }),
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'dontHaveAnAccount'.tr(),
                          style: const TextStyle(
                            color: AppColor.blackColor,
                            fontSize: 14.0,
                          ),
                          children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.goNamed('signUp');
                            },
                          text: 'textSignUp'.tr(),
                          style: const TextStyle(
                            color: AppColor.primaryAppColor,
                            fontSize: 14.0,
                          ),
                        )
                      ])),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
        listener: (context, state) {
          if (state is SignInSuccessState) {
            context.go('/home');
          } else if (state is SignInFailureState) {
            ShowDialogUtils.showDialogNotify(
                context: context,
                message: state.error,
                typeDialog: NotifyTypeDialog.notifyError);
          }
        });
  }

  Widget _buildFormUserSignIn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageConstants.logoApp,
              width: 64.0,
              height: 64.0,
            ),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  Strings.appName,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: AppColor.primaryAppColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  Strings.sologanApp,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColor.primaryAppColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 48.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            autofocus: true,
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'email'.tr(),
              labelStyle: const TextStyle(color: AppColor.primaryAppColor),
              hintText: 'hintEmailText'.tr(),
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: AppColor.primaryAppColor,
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primaryAppColor)),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            autofocus: true,
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'password'.tr(),
              labelStyle: const TextStyle(color: AppColor.primaryAppColor),
              hintText: 'hintPasswordText'.tr(),
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: AppColor.primaryAppColor,
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primaryAppColor)),
            ),
          ),
        ),
      ],
    );
  }
}
