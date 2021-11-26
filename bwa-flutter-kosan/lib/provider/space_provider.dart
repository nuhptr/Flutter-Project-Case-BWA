import 'dart:convert';

import 'package:bwa_cozy/model/space.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SpaceProvider extends ChangeNotifier {
  getRecomendedSpace() async {
    var result = await http
        .get(Uri.parse('https://bwa-cozy.herokuapp.com/recommended-spaces'));
    print(result.statusCode);

    if (result.statusCode == 200) {
      List data = jsonDecode(result.body);
      List<Space> space = data.map((item) => Space.fromJson(item)).toList();
      return space;
    } else {
      return <Space>[];
    }
  }
}
