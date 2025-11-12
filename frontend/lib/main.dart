import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/holdings_provider.dart';
import 'screens/holdings_screen.dart';
import 'utils/app_theme.dart';
import 'utils/constants.dart';

void main() {
  runApp(const TwiggApp());
}

class TwiggApp extends StatelessWidget {
  const TwiggApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HoldingsProvider(),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const HoldingsScreen(),
      ),
    );
  }
}
