import 'package:flutter/material.dart';
import 'package:taskit/models/task_model.dart';

class TaskListTile extends StatefulWidget {
  final TaskModel task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const TaskListTile({
    required this.task,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  @override
  _TaskListTileState createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Dismissible(
              key: Key(widget.task.uid),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                widget.onDelete();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.task.title} finished'),
                  ),
                );
              },
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                color: Colors.green,
                child: const Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              ),
              child: MouseRegion(
                onEnter: (_) => setState(() => isHovered = true),
                onExit: (_) => setState(() => isHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: isHovered
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.inversePrimary,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isHovered ? 20 : 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      child: Text(widget.task.title),
                    ),
                    subtitle: isHovered
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.task.description ?? "",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        : null,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: widget.onEdit,
                          color: isHovered ? Colors.amber : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: widget.onDelete,
                          color: isHovered ? Colors.red : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
