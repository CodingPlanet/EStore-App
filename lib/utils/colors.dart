import 'package:flutter/material.dart';
import 'string.dart';

class colors {
  colors._();

  static const MaterialColor primary_app = const MaterialColor(
    0xffFE7E7B,
    const <int, Color>{
      50: primary,
      100: primary,
      200: primary,
      300: primary,
      400: primary,
      500: primary,
      600: primary,
      700: primary,
      800: primary,
      900: primary,
    },
  );

  static const Color primary = Color(0xffFE7E7B);
  static const Color secondary = Color(0xffFDCD96);

  static Color get fontColor => isDark == "true" ? secondary : const Color(0xff4543C1);
  static const Color grad1Color = Color(0xffFFBD69);
  static const Color grad2Color = Color(0xffFF6363);
  static const Color lightWhite2 = Color(0xffEEF2F3);

  static const Color pink = Color(0xffd4001d);
  static const Color red = Colors.red;

  static Color get lightBlack =>
      isDark == "true" ? whiteTemp : const Color(0xff52575C);

  static Color get lightBlack2 =>
      isDark == "true" ? white70 : const Color(0xff999999);

  static Color get lightWhite =>
      isDark == "true" ? darkColor : const Color(0xffEEF2F9);

  static const Color darkColor = Color(0xff202844);
  static const Color darkColor2 = Color(0xff273152);

  static Color get white => isDark == "true" ? darkColor2 : const Color(0xffFFFFFF);
  static const Color whiteTemp = Color(0xffFFFFFF);

  static Color get black => isDark == "true" ? whiteTemp : const Color(0xff000000);

  static const Color white10 = Colors.white10;
  static const Color white30 = Colors.white30;
  static const Color white70 = Colors.white70;

  static const Color black54 = Colors.black54;
  static const Color black12 = Colors.black12;
  static const Color disableColor=Color(0xffEEF2F9);
  static Color get black26 => isDark == "true" ? white30 : Colors.black26;
}

// const Color APPBAR_TEXT_COLOR = Color(0xff0f1010);
// const Color BACKGROUND_COLOR = Color(0xfff6f5f5);
// const Color APP_BAR_COLOR = Color(0xfff6f5f5);
// const Color TITLE_COLOR = Color(0xff090808);
// const Color TEXT_COLOR = Color(0xff1c1b1b);
// const Color HEADING_TEXT_COLOR = Color(0xff0a0a0a);
// const Color ICON_COLOR = Color(0xff212020);
// const Color ICON_BACKGROUND_COLOR = Color(0xfff2f2f6);
// const Color PRICE_COLOR = Color(0xffe81d1d);
// const Color CARD_BACKGROUND_COLOR = Color(0xffffffff);
// const Color CURSOR_COLOR = Color(0xff090909);
// const Color HINT_TEXT_COLOR = Color(0xffa4a2a2);
// const Color DIVIDER_COLOR  = Color(0xffc5c2c2);
// const Color BORDER_COLOR  = Color(0xffb3b9b9);



const Color APPBAR_TEXT_COLOR = Color(0xff0e324f);
const Color BACKGROUND_COLOR = Color(0xfffffefb);
const Color APP_BAR_COLOR = Color(0xfffffefb);
const Color TITLE_COLOR = Color(0xff0e324f);
const Color TEXT_COLOR = Color(0xff0e6698);
const Color HEADING_TEXT_COLOR = Color(0xff051b28);
const Color ICON_COLOR = Color(0xff0e324f);
const Color BUTTON_COLOR = Color(0xff0e324f);
const Color CIRCULAR_INDICATOR_COLOR = Color(0xff051b28);
const Color ICON_BACKGROUND_COLOR = Color(0xffebf1fa);
const Color PRICE_COLOR = Color(0xffe81d1d);
const Color CARD_BACKGROUND_COLOR = Color(0xfff8f6f1);
const Color CURSOR_COLOR = Color(0xff090909);
const Color HINT_TEXT_COLOR = Color(0xffa4a2a2);
const Color DIVIDER_COLOR  = Color(0xffeaeaea);
const Color BORDER_COLOR  = Color(0xffb3b9b9);