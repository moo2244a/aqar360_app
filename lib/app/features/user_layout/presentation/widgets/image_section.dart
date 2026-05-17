import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ImageSection extends StatelessWidget {
  final String imageUrl;
  final String zoning;
  final double price;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final Color? Function(String)? zoningColor;

  const ImageSection({
    super.key,
    required this.imageUrl,
    required this.zoning,
    required this.price,
    required this.isFavorite,
    required this.onFavoriteTap,
    this.zoningColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(imageUrl)),
      ),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Zoning Badge ───
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: zoningColor?.call(zoning) ?? Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    zoning,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Card(
                  shape: const CircleBorder(),
                  color: AppColors.backgroundWhite.withValues(alpha: .5),
                  child: IconButton(
                    onPressed: onFavoriteTap,
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 30,
                      color: isFavorite
                          ? Colors.red
                          : AppColors.backgroundWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            width: double.infinity,
            alignment: .center,
            color: AppColors.black.withValues(alpha: .4),
            child: Text(
              "${_formatPrice(price)}"
              "ج.م ",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 20,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(double v) {
    if (v >= 1000000) {
      return 'مليون ${(v / 1000000).toStringAsFixed(3)} ';
    }
    if (v >= 1000) return 'ألف ${(v / 1000).toStringAsFixed(2)} ';
    return v.toStringAsFixed(0);
  }
}
