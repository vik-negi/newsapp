import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news/features/auth/service/firestore_service.dart';
import 'package:news/features/home/data/models/article_model.dart';
import 'package:news/features/home/data/repository/news_repository_impl.dart';
import 'package:news/features/home/domain/repository/news_repository.dart';
import 'package:news/injector.dart';

class NewsProvider extends ChangeNotifier {
  final NewsRepository _newsRepository = getIt<NewsRepositoryImpl>();
  List<ArticleModel> topHeadlines = [];

  String _selectedCountry = 'in';
  String _selectedLanguage = 'en';
  String? _selectedCategory;
  bool _isTopHeadlinesLoading = false;
  int currentPage = 1;

  NewsProvider() {
    FirestoreService().getUserCountryCode().then((value) {
      setSelectedCountry(value ?? 'in');
    });
  }

  String get selectedCountry => _selectedCountry;

  void setSelectedCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  String? get selectedCategory => _selectedCategory;
  void setSelectedCountry(String country) {
    _selectedCountry = country;
    notifyListeners();
  }

  String get selectedLanguage => _selectedLanguage;

  void setSelectedLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  void setTopHeadlines(List<ArticleModel> data) {
    topHeadlines = data;
    notifyListeners();
  }

  bool get isTopHeadlinesLoading => _isTopHeadlinesLoading;
  void setIsTopHeadlinesLoading(bool value) {
    _isTopHeadlinesLoading = value;
    notifyListeners();
  }

  void setCurrentPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  Future<void> fetchTopHeadlines() async {
    setIsTopHeadlinesLoading(true);
    final response = await _newsRepository.fetchTopHeadlines(
      countryCode: _selectedCountry,
      // languageCode: _selectedLanguage,
      category: _selectedCategory,
    );
    response.fold((l) => debugPrint(l.message), (r) {
      setTopHeadlines(r.articles);
      // setCurrentPage(currentPage + 1);
    });
    setIsTopHeadlinesLoading(false);
  }

  void reset() {
    topHeadlines = [];
    currentPage = 1;
    _selectedCategory = null;
    _selectedCountry = 'in';
    _selectedLanguage = 'en';

    notifyListeners();
  }
}
