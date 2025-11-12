class Holding {
  final int id;
  final int portfolioId;
  final String symbol;
  final String name;
  final double quantity;
  final double purchasePrice;
  final double currentPrice;
  final String assetType;
  final DateTime purchaseDate;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final double totalCost;
  final double currentValue;
  final double gainLoss;
  final double gainLossPercentage;

  Holding({
    required this.id,
    required this.portfolioId,
    required this.symbol,
    required this.name,
    required this.quantity,
    required this.purchasePrice,
    required this.currentPrice,
    required this.assetType,
    required this.purchaseDate,
    required this.createdAt,
    this.updatedAt,
    required this.totalCost,
    required this.currentValue,
    required this.gainLoss,
    required this.gainLossPercentage,
  });

  factory Holding.fromJson(Map<String, dynamic> json) {
    return Holding(
      id: json['id'] as int,
      portfolioId: json['portfolio_id'] as int,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      quantity: _parseDouble(json['quantity']),
      purchasePrice: _parseDouble(json['purchase_price']),
      currentPrice: _parseDouble(json['current_price']),
      assetType: json['asset_type'] as String,
      purchaseDate: DateTime.parse(json['purchase_date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String) 
          : null,
      totalCost: _parseDouble(json['total_cost']),
      currentValue: _parseDouble(json['current_value']),
      gainLoss: _parseDouble(json['gain_loss']),
      gainLossPercentage: _parseDouble(json['gain_loss_percentage']),
    );
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  bool get isProfit => gainLoss >= 0;
}
