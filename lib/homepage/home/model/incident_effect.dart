class IncidentEffect {
  int? cost;
  int? delivery;
  int? quality;
  int? safety;

  IncidentEffect({this.cost, this.delivery, this.quality, this.safety});

  factory IncidentEffect.fromJson(Map<String, dynamic> json) {
    return IncidentEffect(
      cost: json['t_ecm_cost'] as int?,
      delivery: json['t_ecm_delivery'] as int?,
      quality: json['t_ecm_quality'] as int?,
      safety: json['t_ecm_safety'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['t_ecm_delivery'] = delivery;
    data['t_ecm_quality'] = quality;
    data['t_ecm_cost'] = cost;
    data['t_ecm_safety'] = safety;
    return data;
  }

  String _determineValue(String type) {
    String result = "";
    switch (type) {
      case "cost":
        result = cost != null ? "Cost, " : "";
        break;
      case "delivery":
        result = delivery != null ? "Delivery, " : "";
        break;
      case "quality":
        result = quality != null ? "Quality, " : "";
        break;
      case "safety":
        result = safety != null ? "Safety" : "";
        break;
    }
    return result;
  }

  @override
  String toString() {
    return "${_determineValue("cost")}"
        "${_determineValue("delivery")}"
        "${_determineValue("quality")}"
        "${_determineValue("safety")}";
  }
}
