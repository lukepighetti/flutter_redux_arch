import 'package:flutter/material.dart';
import 'package:redux_sandbox/screens/add_todo_dialog.dart';
import 'package:redux_sandbox/service/toast_service.dart';
import 'package:redux_sandbox/service/todo_api.dart';
import 'package:redux_sandbox/state/actions.dart';
import 'package:redux_sandbox/state/app_state_connector.dart';
import 'package:redux_sandbox/state/selectors.dart';
import 'package:redux_sandbox/state/thunks.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final services = TodoThunkServices(
    toastService: ToastService(),
    todoApi: TodoApi(),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppStateConnector(
      builder: (context, store, state, dispatch) {
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
            actions: [
              PopupMenuButton<VoidCallback>(
                icon: Icon(Icons.add),
                onSelected: (callback) => callback(),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: () => dispatch(fetchAdventurousTodos(services)),
                      child: Text('Fetch adventurous todos'),
                    ),
                    PopupMenuItem(
                      value: () => dispatch(fetchRiskyTodos(services)),
                      child: Text('Fetch risky todos'),
                    ),
                  ];
                },
              )
            ],
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
                    'Nothing to do',
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
                            dispatch(TodoAction.update(
                              todo,
                              todo.copyWith(completed: !value),
                            ));
                          },
                        ),
                        onLongPress: () {
                          dispatch(TodoAction.delete(todo));
                        },
                        onTap: () {
                          dispatch(TodoAction.toggle(todo));
                        },
                      ),
                    if (state.fetchingTodos == true)
                      Center(child: CircularProgressIndicator())
                  ],
                );
            },
          ),
        );
      },
    );
  }
}
