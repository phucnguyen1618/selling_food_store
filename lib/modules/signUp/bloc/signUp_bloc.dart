import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:selling_food_store/dependency_injection.dart';
import 'package:selling_food_store/models/credential.dart';
import 'package:selling_food_store/modules/signUp/bloc/signUp_event.dart';
import 'package:selling_food_store/modules/signUp/bloc/signUp_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user_info.dart';
import '../../../shared/utils/strings.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final prefs = getIt.get<SharedPreferences>();

  SignUpBloc() : super(InitialSignUpState()) {
    on<OnSignUpAccountEvent>(_onSignUp);
    on<OnInitInputUserProfileEvent>(_onInputUserProfile);
    on<OnConfirmInputUserProfileEvent>(_onCofirmInputUserProfile);
    on<OnErrorEvent>(_onErrorSignUp);
  }

  void _onSignUp(OnSignUpAccountEvent event, Emitter<SignUpState> emitter) {
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      FirebaseService.signUpFirebaseWithEmail(event.email, event.password,
          (idUser) async {
        prefs.setString(Strings.email, event.email);
        prefs.setString(Strings.idUser, idUser);
        final credential = Credential(
            idUser: idUser,
            email: event.email,
            password: event.password,
            role: 0);
        FirebaseService.insertAccountInfoToDb(credential, () {
          add(OnInitInputUserProfileEvent());
        }, (error) {
          add(OnErrorEvent(error));
        });
      }, (error) {
        add(OnErrorEvent(error));
      });
    } else {
      add(OnErrorEvent(Strings.emptyInputData));
    }
  }

  void _onInputUserProfile(
      OnInitInputUserProfileEvent event, Emitter<SignUpState> emitter) {
    emitter(SuccessSignUpWithEmailPasswordState());
  }

  void _onCofirmInputUserProfile(
      OnConfirmInputUserProfileEvent event, Emitter<SignUpState> emitter) {
    final prefs = getIt.get<SharedPreferences>();
    String idUser = prefs.getString(Strings.idUser) ?? '';
    final userInfo =
        UserInfo(idUser, event.name, null, event.dateTime, event.address, event.sex);
    FirebaseService.insertUserInfoToDb(userInfo, () {
      EasyLoading.showSuccess(Strings.signUpSuccess);
    }, (error) {
      add(OnErrorEvent(error));
    });
  }

  void _onErrorSignUp(OnErrorEvent event, Emitter<SignUpState> emitter) {
    emitter(ErrorSignUpState(event.message));
  }
}
