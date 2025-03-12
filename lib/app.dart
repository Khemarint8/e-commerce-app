
import 'package:danastoreadminpanel/bindings/general_binding.dart';
import 'package:danastoreadminpanel/routes/app_routes.dart';
import 'package:danastoreadminpanel/routes/routes.dart';

import 'package:danastoreadminpanel/utils/constants/text_strings.dart';
import 'package:danastoreadminpanel/utils/constants/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      getPages: RAppRoutes.pages,
      initialBinding: GeneralBinding(),
      initialRoute: RRoutes.dashboard,
      unknownRoute: GetPage(
          name: '/page-not-found',
          page: () => const Scaffold(
                body: Center(
                  child: Text('Page not Found'),
                ),
              )),
      // home: const FirstScreen(),
    );
  }
}

