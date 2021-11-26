import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Promo extends Equatable {
  final String title;
  final String subtitle;
  final int discount;

  Promo({
    @required this.title,
    @required this.subtitle,
    @required this.discount,
  });

  @override
  List<Object> get props => [title, subtitle, discount];
}

List<Promo> dummyPromo = [
  Promo(
      title: "Liburan Pelajar",
      subtitle: "Maksimal Hanya 2 Orang",
      discount: 50),
  Promo(
    title: "Klub Keluarga",
    subtitle: "Maksimal Untuk 3 Orang",
    discount: 70,
  ),
  Promo(
    title: "Sabtu-Minggu",
    subtitle: "Hanya Satu Orang",
    discount: 30,
  )
];
