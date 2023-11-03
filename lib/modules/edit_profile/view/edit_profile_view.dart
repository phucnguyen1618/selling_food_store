import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:selling_food_store/modules/edit_profile/bloc/edit_profile_event.dart';
import 'package:selling_food_store/modules/edit_profile/bloc/edit_profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dependency_injection.dart';
import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/app_utils.dart';
import '../../../shared/utils/bottomsheet_utils.dart';
import '../../../shared/utils/strings.dart';
import '../../../shared/widgets/general/general_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController sexController = TextEditingController();

  final prefs = getIt.get<SharedPreferences>();
  DateTime dateTime = DateTime.now();
  int sex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
      if (state is DisplayEditProfileState) {
        fullNameController.text = state.userInfo.fullName;
        addressController.text = state.userInfo.address;
        dateTime = state.userInfo.birthDay;
        birthDayController.text = AppUtils.formatDateTime(dateTime);
        emailController.text = prefs.getString(Strings.email) ?? '';
        sexController.text =
            state.userInfo.sex == 0 ? Strings.male : Strings.female;
      } else if (state is ChooseBirthDayState) {
        dateTime = state.dateTime;
        birthDayController.text = AppUtils.formatDateTime(state.dateTime);
      }
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColor.whiteColor,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColor.blackColor,
              )),
          title: const Text(
            Strings.titleUpdateProfileInfo,
            style: TextStyle(
              color: AppColor.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24.0),
              CachedNetworkImage(
                width: 100.0,
                height: 100.0,
                imageUrl: Strings.avatarDemo,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: imageProvider),
                )),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: AppColor.hintGreyColor),
              ),
              const SizedBox(height: 56.0),
              TextField(
                controller: fullNameController,
                decoration: const InputDecoration(
                  labelText: Strings.fullNameInputUserInfo,
                  hintText: Strings.hintTextInputNameUserInfo,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                readOnly: true,
                controller: sexController,
                decoration: InputDecoration(
                  labelText: Strings.sexEditProfile,
                  hintText: Strings.hintSexEditProfile,
                  suffixIcon: InkWell(
                    child: const Icon(Icons.arrow_drop_down),
                    onTap: () {
                      showMenu(
                        initialValue: sex,
                        context: context,
                        position:
                            const RelativeRect.fromLTRB(16, 400, 200, 200),
                        items: [
                          PopupMenuItem(
                            value: 1,
                            child: const Text(Strings.male),
                            onTap: () {
                              setState(() {
                                sex = 1;
                              });
                            },
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: const Text(Strings.female),
                            onTap: () {
                              setState(() {
                                sex = 2;
                              });
                            },
                          ),
                          PopupMenuItem(
                            value: 3,
                            child: const Text(Strings.otherSex),
                            onTap: () {
                              setState(() {
                                sex = 3;
                              });
                            },
                          ),
                        ],
                        elevation: 8.0,
                      ).then((value) {
                        switch (value) {
                          case 1:
                            sexController.text = Strings.male;
                            break;
                          case 2:
                            sexController.text = Strings.female;
                            break;
                          case 3:
                            sexController.text = Strings.otherSex;
                            break;
                          default:
                            sexController.text = Strings.male;
                        }
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: emailController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: Strings.emailProfile,
                  hintText: Strings.hintTextEmailProfile,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: birthDayController,
                decoration: InputDecoration(
                  labelText: Strings.birthDayInputUserInfo,
                  hintText: Strings.hintTextInputBirthDayUserInfo,
                  suffixIcon: InkWell(
                    child: const Icon(Icons.event),
                    onTap: () {
                      BottomSheetUtils.showBottomSheetChooseBirthDay(
                          context: context,
                          onSelect: (newDateTime) {
                            context
                                .read<EditProfileBloc>()
                                .add(OnChooseBirthDayEvent(newDateTime));
                          });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: Strings.textInputAddressUserInfo,
                  hintText: Strings.hintTextInputAddressUserInfo,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32.0),
              GeneralButton(
                title: Strings.updateProfileInfo,
                onClick: () {
                  context.read<EditProfileBloc>().add(OnUpdateUserInfoEvent(
                      fullNameController.text,
                      addressController.text,
                      dateTime));
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
