import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/holdings_provider.dart';
import '../widgets/holding_card.dart';
import '../widgets/portfolio_insights_widget.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/empty_state.dart';
import '../widgets/error_display.dart';
import '../utils/constants.dart';
import '../utils/app_theme.dart';
import 'holding_detail_screen.dart';

class HoldingsScreen extends StatefulWidget {
  const HoldingsScreen({super.key});

  @override
  State<HoldingsScreen> createState() => _HoldingsScreenState();
}

class _HoldingsScreenState extends State<HoldingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HoldingsProvider>().fetchHoldings();
    });
  }

  Future<void> _onRefresh() async {
    await context.read<HoldingsProvider>().fetchHoldings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.account_balance_wallet_rounded,
                color: AppTheme.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(AppConstants.appName),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _onRefresh,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Consumer<HoldingsProvider>(
        builder: (context, provider, child) {
          if (provider.status == HoldingsStatus.loading &&
              provider.holdingsResponse == null) {
            return const LoadingShimmer();
          }

          if (provider.status == HoldingsStatus.error) {
            return ErrorDisplay(
              message: provider.errorMessage ?? AppStrings.errorMessage,
              errorType: provider.errorType,
              onRetry: _onRefresh,
            );
          }

          if (provider.holdingsResponse == null ||
              provider.holdingsResponse!.holdings.isEmpty) {
            return const EmptyState();
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingSmall),
                    child: PortfolioInsightsWidget(
                      insights: provider.holdingsResponse!.insights,
                    ),
                  ),
                ),
                if (provider.assetTypes.isNotEmpty)
                  SliverToBoxAdapter(
                    child: _buildFilterChips(provider),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.all(AppConstants.paddingSmall),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final holding = provider.filteredHoldings[index];
                        return HoldingCard(
                          holding: holding,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HoldingDetailScreen(
                                  holding: holding,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      childCount: provider.filteredHoldings.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterChips(HoldingsProvider provider) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingSmall),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
        children: [
          FilterChip(
            label: const Text('All'),
            selected: provider.selectedAssetType == null,
            onSelected: (_) => provider.clearFilter(),
          ),
          const SizedBox(width: AppConstants.paddingSmall),
          ...provider.assetTypes.map((type) {
            return Padding(
              padding: const EdgeInsets.only(right: AppConstants.paddingSmall),
              child: FilterChip(
                label: Text(type),
                selected: provider.selectedAssetType == type,
                onSelected: (_) => provider.setAssetTypeFilter(type),
              ),
            );
          }),
        ],
      ),
    );
  }
}
