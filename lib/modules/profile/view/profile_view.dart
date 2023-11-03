import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/profile/bloc/profile_bloc.dart';
import 'package:selling_food_store/modules/profile/bloc/profile_event.dart';
import 'package:selling_food_store/modules/profile/bloc/profile_state.dart';
import 'package:selling_food_store/shared/widgets/general/empty_data_widget.dart';
import 'package:selling_food_store/shared/widgets/general/loading_data_widget.dart';

import '../../../models/user_info.dart';
import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/app_utils.dart';
import '../../../shared/utils/show_dialog_utils.dart';
import '../../../shared/utils/strings.dart';
import '../../../shared/widgets/dialog/notify_dialog.dart';
import '../../../shared/widgets/general/general_button.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isDisplay = false;
  UserInfo? userInfo;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is DisplayProfileState) {
          isDisplay = true;
          userInfo = state.userInfo;
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
                )),
            actions: [
              userInfo != null
                  ? IconButton(
                      onPressed: () {
                        context.goNamed('editProfile', extra: userInfo);
                      },
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: AppColor.blackColor,
                      ))
                  : const SizedBox(),
            ],
          ),
          body: isDisplay
              ? userInfo != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                width: 64.0,
                                height: 64.0,
                                imageUrl: Strings.avatarDemo,
                                fit: BoxFit.cover,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                        decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: imageProvider),
                                )),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    color: AppColor.hintGreyColor),
                              ),
                              const SizedBox(width: 12.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    userInfo!.fullName,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      color: AppColor.blackColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    userInfo!.address,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        '${Strings.sexProfile} ${userInfo!.sex == 0 ? Strings.male : Strings.female}',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      const SizedBox(width: 12.0),
                                      Text(
                                        '${Strings.birthDayProfile} ${AppUtils.formatDateTime(userInfo!.birthDay)}',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          _buildLabel(
                              Strings.orderManage, Icons.assessment_outlined,
                              () {
                            context.goNamed('orderList');
                          }),
                          const SizedBox(height: 12.0),
                          _buildLabel(Strings.paymentManage,
                              Icons.attach_money_outlined, () {}),
                          const SizedBox(height: 12.0),
                          _buildLabel(
                              Strings.yourCart, Icons.shopping_bag_outlined,
                              () {
                            context.goNamed('yourCart');
                          }),
                          const SizedBox(height: 12.0),
                          _buildLabel(
                              Strings.changeLanguage, Icons.language, () {}),
                          const SizedBox(height: 12.0),
                          _buildLabel(
                              Strings.changePassword, Icons.autorenew, () {}),
                          const SizedBox(height: 24.0),
                          GeneralButton(
                            title: Strings.signOut,
                            backgroundColor: Colors.red,
                            onClick: () {
                              context.read<ProfileBloc>().add(OnSignOutEvent());
                            },
                          ),
                          const SizedBox(height: 8.0),
                          GeneralButton(
                            title: Strings.deleteAccount,
                            isStroke: true,
                            isTransparent: true,
                            borderColor: Colors.red,
                            textColor: Colors.red,
                            onClick: () {},
                          ),
                        ],
                      ))
                  : EmptyDataWidget(
                      emptyType: EmptyType.profileEmpty,
                      onClick: () {
                        context.pushNamed('signIn');
                      })
              : const LoadingDataWidget(
                  loadingType: LoadingDataType.loadingUserInfo),
        );
      },
      listener: (context, state) {
        if (state is ConfirmSignOutState) {
          context.pop();
        } else if (state is SignOutState) {
          ShowDialogUtils.showDialogNotify(
              context: context,
              typeDialog: NotifyTypeDialog.notifyConfirmSignOut,
              message: Strings.signOutRequest,
              onConfirm: () {
                context.read<ProfileBloc>().add(OnConfirmSignOutEvent());
              });
        } else if (state is ErrorState) {
          EasyLoading.showError(state.error);
        }
      },
    );
  }

  Widget _buildLabel(String name, IconData icon, Function() onClicked) {
    return ListTile(
      leading: Icon(icon),
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0.0,
      title: Text(
        name,
        style: const TextStyle(
          color: AppColor.blackColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          onClicked();
        },
        icon: const Icon(
          Icons.chevron_right_outlined,
          size: 32.0,
        ),
      ),
      onTap: () {
        onClicked();
      },
    );
  }
}
