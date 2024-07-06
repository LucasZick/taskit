import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskit/models/task_model.dart';

class TasksProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseDatabase = FirebaseFirestore.instance;

  List<TaskModel>? _currentTasks;

  List<TaskModel>? get currentTasks => _currentTasks;

  TasksProvider() {
    _firebaseAuth.authStateChanges().listen(
      (user) async {
        if (user != null) {
          await updateTasks();
          notifyListeners();

          _firebaseDatabase
              .collection('users')
              .doc(user.uid)
              .snapshots()
              .listen(
            (snapshots) async {
              if (snapshots.exists) {
                await updateTasks();
                notifyListeners();
              }
            },
          );
        } else {
          _currentTasks = null;
          notifyListeners();
        }
      },
    );
  }

  updateTasks() async {
    User? authenticatedUser = _firebaseAuth.currentUser;
    if (authenticatedUser != null) {
      DocumentSnapshot<Map<String, dynamic>> userFromDatabase =
          await _firebaseDatabase
              .collection("users")
              .doc(authenticatedUser.uid)
              .get();

      List<TaskModel> tasks = [];
      List<dynamic> taskData = userFromDatabase.data()?["tasks"] ?? [];
      for (var task in taskData) {
        tasks.add(
          TaskModel(
            uid: task["uid"],
            title: task["title"] ?? '',
            description: task["description"] ?? '',
          ),
        );
      }

      _currentTasks = tasks;
    } else {
      _currentTasks = null;
    }
  }

  Future<void> addTask(TaskModel task) async {
    User? authenticatedUser = _firebaseAuth.currentUser;
    if (authenticatedUser != null) {
      try {
        // Adicionar a tarefa à lista no documento do usuário
        await _firebaseDatabase
            .collection('users')
            .doc(authenticatedUser.uid)
            .update({
          'tasks': FieldValue.arrayUnion([task.toMap()]),
        });

        // Atualizar a lista local de tarefas
        await updateTasks();
        notifyListeners();
      } catch (e) {
        print('Erro ao adicionar tarefa: $e');
      }
    }
  }

  Future<void> editTask(TaskModel updatedTask) async {
    User? authenticatedUser = _firebaseAuth.currentUser;
    if (authenticatedUser != null) {
      try {
        // Obter as tarefas atuais
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await _firebaseDatabase
                .collection('users')
                .doc(authenticatedUser.uid)
                .get();
        List<dynamic> tasks = userSnapshot.data()?["tasks"] ?? [];

        // Atualizar a tarefa na lista de tarefas
        List<Map<String, dynamic>> updatedTasks = tasks.map((task) {
          if (task["uid"] == updatedTask.uid) {
            return updatedTask.toMap();
          }
          return task as Map<String, dynamic>;
        }).toList();

        // Atualizar o documento do usuário com a lista de tarefas atualizada
        await _firebaseDatabase
            .collection('users')
            .doc(authenticatedUser.uid)
            .update({"tasks": updatedTasks});

        // Atualizar a lista local de tarefas
        await updateTasks();
        notifyListeners();
      } catch (e) {
        print('Erro ao editar tarefa: $e');
      }
    }
  }

  Future<void> removeTask(String taskUid) async {
    User? authenticatedUser = _firebaseAuth.currentUser;
    if (authenticatedUser != null) {
      try {
        // Obter as tarefas atuais
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await _firebaseDatabase
                .collection('users')
                .doc(authenticatedUser.uid)
                .get();
        List<dynamic> tasks = userSnapshot.data()?["tasks"] ?? [];

        // Remover a tarefa da lista de tarefas
        List<Map<String, dynamic>> updatedTasks = tasks
            .where((task) => task["uid"] != taskUid)
            .map((task) => task as Map<String, dynamic>)
            .toList();

        // Atualizar o documento do usuário com a lista de tarefas atualizada
        await _firebaseDatabase
            .collection('users')
            .doc(authenticatedUser.uid)
            .update({"tasks": updatedTasks});

        // Atualizar a lista local de tarefas
        await updateTasks();
        notifyListeners();
      } catch (e) {
        print('Erro ao remover tarefa: $e');
      }
    }
  }
}
