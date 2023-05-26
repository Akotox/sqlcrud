import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqlcrud/common/controllers/todos_notifier.dart';
import 'package:sqlcrud/common/models/todo.dart';
import 'package:sqlcrud/common/utils/constants.dart';
import 'package:sqlcrud/common/widgets/app_style.dart';
import 'package:sqlcrud/common/widgets/custom_outline_btn.dart';
import 'package:sqlcrud/common/widgets/custom_textfield.dart';
import 'package:sqlcrud/common/widgets/date_picker.dart';
import 'package:sqlcrud/common/widgets/height_spacer.dart';
import 'package:sqlcrud/common/widgets/reusable_text.dart';
import 'package:sqlcrud/common/widgets/todo_tile.dart';
import 'package:sqlcrud/sql_helper.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  List<TodoTrial> _todos = [];
  List<TodoTrial> _sorted = [];

  bool loading = true;

  void _refresh() async {
    final data = await DBHelper.getItems();
    setState(() {
      _todos = data.map((e) => TodoTrial.fromJson(e)).toList();
      loading = false;
    });
  }

 

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  dynamic getRandomColor() {
    Random random = Random();
    int randomIndex = random.nextInt(colors.length);
    return colors[randomIndex];
  }

  Future<void> _addItem(TodoTrial todo) async {
    await DBHelper.createItem(todo);
    _refresh();
    title.clear();
    desc.clear();
    print("number of items: ${_todos.length}");
  }

  Future<void> _updateTodos(int id) async {
    await DBHelper.updateItem(id, title.text, desc.text);
    title.clear();
    desc.clear();
    _refresh();
  }

  Future<void> _deleteTodos(int id) async {
    await DBHelper.deleteItem(id);
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
            itemCount: _todos.length,
            itemBuilder: (context, index) {
              final data = _todos[index];
              dynamic color = getRandomColor();
              return TodoTile(
                title: data.title,
                color: color,
                description: data.desc,
                update: () => _showForm(data.id),
                delete: () => _deleteTodos(data.id ?? 0),
                child: Switch(
                  value: false,
                  onChanged: (value) {
                    // ref.read(todosProvider.notifier).toggle(todo.id);
                  },
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(null),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showForm(int? id) async {
    if (id != null) {
      final existingTodo = _todos.firstWhere((element) => element.id == id);
      title.text = existingTodo.title.toString();
      desc.text = existingTodo.desc.toString();
    }

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(maxHeight: AppConst.kHieght),
          decoration: const BoxDecoration(
              color: AppConst.kBackgroundDark,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              )),
          child: SizedBox(
            height: AppConst.kHieght * 0.8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpacer(size: 20),
                  CustomTextField(
                      hintText: "Add title",
                      controller: title,
                      hintStyle:
                          appstyle(16, AppConst.kLightGrey, FontWeight.w600)),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                      hintText: "Add description",
                      controller: desc,
                      hintStyle:
                          appstyle(16, AppConst.kLightGrey, FontWeight.w600)),
                  const HeightSpacer(size: 15),
                  ReusableText(
                      text: "From : ",
                      style: appstyle(16, AppConst.kLight, FontWeight.bold)),
                  const HeightSpacer(size: 5),
                  const DatePicker(),
                  const HeightSpacer(size: 15),
                  ReusableText(
                      text: "To : ",
                      style: appstyle(16, AppConst.kLight, FontWeight.bold)),
                  const HeightSpacer(size: 5),
                  const DatePicker(),
                  const HeightSpacer(size: 15),
                  CustomOutlineBtn(
                      onTap: () async {
                        if (id == null) {
                          TodoTrial todo = TodoTrial(
                              title: title.text,
                              desc: desc.text,
                              createdAt: DateTime.now().toString());
                          await _addItem(todo);
                        } else if (id != null) {
                          await _updateTodos(id);
                        }

                        // ref.read(todosProvider).addTodo(todo);
                      },
                      hieght: 52.h,
                      text: id == null ? "Submit" : "Update",
                      color: AppConst.kGreen)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

final todosProvider = ChangeNotifierProvider<TodosNotifier>((ref) {
  return TodosNotifier();
});
