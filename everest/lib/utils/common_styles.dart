import 'package:flutter/material.dart';

enum FW { regular, medium, semiBold, bold, extraBold }

FontWeight? getFW(FW? fw) {
  switch (fw) {
    case FW.regular:
      return FontWeight.w400;
    case FW.medium:
      return FontWeight.w500;
    case FW.semiBold:
      return FontWeight.w600;
    case FW.bold:
      return FontWeight.w700;
    case FW.extraBold:
      return FontWeight.w900;
    default:
      return FontWeight.w400;
  }
}

const String poppinsFonts = "Poppins";

TextStyle size10({FW? fw, Color? fontColor, String? fontFamily, double? letterSpacing}) {
  return TextStyle(
    fontSize: 10,
    fontWeight: getFW(fw),
    color: fontColor ?? Colors.black,
    letterSpacing: letterSpacing,
    // fontFamily: fontFamily ?? poppinsFonts,
  );
}

TextStyle size11({FW? fw, Color? fontColor, String? fontFamily, double? letterSpacing}) {
  return TextStyle(
    fontSize: 11,
    fontWeight: getFW(fw),
    color: fontColor ?? Colors.black,
    letterSpacing: letterSpacing,
    // fontFamily: fontFamily ?? poppinsFonts,
  );
}

TextStyle size12({FW? fw, Color? fontColor, String? fontFamily, double? letterSpacing}) {
  return TextStyle(
    fontSize: 12,
    fontWeight: getFW(fw),
    color: fontColor ?? Colors.black,
    // fontFamily: fontFamily ?? poppinsFonts,
    letterSpacing: letterSpacing,
  );
}

TextStyle size13({FW? fw, Color? fontColor, String? fontFamily, double? letterSpacing}) {
  return TextStyle(
    fontSize: 13,
    fontWeight: getFW(fw),
    color: fontColor ?? Colors.black,
    // fontFamily: fontFamily ?? poppinsFonts,
    letterSpacing: letterSpacing,
  );
}

TextStyle size14({FW? fw, Color? fontColor, String? fontFamily, double? letterSpacing}) {
  return TextStyle(
    fontSize: 14,
    fontWeight: getFW(fw),
    color: fontColor ?? Colors.black,
    // fontFamily: fontFamily ?? poppinsFonts,
    letterSpacing: letterSpacing,
  );
}

TextStyle size15({FW? fw, Color? fontColor, String? fontFamily, double? letterSpacing}) {
  return TextStyle(
    fontSize: 15,
    fontWeight: getFW(fw),
    color: fontColor ?? Colors.black,
    fontFamily: fontFamily ?? poppinsFonts,
    letterSpacing: letterSpacing,
  );
}

TextStyle size16({FW? fw, Color? fontColor, String? fontFamily, double? letterSpacing}) {
  return TextStyle(
    fontSize: 16,
    fontWeight: getFW(fw),
    color: fontColor ?? Colors.black,
    // fontFamily: fontFamily ?? poppinsFonts,
    letterSpacing: letterSpacing,
  );
}

TextStyle size17({FW? fw, Color? fontColor, String? fontFamily, double? letterSpacing}) {
  return TextStyle(
    fontSize: 17,
    fontWeight: getFW(fw),
    color: fontColor ?? Colors.black,
    // fontFamily: fontFamily ?? poppinsFonts,
    letterSpacing: letterSpacing,
  );
}

TextStyle size18({FW? fw, Color? fontColor, String? fontFamily, double? letterSpacing}) {
  return TextStyle(
    fontSize: 18,
    fontWeight: getFW(fw),
    color: fontColor ?? Colors.black,
    // fontFamily: fontFamily ?? poppinsFonts,
    letterSpacing: letterSpacing,
  );
}

TextStyle size20({FW? fw, Color? fontColor, String? fontFamily, double? letterSpacing}) {
  return TextStyle(
    fontSize: 20,
    fontWeight: getFW(fw),
    color: fontColor ?? Colors.black,
    // fontFamily: fontFamily ?? poppinsFonts,
    letterSpacing: letterSpacing,
  );
}

TextStyle size22({FW? fw, Color? fontColor, String? fontFamily, double? letterSpacing}) {
  return TextStyle(
    fontSize: 22,
    fontWeight: getFW(fw),
    color: fontColor ?? Colors.black,
    // fontFamily: fontFamily ?? poppinsFonts,
    letterSpacing: letterSpacing,
  );
}

TextStyle size21({FW? fw, Color? fontColor, String? fontFamily, double? letterSpacing}) {
  return TextStyle(
    fontSize: 21,
    fontWeight: getFW(fw),
    color: fontColor ?? Colors.black,
    // fontFamily: fontFamily ?? poppinsFonts,
    letterSpacing: letterSpacing,
  );
}

TextStyle size24({FW? fw, Color? fontColor, String? fontFamily, double? letterSpacing}) {
  return TextStyle(
    fontSize: 24,
    fontWeight: getFW(fw),
    color: fontColor ?? Colors.black,
    // fontFamily: fontFamily ?? poppinsFonts,
    letterSpacing: letterSpacing,
  );
}

TextStyle size28({FW? fw, Color? fontColor, String? fontFamily, double? letterSpacing}) {
  return TextStyle(
    fontSize: 28,
    fontWeight: getFW(FW.bold),
    color: fontColor ?? Colors.black,
    // fontFamily: fontFamily ?? poppinsFonts,
    letterSpacing: letterSpacing,
  );
}

class ThemeService {
  static final ThemeService _instance = ThemeService._internal();

  factory ThemeService() {
    return _instance;
  }

  ThemeService._internal();

  static ThemeData getTheme() {
    return neurodeTheme;
  }

  static ThemeData get neurodeTheme {
    return ThemeData(
      visualDensity: VisualDensity.standard,
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) return const Color(0xff4b5d6a);
            return const Color.fromARGB(255, 95, 167, 255);
          }),
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 20, 112, 224),
        brightness: Brightness.light,
        primary: const Color.fromARGB(255, 20, 112, 224),
        secondary: const Color.fromARGB(255, 95, 167, 255),
        tertiary: const Color.fromARGB(255, 224, 152, 20),
        background: const Color.fromARGB(255, 242, 244, 247),
      ),
      // primaryColor: Color.fromARGB(255, 20, 112, 224),
      // scaffoldBackgroundColor: Color.fromARGB(255, 242, 244, 247),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        displayMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        displaySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        headlineMedium: TextStyle(fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 15),
        bodyMedium: TextStyle(fontSize: 13),
        titleMedium: TextStyle(),
        titleSmall: TextStyle(),
        bodySmall: TextStyle(),
        labelLarge: TextStyle(fontWeight: FontWeight.w600),
        labelSmall: TextStyle(),
      ),
    );
  }
}
