
abstract class TodoStates{}

class TodoInitialState extends TodoStates{}

class TodoChangeTabBarState extends TodoStates{}

class TodoChangeFavoriteTaskState extends TodoStates{}

class TodoChangeColorTaskState extends TodoStates{}

class TodoDatabaseCreatedState extends TodoStates{}

class TodoDatabaseTableCreatedState extends TodoStates{}

class TodoDatabaseOpenedState extends TodoStates{}

class TodoDatabaseInsertedState extends TodoStates{}

class TodoGetDataFromDatabaseState extends TodoStates{}

class ShowTasksOfDayState extends TodoStates{}

class TodoDeleteDatabaseState extends TodoStates{}

class TodoUpdateDatabaseState extends TodoStates{}

class ChangeFavoriteTaskState extends TodoStates{}

class ChangeCompletedTaskState extends TodoStates{}

class SearchingState extends TodoStates{}

class EditTaskState extends TodoStates{}
