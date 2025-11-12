import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/holdings_response.dart';
import '../config/api_config.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String type;

  ApiException(this.message, {this.statusCode, this.type = 'unknown'});

  @override
  String toString() => message;
}

class HoldingsApiService {
  Future<HoldingsResponse> fetchHoldings({
    int? portfolioId,
    int? userId,
  }) async {
    try {
      final url = ApiConfig.getHoldingsUrl(
        portfolioId: portfolioId,
        userId: userId,
      );

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw ApiException(
            'Connection timeout. Please check if the backend server is running.',
            type: 'timeout',
          );
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return HoldingsResponse.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw ApiException(
          'No holdings found. The API endpoint may not be available.',
          statusCode: 404,
          type: 'not_found',
        );
      } else if (response.statusCode >= 500) {
        throw ApiException(
          'Server error. Please try again later.',
          statusCode: response.statusCode,
          type: 'server_error',
        );
      } else {
        throw ApiException(
          'Failed to load holdings (${response.statusCode})',
          statusCode: response.statusCode,
          type: 'http_error',
        );
      }
    } on SocketException {
      throw ApiException(
        'Cannot connect to server. Please ensure the backend is running at ${ApiConfig.baseUrl}',
        type: 'connection',
      );
    } on FormatException {
      throw ApiException(
        'Invalid response format from server',
        type: 'format',
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        'Unexpected error: ${e.toString()}',
        type: 'unknown',
      );
    }
  }
}
