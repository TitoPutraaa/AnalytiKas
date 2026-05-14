import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class ProdukStok extends StatefulWidget {
  const ProdukStok({super.key});
  @override
  State<ProdukStok> createState() => _ProdukStokState();
}

class _ProdukStokState extends State<ProdukStok> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Card(
            shadowColor: AppColor.darkGray,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kopi Arabica 250g",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          "Kode Barang : 12345",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          "Kategori : Minuman",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          "Harga : 12345",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Column(children: [Text("STOK"), Text("20")]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: Text("Manage stok"),
                      icon: Icon(Icons.add),
                    ),

                    ElevatedButton.icon(
                      onPressed: () {},
                      label: Text("Edit stok"),
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
