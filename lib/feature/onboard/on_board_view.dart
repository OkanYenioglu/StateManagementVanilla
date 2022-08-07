import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:state_managements_real_life/feature/login/view/login_view.dart';
import 'package:state_managements_real_life/feature/onboard/onboard_model.dart';
import 'package:state_managements_real_life/feature/onboard/tab_indicator.dart';
import 'package:state_managements_real_life/product/model/state/project_context.dart';
import 'package:state_managements_real_life/product/model/state/user_context.dart';
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
  ValueNotifier<bool> isBackEnable = ValueNotifier(false);
  // ---xxx

  void _incrementAndChange([int? value]) {
    if (_isLastPage && value == null) {
      _changeBackEnable(true);
      return;
    }
    _changeBackEnable(false);
    _incrementSelectedPage(value);
  }

  void _changeBackEnable(bool value) {
    if (value == isBackEnable.value) return;

    isBackEnable.value = value;
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
      appBar: _appBar(context),
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

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(context.watch<ProductContext>().newUserName),
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      actions: [
        ValueListenableBuilder<bool>(
            valueListenable: isBackEnable,
            builder: (BuildContext context, bool value, Widget? child) {
              return value
                  ? const SizedBox()
                  : TextButton(
                      onPressed: () {
                        context.read<ProductContext>().changeName('Okan');
                        context.navigateToPage(LoginView());
                      },
                      child: Text(_skipTile));
            })
      ],
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
