import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/forgotPassword/bloc/forgot_password_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:selling_food_store/shared/widgets/dialog/notify_dialog.dart';

import '../../../shared/utils/show_dialog_utils.dart';
import '../../../shared/utils/strings.dart';

class ForgotPasswordBloc extends BlocBase<ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordState());

  void onForgotPassword(BuildContext context, String email) {
    FirebaseService.forgotPasswordAccount(email, () {
      ShowDialogUtils.showDialogNotify(
        context: context,
        message: Strings.contentForgotPasswordSuccess,
        typeDialog: NotifyTypeDialog.notifySuccess,
      );
    }, (error) {
      log('Error: ${error.toString()}');
      ShowDialogUtils.showDialogNotify(
          context: context,
          message: error,
          typeDialog: NotifyTypeDialog.notifyError);
    });
  }
}
