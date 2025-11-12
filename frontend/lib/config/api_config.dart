class ApiConfig {
  static const String baseUrl = 'http://localhost:8000';
  
  static const String holdingsEndpoint = '/api/holdings/';
  
  static String getHoldingsUrl({int? portfolioId, int? userId}) {
    final uri = Uri.parse('$baseUrl$holdingsEndpoint');
    final queryParams = <String, String>{};
    
    if (portfolioId != null) {
      queryParams['portfolio_id'] = portfolioId.toString();
    }
    if (userId != null) {
      queryParams['user_id'] = userId.toString();
    }
    
    return uri.replace(queryParameters: queryParams.isNotEmpty ? queryParams : null).toString();
  }
  
  static String getHoldingByIdUrl(int id) {
    return '$baseUrl$holdingsEndpoint$id';
  }
}
