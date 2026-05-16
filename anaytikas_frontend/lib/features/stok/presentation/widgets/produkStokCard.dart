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
    return Card(
      color: AppColor.white,
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.white,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                    side: BorderSide(color: AppColor.black, width: 1),
                  ),
                ),
                label: Text(
                  "Edit stok",
                  style: TextStyle(
                    color: AppColor.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                icon: Icon(Icons.settings, color: AppColor.black),
              ),

              ElevatedButton.icon(
                onPressed: () {},
                label: Text(
                  "Tambah stok",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
