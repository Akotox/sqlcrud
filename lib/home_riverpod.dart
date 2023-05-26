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

class HomeRiverPod extends StatefulWidget {
  const HomeRiverPod({super.key});

  @override
  State<HomeRiverPod> createState() => _HomeRiverPodState();
}

class _HomeRiverPodState extends State<HomeRiverPod> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TodoListView(update: () {}),
      ),
    );
  }

  _showForm(int? id, List<TodoTrial> todos, TextEditingController title,
      TextEditingController desc) async {
    if (id != null) {
      final existingTodo = todos.firstWhere((element) => element.id == id);
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
                  Consumer(
                    builder: (context, ref, child) {
                      final fcts = ref.read(todosProvider);
                      return CustomOutlineBtn(
                          onTap: () async {
                            if (id == null) {
                              TodoTrial todo = TodoTrial(
                                  title: title.text,
                                  desc: desc.text,
                                  createdAt: DateTime.now().toString());
                              await fcts.addItem(todo);
                            } else if (id != null) {
                              await fcts.updateTodos(id, title.text, desc.text);
                            }

                            // ref.read(todosProvider).addTodo(todo);
                          },
                          hieght: 52.h,
                          text: id == null ? "Submit" : "Update",
                          color: AppConst.kGreen);
                    },
                  )
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

class TodoListView extends ConsumerWidget {
  const TodoListView({super.key, required this.update});

  final void Function()? update;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
        itemCount: ref.watch(todosProvider).todos.length,
        itemBuilder: (context, index) {
          final data = ref.watch(todosProvider).todos[index];
          dynamic color = ref.read(todosProvider).getRandomColor();
          return TodoTile(
            title: data.title,
            color: color,
            description: data.desc,
            update: update,
            delete: () => ref.watch(todosProvider).deleteTodos(data.id ?? 0),
            child: Switch(
              value: false,
              onChanged: (value) {
                // ref.read(todosProvider.notifier).toggle(todo.id);
              },
            ),
          );
        });
  }
}
