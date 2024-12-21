import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lab_3/base.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ToDoList db = ToDoList();

  List selectedItems = [];

  @override
  void initState() {
    db.loadData();
    setState(() {
      selectedItems = db.toDo;
    });
    super.initState();
  }

  int getId() {
    if (db.toDo.isNotEmpty) {
      if (db.toDo.length == 1) {
        return 1;
      } else {
        return db.toDo[db.toDo.length - 1]['id'] + 1;
      }
    } else {
      return 0;
    }
  }

  void redactered_task(int index) {
    final TextEditingController controller = TextEditingController();
    controller.text = selectedItems[index]['name'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Изменить задачу'),
          content: TextField(
            controller: controller,
            decoration:
                const InputDecoration(hintText: 'Введите измененное название'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                String task_name = controller.text;
                setState(() {
                  db.toDo[selectedItems[index]['id']] = {
                    'id': selectedItems[index]['id'],
                    'is_active': false,
                    'name': task_name
                  };
                  db.update();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Изменить'),
            ),
          ],
        );
      },
    );
  }

  void add_task() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Добавить новую задачу'),
          content: TextField(
            controller: controller,
            decoration:
                const InputDecoration(hintText: 'Введите название задачи'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                String task_name = controller.text;
                setState(() {
                  db.toDo.add(
                      {'id': getId(), 'is_active': false, 'name': task_name});
                  db.update();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }

  List get_list(int filter) {
    if (filter == 1) {
      return db.toDo.where((item) => item['is_active'] == false).toList();
    } else if (filter == 2) {
      return db.toDo.where((item) => item['is_active'] == true).toList();
    }
    return db.toDo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 39, 39),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          'ToDo List',
          style: TextStyle(color: Color.fromARGB(255, 172, 18, 100)),
        ),
        actions: [
          DropdownMenu(
            inputDecorationTheme: const InputDecorationTheme(
              border: null
            ),
            initialSelection: 0,
            textStyle: TextStyle(color: Color.fromARGB(255, 22, 231, 250)),
            onSelected: (value) {
              setState(() {
                selectedItems = get_list(int.parse(value!.toString()));
              });
            },
            dropdownMenuEntries: const [
              DropdownMenuEntry(
                value: 0,
                label: 'Все',
              ),
              DropdownMenuEntry(
                value: 1,
                label: 'Не завершенные',
              ),
              DropdownMenuEntry(
                value: 2,
                label: 'Завершенные',
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView.builder(
          itemCount: selectedItems.length,
          itemBuilder: (context, index) {
            return SizedBox(
                child: GestureDetector(
              child: Card(
                color: const Color.fromARGB(255, 96, 8, 118),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: selectedItems[index]['is_active'],
                          onChanged: (value) {
                            setState(() {
                              db.toDo[selectedItems[index]['id']]['is_active'] =
                                  value;
                              db.update();
                            });
                          },
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.57,
                            child: Text(selectedItems[index]['name'],
                                style: TextStyle(
                                    color: Color.fromARGB(255, 22, 231, 250)),
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              db.toDo.removeAt(index);
                            });
                          },
                          child: Text('DEL', style: TextStyle(color: Color.fromARGB(255, 22, 231, 250)),),
                          style: ButtonStyle(
                            alignment: Alignment.centerRight,
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 96, 8, 118),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              onTap: () {
                redactered_task(index);
              },
            ));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add_task,
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 96, 8, 118),
      ),
    );
  }
}
