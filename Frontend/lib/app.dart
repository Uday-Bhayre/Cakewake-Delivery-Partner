
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cakewake_delivery/core/routes/app_route.dart';
import 'package:cakewake_delivery/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class MyApp extends StatelessWidget{

  const MyApp({super.key});

  String _getFontFamily(BuildContext context) {
  final code = Localizations.localeOf(context).languageCode;
  switch (code) {
    case 'hi':
      return 'Mukta';
    default:
      return 'Inter';
  }
}


  @override
  Widget build(BuildContext context) {

    final box = GetStorage();
    String? languageCode = box.read('language');
    Locale initialLocale = Locale(languageCode ?? 'en');

    return GetMaterialApp (

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: initialLocale,
      supportedLocales: [ 
        const Locale('en',''),
        const Locale('hi',''),
      ],
      fallbackLocale: const Locale('en',''),
      debugShowCheckedModeBanner: false,
      title: 'CakeWake Delivery Partner',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, 
      initialRoute: '/splash',
      getPages: AppRoute.routes,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      builder: (context, child){
        final fontFamily = _getFontFamily(context);
        final theme= Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.apply(
            fontFamily: fontFamily,
          ),
        );
        return Theme(data: theme, 
        child: EasyLoading.init()(context, child)
        );
      }
      
    );
  }
}
