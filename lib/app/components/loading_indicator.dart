import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
    this.builder = _defaultSpinnerView,
  }) : super(key: key);

  final Function() builder;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: builder(),
    );
  }

  static Widget _defaultSpinnerView() {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(
        color: Color.fromARGB(150, 0, 0, 0),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: const SpinKitCircle(
        color: Colors.white,
      ),
    );
  }
}
