import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorAlertDialog extends StatelessWidget {
  final dynamic error;
  const ErrorAlertDialog({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      backgroundColor: Colors.black87,
      contentPadding: EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Text(
              'Error!!',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: 24,
                    color: Colors.white,
                  ),
            ),
            SizedBox(height: 4),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
            ),
            SizedBox(height: 20),
            Divider(height: 1),
            Container(
              height: 56,
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Center(
                  child: Text(
                    'OK',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
