import 'package:flutter/material.dart';
import '../models/holding.dart';
import '../utils/formatters.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';

class HoldingCard extends StatelessWidget {
  final Holding holding;
  final VoidCallback? onTap;

  const HoldingCard({
    super.key,
    required this.holding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isProfit = holding.gainLoss >= 0;
    final gainLossColor = isProfit ? AppTheme.profitColor : AppTheme.lossColor;
    final gainLossBgColor = isProfit ? AppTheme.profitLightColor : AppTheme.lossLightColor;
    
    return Card(
      elevation: 0,
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppTheme.dividerColor,
          width: 2.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(AppConstants.paddingMedium + 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          holding.symbol,
                          style: AppTheme.titleLarge.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          holding.name,
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.textSecondaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.dividerColor.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      holding.assetType,
                      style: AppTheme.labelMedium.copyWith(
                        color: AppTheme.textSecondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: gainLossBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Value',
                            style: AppTheme.labelSmall.copyWith(
                              color: AppTheme.textSecondaryColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            CurrencyFormatter.format(holding.currentValue),
                            style: AppTheme.titleLarge.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: gainLossColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isProfit ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                                color: gainLossColor,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                CurrencyFormatter.format(holding.gainLoss.abs()),
                                style: AppTheme.titleMedium.copyWith(
                                  color: gainLossColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            PercentageFormatter.format(holding.gainLossPercentage),
                            style: AppTheme.bodySmall.copyWith(
                              color: gainLossColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Divider(
                height: 1,
                color: AppTheme.dividerColor.withOpacity(0.5),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoItem(
                    'Quantity',
                    NumberFormatter.format(holding.quantity),
                    Icons.layers_outlined,
                  ),
                  Container(
                    width: 1,
                    height: 32,
                    color: AppTheme.dividerColor.withOpacity(0.5),
                  ),
                  _buildInfoItem(
                    'Avg Price',
                    CurrencyFormatter.format(holding.purchasePrice),
                    Icons.shopping_cart_outlined,
                  ),
                  Container(
                    width: 1,
                    height: 32,
                    color: AppTheme.dividerColor.withOpacity(0.5),
                  ),
                  _buildInfoItem(
                    'Current',
                    CurrencyFormatter.format(holding.currentPrice),
                    Icons.attach_money_outlined,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppTheme.textHintColor,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTheme.labelSmall.copyWith(
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
