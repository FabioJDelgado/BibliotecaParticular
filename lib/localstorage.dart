import 'dart:html';

void saveData(String key, String value) {
  window.localStorage[key] = value;
}

String loadData(String key) {
  return window.localStorage[key] ?? "";
}