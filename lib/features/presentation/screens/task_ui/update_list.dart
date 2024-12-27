import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taskmanagement/core.dart';

class UpdateTaskScreen extends StatefulWidget {
  final TaskModel task;
  const UpdateTaskScreen({super.key, required this.task});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
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
    title.text = widget.task.title;
    desc.text = widget.task.description;
    date.text = widget.task.dueDate;
    selectedStatus = widget.task.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Task'),
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
                child:
                    // state is TaskLoading
                    //     ? Center(
                    //         child: CircularProgressIndicator(),
                    //       ) :
                    buttonBlue('Perbaharui', () async {
                  if (formKey.currentState!.validate()) {
                    final task = TaskModel(
                        id: widget.task.id,
                        title: title.text.trim(),
                        description: desc.text.trim(),
                        dueDate: date.text,
                        status: selectedStatus);

                    try {
                      final taskBloc =
                          BlocProvider.of<TaskBloc>(context, listen: false);
                      taskBloc.add(UpdateTask(task: task));
                      print("Task berhasil diperbaharui.");

                      Get.offAll(() => ListTaskScreen());
                    } catch (e) {
                      print(
                          "Error: Tidak dapat memperbaharui task. ${e.toString()}");
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
