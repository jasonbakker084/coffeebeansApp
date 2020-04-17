import 'package:coffeebeans/data/app_state.dart';
import 'package:coffeebeans/data/bean.dart';
import 'package:coffeebeans/widgets/bean_headline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../styles.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);

        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('My Bean'),
          ),
          child: Center(
            child: model.favoriteBeans.isEmpty
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'You haven\'t added any favorite beans to your beans yet.',
                style: Styles.headlineDescription(
                    CupertinoTheme.of(context)),
              ),
            )
                : ListView(
              children: [
                SizedBox(height: 24),
                for (Bean bean in model.favoriteBeans)
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
                    child: BeanHeadline(bean),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}