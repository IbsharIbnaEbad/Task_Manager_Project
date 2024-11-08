import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/utils/app_colors.dart';
import 'package:taskmanager/ui/utils/assets_path.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.onRefreshList,
  });

  final TaskModel taskModel;
  final VoidCallback onRefreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String _selectedTaskStatus = '';
  bool _changeStatusInProgress = false;
  bool _deleteTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    _selectedTaskStatus = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.blueAccent.withOpacity(.5),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title ?? '',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              widget.taskModel.description ?? '',
            ),
            Text(
              'Date - ${widget.taskModel.createdDate ?? ''}',
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTaskStatusChip(),
                Wrap(
                  children: [
                    Visibility(
                      visible: _changeStatusInProgress == false,
                      replacement: const CircularProgressIndicator(),
                      child: IconButton(
                        onPressed: _onTapEditButton,
                        icon: _buildLottieIcon(Assetspath.editIcon),
                      ),
                    ),
                    Visibility(
                      visible: !_deleteTaskInProgress,
                      replacement: const CircularProgressIndicator(),
                      child: IconButton(
                        onPressed: _onTapDeleteButton,
                        icon: _buildLottieIcon(Assetspath.deleteIcon),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLottieIcon(String assetPath) {
    return Lottie.asset(
      assetPath,
      width: 40,
      height: 40,
    );
  }

  void _onTapEditButton() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['New', 'Completed', 'Cencelled', 'Progress'].map((e) {
              return ListTile(
                onTap: () {
                  _changeStatus(e);
                  Navigator.pop(context);
                },
                title: Text(e),
                selected: _selectedTaskStatus == e,
                trailing:
                    _selectedTaskStatus == e ? const Icon(Icons.check) : null,
              );
            }).toList(),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cencel')),
          ],
        );
      },
    );
  }

  Future<void> _onTapDeleteButton() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you  want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                _deleteTaskInProgress = true;
                setState(() {});

                final NetworkResponse response = await NetworkCaller.getRequest(
                  url: Urls.deleteTask(widget.taskModel.sId!),
                );

                if (response.isSuccess) {
                  widget.onRefreshList();
                } else {
                  _deleteTaskInProgress = false;
                  setState(() {});
                  showSnackBarMessage(
                    context,
                    response.errorMessage,
                  );
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  // Future<void> _onTapDeleteButton() async {
  //   _changeStatusInProgress = true;
  //   setState(() {});
  //   final NetworkResponse response = await NetworkCaller.getRequest(
  //       url: Urls.deleteTask(widget.taskModel.sId!));
  //   if (response.isSuccess) {
  //     widget.onRefreshList();
  //     _changeStatusInProgress = false;
  //     setState(() {});
  //   } else {
  //     _changeStatusInProgress = false;
  //     setState(() {});
  //     showSnackBarMessage(context, response.errorMessage);
  //   }
  // }

  Widget _buildTaskStatusChip() {
    return Chip(
      label: Text(
        widget.taskModel.status!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          width: 2,
          color: Colors.cyan,
        ),
      ),
    );
  }

  Future<void> _changeStatus(String newStatus) async {
    _changeStatusInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.changeStatus(widget.taskModel.sId!, newStatus));
    if (response.isSuccess) {
      widget.onRefreshList();
      _changeStatusInProgress = false;
      setState(() {});
    } else {
      _changeStatusInProgress = false;
      setState(() {});
      showSnackBarMessage(context, response.errorMessage);
    }
  }
}
