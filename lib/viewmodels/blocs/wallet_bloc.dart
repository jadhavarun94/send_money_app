import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app_assignment/repository/user_repository.dart';
import '../events/wallet_event.dart';
import '../states/wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final UserRepository userRepository;

  WalletBloc(this.userRepository) : super(WalletInitial()) {
    on<FetchBalance>((event, emit) async {
      try {
        final user = await userRepository.getUser();
        if (user != null) {
          emit(WalletLoaded(user['balance']));
        } else {
          emit(WalletError("Failed to fetch balance."));
        }
      } catch (e) {
        emit(WalletError("An error occurred."));
      }
    });

    on<UpdateBalance>((event, emit) async {
      try {
        await userRepository.updateBalance(event.newBalance);
        emit(WalletLoaded(event.newBalance));
      } catch (e) {
        emit(WalletError("Failed to update balance."));
      }
    });
  }
}
