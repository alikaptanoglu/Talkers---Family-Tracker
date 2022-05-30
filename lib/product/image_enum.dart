import 'package:flutter/material.dart';

enum ImageEnums{rabbit , cat, bulldog, ssst, star, appIcon, payBack, wallpaper, launch, home, deneme, payment, backk, chatbubble}

extension ImageEnumExtension on ImageEnums{

  String get _toPath => 'assets/images/ic_$name.png';

  Image get toImage => Image.asset(_toPath);
  AssetImage get assetImage => AssetImage(_toPath);

}
