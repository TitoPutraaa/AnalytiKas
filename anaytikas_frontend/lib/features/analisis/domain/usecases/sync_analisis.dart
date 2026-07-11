import '../../../../core/shared/domain/repositories/account_repository.dart';
import '../entities/analisis_entitiy.dart';
import '../repository/analisis_repository.dart';

class SyncAnalisis {
  final AnalisisRepository analisisRepository;
  final AccountRepository accountRepository;

  SyncAnalisis({
    required this.analisisRepository,
    required this.accountRepository,
  });

  Future<AnalisisEntitiy> call() async {
    await accountRepository.syncAllData();
    return analisisRepository.getAnalisis();
  }
}
