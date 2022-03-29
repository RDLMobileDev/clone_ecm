import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  final String? imageUri;
  String defaultAsset;
  NetworkImageWidget({
    Key? key,
    this.imageUri,
    this.defaultAsset = "assets/icons/ecm-logo.png",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      image: imageUri ?? "-",
      placeholder: defaultAsset,
      imageErrorBuilder: (context, object, stackTrace) {
        return Image.asset(defaultAsset);
      },
    );
  }
}
