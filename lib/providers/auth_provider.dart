import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StateProvider<bool>((ref) => false);
final apiKeyProvider = StateProvider<String?>((ref) => null); // Define the API key provider

class AuthService {
  Future<void> authenticate(WidgetRef ref, String apiKey) async {
    // Implement your authentication logic here
    // For example, you might want to make an API call to validate the API key
    // If authentication is successful, set the API key
    // Simulating an API call with a delay
    await Future.delayed(Duration(seconds: 1));

    // Assuming the API key is valid, set it in the provider
    ref.read(apiKeyProvider.notifier).state = apiKey; // Correct way to set the state
  }
  // This method simulates logging out the user
  Future<void> logout() async {
    // Implement your logout logic here
    // For example, clear user data, tokens, etc.
    // This is just a placeholder for demonstration purposes
    print("User  logged out");
    // You might want to clear any stored tokens or user data here
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});