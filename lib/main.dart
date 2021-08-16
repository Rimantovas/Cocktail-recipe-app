import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/common/common.dart';
import 'package:recipeapp/screens/screens.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RecipesModel(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => Dropdown(),
        ),
        ChangeNotifierProvider(
          create: (context) => Units(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen.navigate(
              name: "assets/rive/splash.riv",
              startAnimation: 'Loading',
              until: () => Future.delayed(Duration(seconds: 2)),
              backgroundColor: Color(0xffF7D2D2),
              next: (_) => BottomNavScreen())),
    );
  }
}
