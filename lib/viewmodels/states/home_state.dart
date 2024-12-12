import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  final bool isBalanceHidden;

  HomeInitial({this.isBalanceHidden = false});

  @override
  List<Object?> get props => [isBalanceHidden];
}
