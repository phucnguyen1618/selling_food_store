import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/signUp/bloc/signUp_bloc.dart';
import 'package:selling_food_store/modules/signUp/bloc/signUp_event.dart';
import 'package:selling_food_store/modules/signUp/bloc/signUp_state.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';
import 'package:selling_food_store/shared/utils/bottomsheet_utils.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/strings.dart';
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
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        Strings.signUp,
                        style: TextStyle(
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
                          text: const TextSpan(
                              text: Strings.titleAccept,
                              style: TextStyle(
                                  color: AppColor.blackColor, fontSize: 12.0),
                              children: [
                            TextSpan(
                                text: Strings.terms,
                                style: TextStyle(
                                    color: AppColor.primaryAppColor,
                                    fontSize: 12.0)),
                            TextSpan(text: Strings.toOur),
                            TextSpan(text: Strings.acknowledge),
                            TextSpan(
                                text: Strings.privacyPolicy,
                                style: TextStyle(
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
                      title: Strings.textSignUp,
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
          decoration: const InputDecoration(
            labelText: Strings.email,
            hintText: Strings.hintEmailText,
            prefixIcon: Icon(Icons.email_outlined),
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: Strings.password,
            hintText: Strings.hintPasswordText,
            prefixIcon: Icon(Icons.lock_outlined),
            suffixIcon: Icon(Icons.visibility_outlined),
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
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              Strings.titleInputUserInfo,
              style: TextStyle(
                fontSize: 24.0,
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          const Text(
            Strings.fullNameInputUserInfo,
            style: TextStyle(
              fontSize: 14.0,
              color: AppColor.primaryAppColor,
            ),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: fullNameController,
            decoration: const InputDecoration(
              hintText: Strings.hintTextInputNameUserInfo,
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            Strings.birthDayInputUserInfo,
            style: TextStyle(
              fontSize: 14.0,
              color: AppColor.primaryAppColor,
            ),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: birthDayController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: Strings.hintTextInputBirthDayUserInfo,
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
          const Text(
            Strings.textInputSexUserInfo,
            style: TextStyle(
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
                items: const [
                  DropdownMenuItem(
                    value: 0,
                    child: Text('Nam'),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text('Nữ'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('Giới tính khác'),
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
          const Text(
            Strings.textInputAddressUserInfo,
            style: TextStyle(
              fontSize: 14.0,
              color: AppColor.primaryAppColor,
            ),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: addressController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: Strings.hintTextInputAddressUserInfo,
              border: OutlineInputBorder(),
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
                  child: const Text(
                    Strings.cancelInputUserInfo,
                    style: TextStyle(
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
              )),
              const SizedBox(width: 12.0),
              Expanded(
                child: GeneralButton(
                  title: Strings.confirmInputUserInfo,
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
