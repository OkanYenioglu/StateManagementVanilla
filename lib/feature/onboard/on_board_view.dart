import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:state_managements_real_life/feature/onboard/onboard_model.dart';
import 'package:state_managements_real_life/feature/onboard/tab_indicator.dart';
import 'package:state_managements_real_life/product/padding/page_padding.dart';
import 'package:state_managements_real_life/product/widget/onboard_card.dart';

part './module/start_fab_button.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  final String _skipTile = 'Skip';

  int _selectedIndex = 0;
  bool get _isLastPage => OnBoardModels.onBoardItems.length - 1 == _selectedIndex ? true : false;
  bool get _isFirstPage => _selectedIndex == 0;

  // ---xxx
//a
  // ---xxx

  void _incrementAndChange([int? value]) {
    if (_isLastPage && value == null) {
      return;
    }
    _incrementSelectedPage(value);
  }

  void _incrementSelectedPage([int? value]) {
    setState(() {
      if (value != null) {
        _selectedIndex = value;
      } else {
        _selectedIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const PagePadding.all(),
        child: Column(
          children: [
            Expanded(
              child: _pageViewItems(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TabIndicator(selectedIndex: _selectedIndex),
                _StartFabButton(
                  isLastPage: _isLastPage,
                  onPressed: () {
                    _incrementAndChange();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      actions: [TextButton(onPressed: () {}, child: Text(_skipTile))],
      leading: _isFirstPage
          ? null
          : IconButton(onPressed: () {}, color: ColorUtilities().greyColor, icon: const Icon(Icons.chevron_left_outlined)),
    );
  }

  PageView _pageViewItems() {
    return PageView.builder(
      onPageChanged: (value) {
        _incrementAndChange(value);
      },
      itemCount: OnBoardModels.onBoardItems.length,
      itemBuilder: (context, index) {
        return OnBoardCard(
          model: OnBoardModels.onBoardItems[index],
        );
      },
    );
  }
}

class ColorUtilities {
  Color greyColor = Colors.grey;
}
