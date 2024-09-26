import 'package:get_it/get_it.dart';
import 'package:hackathon24/services/backend_service.dart';

class BalanceService {
  int _balance = 0;
  int get balance => _balance;

  final BackendService _backendService = GetIt.I.get<BackendService>();

  Future<void> addBalance(int amount) async {
    await _backendService.httpCall();
    _balance += amount;
  }

  Future<void> removeBalance(int amount) async {
    await _backendService.httpCall();
    _balance -= amount;
  }
}
