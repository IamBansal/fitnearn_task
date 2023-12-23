import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_localizations.dart';

class LocalizationScreen extends StatefulWidget {
  const LocalizationScreen({super.key});

  @override
  State<LocalizationScreen> createState() => _LocalizationScreenState();
}

class _LocalizationScreenState extends State<LocalizationScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(LocaleCont());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.white),
              elevation: MaterialStateProperty.all(20)),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF5271EF),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "${AppLocalization.of(context)
              .getTranslatedValue("localization_appBar_title")}",
          maxLines: 3,
          style: const TextStyle(color: Color(0xFF5271EF)),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: Language.languageList()
              .map(
                (e) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ElevatedButton(
                onPressed: () {
                  Get.find<LocaleCont>()
                      .updateLocale(_changeLanguage(e, context));
                },
                child: Text(e.name),
              ),
            ),
          ).toList(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              AppLocalization.of(context).getTranslatedValue("demo").toString(),
              style: const TextStyle(fontSize: 19),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/forgot.png"),
                    fit: BoxFit.fitHeight)),
          ),
        ],
      ),
    );
  }

  Locale _changeLanguage(Language language, context) {
    Locale a;
    switch (language.languageCode) {
      case ENGLISH:
        a = Locale(language.languageCode, "US");
        break;
      case SPANISH:
        a = Locale(language.languageCode, 'AR');
        break;
      case RUSSIAN:
        a = Locale(language.languageCode, 'RU');
        break;
      default:
        a = Locale(language.languageCode, 'US');
    }
    return a;
  }
}
