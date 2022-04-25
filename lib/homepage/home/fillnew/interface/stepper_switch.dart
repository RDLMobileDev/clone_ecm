class StepperSwitch {
  bool isStepSatuFill = true,
      isStepDuaFill = false,
      isStepTigaFill = false,
      isStepEmpatFill = false,
      isStepLimaFill = false,
      isStepEnamFill = false,
      isStepTujuhFill = false,
      isStepDelapanFill = false;

  bool getStepSatu() {
    return isStepSatuFill;
  }

  void setStepSatu(bool stepValue) {
    isStepSatuFill = stepValue;
  }
}

final stepperSwitch = StepperSwitch();
