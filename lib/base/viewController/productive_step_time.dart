class ProductionStepTime {
  late int step;
  late Duration timeDuration;
  late Duration breakTime;
  late DateTime day;

  ProductionStepTime(
    this.step,
    this.timeDuration,
    this.breakTime,
    this.day,
  );

  ProductionStepTime.fromJson(Map<String, dynamic> json) {
    step = json["step"];
    timeDuration = json["timeDuration"];
    breakTime = json["breakTime"];
    day = json["day"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["step"] = step;
    data["timeDuration"] = timeDuration;
    data["breakTime"] = breakTime;
    data["day"] = day;
    return data;
  }
}