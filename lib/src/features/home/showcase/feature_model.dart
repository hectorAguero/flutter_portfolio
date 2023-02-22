import 'package:flutter/material.dart';

class FeatureModel {
  final String title;
  final String description;
  final String? image;
  final String route;
  final Widget widget;

  FeatureModel({
    required this.widget,
    required this.title,
    required this.description,
    this.image,
    required this.route,
  });
}
