import 'package:flutter/material.dart';
import 'api_service.dart';
import 'yemek_detay_ekrani.dart';

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
        title: Hero(
          tag: widget.kategori,
          child: Material(
            color: Colors.transparent,
            child: Text('${widget.kategori} Yemekleri'),
          ),
        ),
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
                final meal = snapshot.data![index];
                return ListTile(
                  title: Text(meal['strMeal']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YemekDetayEkrani(
                          meal: meal,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
