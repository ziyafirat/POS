import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/assistant_controller.dart';

class AssistantView extends GetView<AssistantController> {
  const AssistantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistant Mode'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: controller.clearHistory,
            tooltip: 'Clear History',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Connection Status',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Obx(() => Text(controller.connectionStatus)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Test Actions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 2,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: controller.testActions.length,
                itemBuilder: (context, index) {
                  final action = controller.testActions[index];
                  return Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.executeTestAction(
                              action['name']!,
                              action['action']!,
                            ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade600,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      action['name']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ));
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Last Response',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Obx(() => Text(
                      controller.lastResponse.value.isEmpty
                          ? 'No actions executed yet'
                          : controller.lastResponse.value,
                      style: TextStyle(
                        color: controller.lastResponse.value.startsWith('Error')
                            ? Colors.red
                            : Colors.green.shade700,
                      ),
                    )),
                    const SizedBox(height: 8),
                    Obx(() => controller.isLoading.value
                        ? const LinearProgressIndicator()
                        : const SizedBox.shrink()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Action History',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() => controller.actionHistory.isEmpty
                  ? const Center(
                      child: Text(
                        'No actions in history',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.actionHistory.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            dense: true,
                            title: Text(
                              controller.actionHistory[index],
                              style: const TextStyle(fontSize: 12),
                            ),
                            leading: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.teal.shade100,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        );
                      },
                    )),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.goToStart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Go to Start'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.goToItemScan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Go to Scan'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
