import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/pages/models/ogretmen.dart';

class DataService {
  final String baseUrl = 'https://61d3533ab4c10c001712b8f6.mockapi.io/';

  Future<Ogretmen> ogretmenIndir() async {
    final response = await http.get(Uri.parse('$baseUrl/ogretmen/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Ogretmen.fromMap(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Ogretmen indirilemedi ${response.statusCode}');
    }
  }

  Future<void> ogretmenEkle(Ogretmen ogretmen) async {
    final response = await http.post(Uri.parse('$baseUrl/ogretmen'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(ogretmen.toMap()));

    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Ogretmen eklenemedi ${response.statusCode}');
    }
  }

  var i = 0;
  Future<List<Ogretmen>> ogretmenleriGetir() async {
    final response = await http.get(Uri.parse('$baseUrl/ogretmen'));
 
    i++;
    if (response.statusCode == (i<4 ? 100 : 200)) {
      final l = jsonDecode(response.body);
      return l.map<Ogretmen>((e) => Ogretmen.fromMap(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Ogretmen getirilemedi ${response.statusCode}');
    }
  }
}

final dataServiceProvider = Provider((ref) {
  return DataService();
});
