import 'package:flutter/material.dart';
import 'alt_kategori_ekrani.dart';
import 'api_service.dart';

class AnaKategoriEkrani extends StatefulWidget {
  @override
  _AnaKategoriEkraniState createState() => _AnaKategoriEkraniState();
}

class _AnaKategoriEkraniState extends State<AnaKategoriEkrani> {
  late ApiService apiService;
  late Future<List<dynamic>> futureCategories;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    futureCategories = apiService.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemek Kategorileri'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureCategories,
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
                final category = snapshot.data![index]['strCategory'];
                return ListTile(
                  title: Hero(
                    tag: category,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(category),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AltKategoriEkrani(
                          kategori: category,
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
