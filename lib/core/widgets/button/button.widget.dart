import 'package:flutter/material.dart';

class InvictusButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color backgroundColor;
  final Color textColor;

  InvictusButton({
    @required this.onPressed,
    this.title,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        color: this.backgroundColor ?? Colors.transparent,
        border: Border.all(
          color: theme.primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: RaisedButton(
        onPressed: this.onPressed,
        padding: EdgeInsets.zero,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        elevation: 0,
        color: Colors.transparent,
        child: Text(
          this.title,
          style: theme.textTheme.bodyText2.copyWith(
            color: this.textColor ?? theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
