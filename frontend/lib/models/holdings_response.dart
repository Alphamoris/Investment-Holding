import 'holding.dart';
import 'portfolio_insights.dart';

class HoldingsResponse {
  final List<Holding> holdings;
  final PortfolioInsights insights;

  HoldingsResponse({
    required this.holdings,
    required this.insights,
  });

  factory HoldingsResponse.fromJson(Map<String, dynamic> json) {
    return HoldingsResponse(
      holdings: (json['holdings'] as List<dynamic>)
          .map((holdingJson) => Holding.fromJson(holdingJson as Map<String, dynamic>))
          .toList(),
      insights: PortfolioInsights.fromJson(json['insights'] as Map<String, dynamic>),
    );
  }
}
