import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/signUp/bloc/signUp_bloc.dart';
import 'package:selling_food_store/modules/signUp/bloc/signUp_event.dart';
import 'package:selling_food_store/modules/signUp/bloc/signUp_state.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';
import 'package:selling_food_store/shared/utils/bottomsheet_utils.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/widgets/general/general_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isAccept = false;
  int sex = 0;
  DateTime dateTime = DateTime.now();
  String? error;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      if (state is ErrorSignUpState) {
        error = state.message;
      }
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColor.whiteColor,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.blackColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: state is SuccessSignUpWithEmailPasswordState
              ? _buildInputUserProfileForm()
              : Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'signUp'.tr(),
                        style: const TextStyle(
                          fontSize: 24.0,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    _buildUserSignUpForm(),
                    const SizedBox(height: 16.0),
                    CheckboxListTile(
                      value: isAccept,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: RichText(
                          text: TextSpan(
                              text: 'titleAccept'.tr(),
                              style: const TextStyle(
                                  color: AppColor.blackColor, fontSize: 12.0),
                              children: [
                            TextSpan(
                                text: 'terms'.tr(),
                                style: const TextStyle(
                                    color: AppColor.primaryAppColor,
                                    fontSize: 12.0)),
                            TextSpan(text: 'toOur'.tr()),
                            TextSpan(text: 'acknowledge'.tr()),
                            TextSpan(
                                text: 'privacyPolicy'.tr(),
                                style: const TextStyle(
                                    color: AppColor.primaryAppColor,
                                    fontSize: 12.0)),
                          ])),
                      onChanged: (value) {
                        setState(() {
                          isAccept = value ?? false;
                        });
                      },
                    ),
                    const SizedBox(height: 24.0),
                    GeneralButton(
                      title: 'textSignUp'.tr(),
                      onClick: () {
                        if (isAccept) {
                          context.read<SignUpBloc>().add(OnSignUpAccountEvent(
                              emailController.text, passwordController.text));
                        }
                      },
                    ),
                    const SizedBox(height: 12.0),
                    error != null
                        ? Text(
                            error!,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.red,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
        ),
      );
    });
  }

  Widget _buildUserSignUpForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'email'.tr(),
            hintText: 'hintEmailText'.tr(),
            prefixIcon: const Icon(Icons.email_outlined),
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: 'password'.tr(),
            hintText: 'hintPasswordText'.tr(),
            prefixIcon: const Icon(Icons.lock_outlined),
            suffixIcon: const Icon(Icons.visibility_outlined),
          ),
        ),
      ],
    );
  }

  Widget _buildInputUserProfileForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'titleInputUserInfo'.tr(),
              style: const TextStyle(
                fontSize: 24.0,
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Text(
            'fullNameInputUserInfo'.tr(),
            style: const TextStyle(
              fontSize: 14.0,
              color: AppColor.primaryAppColor,
            ),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: fullNameController,
            decoration: InputDecoration(
              hintText: 'hintTextInputNameUserInfo'.tr(),
              prefixIcon: const Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'birthDayInputUserInfo'.tr(),
            style: const TextStyle(
              fontSize: 14.0,
              color: AppColor.primaryAppColor,
            ),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: birthDayController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'hintTextInputBirthDayUserInfo'.tr(),
              suffixIcon: InkWell(
                onTap: () {
                  BottomSheetUtils.showBottomSheetChooseBirthDay(
                      context: context,
                      onSelect: (birthDay) {
                        setState(() {
                          dateTime = birthDay;
                          birthDayController.text =
                              AppUtils.formatDateTime(dateTime);
                        });
                      });
                },
                child: const Icon(Icons.event),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'textInputSexUserInfo'.tr(),
            style: const TextStyle(
              fontSize: 14.0,
              color: AppColor.primaryAppColor,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.primaryAppColor),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    value: 0,
                    child: Text('male'.tr()),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text('female'.tr()),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('otherSex'.tr()),
                  )
                ],
                onChanged: (value) {
                  setState(() {
                    sex = value ?? 0;
                  });
                },
                value: sex,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'textInputAddressUserInfo'.tr(),
            style: const TextStyle(
              fontSize: 14.0,
              color: AppColor.primaryAppColor,
            ),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: addressController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'hintTextInputAddressUserInfo'.tr(),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 48.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: AppColor.shimmerColor,
                ),
                child: MaterialButton(
                  color: AppColor.shimmerColor,
                  elevation: 0.0,
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    'cancelInputUserInfo'.tr(),
                    style: const TextStyle(
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
              )),
              const SizedBox(width: 12.0),
              Expanded(
                child: GeneralButton(
                  title: 'confirmInputUserInfo'.tr(),
                  onClick: () {
                    context.read<SignUpBloc>().add(
                        OnConfirmInputUserProfileEvent(fullNameController.text,
                            dateTime, sex, addressController.text));
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
