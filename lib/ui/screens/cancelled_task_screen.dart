import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/cancelled_task_controller.dart';
import 'package:taskmanager/ui/widgets/build_summery_section.dart';
import 'package:taskmanager/ui/widgets/center_circular_progress.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final CancelledTaskController _cancelledTaskController =
      Get.find<CancelledTaskController>();

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getCancelledTaskList();
        },
        child: Column(
          children: [
            BuildSummerySection(),
            Expanded(
              child: GetBuilder<CancelledTaskController>(builder: (controller) {
                return Visibility(
                  visible: !controller.inprogress,
                  replacement: const CenterCircularProgress(),
                  child: ListView.separated(
                      itemCount: controller.taskList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskModel: controller.taskList[index],
                          onRefreshList: () {
                            _getCancelledTaskList;
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8,
                        );
                      }),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getCancelledTaskList() async {
    final bool result = await _cancelledTaskController.getCancelledTaskList();
    if (result == false) {
      showSnackBarMessage(
          context, _cancelledTaskController.errorMessage!, true);
    }
  }
}
