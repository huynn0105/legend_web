import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../colors.dart';
import 'donut_chart_helper.dart';
import 'lerp.dart';

class DonutChartData with EquatableMixin {
  const DonutChartData({
    this.displayTotal = 0,
    this.isLoading = true,
    this.animatedAngle = 0.0,
    this.startDegreeAngle = -90.0,
    this.dividerWidth = 2.0,
    this.sections = const [],
    this.indexToFocus = -1,
  });

  const DonutChartData.success({
    this.displayTotal = 0,
    this.sections = const [],
  })  : isLoading = false,
        animatedAngle = 360,
        indexToFocus = -1,
        startDegreeAngle = -90.0,
        dividerWidth = 2.0;

  final bool isLoading;
  final double animatedAngle;
  final double startDegreeAngle;
  final double dividerWidth;
  final List<DonutChartSectionData> sections;
  final int indexToFocus;
  final double displayTotal;

  @override
  List<Object> get props => [
        isLoading,
        animatedAngle,
        startDegreeAngle,
        sections,
        dividerWidth,
        indexToFocus,
        displayTotal,
      ];

  DonutChartData lerp(DonutChartData a, DonutChartData b, double t) {
    return DonutChartData(
      isLoading: b.isLoading,
      startDegreeAngle: b.startDegreeAngle,
      animatedAngle: lerpDouble(a.animatedAngle, b.animatedAngle, t) ?? 0.0,
      sections: lerpDonutSectionDataList(a.sections, b.sections, t) ?? [],
      dividerWidth: lerpDouble(a.dividerWidth, b.dividerWidth, t) ?? 0.0,
      indexToFocus: b.indexToFocus,
      displayTotal: b.displayTotal,
    );
  }

  DonutChartData copyWith({
    bool? isLoading,
    double? animatedAngle,
    double? startDegreeAngle,
    double? dividerWidth,
    List<DonutChartSectionData>? sections,
    int? indexToFocus,
    double? displayTotal,
  }) {
    return DonutChartData(
      isLoading: isLoading ?? this.isLoading,
      animatedAngle: animatedAngle ?? this.animatedAngle,
      startDegreeAngle: startDegreeAngle ?? this.startDegreeAngle,
      dividerWidth: dividerWidth ?? this.dividerWidth,
      sections: sections ?? this.sections,
      indexToFocus: indexToFocus ?? this.indexToFocus,
      displayTotal: displayTotal ?? this.displayTotal,
    );
  }

  double sumValue() {
    if (sections.isEmpty) {
      return 0.0;
    }
    return sections.map((data) => data.getValue()).reduce((first, second) => first + second);
  }

  List<double> calculateSectionDegreeAngles() {
    double total = sumValue();
    if (total == 0) {
      total = 1;
    }
    return sections.map((section) {
      return (section.getValue() / total) * 360;
    }).toList();
  }

  List<double> calculateSectionPercents() {
    double total = sumValue();
    if (total == 0) {
      total = 1;
    }
    return sections.map((section) {
      return (section.getValue() / total) * 100;
    }).toList();
  }

  static kLoading() {
    return const DonutChartData(
      isLoading: true,
      animatedAngle: 45,
      sections: [
        DonutChartSectionData(
          color: UIColors.gray,
          value: 0,
          percent: 100,
          label: "",
          unit: "",
        ),
      ],
    );
  }

  static kEmpty() {
    return const DonutChartData(
      isLoading: false,
      animatedAngle: 360,
      sections: [
        DonutChartSectionData(
          color: UIColors.gray,
          value: 0,
          percent: 100,
          label: "",
          unit: "",
        ),
      ],
    );
  }
}

class DonutChartSectionData with EquatableMixin {
  const DonutChartSectionData({
    required this.color,
    required this.label,
    required this.unit,
    required this.value,
    this.percent,
    this.radius = 0.0,
    this.legendData,
  });

  final Color color;
  final String label;
  final String unit;
  final double value; // TODO: display on legend
  final double? percent; // TODO: display on chart -> calculate
  final double radius;
  final DonutChartLegendSectionData? legendData;

  double getValue() {
    return percent ?? value;
  }

  @override
  List<Object> get props => [
        value,
        label,
        color,
        radius,
      ];

  static DonutChartSectionData lerp(
    DonutChartSectionData a,
    DonutChartSectionData b,
    double t,
  ) {
    return DonutChartSectionData(
      color: b.color,
      label: b.label,
      unit: b.unit,
      value: b.value,
      percent: b.percent,
      radius: lerpDouble(a.radius, b.radius, t) ?? 0,
      legendData: b.legendData,
    );
  }

  DonutChartSectionData copyWith({
    Color? color,
    String? label,
    String? unit,
    double? value,
    double? percent,
    double? radius,
    DonutChartLegendSectionData? legendData,
  }) {
    return DonutChartSectionData(
      color: color ?? this.color,
      label: label ?? this.label,
      unit: unit ?? this.unit,
      value: value ?? this.value,
      percent: percent ?? this.percent,
      radius: radius ?? this.radius,
      legendData: legendData ?? this.legendData,
    );
  }
}

class DonutChartLegendSectionData {
  DonutChartLegendSectionData({
    required this.growthValue,
    required this.growthStatus,
  });

  final double growthValue;
  final String? growthStatus;

  DonutChartLegendSectionData copyWith({
    double? growthValue,
    String? growthStatus,
  }) {
    return DonutChartLegendSectionData(
      growthValue: growthValue ?? this.growthValue,
      growthStatus: growthStatus ?? this.growthStatus,
    );
  }

  DonutLegendGrowthStatus? getStatus() {
    return DonutLegendGrowthStatus.values.firstWhereOrNull((e) => e.name == growthStatus);
  }
}
