import 'package:flutter/material.dart';
import 'package:taskit/models/task_model.dart';
import 'package:taskit/providers/tasks_provider.dart';

class TaskDialogs {
  static void _showTaskDialog(
    BuildContext context,
    String titleText,
    TaskModel? task,
    Function(TaskModel) actionCallback,
  ) {
    TextEditingController titleController =
        TextEditingController(text: task?.title ?? '');
    TextEditingController descriptionController =
        TextEditingController(text: task?.description ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600.0),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  titleText,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: descriptionController,
                  maxLines: null,
                  minLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close, color: Colors.red),
                    ),
                    const SizedBox(width: 8.0),
                    IconButton(
                      onPressed: () {
                        String title = titleController.text.trim();
                        String description = descriptionController.text.trim();
                        TaskModel updatedTask = TaskModel(
                          uid: task?.uid ??
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          title: title,
                          description: description,
                        );
                        actionCallback(updatedTask);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.check, color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showAddTaskDialog(
      BuildContext context, TasksProvider tasksProvider) {
    _showTaskDialog(
        context, 'Add Task', null, (newTask) => tasksProvider.addTask(newTask));
  }

  static void showEditTaskDialog(
      BuildContext context, TasksProvider tasksProvider, TaskModel task) {
    _showTaskDialog(context, 'Edit Task', task,
        (updatedTask) => tasksProvider.editTask(updatedTask));
  }

  static void showTaskDetailsDialog(BuildContext context, TaskModel task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600.0),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Description:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  task.description ?? "",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 32,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
