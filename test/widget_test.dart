import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'mocks.dart';

void main() {
  testWidgets('login with valid credentials', (WidgetTester tester) async {
    // Créez un mock pour votre service d'authentification
    final authService = MockAuthService();

    // Configurez le mock pour renvoyer true lorsque la méthode login est appelée avec des identifiants valides
    when(authService.login('valid_username', 'valid_password'))
        .thenAnswer((_) => Future.value(true));

    // Exécutez votre application avec le mock
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(authService: authService),
    ));

    // Remplissez le formulaire de connexion avec des identifiants valides
    await tester.enterText(find.byKey(Key('usernameField')), 'valid_username');
    await tester.enterText(find.byKey(Key('passwordField')), 'valid_password');

    // Appuyez sur le bouton de connexion
    await tester.tap(find.byKey(Key('loginButton')));
    await tester.pump();

    // Vérifiez que la méthode login a été appelée avec les identifiants valides
    verify(authService.login('valid_username', 'valid_password')).called(1);
  });
}
