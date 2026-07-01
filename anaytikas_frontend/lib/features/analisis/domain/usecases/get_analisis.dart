import 'package:anaytikas_frontend/features/analisis/domain/entities/analisis_entitiy.dart';
import 'package:anaytikas_frontend/features/analisis/domain/repository/analisis_repository.dart';

class GetAnalisis {
  final AnalisisRepository analisisRepository;

  GetAnalisis({required this.analisisRepository});

  Future<AnalisisEntitiy> call(String email, String token) async {
    return analisisRepository.getAnalisis(email, token);
  }
}
