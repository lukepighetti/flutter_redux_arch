import 'package:flutter/material.dart';
import 'package:redux_sandbox/state/actions.dart';
import 'package:redux_sandbox/state/app_state_connector.dart';
import 'package:redux_sandbox/state/models.dart';

class AddTodoDialog extends StatefulWidget {
  /// Show a dialog for adding a [Todo] item
  AddTodoDialog({
    Key key,
    this.initialText = '',
    this.popOnAdd = true,
  }) : super(key: key);

  /// The initial text to use for making this [Todo]
  final String initialText;

  /// If this dialog should disappear after adding the [Todo]
  final bool popOnAdd;

  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialText);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateConnector(
      builder: (context, store, state, dispatch) {
        /// Dispatch [CreateTodoAction], clear the controller, optionally
        /// pop the dialog
        void _handleAddTodo(String value) {
          dispatch(TodoAction.create(
            Todo(value, completed: false),
          ));

          controller.clear();
          if (widget.popOnAdd) Navigator.of(context).pop();
        }

        return AlertDialog(
          title: Text('Add todo'),
          content: TextField(
            controller: controller,
            autofocus: true,
            onSubmitted: (value) => _handleAddTodo(value),
          ),
          actions: [
            ElevatedButton(
              child: Text('Save'),
              onPressed: () => _handleAddTodo(controller.text),
            ),
          ],
        );
      },
    );
  }
}
