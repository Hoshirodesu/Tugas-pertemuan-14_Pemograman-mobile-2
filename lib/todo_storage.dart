import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo_item.dart';

class TodoStorage {
  static const String _key = 'todos';

  static Future<List<TodoItem>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_key);

    if (data == null) return [];

    final List decoded = jsonDecode(data);
    return decoded.map((e) => TodoItem.fromMap(e)).toList();
  }

  static Future<void> saveTodos(List<TodoItem> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final String data =
        jsonEncode(todos.map((e) => e.toMap()).toList());
    await prefs.setString(_key, data);
  }
}
