import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FlutiveTransaction extends Equatable {
  final String userId;
  final String title;
  final String subtitle;
  final String picture;
  final int amount;
  final DateTime time;

  FlutiveTransaction({
    @required this.userId,
    @required this.title,
    @required this.subtitle,
    this.picture,
    this.amount = 0,
    @required this.time,
  });

  @override
  List<Object> get props => [userId, title, subtitle, picture, amount, time];
}
