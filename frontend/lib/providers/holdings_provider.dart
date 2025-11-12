import 'package:flutter/foundation.dart';
import '../models/holdings_response.dart';
import '../services/holdings_api_service.dart';

enum HoldingsStatus {
  initial,
  loading,
  loaded,
  error,
}

class HoldingsProvider with ChangeNotifier {
  final HoldingsApiService _apiService = HoldingsApiService();
  
  HoldingsResponse? _holdingsResponse;
  HoldingsStatus _status = HoldingsStatus.initial;
  String? _errorMessage;
  String? _errorType;
  String? _selectedAssetType;
  
  HoldingsResponse? get holdingsResponse => _holdingsResponse;
  HoldingsStatus get status => _status;
  String? get errorMessage => _errorMessage;
  String? get errorType => _errorType;
  String? get selectedAssetType => _selectedAssetType;
  
  bool get hasData => _holdingsResponse != null && _holdingsResponse!.holdings.isNotEmpty;
  
  List<String> get assetTypes {
    if (_holdingsResponse == null) return [];
    final types = _holdingsResponse!.holdings
        .map((h) => h.assetType)
        .toSet()
        .toList();
    types.sort();
    return types;
  }
  
  List<dynamic> get filteredHoldings {
    if (_holdingsResponse == null) return [];
    if (_selectedAssetType == null) {
      return _holdingsResponse!.holdings;
    }
    return _holdingsResponse!.holdings
        .where((h) => h.assetType == _selectedAssetType)
        .toList();
  }
  
  Future<void> fetchHoldings({int? portfolioId, int? userId}) async {
    _status = HoldingsStatus.loading;
    _errorMessage = null;
    _errorType = null;
    notifyListeners();
    
    try {
      final response = await _apiService.fetchHoldings(
        portfolioId: portfolioId,
        userId: userId,
      );
      
      _holdingsResponse = response;
      _status = HoldingsStatus.loaded;
      _errorMessage = null;
      _errorType = null;
    } on ApiException catch (e) {
      _status = HoldingsStatus.error;
      _errorMessage = e.message;
      _errorType = e.type;
      _holdingsResponse = null;
    } catch (e) {
      _status = HoldingsStatus.error;
      _errorMessage = 'An unexpected error occurred';
      _errorType = 'unknown';
      _holdingsResponse = null;
    }
    
    notifyListeners();
  }
  
  void setAssetTypeFilter(String? assetType) {
    _selectedAssetType = assetType;
    notifyListeners();
  }
  
  void clearFilter() {
    _selectedAssetType = null;
    notifyListeners();
  }
  
  void reset() {
    _holdingsResponse = null;
    _status = HoldingsStatus.initial;
    _errorMessage = null;
    _errorType = null;
    _selectedAssetType = null;
    notifyListeners();
  }
}
