part of '../on_board_view.dart';

class _StartFabButton extends StatelessWidget {
  const _StartFabButton({Key? key, required this.isLastPage, this.onPressed}) : super(key: key);
  final String _startText = 'Start';
  final String _nextText = 'Next';

  final VoidCallback? onPressed;

  final bool isLastPage;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Text(isLastPage ? _startText : _nextText),
      onPressed: onPressed,
    );
  }
}
