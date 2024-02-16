import 'package:flutter/material.dart';
import 'package:todonow_lite/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({
    Key? key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFcaf0f8),
      content: SizedBox(
        height: 200, // Adjust height as needed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                maxLines: null, // Allows the TextField to expand vertically
                expands: true, // Allows the TextField to expand vertically
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add a new task here',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: 'cancel', onPressed: onCancel),
                const SizedBox(
                  width: 8,
                ),
                MyButton(text: 'save', onPressed: onSave),
              ],
            )
          ],
        ),
      ),
    );
  }
}
