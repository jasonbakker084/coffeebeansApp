import 'dart:async';

import 'package:coffeebeans/data/bean.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Preferences extends Model {

  static const _cafeineKey = "cafeine";
  static const _preferredCategoriesKey = "preferredCategories";

  Future<void> _loading;

  int _desiredCafeine = 2000;

  Set<BeanCategory> _preferredCategories = Set<BeanCategory>();

  Future<int> get desiredCafeine async {
    await _loading;
    return _desiredCafeine;
  }

  Future<Set<BeanCategory>> get preferredCategories async {
    await _loading;
    return Set.from(_preferredCategories);
  }

  Future<void> addPreferredCategory(BeanCategory category) async {
    _preferredCategories.add(category);
    await _saveToSharedPrefs();
    notifyListeners();
  }

  Future<void> removePreferredCategory(BeanCategory category) async {
    _preferredCategories.remove(category);
    await _saveToSharedPrefs();
    notifyListeners();
  }

  Future<void> setDesiredCafeine(int cafeine) async {
    _desiredCafeine = cafeine;
    await _saveToSharedPrefs();
    notifyListeners();
  }

  void load() {
    _loading = _loadFromSharedPrefs();
  }

  Future<void> _saveToSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_cafeineKey, _desiredCafeine);

    // Store preferred categories as a comma-separated string containing their
    // indices.
    await prefs.setString(_preferredCategoriesKey,
        _preferredCategories.map((c) => c.index.toString()).join(','));
  }

  Future<void> _loadFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _desiredCafeine = prefs.getInt(_cafeineKey) ?? 2000;
    _preferredCategories.clear();
    final names = prefs.getString(_preferredCategoriesKey);

    if (names != null && names.isNotEmpty) {
      for (final name in names.split(',')) {
        final index = int.tryParse(name) ?? -1;
        if (BeanCategory.values[index] != null) {
          _preferredCategories.add(BeanCategory.values[index]);
        }
      }
    }

    notifyListeners();
  }
}