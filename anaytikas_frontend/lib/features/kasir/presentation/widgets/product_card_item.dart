import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_color.dart';
import '../../../../core/shared/entities/product_with_details_entity.dart';
import '../../../../core/shared/extensions/currency_extension.dart';
import '../manager/cart_provider.dart';

class ProductCardItem extends StatelessWidget {
  final ProductWithDetailsEntity product;

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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
                    'KODE: ${product.product.idProduct}',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      text: 'Harga:  ',
                      children: <TextSpan>[
                        TextSpan(
                          text: product.harga.hargaJual.toRupiah(),
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
                    Builder(
                      builder: (context) {
                        final warningStok = product.product.stokWarning;

                        final stokValue = product.product.jmlhStok;
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: warningStok < stokValue
                                ? Colors.green.withValues(alpha: 0.2)
                                : Colors.red.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            warningStok < stokValue
                                ? 'Stok ada'
                                : 'Stok menipis ($stokValue)',
                            style: TextStyle(
                              color: warningStok < stokValue
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            ),
                          ),
                        );
                      },
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary.withValues(
                          alpha: 0.9,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        // fixedSize: const Size(5, 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        final cart = context.read<CartProvider>();
                        if (cart.isProductInCart(product.product.idProduct)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${product.product.namaProduct} sudah di keranjang!',
                              ),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        } else if (product.product.jmlhStok == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${product.product.namaProduct} sudah habis!',
                              ),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        } else {
                          cart.addItemToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${product.product.namaProduct} berhasil ditambahkan!',
                              ),

                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
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
