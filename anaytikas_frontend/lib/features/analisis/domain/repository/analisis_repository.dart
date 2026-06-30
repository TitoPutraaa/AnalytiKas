import 'package:anaytikas_frontend/features/analisis/domain/entities/analisis_entitiy.dart';

abstract class AnalisisRepository {
  Future<AnalisisEntitiy> getAnalisis(String email, String token);
}
