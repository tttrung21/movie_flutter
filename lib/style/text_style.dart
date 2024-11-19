import 'package:flutter/cupertino.dart';

import 'color_style.dart';

class ModTextStyle{
  static const title = TextStyle(fontSize: 16,fontWeight: FontWeight.w600,height: 0,color: CupertinoColors.white);
  static const itemTitle = TextStyle(fontSize: 16,fontWeight: FontWeight.w400,height: 0,color: CupertinoColors.white);
  static const itemDetail = TextStyle(fontSize: 12,fontWeight: FontWeight.w400,height: 0,color: CupertinoColors.white);
  static const detailTitle = TextStyle(fontSize: 18,fontWeight: FontWeight.w600,height: 0,color: CupertinoColors.white);
  static TextStyle detailInfo = const TextStyle(fontSize: 12,fontWeight: FontWeight.w500,height: 0,color: ModColorStyle.detailGrey);
}