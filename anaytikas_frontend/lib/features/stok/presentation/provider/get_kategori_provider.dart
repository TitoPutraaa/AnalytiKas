import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/get_all_category.dart';
import 'package:flutter/material.dart';

class GetKategoriProvider with ChangeNotifier {
  final GetAllCategory getAllCategory;

  GetKategoriProvider({required this.getAllCategory});

  List<Kategori> _allCategory = [];
  List<Kategori> get allCategory => _allCategory;

  Future<void> loadCategory() async {
    try {
      _allCategory = await getAllCategory.call();
      notifyListeners();
    } catch (e) {
      throw Error();
    }
  }
}
