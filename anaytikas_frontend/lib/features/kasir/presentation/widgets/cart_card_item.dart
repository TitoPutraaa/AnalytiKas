import '../../../../core/shared/extensions/currency_extension.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../manager/cart_provider.dart';
import 'custom_alert_dialog.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class CartCardItem extends StatelessWidget {
  final CartItemEntity product;
  const CartCardItem({super.key, required this.product});

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
                    product.namaProduct,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    // maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'KODE: ${product.idProduct}',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      text: 'Harga:  ',
                      children: <TextSpan>[
                        TextSpan(
                          text: product.hargaJual.toRupiah(),
                          style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  product.isGrosir
                      ? Column(
                          children: [
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.check_box, color: AppColor.primary),
                                SizedBox(width: 4),
                                const Text(
                                  "Harga Grosir",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColor.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),

            const SizedBox(width: 12),
            Expanded(
              flex: 0,
              child: SizedBox(
                height: 95,
                child: Row(
                  children: [
                    // Button minus
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 10,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        // fixedSize: const Size(5, 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (product.quantity == 1) {
                          showDialog(
                            context: context,
                            builder: (context) => CustomAlertDialog(
                              title: 'Peringatan',
                              content:
                                  'Apakah anda yakin ingin menghapus ${product.namaProduct} dari keranjang?',
                              onConfirm: () {
                                context.read<CartProvider>().reduceItem(
                                  product.idProduct,
                                );
                              },
                            ),
                          );
                        } else {
                          context.read<CartProvider>().reduceItem(
                            product.idProduct,
                          );
                        }
                      },
                      child: Icon(Icons.remove, color: AppColor.darkGray),
                    ),
                    SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.lowGray.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${product.quantity}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    // Button plus
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 10,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        // fixedSize: const Size(5, 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        context.read<CartProvider>().addItem(product.idProduct);
                      },
                      child: Icon(Icons.add, color: AppColor.darkGray),
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
