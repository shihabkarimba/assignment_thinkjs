import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WordListProvider extends ChangeNotifier {
  List<String> wordList = [];
  List<String> wishlist = [];

  WordListProvider() {
    loadWordList();
    loadWishlist();
  }

  Future<void> loadWordList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    wordList = prefs.getStringList('wordList') ?? [];
    notifyListeners();
  }

  Future<void> loadWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    wishlist = prefs.getStringList('wishlist') ?? [];
    notifyListeners();
  }

  Future<void> addWord(String newWord) async {
    wordList.add(newWord);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('wordList', wordList);
    notifyListeners();
  }

  Future<void> addToWishlist(String word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (wishlist.contains(word)) {
      return;
    }
    wishlist.add(word);
    await prefs.setStringList('wishlist', wishlist);
    notifyListeners();
  }

  Future<void> removeFromWishlist(String word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    wishlist.remove(word);
    await prefs.setStringList('wishlist', wishlist);
    notifyListeners();
  }

  void editWord(int index, String editedWord) {
    wordList[index] = editedWord;
    saveWordList();
  }

  void deleteWord(int index) {
    wordList.removeAt(index);
    saveWordList();
  }

  void saveWordList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('wordList', wordList);
    notifyListeners();
  }
}
