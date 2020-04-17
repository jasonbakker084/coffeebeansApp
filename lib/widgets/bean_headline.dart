import 'package:coffeebeans/data/bean.dart';
import 'package:coffeebeans/screens/details.dart';
import 'package:flutter/cupertino.dart';

import '../styles.dart';

class ZoomClipAssetImage extends StatelessWidget {
  const ZoomClipAssetImage(
      {@required this.zoom,
        this.height,
        this.width,
        @required this.imageAsset});

  final double zoom;
  final double height;
  final double width;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: OverflowBox(
          maxHeight: height * zoom,
          maxWidth: width * zoom,
          child: Image.asset(
            imageAsset,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class BeanHeadline extends StatelessWidget {
  final Bean bean;

  const BeanHeadline(this.bean);

  List<Widget> _buildSeasonDots(List<Season> seasons) {
    List<Widget> widgets = <Widget>[];

    for (Season season in seasons) {
      widgets.add(SizedBox(width: 4));
      widgets.add(
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: Styles.seasonColors[season],
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final CupertinoThemeData themeData = CupertinoTheme.of(context);

    return GestureDetector(
      onTap: () => Navigator.of(context).push<void>(CupertinoPageRoute(
        builder: (context) => DetailsScreen(bean.id),
        fullscreenDialog: true,
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZoomClipAssetImage(
            imageAsset: bean.imageAssetPath,
            zoom: 2.4,
            height: 72,
            width: 72,
          ),
          SizedBox(width: 8),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      bean.name,
                      style: Styles.headlineName(themeData),
                    ),
                    ..._buildSeasonDots(bean.seasons),
                  ],
                ),
                Text(
                  bean.shortDescription,
                  style: Styles.headlineDescription(themeData),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}