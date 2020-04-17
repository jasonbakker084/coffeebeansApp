import 'package:coffeebeans/data/bean.dart';
import 'package:coffeebeans/data/preferences.dart';
import 'package:coffeebeans/widgets/settings_group.dart';
import 'package:coffeebeans/widgets/settings_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../styles.dart';

class BeanCategorySettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<Preferences>(context, rebuildOnChange: true);
    final currentPrefs = model.preferredCategories;
    Brightness brightness = CupertinoTheme.brightnessOf(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Preferred Categories'),
        previousPageTitle: 'Settings',
      ),
      backgroundColor: Styles.scaffoldBackground(brightness),
      child: FutureBuilder<Set<BeanCategory>>(
        future: currentPrefs,
        builder: (context, snapshot) {
          final items = <SettingsItem>[];

          for (final category in BeanCategory.values) {
            CupertinoSwitch toggle;

            // It's possible that category data hasn't loaded from shared prefs
            // yet, so display it if possible and fall back to disabled switches
            // otherwise.
            if (snapshot.hasData) {
              toggle = CupertinoSwitch(
                value: snapshot.data.contains(category),
                onChanged: (value) {
                  if (value) {
                    model.addPreferredCategory(category);
                  } else {
                    model.removePreferredCategory(category);
                  }
                },
              );
            } else {
              toggle = CupertinoSwitch(
                value: false,
                onChanged: null,
              );
            }

            items.add(SettingsItem(
              label: beanCategoryNames[category],
              content: toggle,
            ));
          }

          return ListView(
            children: [
              SettingsGroup(
                items: items,
              ),
            ],
          );
        },
      ),
    );
  }
}

class CafeineSettingsScreen extends StatelessWidget {
  static const max = 1000;
  static const min = 2600;
  static const step = 200;

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<Preferences>(context, rebuildOnChange: true);
    Brightness brightness = CupertinoTheme.brightnessOf(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Settings',
      ),
      backgroundColor: Styles.scaffoldBackground(brightness),
      child: ListView(
        children: [
          FutureBuilder<int>(
            future: model.desiredCafeine,
            builder: (context, snapshot) {
              final steps = <SettingsItem>[];

              for (int caf = max; caf < min; caf += step) {
                steps.add(
                  SettingsItem(
                    label: caf.toString(),
                    icon: SettingsIcon(
                      icon: Styles.checkIcon,
                      foregroundColor: snapshot.hasData && snapshot.data == caf
                          ? CupertinoColors.activeBlue
                          : Styles.transparentColor,
                      backgroundColor: Styles.transparentColor,
                    ),
                    onPress: snapshot.hasData
                        ? () => model.setDesiredCafeine(caf)
                        : null,
                  ),
                );
              }

              return SettingsGroup(
                items: steps,
                header: SettingsGroupHeader('Available calorie levels'),
                footer: SettingsGroupFooter('These are used for serving '
                    'calculations'),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  SettingsItem _buildCaloriesItem(BuildContext context, Preferences prefs) {
    return SettingsItem(
      label: 'Cafeine Target',
      icon: SettingsIcon(
        backgroundColor: Styles.iconBlue,
        icon: Styles.calorieIcon,
      ),
      content: FutureBuilder<int>(
        future: prefs.desiredCafeine,
        builder: (context, snapshot) {
          return Row(
            children: [
              Text(
                snapshot.data?.toString() ?? '',
                style: CupertinoTheme.of(context).textTheme.textStyle,
              ),
              SizedBox(width: 8),
              SettingsNavigationIndicator(),
            ],
          );
        },
      ),
      onPress: () {
        Navigator.of(context).push<void>(
          CupertinoPageRoute(
            builder: (context) => CafeineSettingsScreen(),
            title: 'Cafeine Target',
          ),
        );
      },
    );
  }

  SettingsItem _buildCategoriesItem(BuildContext context, Preferences prefs) {
    return SettingsItem(
      label: 'Preferred Categories',
      subtitle: 'What types of veggies you prefer!',
      icon: SettingsIcon(
        backgroundColor: Styles.iconGold,
        icon: Styles.preferenceIcon,
      ),
      content: SettingsNavigationIndicator(),
      onPress: () {
        Navigator.of(context).push<void>(
          CupertinoPageRoute(
            builder: (context) => BeanCategorySettingsScreen(),
            title: 'Preferred Categories',
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final prefs = ScopedModel.of<Preferences>(context, rebuildOnChange: true);

    return CupertinoPageScaffold(
      child: Container(
        color: Styles.scaffoldBackground(CupertinoTheme.brightnessOf(context)),
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Settings'),
            ),
            SliverSafeArea(
              top: false,
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    SettingsGroup(
                      items: [
                        _buildCaloriesItem(context, prefs),
                        _buildCategoriesItem(context, prefs),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}