import 'package:flutter/material.dart';
import 'package:ogrenci_app/pages/mesajlar_sayfasi.dart';
import 'package:ogrenci_app/pages/ogrenciler_sayfasi.dart';
import 'package:ogrenci_app/pages/ogretmenler_sayfasi.dart'; 
import 'package:ogrenci_app/repository/mesajlar_repo.dart';
import 'package:ogrenci_app/repository/ogrenciler_repo.dart';
import 'package:ogrenci_app/repository/ogretmenler_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: OgrenciApp()));
}

class OgrenciApp extends StatelessWidget {
  const OgrenciApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ogrenci Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnaSayfa(title: 'Ogrenci Ana Sayfa'),
    );
  }
}

class AnaSayfa extends ConsumerWidget {
  const AnaSayfa({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ogrencilerRepository = ref.watch(ogrencilerProvider);
    final ogretmenlerRepository = ref.watch(ogretmenlerProvider);
    final mesajlarRepository = ref.watch(mesajProvider);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Öğrenci Uygulaması'),
            ),
            ListTile(
              title: Text('Öğrenciler'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OgrencilerSayfasi(),
                ));
              },
            ),
            ListTile(
              title: Text('Öğretmenler'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OgretmenlerSayfasi(),
                ));
              },
            ),
            ListTile(
              title: Text('Mesajlar'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MesajlarSayfasi(),
                ));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  _mesajlaraGit(context);
                },
                child:
                    Text('${ref.watch(yeniMesajSayisiProvider)} Yeni Mesaj')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OgretmenlerSayfasi(),
                  ));
                },
                child: Text(
                    '${ogretmenlerRepository.ogretmenler.length} Öğretmen')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OgrencilerSayfasi(),
                  ));
                },
                child:
                    Text('${ogrencilerRepository.ogrenciler.length} Öğrenci')),
          ],
        ),
      ),
    );
  }

  Future<void> _mesajlaraGit(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const MesajlarSayfasi(),
    ));
  }
}
