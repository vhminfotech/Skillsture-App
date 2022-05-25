import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utils/app_config.dart';
import 'utils/constants.dart';
import 'utils/localization/localization.dart';
import 'utils/navigation.dart';

void mainDelegate() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    print(apiBaseUrl);

    return MaterialApp(
      title: 'Base Project',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.oswaldTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: routeLaunch,
      onGenerateRoute: NavigationUtils.generateRoute,
      localizationsDelegates: [
        const MyLocalizationsDelegate(),
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        // const Locale('es', ''),
      ],
    );

//    MultiProvider(
//      providers: [
//        ChangeNotifierProvider(create: (_) => AuthProvider()),
//      ],
//      child: MaterialApp(
//        title: 'MyAreaPlus',
//        theme: ThemeData(
//          primarySwatch: Colors.indigo,
//          textTheme: GoogleFonts.oswaldTextTheme(
//            Theme.of(context).textTheme,
//          ),
//        ),
//        initialRoute: Constants.ROUTE_LAUNCH,
//        onGenerateRoute: NavigationUtils.generateRoute,
//        localizationsDelegates: [
//          const MyLocalizationsDelegate(),
//          DefaultMaterialLocalizations.delegate,
//          DefaultWidgetsLocalizations.delegate,
//        ],
//        supportedLocales: [
//          const Locale('en', ''),
//          // const Locale('es', ''),
//        ],
//      ),
//    );
  }
}
