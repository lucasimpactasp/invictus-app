import 'package:flutter/material.dart';

class InvictusButton extends StatelessWidget {
  final Function onPressed;
  final String title;

  InvictusButton({
    @required this.onPressed,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: theme.primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: RaisedButton(
        onPressed: this.onPressed,
        padding: EdgeInsets.zero,
        elevation: 0,
        color: Colors.transparent,
        child: Text(
          this.title,
          style: theme.textTheme.bodyText2.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
