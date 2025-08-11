import 'package:flutter/material.dart';
import 'router/routes.dart';
import 'router/app_router.dart';
import 'ds/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Educational UI',
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.light,
      initialRoute: Routes.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}