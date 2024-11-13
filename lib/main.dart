import 'package:curancy_converter_app/utils/colors.dart';
import 'package:curancy_converter_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Currency Convertor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.colorSecondary,
          ).copyWith(
            background: AppColors.colorPrimary,
          ),
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme.apply(
              bodyColor: AppColors.fontColorWhite,
            ),
          ),
        ),
        initialRoute: Routes.rSplashView,
        onGenerateRoute: Routes.generateRoute,
      );
    });
  }
}
