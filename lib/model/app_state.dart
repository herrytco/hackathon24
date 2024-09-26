import 'package:get_it/get_it.dart';
import 'package:hackathon24/services/balance_service.dart';

class AppState {
  final int balance;

  double get euro {
    return balance / 102.0;
  }

  double get co2 {
    return balance / 777;
  }

  AppState(this.balance);
}

Future<AppState> loadAppState() async {
  int balance = GetIt.I.get<BalanceService>().balance;

  return AppState(balance);
}
