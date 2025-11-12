import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';
import '../config/api_config.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? errorType;

  const ErrorDisplay({
    super.key,
    required this.message,
    this.onRetry,
    this.errorType,
  });

  IconData _getErrorIcon() {
    if (errorType == 'connection' || errorType == 'timeout') {
      return Icons.cloud_off_outlined;
    } else if (errorType == 'not_found') {
      return Icons.search_off_outlined;
    } else if (errorType == 'server_error') {
      return Icons.storage_outlined;
    }
    return Icons.error_outline;
  }

  String _getErrorTitle() {
    if (errorType == 'connection' || errorType == 'timeout') {
      return 'Connection Failed';
    } else if (errorType == 'not_found') {
      return 'No Data Found';
    } else if (errorType == 'server_error') {
      return 'Server Error';
    }
    return AppStrings.errorTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingLarge * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getErrorIcon(),
                size: 64,
                color: AppTheme.errorColor,
              ),
            ),
            const SizedBox(height: AppConstants.paddingLarge * 1.5),
            Text(
              _getErrorTitle(),
              style: AppTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Text(
              message,
              style: AppTheme.bodyMedium.copyWith(height: 1.6),
              textAlign: TextAlign.center,
            ),
            if (errorType == 'connection' || errorType == 'timeout') ...[
              const SizedBox(height: AppConstants.paddingLarge),
              Container(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                decoration: BoxDecoration(
                  color: AppTheme.infoColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.infoColor.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: AppTheme.infoColor,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Backend Server',
                            style: AppTheme.titleSmall.copyWith(
                              color: AppTheme.infoColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Make sure the FastAPI backend is running at:\n${ApiConfig.baseUrl}',
                      style: AppTheme.bodySmall.copyWith(
                        fontFamily: 'monospace',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: AppConstants.paddingLarge * 2),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 20),
                label: const Text(AppStrings.retry),
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
