import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../base/viewController/productive_step_time.dart';

class MainMenuController extends GetxController {
  late String key;
  late RxInt currentCicle;
  late RxBool isLoading;
  late RxBool activityScreen;
  late RxString textFirstButton;
  late RxString textSecondButton;
  late RxString textFirstPauseButton;
  late RxString textSecondPauseButton;
  late ProductionStepTime productionStepTime;
  late CountDownController countDownController;
  late CountDownController countDownPauseController;
  late SharedPreferences sharedPreferences;

  MainMenuController(){
    _initializeVariables();
  }

  @override
  void onInit() async {
    await _loadFirstScreen();
    super.onInit();
  }

  _initializeVariables(){
    currentCicle = 1.obs;
    isLoading = true.obs;
    activityScreen = true.obs;
    textFirstButton = "Iniciar".obs;
    textSecondButton = "Parar".obs;
    textFirstPauseButton = "Iniciar".obs;
    textSecondPauseButton = "Parar".obs;
    countDownController = CountDownController();
    countDownPauseController = CountDownController();
    productionStepTime = getProductionStepsTime();
    key = "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
  }

  _loadFirstScreen() async {
    sharedPreferences = await SharedPreferences.getInstance();
    currentCicle.value = sharedPreferences.getInt(key) ?? 1;
    productionStepTime = getProductionStepsTime();
    isLoading.value = false;
  }

  ProductionStepTime getProductionStepsTime(){
    switch(currentCicle.value){
      case 2:
        return ProductionStepTime(
          2,
          const Duration(minutes: 25),
          const Duration(minutes: 5),
          DateTime.now(),
        );
      case 3:
        return ProductionStepTime(
          3,
          const Duration(minutes: 25),
          const Duration(minutes: 5),
          DateTime.now(),
        );
      case 4:
        return ProductionStepTime(
          4,
          const Duration(minutes: 25),
          const Duration(minutes: 10),
          DateTime.now(),
        );
      case 5:
        return ProductionStepTime(
          5,
          const Duration(minutes: 25),
          const Duration(minutes: 15),
          DateTime.now(),
        );
      case 6:
        return ProductionStepTime(
          6,
          const Duration(minutes: 25),
          const Duration(minutes: 20),
          DateTime.now(),
        );
      default:
        return ProductionStepTime(
          1,
          const Duration(minutes: 25),
          const Duration(minutes: 5),
          DateTime.now(),
        );
    }
  }

  startButtonClicked() {
    switch(textFirstButton.value){
      case "Iniciar":
        countDownController.start();
        textFirstButton.value = "Pausar";
        textSecondButton.value = "Parar";
        break;
      case "Pausar":
        countDownController.pause();
        textFirstButton.value = "Continuar";
        textSecondButton.value = "Resetar";
        break;
      case "Continuar":
        countDownController.resume();
        textFirstButton.value = "Pausar";
        textSecondButton.value = "Parar";
        break;
    }
  }

  stopButtonClicked() async {
    switch(textSecondButton.value){
      case "Parar":
        textFirstButton.value = "Iniciar";
        countDownController.pause();
        await startPauseTime();
        break;
      case "Resetar":
        textFirstButton.value = "Iniciar";
        textSecondButton.value = "Parar";
        countDownController.pause();
        countDownController.restart();
        break;
    }
  }

  startButtonPauseClicked(){
    switch(textFirstPauseButton.value){
      case "Iniciar":
        countDownPauseController.start();
        textFirstPauseButton.value = "Pausar";
        textSecondPauseButton.value = "Parar";
        break;
      case "Pausar":
        countDownPauseController.pause();
        textFirstPauseButton.value = "Continuar";
        textSecondPauseButton.value = "Resetar";
        break;
      case "Continuar":
        countDownPauseController.resume();
        textFirstPauseButton.value = "Pausar";
        textSecondPauseButton.value = "Parar";
        break;
    }
  }

  stopButtonPauseClicked() async {
    switch(textSecondPauseButton.value){
      case "Parar":
        textFirstPauseButton.value = "Iniciar";
        countDownPauseController.pause();
        await saveTime();
        break;
      case "Resetar":
        textFirstPauseButton.value = "Iniciar";
        textSecondPauseButton.value = "Parar";
        countDownPauseController.pause();
        countDownPauseController.restart();
        break;
    }
  }

  startPauseTime(){
    activityScreen.value = false;
  }

  saveTime() async {
    if(currentCicle.value == 6){
      currentCicle.value = 1;
    }
    else{
      currentCicle.value++;
    }
    await sharedPreferences.setInt(key, currentCicle.value);
    productionStepTime = getProductionStepsTime();
    activityScreen.value = true;
  }
}