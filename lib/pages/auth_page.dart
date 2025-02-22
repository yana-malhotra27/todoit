import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoit/pages/todo_page.dart';
import '../providers/auth_provider.dart';

class AuthPage extends ConsumerWidget {
  AuthPage({Key? key}) : super(key: key);

  final TextEditingController apiKeyController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Authentication"),
        centerTitle: true,
        elevation: 4,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('lib/logo.png'),
            ),
            SizedBox(height: 5),
            TextField(
              obscureText: true,
              controller: apiKeyController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: "API Key",
                hintText: 'Enter your API Key',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Rounded edges
                      ),
                    ),
                    onPressed: () async {
                      ref.read(authStateProvider.notifier).state =
                          true; // Set loading state to true
                      await ref
                          .read(authServiceProvider)
                          .authenticate(ref, apiKeyController.text);
                      ref.read(authStateProvider.notifier).state =
                          false; // Set loading state to false
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => TodoPage()),
                      );
                    },
                    child: Text("Login"),
                  ),
          ],
        ),
      ),
    );
  }
}
