import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphqlconfigs/graphql_provider.dart';
import '../localization/localization.dart';
import '../navigation/navigation.dart';
import '../utils/constants.dart';

Future<void> mainDelegate() async {
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  GraphqlProviderClass graphqlProviderClass = GraphqlProviderClass();

  @override
  Widget build(BuildContext context) {
/*    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);*/

    return GraphQLProvider(
      client: graphqlProviderClass.client,
      child: CacheProvider(
        child: MaterialApp(
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
        ),
      ),
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
