import 'package:flutter/material.dart';
import 'package:recipeapp/Styling/styling.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget actionWidget;
  final VoidCallback function;
  CustomAppBar({required this.actionWidget, required this.function});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primaryColor,
      leading: IconButton(
        onPressed: function,
        icon: Icon(Icons.restart_alt),
        splashRadius: 22,
      ),
      actions: [],
      title: Align(alignment: Alignment.centerRight, child: actionWidget),
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
