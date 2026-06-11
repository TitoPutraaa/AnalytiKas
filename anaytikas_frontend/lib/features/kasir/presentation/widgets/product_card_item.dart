import 'package:anaytikas_frontend/core/shared/models/product_with_details.dart';
import 'package:anaytikas_frontend/features/kasir/data/models/cart_item_models.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/pages/keranjang_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_color.dart';

class ProductCardItem extends StatelessWidget {
  final ProductWithDetails product;

  const ProductCardItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(color: AppColor.lowGray, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.product.namaProduct,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    // maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${product.product.idHarga}',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      text: 'Harga:  ',
                      style: TextStyle(),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Rp. ${(product.harga.hargaJual)}',
                          style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),
            Expanded(
              flex: 0,
              child: SizedBox(
                height: 95,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Stok ada',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary.withValues(
                          alpha: 0.9,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 18,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        // fixedSize: const Size(5, 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              final CartItemModels itemCart =
                                  CartItemModels.fromMap(product);
                              return KeranjangPage(product: itemCart);
                            },
                          ),
                        );
                      },
                      child: const Icon(Icons.shopping_cart, size: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
