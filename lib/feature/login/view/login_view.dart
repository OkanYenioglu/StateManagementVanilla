import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_managements_real_life/feature/login/viewModel/login_view_model.dart';
import 'package:state_managements_real_life/product/constant/image_enum.dart';
import 'package:kartal/kartal.dart';
import 'package:state_managements_real_life/product/model/state/user_context.dart';
import 'package:state_managements_real_life/product/padding/page_padding.dart';
import 'package:state_managements_real_life/product/utility/input_decoration.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final String checkTileTitle = 'Remember me';
  final String loginTitle = 'Login';
  final String loginHintTitle = 'Name';

  late final LoginViewModel _loginViewModel;

  @override
  void initState() {
    super.initState();
    _loginViewModel = LoginViewModel();
    print(context.read<UserContext?>()?.name);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loginViewModel,
      builder: (context, child) {
        return _bodyView(context);
      },
    );
  }

  Scaffold _bodyView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<UserContext?>()?.name ?? ''),
        leading: _loadingWidget(),
      ),
      body: Padding(
        padding: const PagePadding.allow(),
        child: Column(
          children: [
            AnimatedContainer(
              duration: context.durationLow,
              height: context.isKeyBoardOpen ? 0 : context.dynamicHeight(0.3),
              child: ImageEnums.door.toImage,
            ),
            Text('Login', style: context.textTheme.headline3),
            TextField(
              decoration: ProjectInputs(loginHintTitle),
            ),
            ElevatedButton(
              onPressed: _loginViewModel.isLoading
                  ? null
                  : () {
                      _loginViewModel.controlTextValue();
                    },
              child: Center(child: Text(loginTitle)),
            ),
            CheckboxListTile(
              title: Text(checkTileTitle),
              value: context.watch<LoginViewModel>().isCheckBoxOkay,
              onChanged: (value) {
                context.read<LoginViewModel>().checkBoxChecked(value ?? false);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    return Selector<LoginViewModel, bool>(builder: ((context, value, child) {
      return value ? Center(child: const CircularProgressIndicator()) : SizedBox();
    }), selector: ((context, viewModel) {
      return viewModel.isLoading;
    }));
    return Consumer<LoginViewModel>(builder: (context, value, child) {
      return value.isLoading ? const Center(child: const CircularProgressIndicator()) : const SizedBox();
    });
  }
}
