import 'package:flutter_dust/models/air_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

class AirBloc {

  final _airSubject = BehaviorSubject<AirResult>();

  AirBloc() {
    fetch();
  }

  Future<AirResult> fetchData() async {
    var response = await http.get('http://api.airvisual.com/v2/nearest_city?key=3d32f807-7034-43f7-87ce-5d6b0bd992c2');
    AirResult result = AirResult.fromJson(json.decode(response.body));

    return result;
  }

  void fetch() async {
    var airResult = await  fetchData();
    _airSubject.add(airResult);
  }

  Stream<AirResult> get airResult => _airSubject.stream;

}