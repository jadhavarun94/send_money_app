import 'package:flutter_bloc/flutter_bloc.dart';
import '../events/wallet_event.dart';
import '../states/wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  double _balance = 500.0; // Default wallet balance

  WalletBloc() : super(WalletInitial()) {
    on<LoadWalletBalance>((event, emit) {
      emit(WalletBalanceLoaded(_balance));
    });

    on<UpdateWalletBalance>((event, emit) {
      _balance -= event.sentAmount;
      emit(WalletBalanceLoaded(_balance));
    });
  }
}
