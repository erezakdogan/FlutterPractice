import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/pages/models/ogretmen.dart';
import 'package:ogrenci_app/services/data_services.dart';

class OgretmenlerRepository extends ChangeNotifier {
  List<Ogretmen> ogretmenler = [
    Ogretmen("Faruk", "Yılmaz", 18, "Erkek"),
    Ogretmen("Semiha", "Çelik", 20, "Kadın"),
  ];
  final DataService dataService;
  OgretmenlerRepository(this.dataService);

  Future<void> indir() async {
    Ogretmen ogretmen = await dataService.ogretmenIndir();

    ogretmenler.add(ogretmen);
    notifyListeners();
  }

  Future<List<Ogretmen>> hepsiniGetir() async {
    ogretmenler = await dataService.ogretmenleriGetir();
    return ogretmenler;
  }
}

final ogretmenlerProvider = ChangeNotifierProvider((ref) {
  return OgretmenlerRepository(ref.watch(dataServiceProvider));
});

final ogretmenListesiProvider = FutureProvider((ref) {
  return ref.watch(ogretmenlerProvider).hepsiniGetir();
});
 