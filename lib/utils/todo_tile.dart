import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  const ToDoTile({
    Key? key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.red.shade300,
            borderRadius: BorderRadius.circular(15),
          )
        ]),
        child: Container(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          decoration: BoxDecoration(
            color: Color(0xFF90e0ef),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              // Checkbox and Text wrapped in a Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Checkbox
                  Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    activeColor: Colors.black,
                  ),
                  SizedBox(width: 10), // Spacer between Checkbox and Text
                ],
              ),
              // Task name wrapped inside Flexible
              Flexible(
                child: Text(
                  taskName,
                  style: TextStyle(
                    fontFamily: GoogleFonts.pacifico().fontFamily,
                    fontSize: 20,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
