class IncidentMistake {
  IncidentMistake({
    this.molding,
    this.production,
    this.other,
    this.utility,
    this.engineering,
  });

  IncidentMistake.fromJson(dynamic json) {
    molding = json['t_ecm_molding'];
    production = json['t_ecm_production'];
    other = json['t_ecm_other'];
    utility = json['t_ecm_utility'];
    engineering = json['t_ecm_engineering'];
  }
  int? molding;
  int? production;
  int? other;
  int? utility;
  int? engineering;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['t_ecm_molding'] = molding;
    map['t_ecm_production'] = production;
    map['t_ecm_other'] = other;
    map['t_ecm_utility'] = utility;
    map['t_ecm_engineering'] = engineering;
    return map;
  }

  String _determineValue(String type) {
    String result = "";
    switch (type) {
      case "molding":
        result = molding != null ? "Molding, " : "";
        break;
      case "production":
        result = production != null ? "Production, " : "";
        break;
      case "other":
        result = other != null ? "Other, " : "";
        break;
      case "utility":
        result = utility != null ? "Utility, " : "";
        break;
      case "engineering":
        result = engineering != null ? "Engineering" : "";
        break;
    }
    return result;
  }

  @override
  String toString() {
    return "${_determineValue("molding")}"
        "${_determineValue("production")}"
        "${_determineValue("other")}"
        "${_determineValue("utility")}"
        "${_determineValue("engineering")}";
  }
}
