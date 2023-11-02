import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('On Change: ${change.currentState} - ${change.nextState}');
    super.onChange(bloc, change);
  }
}
