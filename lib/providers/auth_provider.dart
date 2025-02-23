import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StateProvider<bool>((ref) => false);
final apiKeyProvider =
    StateProvider<String?>((ref) => null); // Define the API key provider

class AuthService {
  Future<void> authenticate(WidgetRef ref, String apiKey) async {
    await Future.delayed(Duration(seconds: 1));

    // Assuming the API key is valid, set it in the provider
    ref.read(apiKeyProvider.notifier).state = apiKey;
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
