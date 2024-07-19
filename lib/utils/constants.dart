import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String fontFamily = "Poppins";
  static const baseUrl = "https://newsapi.org/v2/";
  static final apiKey = dotenv.env['NEWSAPI'];
  static const login = "/login";
  static const register = "/register";
  static const profile = "/profile";
  static const home = "/home";
  static List<Map<String, String>> countryList = [
    {"India": "in"},
    {"United Arab Emirates": "ae"},
    {"Argentina": "ar"},
    {"Australia": "au"},
    {"Belgium": "be"},
    {"Bulgaria": "bg"},
    {"Brazil": "br"},
    {"Canada": "ca"},
    {"Switzerland": "ch"},
    {"China": "cn"},
    {"Colombia": "co"},
    {"Cuba": "cu"},
    {"Czech Republic": "cz"},
    {"Germany": "de"},
    {"Egypt": "eg"},
    {"France": "fr"},
    {"United Kingdom": "gb"},
    {"Greece": "gr"},
    {"Hong Kong": "hk"},
    {"Hungary": "hu"},
    {"Indonesia": "id"},
    {"Ireland": "ie"},
    {"Israel": "il"},
    {"Italy": "it"},
    {"Japan": "jp"},
    {"Korea": "kr"},
    {"Lithuania": "lt"},
    {"Latvia": "lv"},
    {"Morocco": "ma"},
    {"Mexico": "mx"},
    {"Malaysia": "my"},
    {"Nigeria": "ng"},
    {"Netherlands": "nl"},
    {"New Zealand": "nz"},
    {"Philippines": "ph"},
    {"Poland": "pl"},
    {"Portugal": "pt"},
    {"Romania": "ro"},
    {"Russia": "ru"},
    {"Saudi Arabia": "sa"},
    {"Sweden": "se"},
    {"Singapore": "sg"},
    {"Slovakia": "sk"},
    {"Thailand": "th"},
    {"Turkey": "tr"},
    {"Taiwan": "tw"},
    {"Ukraine": "ua"},
    {"United States": "us"},
    {"Venezuela": "ve"},
    {"South Africa": "za"}
  ];

  static List<Map<String, String>> languageList = [
    {"Arabic": "ar"},
    {"German": "de"},
    {"English": "en"},
    {"Spanish": "es"},
    {"French": "fr"},
    {"Hebrew": "he"},
    {"Italian": "it"},
    {"Dutch": "nl"},
    {"Norwegian": "no"},
    {"Portuguese": "pt"},
    {"Russian": "ru"},
    {"Slovak": "sk"},
    {"Swedish": "sv"},
    {"Ukrainian": "uk"},
    {"Chinese": "zh"}
  ];

  static List<String> categoryList = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology",
  ];

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your name";
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }
}
