import 'package:scoped_model/scoped_model.dart';
import 'localBeanProvider.dart';
import 'bean.dart';


class AppState extends Model {

  List<Bean> _beans;
  AppState() : _beans = LocalBeanProvider.beans;
  List<Bean> get allBeans =>List<Bean>.from(_beans);
  Bean getBean(int id) => _beans.singleWhere((b) => b.id == id);

  List<Bean> get availableBeans {
    Season currentSeason = _getSeasonForDate(DateTime.now());
    return _beans.where((b) => b.seasons.contains(currentSeason)).toList();
  }

  List<Bean> get unavailableBeans {
    Season currentSeason = _getSeasonForDate(DateTime.now());
    return _beans.where((b) => !b.seasons.contains(currentSeason)).toList();
  }

  List<Bean> get favoriteBeans => _beans.where((b) => b.isFavorite).toList();

  List<Bean> searchBeans(String terms) => _beans.where((b) => b.name.toLowerCase().contains(terms.toLowerCase()))
      .toList();

  void setFavorite(int id, bool isFavorite) {
    Bean bean = getBean(id);
    bean.isFavorite = isFavorite;
    notifyListeners();
  }

  static Season _getSeasonForDate(DateTime date) {
    // Technically the start and end dates of seasons can vary by a day or so,
    // but this is close enough for produce.
    switch (date.month) {
      case 1:
        return Season.winter;
      case 2:
        return Season.winter;
      case 3:
        return date.day < 21 ? Season.winter : Season.spring;
      case 4:
        return Season.spring;
      case 5:
        return Season.spring;
      case 6:
        return date.day < 21 ? Season.spring : Season.summer;
      case 7:
        return Season.summer;
      case 8:
        return Season.summer;
      case 9:
        return date.day < 22 ? Season.autumn : Season.winter;
      case 10:
        return Season.autumn;
      case 11:
        return Season.autumn;
      case 12:
        return date.day < 22 ? Season.autumn : Season.winter;
      default:
        throw ArgumentError('Can\'t return a season for month #${date.month}.');
    }
  }
}