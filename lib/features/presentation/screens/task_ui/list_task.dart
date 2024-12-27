import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagement/core.dart';

class ListTaskScreen extends StatefulWidget {
  const ListTaskScreen({super.key});

  @override
  State<ListTaskScreen> createState() => _ListTaskScreenState();
}

enum FilterStatus { all, pending, inProgress, completed }

class _ListTaskScreenState extends State<ListTaskScreen> {
  bool changeTheme = false;
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();
  String filterStatus = 'All';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTask(
          context,
          changeTheme,
          () => showFilterDialog(context, filterStatus, (value) {
                setState(() {
                  filterStatus = value!;
                });
                Navigator.of(context).pop();
              }), () {
        setState(() {
          changeTheme = !changeTheme;
          BlocProvider.of<ThemeBloc>(context).add(ToggleTheme());
        });
      }),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            tffIconPress(
              searchController,
              'Cari Judul',
              Icons.clear,
              () {
                searchController.clear();
                BlocProvider.of<TaskBloc>(context).add(LoadTasks());
              },
              (value) {
                if (value.length > 4) {
                  BlocProvider.of<TaskBloc>(context)
                      .add(SearchTasks(query: value));
                }
              },
            ),
            Expanded(child:
                BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
              if (state is TaskLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TaskLoaded) {
                final task = state.tasks;
                if (task.isEmpty) {
                  return Center(
                    child: Text('Task empty...'),
                  );
                }
                return CustomMaterialIndicator(
                  onRefresh: () async {
                    BlocProvider.of<TaskBloc>(context).add(LoadTasks());
                  },
                  indicatorBuilder: (context, controller) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: CircularProgressIndicator(),
                    );
                  },
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: task.length,
                      itemBuilder: (context, index) {
                        return Slideable(
                          items: [
                            ActionItems(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              onPress: () {
                                Get.to(
                                    () => UpdateTaskScreen(task: task[index]));
                              },
                              backgroudColor: Colors.transparent,
                            ),
                            ActionItems(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPress: () {
                                setState(() {
                                  int? id = task[index].id;
                                  BlocProvider.of<TaskBloc>(context)
                                      .add(DeleteTask(id: id!));
                                });
                              },
                              backgroudColor: Colors.transparent,
                            ),
                          ],
                          child: Container(
                            width: Get.width,
                            padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.black, width: 0.3)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textChangeColor(
                                        task[index].title, changeTheme),
                                    textChangeColor(
                                        task[index].dueDate, changeTheme),
                                  ],
                                ),
                                hbox(6),
                                textChangeColor2(
                                    task[index].description, changeTheme),
                                hbox(6),
                                textChangeColor(
                                    task[index].status, changeTheme),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              } else if (state is TaskError) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: Text('No tasks available.'));
              }
            })),
            Align(
              alignment: Alignment.bottomCenter,
              child: buttonBlue('Tambah Task', () {
                Get.to(() => AddTaskScreen());
              }),
            )
          ],
        ),
      ),
    );
  }
}
