import 'package:flavor_client/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final textTheme = GoogleFonts.contrailOneTextTheme().copyWith(
  subtitle2: TextStyle(color: Colors.red),
);

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

MaterialColor colorCustom = MaterialColor(0xFFA73030, color);

ThemeData darkTheme(TextTheme textTheme) => ThemeData.dark()
    .copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
    )
    .copyWith(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: mcgpalette0,
        // primaryColorDark: Colors.red,
        cardColor: Colors.grey.shade800,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.amber,
        labelStyle: TextStyle(color: Colors.white),
        suffixStyle: TextStyle(color: Colors.white),
        helperStyle: TextStyle(color: Colors.white),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade800,
      ),
      unselectedWidgetColor: Colors.white38,
      primaryColor: Colors.red,
      accentColor: Colors.red,
      chipTheme: ThemeData.dark().chipTheme.copyWith(
            selectedColor: Colors.red,
          ),
      navigationRailTheme: NavigationRailThemeData(
        unselectedIconTheme: IconThemeData(
          color: Colors.white,
          opacity: .5,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: Colors.white.withOpacity(.5),
        ),
      ),
      textTheme: textTheme.merge(defaultTextThemeDark),
    );
ThemeData lightTheme(TextTheme textTheme) => flavorThemeMaterialLight.copyWith(
      iconTheme: IconThemeData(color: Colors.black),
      primaryIconTheme: IconThemeData(color: Colors.black),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.red,
        primaryColorDark: Colors.red,
        // cardColor: Colors.grey.shade800,
      ),
      cardTheme: CardTheme(
        elevation: 2,
      ),
      appBarTheme: AppBarTheme(backgroundColor: Colors.white, elevation: 1),
      // primaryColor: Colors.white,
      accentColor: Colors.red,
      chipTheme:
          ThemeData.light().chipTheme.copyWith(selectedColor: Colors.red),
      fixTextFieldOutlineLabel: true,
      navigationRailTheme: NavigationRailThemeData(),
      textTheme: textTheme.merge(defaultTextThemeLight),
    );

InputDecoration inputBorder(BuildContext context, String? labelText) {
  return InputDecoration(
    labelText: labelText ?? '',
    // isDense: true,
    labelStyle: Theme.of(context).textTheme.bodyText2,
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(),
    hoverColor: Colors.green,
    fillColor: Colors.green,
    focusColor: Colors.amber,
  );
}

const MaterialColor mcgpalette0 =
    MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
  50: Color(0xFFFDFDFD),
  100: Color(0xFFF9F9F9),
  200: Color(0xFFF6F6F6),
  300: Color(0xFFF2F2F2),
  400: Color(0xFFEFEFEF),
  500: Color(_mcgpalette0PrimaryValue),
  600: Color(0xFFEAEAEA),
  700: Color(0xFFE7E7E7),
  800: Color(0xFFE4E4E4),
  900: Color(0xFFDFDFDF),
});
const int _mcgpalette0PrimaryValue = 0xFFECECEC;

const MaterialColor mcgpalette0Accent =
    MaterialColor(_mcgpalette0AccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_mcgpalette0AccentValue),
  400: Color(0xFFFFFFFF),
  700: Color(0xFFFFFFFF),
});
const int _mcgpalette0AccentValue = 0xFFFFFFFF;
