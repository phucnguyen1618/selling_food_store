import 'package:equatable/equatable.dart';

abstract class CartButtonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitCartButtonState extends CartButtonState {
  final int value;

  InitCartButtonState(this.value);
}

class UpdateNumberProductInCartWhenAddState extends CartButtonState {
  final int value;

  UpdateNumberProductInCartWhenAddState(this.value);
}

class UpdateNumberProductInCartWhenRemoveState extends CartButtonState {
  final int value;

  UpdateNumberProductInCartWhenRemoveState(this.value);
}
