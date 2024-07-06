import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskit/providers/tasks_provider.dart';
import 'package:taskit/services/auth_service.dart';
import 'package:taskit/widgets/button_switch_brightness.dart';
import 'package:taskit/widgets/task_dialogs.dart';
import 'package:taskit/widgets/task_list_tile.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userDataService = Provider.of<AuthService>(context);
    final tasksProvider = Provider.of<TasksProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("TASKIT"),
        centerTitle: true,
        actions: [
          const ButtonSwitchBrightness(),
          IconButton(
            onPressed: userDataService.signOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => TaskDialogs.showAddTaskDialog(context, tasksProvider),
        child: const Icon(Icons.add),
      ),
      body: tasksProvider.currentTasks != null
          ? Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: tasksProvider.currentTasks!.isEmpty
                      ? Center(
                          child: Text(
                            'You have no tasks',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: tasksProvider.currentTasks!.length,
                          itemBuilder: (context, index) {
                            final task = tasksProvider.currentTasks![index];
                            return TaskListTile(
                              task: task,
                              onEdit: () => TaskDialogs.showEditTaskDialog(
                                  context, tasksProvider, task),
                              onDelete: () =>
                                  tasksProvider.removeTask(task.uid),
                              onTap: () => TaskDialogs.showTaskDetailsDialog(
                                  context, task),
                            );
                          },
                        ),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
