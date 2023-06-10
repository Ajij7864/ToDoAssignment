import '../imports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'authentication_provider.dart';
part 'todoprovider.dart';
part 'riverpod_provider.dart';

final todoProvider =
    AsyncNotifierProvider<TodoModelProvider, Map<String, ToDoModel>>(
  () => TodoModelProvider(),
);
//TODO use consumer widget or consumer buider based on your requirement for accessing ref variable
//TODO use ref.read(todoProvider) to read data
//TODO use ref.watch(todoProvider) to listen all data changes
//TODO use ref.watch(todoProvider.select((e)=>e.isChecked)) to listen isChecked change only
//TODO use ref.read(todoProvider.select((e)=>e.id)) to read id only
//TODO use ref.read(todoProvider.notifier).removeTodo("id") to call todoProvider methods