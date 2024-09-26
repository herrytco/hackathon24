import 'package:get_it/get_it.dart';
import 'package:hackathon24/model/chargepoint.dart';
import 'package:hackathon24/services/balance_service.dart';
import 'package:hackathon24/services/chargepoint_service.dart';

class AppState {
  final int balance;
  final int streak;
  final List<ChargePoint> chargePoints;

  double get euro {
    return balance / 102.0;
  }

  double get co2 {
    return balance / 777;
  }

  AppState(this.balance, this.chargePoints, this.streak);
}

Future<AppState> loadAppState() async {
  return AppState(
    GetIt.I.get<BalanceService>().balance,
    await GetIt.I.get<ChargePointService>().loadChargePoints(),
    GetIt.I.get<BalanceService>().streak,
  );
}
