import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taskmanagement/core.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController date = TextEditingController();
  final List<String> statusList = ["Pending", "In Progress", "Completed"];
  String selectedStatus = 'Pending';
  late final TaskBloc taskBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Add Task'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: Get.height,
        width: Get.width,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              tffTitle(title, 'Judul'),
              hbox(8),
              tff(desc, 'Keterangan'),
              hbox(8),
              tffDate(date, 'Pilih Tanggal', () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2050),
                );

                if (pickedDate != null) {
                  setState(() {
                    date.text = (DateFormat('dd MMM yyyy').format(pickedDate))
                        .toString();
                  });
                }
              }),
              hbox(8),
              ddStatus(
                  selectedStatus,
                  statusList.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(), (newValue) {
                setState(() {
                  selectedStatus = newValue!;
                });
              }),
              hbox(12),
              Align(
                alignment: Alignment.bottomCenter,
                child: buttonBlue('Tambah', () async {
                  if (formKey.currentState!.validate()) {
                    final task = TaskModel(
                        title: title.text.trim(),
                        description: desc.text.trim(),
                        dueDate: date.text,
                        status: selectedStatus);
                    // print('task id :: ${task.id.toString()}');
                    print('task title:: ${task.title.toString()}');
                    print('task desc :: ${task.description.toString()}');
                    print('task date :: ${task.dueDate.toString()}');
                    print('task status:: ${task.status.toString()}');
                    try {
                      final taskBloc =
                          BlocProvider.of<TaskBloc>(context, listen: false);
                      taskBloc.add(AddTask(task: task));
                      print("Task berhasil ditambahkan.");
                      Get.offAll(() => ListTaskScreen());
                    } catch (e) {
                      print(
                          "Error: Tidak dapat menambahkan task. ${e.toString()}");
                    }
                  } else {
                    Get.snackbar(
                        'Field Required', 'Please complete fill the form');
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
