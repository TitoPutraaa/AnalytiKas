import 'package:anaytikas_frontend/core/shared/domain/repositories/account_repository.dart';
import 'package:anaytikas_frontend/features/analisis/domain/entities/analisis_entitiy.dart';
import 'package:anaytikas_frontend/features/analisis/domain/repository/analisis_repository.dart';

class GetAnalisis {
  final AnalisisRepository analisisRepository;
  final AccountRepository accountRepository;

  GetAnalisis({
    required this.analisisRepository,
    required this.accountRepository,
  });

  Future<AnalisisEntitiy> call() async {
    await accountRepository.syncAllData();
    return analisisRepository.getAnalisis();
  }
}
