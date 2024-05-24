import 'package:flutter/material.dart';

class YemekDetayEkrani extends StatelessWidget {
  final dynamic meal;

  YemekDetayEkrani({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal['strMeal']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: meal['strMeal'],
              child: Material(
                color: Colors.transparent,
                child: Text(
                  meal['strMeal'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 16),
            Image.network(meal['strMealThumb']),
            SizedBox(height: 16),
            Text(
              'Meal ID: ${meal['idMeal']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            // Diğer detaylar burada gösterilebilir
          ],
        ),
      ),
    );
  }
}
