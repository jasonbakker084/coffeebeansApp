import 'package:coffeebeans/widgets/settings_item.dart';
import 'package:flutter/cupertino.dart';

import '../styles.dart';

class SettingsGroupHeader extends StatelessWidget {
  const SettingsGroupHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 6,
      ),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: CupertinoColors.inactiveGray,
          fontSize: 13.5,
          letterSpacing: -0.5,
        ),
      ),
    );
  }
}

class SettingsGroupFooter extends StatelessWidget {
  const SettingsGroupFooter(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 7.5,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Styles.settingsGroupSubtitle,
          fontSize: 13,
          letterSpacing: -0.08,
        ),
      ),
    );
  }
}

class SettingsGroup extends StatelessWidget {
  SettingsGroup({
    @required this.items,
    this.header,
    this.footer,
  })  : assert(items != null),
        assert(items.isNotEmpty);

  final List<SettingsItem> items;
  final Widget header;
  final Widget footer;
  @override
  Widget build(BuildContext context) {
    Brightness brightness = CupertinoTheme.brightnessOf(context);
    final dividedItems = <Widget>[items[0]];
    for (int i = 1; i < items.length; i++) {
      dividedItems.add(Container(
        color: Styles.settingsLineation(brightness),
        height: 0.3,
      ));
      dividedItems.add(items[i]);
    }

    return Padding(
      padding: EdgeInsets.only(
        top: header == null ? 35 : 22,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null) header,
          Container(
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              border: Border(
                top: BorderSide(
                  color: Styles.settingsLineation(brightness),
                  width: 0,
                ),
                bottom: BorderSide(
                  color: Styles.settingsLineation(brightness),
                  width: 0,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: dividedItems,
            ),
          ),
          if (footer != null) footer,
        ],
      ),
    );
  }
}