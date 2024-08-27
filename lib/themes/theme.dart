import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.indigo,
      surfaceTint: Color(0xff006b5f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9ef2e3),
      onPrimaryContainer: Color(0xff00201c),
      secondary: Color(0xffff00bb),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffd8e9),
      onSecondaryContainer: Color(0xff380727),
      tertiary: Color(0xff4dff00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc3efad),
      onTertiaryContainer: Color(0xff042100),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff171d1e),
      onSurfaceVariant: Color(0xff3f484a),
      outline: Color(0xff6f797a),
      outlineVariant: Color(0xffbfc8ca),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xff82d5c7),

    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }



  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff05f3f7),
      surfaceTint: Color(0xff82d5c7),
      onPrimary: Color(0xff003731),
      primaryContainer: Color(0xff005048),
      onPrimaryContainer: Color(0xff9ef2e3),
      secondary: Color(0xffff00bb),
      onSecondary: Color(0xff511d3d),
      secondaryContainer: Color(0xff6c3454),
      onSecondaryContainer: Color(0xffffd8e9),
      tertiary: Color(0xff4dff00),
      onTertiary: Color(0xff143809),
      tertiaryContainer: Color(0xff2b4f1e),
      onTertiaryContainer: Color(0xffc3efad),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdee3e5),
      onSurfaceVariant: Color(0xffbfc8ca),
      outline: Color(0xff899294),
      outlineVariant: Color(0xff3f484a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff006b5f),
     
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

 

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
