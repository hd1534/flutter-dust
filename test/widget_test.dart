// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dust/models/air_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_dust/main.dart';

void main() {
  test("http 통신 테스트", () async {
    var response = await http.get('http://api.airvisual.com/v2/nearest_city?key=3d32f807-7034-43f7-87ce-5d6b0bd992c2');
    expect(response.statusCode, 200);

    AirResult result = AirResult.fromJson(json.decode(response.body));
    expect(result.status, 'success');
  });
}
