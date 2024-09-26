import 'package:get_it/get_it.dart';
import 'package:hackathon24/services/backend_service.dart';

class BalanceService {
  int _balance = 0;
  int get balance => _balance;
  int _streak = 3;
  int get streak => _streak;

  final BackendService _backendService = GetIt.I.get<BackendService>();

  Future<void> addBalance(int amount) async {
    await _backendService.httpCall();
    _balance += amount;
  }

  Future<void> removeBalance(int amount) async {
    await _backendService.httpCall();
    _balance -= amount;
  }

  Future<void> increaseStreak() async {
    await _backendService.httpCall();
    _streak++;
  }

  Future<void> resetStreak() async {
    await _backendService.httpCall();
    _streak = 0;
  }
}
