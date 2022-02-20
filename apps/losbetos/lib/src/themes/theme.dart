// import 'package:flavor_client/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:losbetosapp/src/themes/light.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

final textTheme = GoogleFonts.contrailOneTextTheme().copyWith(
  subtitle2: const TextStyle(color: Colors.red),
);

Map<int, Color> color = {
  50: const Color.fromRGBO(136, 14, 79, .1),
  100: const Color.fromRGBO(136, 14, 79, .2),
  200: const Color.fromRGBO(136, 14, 79, .3),
  300: const Color.fromRGBO(136, 14, 79, .4),
  400: const Color.fromRGBO(136, 14, 79, .5),
  500: const Color.fromRGBO(136, 14, 79, .6),
  600: const Color.fromRGBO(136, 14, 79, .7),
  700: const Color.fromRGBO(136, 14, 79, .8),
  800: const Color.fromRGBO(136, 14, 79, .9),
  900: const Color.fromRGBO(136, 14, 79, 1),
};

MaterialColor colorCustom = MaterialColor(0xFFA73030, color);

ThemeData darkTheme2(Color primary, TextTheme textTheme) =>
    FlexColorScheme.dark(
      colors: FlexSchemeColor.from(primary: primary),
    ).toTheme;

ThemeData lightTheme2(Color primary, TextTheme textTheme) =>
    FlexColorScheme.light(
      colors: FlexSchemeColor.from(primary: primary),
    ).toTheme;

ThemeData darkTheme(Color primary, TextTheme textTheme) => ThemeData.from(
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: primary.withOpacity(.5),
        onPrimary: Colors.white,
        surface: Colors.grey.shade900,
      ),
    )
        .copyWith(
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.grey.shade900,
          ),
        )
        .copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        )
        .copyWith(
          inputDecorationTheme: const InputDecorationTheme(
            fillColor: Colors.amber,
            labelStyle: TextStyle(color: Colors.white),
            suffixStyle: TextStyle(color: Colors.white),
            helperStyle: TextStyle(color: Colors.white),
          ),
          unselectedWidgetColor: Colors.white38,
          chipTheme: ThemeData.dark().chipTheme.copyWith(
                selectedColor: primary,
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
          toggleButtonsTheme: ToggleButtonsThemeData(
            color: primary,
          ),

          // textTheme: textTheme.merge(defaultTextThemeDark),
        );
ThemeData lightThemeXXX(Color primary, TextTheme textTheme) => ThemeData.from(
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: primary.withOpacity(.5),
        onPrimary: Colors.white,
      ),
    ).copyWith(
      iconTheme: IconThemeData(color: Colors.black),
      primaryIconTheme: IconThemeData(color: Colors.black),
      cardTheme: CardTheme(
        elevation: 2,
      ),
      appBarTheme: AppBarTheme(backgroundColor: Colors.white, elevation: 0),
      chipTheme:
          ThemeData.light().chipTheme.copyWith(selectedColor: Colors.red),
      // fixTextFieldOutlineLabel: true,
      navigationRailTheme: NavigationRailThemeData(),
      toggleButtonsTheme: ToggleButtonsThemeData(
        color: primary,
      ),

      textTheme: textTheme,

      // textTheme: textTheme.merge(defaultTextThemeLight),
    );

ThemeData lightTheme(Color primary, TextTheme textTheme) =>
    lbThemeLight.copyWith(
      textTheme: textTheme,
      toggleButtonsTheme: ToggleButtonsThemeData(
        color: primary,
      ),
      chipTheme: ThemeData.light()
          .chipTheme
          .copyWith(selectedColor: primary.withOpacity(.7)),
      // appBarTheme: AppBarTheme(backgroundColor: Colors.white, elevation: 0),
      // chipTheme: ChipThemeData(
      //   backgroundColor: Colors.white,
      //   disabledColor: Colors.grey,
      //   selectedColor: primary,
      //   secondarySelectedColor: Colors.orange,
      //   padding: EdgeInsets.all(8),
      //   labelStyle: TextStyle(color: Colors.black54),
      //   secondaryLabelStyle: TextStyle(color: Colors.white),
      //   brightness: Brightness.dark,
      //   elevation: 0,
      //   pressElevation: 10,
      // ),
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
