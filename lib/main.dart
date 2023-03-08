import 'package:flutter/material.dart';
import 'package:gymnesia/cardioExercise.dart';
import 'package:gymnesia/exercise.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const MyHomePage(title: 'Current Workout'),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {

  bool isWorkingOut = false;
  List<Exercise> currentWorkout = <Exercise>[];

  void startWorkout() {
    isWorkingOut = true;
    currentWorkout = <Exercise>[
    CardioExercise("Treadmill", const Icon(Icons.directions_run)),
    CardioExercise("Elliptical", const Icon(Icons.directions_run)),
    ];
    notifyListeners();
  }

  void endWorkout() {
    isWorkingOut = false;
    notifyListeners();
  }

  void addExercise() {
    currentWorkout.insert(0, CardioExercise("name", const Icon(Icons.directions_run)));
    notifyListeners();
  }

  void removeExercise(id) {
    currentWorkout.removeAt(id);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 1;
  var destinations = [
    const NavigationDestination(icon: Icon(Icons.show_chart), label: "Logs"),
    const NavigationDestination(icon: Icon(Icons.home), label: "Workout"),
    const NavigationDestination(
        icon: Icon(Icons.fitness_center), label: "Exercise Library"),
  ];

  @override
  Widget build(BuildContext context) {
    Widget currentPage;

    switch (currentPageIndex) {
      case 0:
        currentPage = const LogsPage();
        break;
      case 1:
        currentPage = const CurrentWorkoutPage();
        break;
      case 2:
        currentPage = const LibraryPage();
        break;
      default:
        throw UnimplementedError("No widget for $currentPageIndex");
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Container(
          color: Theme
              .of(context)
              .colorScheme
              .background,
          child: currentPage,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentPageIndex,
          destinations: destinations,
          onDestinationSelected: (int newIndex) {
            setState(() {
              currentPageIndex = newIndex;
            });
          },
        ),
      );
    });
  }
}

class CurrentWorkoutPage extends StatelessWidget {
  const CurrentWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var appTheme = Theme.of(context);
    var textStyle = appTheme.textTheme.bodyLarge!.copyWith(
        color: appTheme.colorScheme.onBackground
    );

    if (appState.isWorkingOut) {
      return Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                for (var exercise in appState.currentWorkout)
                  ListTile(
                    leading: exercise.icon,
                    title: Text(exercise.name, style: textStyle,),
                    trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => {appState.removeExercise(appState.currentWorkout.indexOf(exercise))},),
                    selectedColor: Colors.blue,
                  ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: appState.endWorkout, child: const Text("End Workout")),
                    // BigIconButton(const Icon(Icons.done), appState.endWorkout ),
                    const SizedBox(width: 20,),
                    ElevatedButton(onPressed: appState.addExercise, child: const Text("Add Exercise")),
                    // BigIconButton(const Icon(Icons.add), appState.addExercise),
                  ],
                ),
              ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(onPressed: appState.startWorkout, child: const Text("Start Workout"),),
          )
        ],
      );
    }


  }
}

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError("Build logs page");
  }
}

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError("Build library page");
  }
}

class BigIconButton extends StatelessWidget {

  final Icon icon;
  final Function action;

  const BigIconButton(this.icon, this.action, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {action()},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          // set button corner radius
          side: BorderSide(color: Theme.of(context).colorScheme
              .primary), // set button border
        ),
        minimumSize: const Size(120, 120), // set button size
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
      ),
      child: icon,
    );
  }


}
