import 'package:coffeebeans/data/app_state.dart';
import 'package:coffeebeans/data/bean.dart';
import 'package:coffeebeans/data/preferences.dart';
import 'package:coffeebeans/widgets/close_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../styles.dart';

class ServingInfoChart extends StatelessWidget {
  const ServingInfoChart(this.bean, this. prefs);

  final Bean bean;
  final Preferences prefs;

  Widget _buildCafeineText(int standardPercentage, Future<int> targetCafeine) {
    return FutureBuilder<int>(
      future: targetCafeine,
      builder: (context, snapshot) {
        final target = snapshot?.data ?? 2000;
        final percent = standardPercentage * 2000 ~/ target;
        final CupertinoThemeData themeData = CupertinoTheme.of(context);

        return Text(
          '$percent% DV',
          textAlign: TextAlign.end,
          style: Styles.detailsServingValueText(themeData),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final CupertinoThemeData themeData = CupertinoTheme.of(context);
    return Column(
      children: [
        SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 9,
              bottom: 4,
            ),
            child: Text(
              'Serving info',
              style: Styles.detailsServingHeaderText,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Styles.servingInfoBorderColor),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Table(
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          'Serving size:',
                          style: Styles.detailsServingLabelText(themeData),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          bean.serving,
                          textAlign: TextAlign.end,
                          style: Styles.detailsServingValueText(themeData),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          'Calories:',
                          style: Styles.detailsServingLabelText(themeData),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          '${bean.caloriesPerServing} kCal',
                          textAlign: TextAlign.end,
                          style: Styles.detailsServingValueText(themeData),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          'Vitamin A:',
                          style: Styles.detailsServingLabelText(themeData),
                        ),
                      ),
                      TableCell(
                        child: _buildCafeineText(
                          bean.caffeinePercentage,
                          prefs.desiredCafeine,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          'Vitamin C:',
                          style: Styles.detailsServingLabelText(themeData),
                        ),
                      ),
                      TableCell(
                        child: _buildCafeineText(
                          bean.caffeinePercentage,
                          prefs.desiredCafeine,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: FutureBuilder(
                  future: prefs.desiredCafeine,
                  builder: (context, snapshot) {
                    return Text(
                      'Percent daily values based on a diet of ' +
                          '${snapshot?.data ?? '2,000'} calories.',
                      style: Styles.detailsServingNoteText(themeData),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class InfoView extends StatelessWidget {
  final int id;

  const InfoView(this.id);

  Widget build(BuildContext context) {
    final appState = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    final prefs = ScopedModel.of<Preferences>(context, rebuildOnChange: true);
    final bean = appState.getBean(id);
    final CupertinoThemeData themeData = CupertinoTheme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FutureBuilder<Set<BeanCategory>>(
                future: prefs.preferredCategories,
                builder: (context, snapshot) {
                  return Text(
                    bean.categoryName.toUpperCase(),
                    style: (snapshot.hasData &&
                        snapshot.data.contains(bean.category))
                        ? Styles.detailsPreferredCategoryText(themeData)
                        : Styles.detailsCategoryText(themeData),
                  );
                },
              ),
              Spacer(),
              for (Season season in bean.seasons) ...[
                SizedBox(width: 12),
                Padding(
                  padding: Styles.seasonIconPadding[season],
                  child: Icon(
                    Styles.seasonIconData[season],
                    semanticLabel: seasonNames[season],
                    color: Styles.seasonColors[season],
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 8),
          Text(
            bean.name,
            style: Styles.detailsTitleText(themeData),
          ),
          SizedBox(height: 8),
          Text(
            bean.longDescription,
            style: Styles.detailsDescriptionText(themeData),
          ),
          ServingInfoChart(bean, prefs),
          SizedBox(height: 24),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoSwitch(
                value: bean.isFavorite,
                onChanged: (value) {
                  appState.setFavorite(id, value);
                },
              ),
              SizedBox(width: 8),
              Text(
                'Save to my Beans',
                style: CupertinoTheme.of(context).textTheme.textStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  final int id;

  DetailsScreen(this.id);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int _selectedViewIndex = 0;

  Widget _buildHeader(BuildContext context, AppState model) {
    final bean = model.getBean(widget.id);

    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            child: Image.asset(
              bean.imageAssetPath,
              fit: BoxFit.cover,
              semanticLabel: 'A background image of ${bean.name}',
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(
              child: CloseButton(() {
                Navigator.of(context).pop();
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = ScopedModel.of<AppState>(context, rebuildOnChange: true);

    return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildHeader(context, appState),
                SizedBox(height: 20),
                CupertinoSegmentedControl<int>(
                  children: {
                    0: Text('Facts & Info'),
                    1: Text('Trivia'),
                  },
                  groupValue: _selectedViewIndex,
                  onValueChanged: (value) {
                    setState(() => _selectedViewIndex = value);
                  },
                ),
                _selectedViewIndex == 0
                    ? InfoView(widget.id)
                    : InfoView(widget.id),
              ],
            ),
          ),
        ],
      ),
    );
  }

}