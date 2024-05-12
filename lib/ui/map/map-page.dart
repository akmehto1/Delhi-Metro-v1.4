import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';

Widget mapPage(){
  return SizedBox(
    height: 1000,
    child: PhotoView(
      imageProvider:AssetImage('assets/images/core/map.jpg'),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 2,
    ),
  );
}