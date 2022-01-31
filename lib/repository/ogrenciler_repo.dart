import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/pages/models/ogrenci.dart';

class OgrencilerRepository extends ChangeNotifier {
  final Set<Ogrenci> sevdiklerim = {};

  final ogrenciler = [
    Ogrenci("Ali", "Yılmaz", 18, "Erkek"),
    Ogrenci("Ayşe", "Çelik", 20, "Kadın"),
  ];

  void sev(Ogrenci ogrenci) {
    if (seviyorMuyum(ogrenci)) {
      sevdiklerim.remove(ogrenci);
    } else {
      sevdiklerim.add(ogrenci);
    }
    return notifyListeners();
  }

  bool seviyorMuyum(Ogrenci ogrenci) {
    return sevdiklerim.contains(ogrenci);
  }
}

final ogrencilerProvider = ChangeNotifierProvider((ref) {
  return OgrencilerRepository();
});
