import 'package:flutter/material.dart';
import 'package:ifood_delivery/utils/dimensions.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;

  const NoDataPage({
    Key? key,
    required this.text,
    this.imgPath = "assets/image/empty_cart.png",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_20, vertical: Dimensions.PADDING_SIZE_20*3.8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height*0.0175,
              color: Theme.of(context).dividerColor
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
