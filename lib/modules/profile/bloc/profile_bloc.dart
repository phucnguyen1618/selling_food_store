import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/dependency_injection.dart';
import 'package:selling_food_store/modules/profile/bloc/profile_event.dart';
import 'package:selling_food_store/modules/profile/bloc/profile_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:selling_food_store/shared/services/hive_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/utils/strings.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final prefs = getIt.get<SharedPreferences>();

  ProfileBloc() : super(InitProfileState()) {
    on<OnLoadingProfileEvent>(_getUserInfo);
    on<OnDisplayProfileEvent>(_onDisplayUserInfo);
    on<OnSignOutEvent>(_onSignOut);
    on<OnConfirmSignOutEvent>(_onConfirmSignOut);
    on<OnSignOutSuccessEvent>(_onSignOutSuccess);
    on<OnErrorEvent>(_onError);
  }

  void _getUserInfo(
      OnLoadingProfileEvent event, Emitter<ProfileState> emitter) {
    FirebaseService.getUserInfo((dataInfo) {
      if (dataInfo != null) {
        add(OnDisplayProfileEvent(dataInfo));
      } else {
        add(OnDisplayProfileEvent(null));
      }
    }, (error) {
      add(OnErrorEvent(error));
    });
  }

  void _onDisplayUserInfo(
      OnDisplayProfileEvent event, Emitter<ProfileState> emitter) {
    emitter(DisplayProfileState(userInfo: event.userInfo));
  }

  void _onSignOut(OnSignOutEvent event, Emitter<ProfileState> emitter) {
    emitter(SignOutState());
  }

  void _onConfirmSignOut(
      OnConfirmSignOutEvent event, Emitter<ProfileState> emitter) {
    FirebaseService.signOutAccount(() {
      prefs.remove(Strings.idUser);
      HiveService.deleteAllItemCart();
      add(OnSignOutSuccessEvent());
    }, (error) {
      add(OnErrorEvent(error));
    });
  }

  void _onSignOutSuccess(
      OnSignOutSuccessEvent event, Emitter<ProfileState> emitter) {
    emitter(ConfirmSignOutState());
  }

  void _onError(OnErrorEvent event, Emitter<ProfileState> emitter) {
    emitter(ErrorState(event.error));
  }
}