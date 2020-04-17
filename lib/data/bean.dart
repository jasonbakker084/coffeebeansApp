import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

enum BeanCategory {
  arabica,
  robusta,
}

enum Season {
  winter,
  spring,
  summer,
  autumn,
}

const Map<BeanCategory, String> beanCategoryNames = {
  BeanCategory.arabica: "Arabica",
  BeanCategory.robusta: "Robusta"
};

const Map<Season, String> seasonNames = {
  Season.winter: 'Winter',
  Season.spring: 'Spring',
  Season.summer: 'Summer',
  Season.autumn: 'Autumn',
};

class Bean {
  Bean({
    @required this.id,
    @required this.name,
    @required this.imageAssetPath,
    @required this.category,
    @required this.shortDescription,
    @required this.longDescription,
    @required this.leafTipColor,
    @required this.seasons,
    @required this.caffeinePercentage,
    @required this.serving,
    @required this.caloriesPerServing,
    this.isFavorite = false,
});

  final int id;

  final String name;

  final String imageAssetPath;

  final BeanCategory category;

  final String shortDescription;

  final String longDescription;

  final Color leafTipColor;

  final List<Season> seasons;

  final int caffeinePercentage;

  final String serving;

  final int caloriesPerServing;

  bool isFavorite;

  String get categoryName => beanCategoryNames[category];

}