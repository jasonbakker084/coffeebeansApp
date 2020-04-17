import 'package:coffeebeans/data/app_state.dart';
import 'package:coffeebeans/data/bean.dart';
import 'package:coffeebeans/widgets/bean_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:coffeebeans/data/preferences.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import '../styles.dart';

class ListScreen extends StatelessWidget {
  Widget _generateBeanRow(Bean bean, Preferences prefs, {bool inSeason = true}) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: FutureBuilder<Set<BeanCategory>>(
        future: prefs.preferredCategories,
        builder: (context, snapshot) {
          final data = snapshot.data ?? Set<BeanCategory>();
          return BeanCard(bean, inSeason, data.contains(bean.category));
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoTabView(
      builder: (context) {
        String dateString = DateFormat("MMMM y").format(DateTime.now());

        final appState =
        ScopedModel.of<AppState>(context, rebuildOnChange: true);
        final prefs =
        ScopedModel.of<Preferences>(context, rebuildOnChange: true);
        final CupertinoThemeData themeData = CupertinoTheme.of(context);
        return SafeArea(
          bottom: false,
          child: ListView.builder(
            itemCount: appState.allBeans.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dateString.toUpperCase(), style: Styles.minorText),
                      Text('In season today',
                          style: Styles.headlineText(themeData)),
                    ],
                  ),
                );
              } else if (index <= appState.availableBeans.length) {
                return _generateBeanRow(
                  appState.availableBeans[index - 1],
                  prefs,
                );
              } else if (index <= appState.availableBeans.length + 1) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Text('Not in season',
                      style: Styles.headlineText(themeData)),
                );
              } else {
                int relativeIndex =
                    index - (appState.availableBeans.length + 2);
                return _generateBeanRow(
                    appState.unavailableBeans[relativeIndex], prefs,
                    inSeason: false);
              }
            },
          ),
        );
      },
    );
  }}