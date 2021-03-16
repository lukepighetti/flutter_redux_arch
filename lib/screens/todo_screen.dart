import 'package:flutter/material.dart';
import 'package:redux_sandbox/screens/add_todo_dialog.dart';
import 'package:redux_sandbox/state/actions.dart';
import 'package:redux_sandbox/state/app_state_connector.dart';
import 'package:redux_sandbox/state/selectors.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppStateConnector(
      builder: (context, state, dispatch) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Todos',
                ),
                Text(
                  completeTodosCountSelector(state) == 0
                      ? 'All done!'
                      : '${completeTodosCountSelector(state)}/${totalTodosCountSelector(state)} remaining',
                  style: theme.textTheme.caption.copyWith(
                    color: Colors.white70,
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AddTodoDialog();
                },
              );
            },
          ),
          body: Builder(
            builder: (context) {
              if (state.todos.isEmpty)
                return Center(
                  child: Text(
                    'Nothing left to do',
                    style: theme.textTheme.headline5,
                  ),
                );
              else
                return ListView(
                  children: [
                    for (var todo in state.todos)
                      ListTile(
                        title: Text(todo.task),
                        trailing: Checkbox(
                          value: !todo.completed,
                          onChanged: (value) {
                            dispatch(UpdateTodoAction(
                              todo,
                              (e) => e.copyWith(completed: !value),
                            ));
                          },
                        ),
                        onLongPress: () {
                          dispatch(DeleteTodoAction(todo));
                        },
                        onTap: () {
                          dispatch(ToggleTodoAction(todo));
                        },
                      ),
                  ],
                );
            },
          ),
        );
      },
    );
  }
}
