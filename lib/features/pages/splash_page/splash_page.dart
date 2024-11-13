import 'package:curancy_converter_app/features/pages/splash_page/splash_cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../core/dependency_injection.dart';
import '../../../utils/colors.dart';
import '../../../utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _bloc = injection.call<SplashCubit>();

  @override
  void initState() {
    _bloc.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorSecondary,
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashSuccessState) {
              Navigator.pushNamed(context, Routes.rHomeView);
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    PhosphorIcons.currency_circle_dollar_fill,
                    color:AppColors.fontColorWhite,
                    size: 30.h,
                  ),
                  Column(
                    children: [
                      Text(
                        "Welcome to Currency Converter".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.fontColorWhite,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      // Icon(
                      //   Icons.arrow_forward_rounded,
                      //   color: AppColors.fontColorWhite,
                      //   size: 22.sp,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
