// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:alfaid/main.dart';

void main() {
  testWidgets('Login screen loads correctly', (WidgetTester tester) async {
    // Build the MyApp widget, que agora carrega a LoginScreen.
    await tester.pumpWidget(const MyApp());

    // Verifica se os componentes da tela de login estão presentes.
    expect(find.text('Usuário (CPF)'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('Selecione o Centro de Custo'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
