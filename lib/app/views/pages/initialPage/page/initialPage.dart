import 'package:flutter/material.dart';
import 'package:pomodoro/app/views/stylePages/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      child: Center(
        child: SizedBox(
          height: 30.h,
          width: 30.h,
          child: CircularProgressIndicator(
            color: AppColors.purpleDefaultColor,
            strokeWidth: 2.h,
          ),
        ),
      ),
    );
  }
}
