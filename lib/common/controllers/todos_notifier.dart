import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqlcrud/common/models/todo.dart';
import 'package:sqlcrud/common/utils/constants.dart';
import 'package:sqlcrud/sql_helper.dart';

class TodosNotifier extends ChangeNotifier {
  List<TodoTrial> todos = <TodoTrial>[];
  bool loading = false;

  void refresh() async {
    loading = true;
    final data = await DBHelper.getItems();
    todos = data.map((e) => TodoTrial.fromJson(e)).toList();
  }

  void sortTodosByCreatedAt() {
    todos.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
  }

  dynamic getRandomColor() {
    Random random = Random();
    int randomIndex = random.nextInt(colors.length);
    return colors[randomIndex];
  }

  Future<void> addItem(TodoTrial todo) async {
    await DBHelper.createItem(todo);
    refresh();
    notifyListeners();
    print("number of items: ${todos.length}");
  }

  Future<void> updateTodos(int id, String title, String desc) async {
    await DBHelper.updateItem(id, title, desc);
    refresh();
    notifyListeners();
  }

  Future<void> deleteTodos(int id) async {
    await DBHelper.deleteItem(id);
    refresh();
    notifyListeners();
  }
}
