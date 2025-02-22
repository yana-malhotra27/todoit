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
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});