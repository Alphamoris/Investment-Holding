class PortfolioInsights {
  final int totalHoldings;
  final double totalCost;
  final double totalCurrentValue;
  final double totalGainLoss;
  final double totalGainLossPercentage;
  final String? bestPerformer;
  final String? worstPerformer;
  final Map<String, double> assetAllocation;

  PortfolioInsights({
    required this.totalHoldings,
    required this.totalCost,
    required this.totalCurrentValue,
    required this.totalGainLoss,
    required this.totalGainLossPercentage,
    this.bestPerformer,
    this.worstPerformer,
    required this.assetAllocation,
  });

  factory PortfolioInsights.fromJson(Map<String, dynamic> json) {
    final assetAllocation = <String, double>{};
    if (json['asset_allocation'] != null) {
      (json['asset_allocation'] as Map<String, dynamic>).forEach((key, value) {
        assetAllocation[key] = _parseDouble(value);
      });
    }

    return PortfolioInsights(
      totalHoldings: json['total_holdings'] as int,
      totalCost: _parseDouble(json['total_cost']),
      totalCurrentValue: _parseDouble(json['total_current_value']),
      totalGainLoss: _parseDouble(json['total_gain_loss']),
      totalGainLossPercentage: _parseDouble(json['total_gain_loss_percentage']),
      bestPerformer: json['best_performer'] as String?,
      worstPerformer: json['worst_performer'] as String?,
      assetAllocation: assetAllocation,
    );
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
