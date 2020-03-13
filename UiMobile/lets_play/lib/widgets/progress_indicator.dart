import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        new Opacity(
          opacity: 0.3,
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child:
                  const ModalBarrier(dismissible: false, color: Colors.transparent)),
        ),
        new Center(
          child: new CircularProgressIndicator(),
        ),
      ],
    );
  }
}
