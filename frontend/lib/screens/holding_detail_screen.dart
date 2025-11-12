import 'package:flutter/material.dart';
import '../models/holding.dart';
import '../utils/formatters.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';

class HoldingDetailScreen extends StatelessWidget {
  final Holding holding;

  const HoldingDetailScreen({
    super.key,
    required this.holding,
  });

  @override
  Widget build(BuildContext context) {
    final isProfit = holding.gainLoss >= 0;
    final gainLossColor = isProfit ? AppTheme.profitColor : AppTheme.lossColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(holding.symbol),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryColor,
                    AppTheme.primaryColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    holding.name,
                    style: AppTheme.headlineMedium.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: AppConstants.paddingSmall),
                  Text(
                    holding.symbol,
                    style: AppTheme.titleMedium.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: AppConstants.paddingLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Value',
                            style: AppTheme.bodyMedium.copyWith(color: Colors.white70),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            CurrencyFormatter.format(holding.currentValue),
                            style: AppTheme.headlineLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(AppConstants.paddingMedium),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              isProfit ? Icons.trending_up : Icons.trending_down,
                              color: Colors.white,
                              size: AppConstants.iconSizeLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              PercentageFormatter.format(holding.gainLossPercentage),
                              style: AppTheme.titleMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Performance'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.paddingMedium),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            'Gain/Loss',
                            CurrencyFormatter.format(holding.gainLoss),
                            valueColor: gainLossColor,
                          ),
                          const Divider(),
                          _buildDetailRow(
                            'Gain/Loss %',
                            PercentageFormatter.format(holding.gainLossPercentage),
                            valueColor: gainLossColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingMedium),
                  _buildSectionTitle('Holdings Information'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.paddingMedium),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            'Quantity',
                            NumberFormatter.format(holding.quantity),
                          ),
                          const Divider(),
                          _buildDetailRow(
                            'Purchase Price',
                            CurrencyFormatter.format(holding.purchasePrice),
                          ),
                          const Divider(),
                          _buildDetailRow(
                            'Current Price',
                            CurrencyFormatter.format(holding.currentPrice),
                          ),
                          const Divider(),
                          _buildDetailRow(
                            'Total Cost',
                            CurrencyFormatter.format(holding.totalCost),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingMedium),
                  _buildSectionTitle('Additional Details'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.paddingMedium),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            'Asset Type',
                            holding.assetType,
                          ),
                          const Divider(),
                          _buildDetailRow(
                            'Purchase Date',
                            DateFormatter.formatDate(holding.purchaseDate),
                          ),
                          const Divider(),
                          _buildDetailRow(
                            'Created At',
                            DateFormatter.formatDateTime(holding.createdAt),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingSmall),
      child: Text(
        title,
        style: AppTheme.titleLarge,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.bodyMedium,
          ),
          Text(
            value,
            style: AppTheme.titleMedium.copyWith(
              color: valueColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
