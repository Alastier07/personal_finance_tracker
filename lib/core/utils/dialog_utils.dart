import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context) => showDialog(
      context: context,
      builder: (ctx) => const AlertDialog(
        content: SizedBox(
          height: 100,
          width: 100,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );

void hideDialog(BuildContext context) => Navigator.of(
      context,
      rootNavigator: true,
    ).pop();

void showErrorDialog(BuildContext context, String message) => showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(message),
      ),
    );
