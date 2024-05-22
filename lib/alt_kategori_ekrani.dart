import 'package:flutter/material.dart';
import 'api_service.dart';

class AltKategoriEkrani extends StatefulWidget {
  final String kategori;

  AltKategoriEkrani({required this.kategori});

  @override
  _AltKategoriEkraniState createState() => _AltKategoriEkraniState();
}

class _AltKategoriEkraniState extends State<AltKategoriEkrani> {
  late ApiService apiService;
  late Future<List<dynamic>> futureMeals;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    futureMeals = apiService.fetchMealsByCategory(widget.kategori);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.kategori} Yemekleri'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureMeals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Veri bulunamadı'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]['strMeal']),
                  // Burada yemek detayları sayfasına gitmek için onTap fonksiyonu eklenebilir
                );
              },
            );
          }
        },
      ),
    );
  }
}
