// class that parses the output of the fetchData function
// allows us to obtain the lengths of the Time and Channel labels

class ApiInfo {
  int? iNumDimensions;
  List<Axis>? lAxis;

  ApiInfo({this.iNumDimensions, this.lAxis});

  ApiInfo.fromJson(Map<String, dynamic> json) {
    iNumDimensions = json['_numDimensions'];
    if (json['_axis'] != null) {
      lAxis = <Axis>[];
      json['_axis'].forEach((v) {
        lAxis!.add(new Axis.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_numDimensions'] = this.iNumDimensions;
    if (this.lAxis != null) {
      data['_axis'] = this.lAxis!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Axis {
  Label? lLabel;
  Label? lUnits;
  Label? lDomain;
  int? iLength;
  int? iLogicalOrigin;
  int? iLogicalDelta;
  double? iPhysicalOrigin;
  double? dPhysicalDelta;

  Axis(
      {this.lLabel,
      this.lUnits,
      this.lDomain,
      this.iLength,
      this.iLogicalOrigin,
      this.iLogicalDelta,
      this.iPhysicalOrigin,
      this.dPhysicalDelta});

  Axis.fromJson(Map<String, dynamic> json) {
    lLabel = json['_label'] != null ? new Label.fromJson(json['_label']) : null;
    lUnits = json['_units'] != null ? new Label.fromJson(json['_units']) : null;
    lDomain =
        json['_domain'] != null ? new Label.fromJson(json['_domain']) : null;
    iLength = json['_length'];
    iLogicalOrigin = json['_logicalOrigin'];
    iLogicalDelta = json['_logicalDelta'];
    iPhysicalOrigin = json['_physicalOrigin'];
    dPhysicalDelta = json['_physicalDelta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lLabel != null) {
      data['_label'] = this.lLabel!.toJson();
    }
    if (this.lUnits != null) {
      data['_units'] = this.lUnits!.toJson();
    }
    if (this.lDomain != null) {
      data['_domain'] = this.lDomain!.toJson();
    }
    data['_length'] = this.iLength;
    data['_logicalOrigin'] = this.iLogicalOrigin;
    data['_logicalDelta'] = this.iLogicalDelta;
    data['_physicalOrigin'] = this.iPhysicalOrigin;
    data['_physicalDelta'] = this.dPhysicalDelta;
    return data;
  }
}

class Label {
  String? sName;
  String? sDescription;

  Label({this.sName, this.sDescription});

  Label.fromJson(Map<String, dynamic> json) {
    sName = json['_name'];
    sDescription = json['_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_name'] = this.sName;
    data['_description'] = this.sDescription;
    return data;
  }
}
