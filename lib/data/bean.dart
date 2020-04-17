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

enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}

const Map<Month, String> months = {
  Month.january: 'January',
  Month.february: 'February',
  Month.march: 'March',
  Month.april: 'April',
  Month.may: 'May',
  Month.june: 'June',
  Month.july: 'July',
  Month.august: 'August',
  Month.september: 'Septmeber',
  Month.october: 'October',
  Month.november: 'November',
  Month.december: 'December',
};

enum Country {
  brazil,
  vietnam,
  colombia,
  indonesia,
  ethiopia,
  honduras,
  india,
  uganda,
  mexico,
  guatemala,
  peru,
  nicaragua,
  china,
  ivoryCoast,
  costaRica,
  kenya,
  papuaNewGuinea,
  tanzania,
  elSalvador,
  ecuador,
  cameroon,
  laos,
  madagascar,
  gabon,
  thailand,
  venezuela,
  dominicanRepuclic,
  haiti,
  congo,
  rwanda,
  burundi,
  philippines,
  togo,
  guinea,
  yemen,
  cuba,
  panama,
  bolivia,
  timorLeste,
  nigeria,
  ghana,
  sierraLeon,
  angola,
  jamaica,
  paraguay,
  malawi,
  tobago,
  zimbabwe,
  zambia,
  liberia,
}

const Map<Country, String> countryNames = {
  Country.brazil: 'Brazil',
  Country.vietnam: 'Vietnam',
  Country.colombia: 'Colombia',
  Country.indonesia: 'Indonesia',
  Country.ethiopia: 'Ethiopia',
  Country.honduras: 'Honduras',
  Country.india: 'India',
  Country.uganda: 'Uganda',
  Country.mexico: 'Mexico',
  Country.guatemala: 'Guatemala',
  Country.peru: 'Peru',
  Country.nicaragua: 'Nicaragua',
  Country.china: 'China',
  Country.ivoryCoast: 'Ivory Coast',
  Country.costaRica: 'Costa Rica',
  Country.kenya: 'Kenya',
  Country.papuaNewGuinea: 'Papua New Guinea',
  Country.tanzania: 'Tanzania',
  Country.elSalvador: 'El Salvador',
  Country.ecuador: 'Eceador',
  Country.cameroon: 'Cameroon',
  Country.laos: 'Laos',
  Country.madagascar: 'Madagascar',
  Country.gabon: 'Gabon',
  Country.thailand: 'Thailand',
  Country.venezuela: 'Venezuela',
  Country.dominicanRepuclic: 'Dominican Republic',
  Country.haiti: 'Haiti',
  Country.congo: 'Congo',
  Country.rwanda: 'Rwanda',
  Country.burundi: 'Burundi',
  Country.philippines: 'Philippines',
  Country.togo: 'Togo',
  Country.guinea: 'Guinea',
  Country.yemen: 'Yemen',
  Country.cuba: 'Cuba',
  Country.panama: 'Panama',
  Country.bolivia: 'Bolivia',
  Country.timorLeste: 'Timor Leste',
  Country.nigeria: 'Nigeria',
  Country.ghana: 'Ghana',
  Country.sierraLeon: 'Sierra Leon',
  Country.angola: 'Angola',
  Country.jamaica: 'Jamaica',
  Country.paraguay: 'Paraguay',
  Country.malawi: 'Malawi',
  Country.tobago: 'Tobago',
  Country.zimbabwe: 'Zimbabwe',
  Country.liberia: 'Liberia',
  Country.zambia: 'Zambia',
};

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
    @required this.countries,
    @required this.imageAssetPath,
    @required this.category,
    @required this.shortDescription,
    @required this.longDescription,
    @required this.leafTipColor,
    @required this.seasons,
    @required this.harvestMonth,
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

  final List<Month> harvestMonth;

  final List<Country> countries;

  final int caffeinePercentage;

  final String serving;

  final int caloriesPerServing;

  bool isFavorite;

  String get categoryName => beanCategoryNames[category];

}