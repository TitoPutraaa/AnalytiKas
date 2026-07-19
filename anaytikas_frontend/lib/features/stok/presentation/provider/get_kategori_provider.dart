import 'package:anaytikas_frontend/core/shared/domain/entitties/kategori_entity.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/get_all_category.dart';
import 'package:flutter/material.dart';

class GetKategoriProvider with ChangeNotifier {
  final GetAllCategory getAllCategory;

  GetKategoriProvider({required this.getAllCategory});

  List<KategoriEntity> _allCategory = [];
  List<KategoriEntity> get allCategory => _allCategory;

  Future<void> loadCategory() async {
    try {
      _allCategory = await getAllCategory.call();
      notifyListeners();
    } catch (e) {
      throw Error();
    }
  }
}
