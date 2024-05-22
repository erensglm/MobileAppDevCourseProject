import 'package:flutter/material.dart';
import 'ana_kategori_ekrani.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kategori Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnaKategoriEkrani(),
    );
  }
}
