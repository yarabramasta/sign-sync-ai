// ignore_for_file: use_full_hex_values_for_flutter_colors

import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4282081423),
      surfaceTint: Color(4282081423),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292142079),
      onPrimaryContainer: Color(4278197306),
      secondary: Color(4283719537),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292404216),
      onSecondaryContainer: Color(4279311403),
      tertiary: Color(4286142732),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294958755),
      onTertiaryContainer: Color(4280686848),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294572543),
      onSurface: Color(4279835680),
      onSurfaceVariant: Color(4282599246),
      outline: Color(4285757311),
      outlineVariant: Color(4291020495),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217077),
      inversePrimary: Color(4289054974),
      primaryFixed: Color(4292142079),
      onPrimaryFixed: Color(4278197306),
      primaryFixedDim: Color(4289054974),
      onPrimaryFixedVariant: Color(4280371318),
      secondaryFixed: Color(4292404216),
      onSecondaryFixed: Color(4279311403),
      secondaryFixedDim: Color(4290562012),
      onSecondaryFixedVariant: Color(4282206040),
      tertiaryFixed: Color(4294958755),
      onTertiaryFixed: Color(4280686848),
      tertiaryFixedDim: Color(4293640300),
      onTertiaryFixedVariant: Color(4284301824),
      surfaceDim: Color(4292467424),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112250),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4292993769),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4280042610),
      surfaceTint: Color(4282081423),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283594407),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281942868),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285166983),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4283973376),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4287786787),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294572543),
      onSurface: Color(4279835680),
      onSurfaceVariant: Color(4282336074),
      outline: Color(4284178279),
      outlineVariant: Color(4286020483),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217077),
      inversePrimary: Color(4289054974),
      primaryFixed: Color(4283594407),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281949581),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285166983),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283587950),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4287786787),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4285945609),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292467424),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112250),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4292993769),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278199109),
      surfaceTint: Color(4282081423),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4280042610),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279771954),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281942868),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281278464),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283973376),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294572543),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280296491),
      outline: Color(4282336074),
      outlineVariant: Color(4282336074),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217077),
      inversePrimary: Color(4293127423),
      primaryFixed: Color(4280042610),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278201687),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281942868),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280495421),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283973376),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282132992),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292467424),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112250),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4292993769),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289054974),
      surfaceTint: Color(4289054974),
      onPrimary: Color(4278202717),
      primaryContainer: Color(4280371318),
      onPrimaryContainer: Color(4292142079),
      secondary: Color(4290562012),
      onSecondary: Color(4280693057),
      secondaryContainer: Color(4282206040),
      onSecondaryContainer: Color(4292404216),
      tertiary: Color(4293640300),
      onTertiary: Color(4282395904),
      tertiaryContainer: Color(4284301824),
      onTertiaryContainer: Color(4294958755),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279309080),
      onSurface: Color(4292993769),
      onSurfaceVariant: Color(4291020495),
      outline: Color(4287467929),
      outlineVariant: Color(4282599246),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292993769),
      inversePrimary: Color(4282081423),
      primaryFixed: Color(4292142079),
      onPrimaryFixed: Color(4278197306),
      primaryFixedDim: Color(4289054974),
      onPrimaryFixedVariant: Color(4280371318),
      secondaryFixed: Color(4292404216),
      onSecondaryFixed: Color(4279311403),
      secondaryFixedDim: Color(4290562012),
      onSecondaryFixedVariant: Color(4282206040),
      tertiaryFixed: Color(4294958755),
      onTertiaryFixed: Color(4280686848),
      tertiaryFixedDim: Color(4293640300),
      onTertiaryFixedVariant: Color(4284301824),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281480506),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289515007),
      surfaceTint: Color(4289054974),
      onPrimary: Color(4278196016),
      primaryContainer: Color(4285502149),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290825184),
      onSecondary: Color(4278982438),
      secondaryContainer: Color(4287009188),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293969264),
      onTertiary: Color(4280292352),
      tertiaryContainer: Color(4289825597),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279309080),
      onSurface: Color(4294703871),
      onSurfaceVariant: Color(4291349460),
      outline: Color(4288652203),
      outlineVariant: Color(4286612363),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292993769),
      inversePrimary: Color(4280437111),
      primaryFixed: Color(4292142079),
      onPrimaryFixed: Color(4278194472),
      primaryFixedDim: Color(4289054974),
      onPrimaryFixedVariant: Color(4278728548),
      secondaryFixed: Color(4292404216),
      onSecondaryFixed: Color(4278587936),
      secondaryFixedDim: Color(4290562012),
      onSecondaryFixedVariant: Color(4281087815),
      tertiaryFixed: Color(4294958755),
      onTertiaryFixed: Color(4279832320),
      tertiaryFixedDim: Color(4293640300),
      onTertiaryFixedVariant: Color(4282921728),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281480506),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294703871),
      surfaceTint: Color(4289054974),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4289515007),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294703871),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290825184),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294966007),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4293969264),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279309080),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294703871),
      outline: Color(4291349460),
      outlineVariant: Color(4291349460),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292993769),
      inversePrimary: Color(4278200914),
      primaryFixed: Color(4292601855),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4289515007),
      onPrimaryFixedVariant: Color(4278196016),
      secondaryFixed: Color(4292667389),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290825184),
      onSecondaryFixedVariant: Color(4278982438),
      tertiaryFixed: Color(4294960051),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4293969264),
      onTertiaryFixedVariant: Color(4280292352),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281480506),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
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

  /// Success
  static const success = ExtendedColor(
    seed: Color(4278234205),
    value: Color(4278233729),
    light: ColorFamily(
      color: Color(4279921490),
      onColor: Color(4294967295),
      colorContainer: Color(4289131218),
      onColorContainer: Color(4278198550),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4279921490),
      onColor: Color(4294967295),
      colorContainer: Color(4289131218),
      onColorContainer: Color(4278198550),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4279921490),
      onColor: Color(4294967295),
      colorContainer: Color(4289131218),
      onColorContainer: Color(4278198550),
    ),
    dark: ColorFamily(
      color: Color(4287289015),
      onColor: Color(4278204456),
      colorContainer: Color(4278210876),
      onColorContainer: Color(4289131218),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4287289015),
      onColor: Color(4278204456),
      colorContainer: Color(4278210876),
      onColorContainer: Color(4289131218),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4287289015),
      onColor: Color(4278204456),
      colorContainer: Color(4278210876),
      onColorContainer: Color(4289131218),
    ),
  );

  /// Warning
  static const warning = ExtendedColor(
    seed: Color(4294952281),
    value: Color(4293643610),
    light: ColorFamily(
      color: Color(4285488397),
      onColor: Color(4294967295),
      colorContainer: Color(4294697351),
      onColorContainer: Color(4280425216),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4285488397),
      onColor: Color(4294967295),
      colorContainer: Color(4294697351),
      onColorContainer: Color(4280425216),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4285488397),
      onColor: Color(4294967295),
      colorContainer: Color(4294697351),
      onColorContainer: Color(4280425216),
    ),
    dark: ColorFamily(
      color: Color(4292789614),
      onColor: Color(4282068736),
      colorContainer: Color(4283778560),
      onColorContainer: Color(4294697351),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4292789614),
      onColor: Color(4282068736),
      colorContainer: Color(4283778560),
      onColorContainer: Color(4294697351),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4292789614),
      onColor: Color(4282068736),
      colorContainer: Color(4283778560),
      onColorContainer: Color(4294697351),
    ),
  );

  /// Info
  static const info = ExtendedColor(
    seed: Color(4283546309),
    value: Color(4284069844),
    light: ColorFamily(
      color: Color(4278413182),
      onColor: Color(4294967295),
      colorContainer: Color(4290046975),
      onColorContainer: Color(4278198056),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4278413182),
      onColor: Color(4294967295),
      colorContainer: Color(4290046975),
      onColorContainer: Color(4278198056),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4278413182),
      onColor: Color(4294967295),
      colorContainer: Color(4290046975),
      onColorContainer: Color(4278198056),
    ),
    dark: ColorFamily(
      color: Color(4287091178),
      onColor: Color(4278203714),
      colorContainer: Color(4278210143),
      onColorContainer: Color(4290046975),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4287091178),
      onColor: Color(4278203714),
      colorContainer: Color(4278210143),
      onColorContainer: Color(4290046975),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4287091178),
      onColor: Color(4278203714),
      colorContainer: Color(4278210143),
      onColorContainer: Color(4290046975),
    ),
  );

  List<ExtendedColor> get extendedColors => [
        success,
        warning,
        info,
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
