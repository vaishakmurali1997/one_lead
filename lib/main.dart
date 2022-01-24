import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_lead/utils/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1 Lead ',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme
        )
      ),
      initialRoute: '/',
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}