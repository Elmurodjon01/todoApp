import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.onEdit,
    required this.onChoose,
    required this.onDelete,
    required this.todo,
    required this.dateTime,
    required this.priviousTodoStatus,
    required this.onTap,
    // required this.newTodoStatus,
  });

  final VoidCallback onEdit;
  final Function(bool?) onChoose;
  final VoidCallback onDelete;
  final String todo;
  final String dateTime;
  final bool priviousTodoStatus;
  final Function()? onTap;
  //final String newTodoStatus;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 85,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color(0xFFD5D5D5),
          ),
          color:
              priviousTodoStatus ? const Color(0xFF9FFFB8) : Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MSHCheckbox(
              colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                checkedColor: Colors.green,
              ),
              value: priviousTodoStatus,
              onChanged: onChoose,
              style: MSHCheckboxStyle.fillScaleColor,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  todo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                Text(
                  dateTime,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
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
