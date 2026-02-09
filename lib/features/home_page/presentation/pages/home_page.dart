import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_practise/features/auth/presentation/pages/login_screen.dart';
import 'package:river_pod_practise/features/auth/presentation/riverpod/auth_state.dart';
// import 'package:river_pod_practise/features/auth/presentation/pages/auth_page.dart';
// import 'package:river_pod_practise/features/auth/presentation/riverpod/auth_provider.dart';
import 'package:river_pod_practise/features/home_page/presentation/riverpod/riverpod.dart';
import 'package:river_pod_practise/features/home_page/presentation/widgets/floating_action_button.dart';
import 'package:river_pod_practise/features/task/presentation/pages/task_list_screen.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final usersAsync = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("RiverPod Practise"),
        actions: [
          IconButton(
            // onPressed: () => ref.read(authControllerProvider.notifier).logout(),
            onPressed: () async {
              ref.read(authControllerProvider.notifier).logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskListScreen(),
                          ),
                        );
                      },
                      child: Text("Phase 2 - REST API + Pagination"),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Phase 3 - Forms & Validation"),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Phase 4 - Offline First Cache"),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Phase 5 — Realtime WebSocket"),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Phase 6 — Optimistic Updates"),
                    ),
                    // SizedBox(width: 20),
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   child: Text("Dependency injection"),
                    // ),
                  ],
                ),
              ),
              const Text(
                'counter',
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                ref.watch(initialNumber).toString(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  Text("easy", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButtonCustom(
                        widget: Text("add"),
                        function: () {
                          ref.read(initialNumber.notifier).state++;
                        },
                        tooltip: "IncrementCounter",
                        icon: const Icon(Icons.add),
                      ),
                      SizedBox(width: 30),
                      FloatingActionButtonCustom(
                        widget: Text("minus"),
                        function: () {
                          ref.read(initialNumber.notifier).state--;
                        },
                        tooltip: "DecrementCounter",
                        icon: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  Text(
                    ref.watch(riverpodHard).counter.toString(),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text("hard", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButtonCustom(
                        widget: Text("add"),
                        function: () {
                          ref.read(riverpodHard).addCounter();
                        },
                        tooltip: "IncrementCounter",
                        icon: const Icon(Icons.add),
                      ),
                      SizedBox(width: 30),
                      FloatingActionButtonCustom(
                        widget: Text("minus"),
                        function: () {
                          ref.read(riverpodHard).removeCounter();
                        },
                        tooltip: "DecrementCounter",
                        icon: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  usersAsync.when(
                    data: (users) => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];

                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(user.id.toString()),
                          ),
                          title: Text(user.name),
                          subtitle: Text(user.email),
                        );
                      },
                    ),
                    error: (e, _) => Text("Error : $e"),
                    loading: () => const CircularProgressIndicator(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
