import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro/app/views/pages/widgetsShared/text_widget.dart';
import 'package:pomodoro/app/views/stylePages/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../widgetsShared/button_widget.dart';
import '../controller/main_menu_controller.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class MainMenuWatchPage extends StatefulWidget {
  const MainMenuWatchPage({Key? key}) : super(key: key);

  @override
  State<MainMenuWatchPage> createState() => _MainMenuWatchPageState();
}

class _MainMenuWatchPageState extends State<MainMenuWatchPage> {
  late MainMenuController controller;

  @override
  void initState() {
    controller = Get.put(MainMenuController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: Obx(
          () => Visibility(
            visible: !controller.isLoading.value,
            replacement: Center(
              child: SizedBox(
                height: 30.h,
                width: 30.h,
                child: const CircularProgressIndicator(
                  color: AppColors.purpleDefaultColor,
                ),
              ),
            ),
            child: Visibility(
              visible: controller.activityScreen.value,
              replacement: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    "Pausa",
                    fontWeight: FontWeight.bold,
                    fontSize: 28.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: CircularCountDownTimer(
                      controller: controller.countDownPauseController,
                      initialDuration: 0,
                      duration: controller.productionStepTime.breakTime.inSeconds,
                      width: 30.h,
                      height: 30.h,
                      ringColor: AppColors.grayAcademicCardColor,
                      ringGradient: null,
                      fillColor: AppColors.orangeColor,
                      fillGradient: null,
                      backgroundColor: AppColors.purpleDefaultColor,
                      backgroundGradient: null,
                      strokeWidth: 1.h,
                      strokeCap: StrokeCap.round,
                      textStyle: TextStyle(
                        fontSize: 28.sp,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textFormat: CountdownTextFormat.MM_SS,
                      isReverse: false,
                      isReverseAnimation: false,
                      isTimerTextShown: true,
                      autoStart: false,
                      onComplete: () => controller.saveTime(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonWidget(
                          hintText: controller.textFirstPauseButton.value,
                          widthButton: 40.w,
                          onPressed: () => controller.startButtonPauseClicked(),
                        ),
                        ButtonWidget(
                          hintText: controller.textSecondPauseButton.value,
                          widthButton: 40.w,
                          onPressed: () => controller.stopButtonPauseClicked(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    "Ciclo ${controller.currentCicle.value}",
                    fontWeight: FontWeight.bold,
                    fontSize: 28.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: CircularCountDownTimer(
                      controller: controller.countDownController,
                      initialDuration: 0,
                      duration: controller.productionStepTime.timeDuration.inSeconds,
                      width: 30.h,
                      height: 30.h,
                      ringColor: AppColors.grayAcademicCardColor,
                      ringGradient: null,
                      fillColor: AppColors.orangeColor,
                      fillGradient: null,
                      backgroundColor: AppColors.purpleDefaultColor,
                      backgroundGradient: null,
                      strokeWidth: 1.h,
                      strokeCap: StrokeCap.round,
                      textStyle: TextStyle(
                        fontSize: 28.sp,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textFormat: CountdownTextFormat.MM_SS,
                      isReverse: true,
                      isReverseAnimation: false,
                      isTimerTextShown: true,
                      autoStart: false,
                      onComplete: () => controller.startPauseTime(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonWidget(
                          hintText: controller.textFirstButton.value,
                          widthButton: 40.w,
                          onPressed: () => controller.startButtonClicked(),
                        ),
                        ButtonWidget(
                          hintText: controller.textSecondButton.value,
                          widthButton: 40.w,
                          onPressed: () => controller.stopButtonClicked(),
                        ),
                      ],
                    ),
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
