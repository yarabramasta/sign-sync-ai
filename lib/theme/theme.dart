import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4281884815),
      surfaceTint: Color(4281884815),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292011263),
      onPrimaryContainer: Color(4278197303),
      secondary: Color(4283654000),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292338680),
      onSecondaryContainer: Color(4279245867),
      tertiary: Color(4285815564),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294958992),
      onTertiaryContainer: Color(4280556032),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294507007),
      onSurface: Color(4279835680),
      onSurfaceVariant: Color(4282599246),
      outline: Color(4285757311),
      outlineVariant: Color(4291020495),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217333),
      inversePrimary: Color(4288858621),
      primaryFixed: Color(4292011263),
      onPrimaryFixed: Color(4278197303),
      primaryFixedDim: Color(4288858621),
      onPrimaryFixedVariant: Color(4280043893),
      secondaryFixed: Color(4292338680),
      onSecondaryFixed: Color(4279245867),
      secondaryFixedDim: Color(4290496475),
      onSecondaryFixedVariant: Color(4282140760),
      tertiaryFixed: Color(4294958992),
      onTertiaryFixed: Color(4280556032),
      tertiaryFixedDim: Color(4293182316),
      onTertiaryFixedVariant: Color(4283974656),
      surfaceDim: Color(4292401888),
      surfaceBright: Color(4294507007),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112250),
      surfaceContainer: Color(4293717748),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4292993768),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4279649649),
      surfaceTint: Color(4281884815),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283398054),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281877588),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285101447),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4283711488),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4287394083),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294507007),
      onSurface: Color(4279835680),
      onSurfaceVariant: Color(4282336074),
      outline: Color(4284178279),
      outlineVariant: Color(4286020483),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217333),
      inversePrimary: Color(4288858621),
      primaryFixed: Color(4283398054),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281687692),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285101447),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283522414),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4287394083),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4285618440),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292401888),
      surfaceBright: Color(4294507007),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112250),
      surfaceContainer: Color(4293717748),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4292993768),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278199106),
      surfaceTint: Color(4281884815),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4279649649),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279706418),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281877588),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281082112),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283711488),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294507007),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280296491),
      outline: Color(4282336074),
      outlineVariant: Color(4282336074),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217333),
      inversePrimary: Color(4293062143),
      primaryFixed: Color(4279649649),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278201940),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281877588),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280429885),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283711488),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281936640),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292401888),
      surfaceBright: Color(4294507007),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112250),
      surfaceContainer: Color(4293717748),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4292993768),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4288858621),
      surfaceTint: Color(4288858621),
      onPrimary: Color(4278202970),
      primaryContainer: Color(4280043893),
      onPrimaryContainer: Color(4292011263),
      secondary: Color(4290496475),
      onSecondary: Color(4280627521),
      secondaryContainer: Color(4282140760),
      onSecondaryContainer: Color(4292338680),
      tertiary: Color(4293182316),
      onTertiary: Color(4282199552),
      tertiaryContainer: Color(4283974656),
      onTertiaryContainer: Color(4294958992),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279309336),
      onSurface: Color(4292993768),
      onSurfaceVariant: Color(4291020495),
      outline: Color(4287467929),
      outlineVariant: Color(4282599246),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292993768),
      inversePrimary: Color(4281884815),
      primaryFixed: Color(4292011263),
      onPrimaryFixed: Color(4278197303),
      primaryFixedDim: Color(4288858621),
      onPrimaryFixedVariant: Color(4280043893),
      secondaryFixed: Color(4292338680),
      onSecondaryFixed: Color(4279245867),
      secondaryFixedDim: Color(4290496475),
      onSecondaryFixedVariant: Color(4282140760),
      tertiaryFixed: Color(4294958992),
      onTertiaryFixed: Color(4280556032),
      tertiaryFixedDim: Color(4293182316),
      onTertiaryFixedVariant: Color(4283974656),
      surfaceDim: Color(4279309336),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278914579),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280756783),
      surfaceContainerHighest: Color(4281480506),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289252863),
      surfaceTint: Color(4288858621),
      onPrimary: Color(4278196014),
      primaryContainer: Color(4285305796),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290759903),
      onSecondary: Color(4278916901),
      secondaryContainer: Color(4286943908),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293511024),
      onTertiary: Color(4280161536),
      tertiaryContainer: Color(4289367357),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279309336),
      onSurface: Color(4294638335),
      onSurfaceVariant: Color(4291283923),
      outline: Color(4288652203),
      outlineVariant: Color(4286546827),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292993768),
      inversePrimary: Color(4280109686),
      primaryFixed: Color(4292011263),
      onPrimaryFixed: Color(4278194726),
      primaryFixedDim: Color(4288858621),
      onPrimaryFixedVariant: Color(4278204515),
      secondaryFixed: Color(4292338680),
      onSecondaryFixed: Color(4278587936),
      secondaryFixedDim: Color(4290496475),
      onSecondaryFixedVariant: Color(4281022279),
      tertiaryFixed: Color(4294958992),
      onTertiaryFixed: Color(4279767040),
      tertiaryFixedDim: Color(4293182316),
      onTertiaryFixedVariant: Color(4282659840),
      surfaceDim: Color(4279309336),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278914579),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280756783),
      surfaceContainerHighest: Color(4281480506),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294638335),
      surfaceTint: Color(4288858621),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4289252863),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294638335),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290759903),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294966006),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4293511024),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279309336),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294638335),
      outline: Color(4291283923),
      outlineVariant: Color(4291283923),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292993768),
      inversePrimary: Color(4278201167),
      primaryFixed: Color(4292471039),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4289252863),
      onPrimaryFixedVariant: Color(4278196014),
      secondaryFixed: Color(4292602108),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290759903),
      onSecondaryFixedVariant: Color(4278916901),
      tertiaryFixed: Color(4294960292),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4293511024),
      onTertiaryFixedVariant: Color(4280161536),
      surfaceDim: Color(4279309336),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278914579),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280756783),
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
     scaffoldBackgroundColor: colorScheme.background,
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
