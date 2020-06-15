import 'package:flutter/material.dart';
import 'candy_tile.dart';
import 'package:provider/provider.dart';
import 'package:dulces_client_a/models/candy_data.dart';
import '../screens/add_candy.dart';


class CandyList extends StatelessWidget {
  int posicion;
  @override
  Widget build(BuildContext context) {
    return Consumer<CandyData>(
      builder: (context, candyData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
              final candy  = candyData.candys[index];
            return CandyTile(
              candyTile: candy.name,
              priceTile: candyData.candys[index].price,
              cantidad: candyData.candys[index].cantidad,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => AddCandy(),
                );
              },
            );
          },
          itemCount: candyData.candyCount,
        );
      },
    );
  }
}
