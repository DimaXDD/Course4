import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase/addCarPage.dart';
import 'package:firebase/authPage.dart';
import 'package:firebase/authorization.dart';
import 'package:firebase/car.dart';
import 'package:firebase/main.dart';
import 'package:firebase/registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();
}

Future<T> neverEndingFuture<T>() async {
  // ignore: literal_only_boolean_expressions
  while (true) {
    await Future.delayed(const Duration(minutes: 5));
  }
}

class MockTask extends Mock {
  void call();
}

void main() {
  setupFirebaseAuthMocks();
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('SignIn', () {
    testWidgets('should save form data', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignInPage()));

      final emailFieldFinder = find.byType(TextFormField).at(0);
      final passwordFieldFinder = find.byType(TextFormField).at(1);

      expect(emailFieldFinder, findsOneWidget);
      expect(passwordFieldFinder, findsOneWidget);

      await tester.enterText(emailFieldFinder, 'test@example.com');
      await tester.enterText(passwordFieldFinder, 'password');

      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('password'), findsOneWidget);

      expect(find.widgetWithText(TextButton, 'Регистрация'), findsOneWidget);
    });

    testWidgets('Products in ListView can be scrolled', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return ListTile(title: Text('Product $index'));
            },
          ),
        ),
      ));

      expect(find.text('Product 0'), findsOneWidget);

      await tester.drag(find.byType(ListView), Offset(0, -200));
      await tester.pumpAndSettle();

      expect(find.text('Product 0'), findsNothing);
    });

    testWidgets('Tap on "Регистрация" button navigates to RegisterPage', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: SignInPage(),
        routes: {
          '/register': (context) => RegistrationPage(),
        },
      ));

      final registerButtonFinder = find.widgetWithText(TextButton, 'Регистрация');

      expect(registerButtonFinder, findsOneWidget);

      await tester.tap(registerButtonFinder);
      await tester.pumpAndSettle();

      expect(find.byType(RegistrationPage), findsOneWidget);
    });

  });

  group('Unit', ()
  {
    test('toMap returns correct map', () {
      final car = Car('fdfdfd', 1970, 4);
      final expectedMap = {
        'brand': 'fdfdfd',
        'year': 1970,
        'numberOfDoors': 4,
      };
      expect(car.toMap(), equals(expectedMap));
    });

    test('toString returns correct string', () {
      final car = Car('fdfdfd', 1970, 4);
      expect(car.toString(),
          equals('Car(brand: fdfdfd, year: 1970, numberOfDoors: 4)'));
    });

    test('car prints correct message', () {
      final car = Car('fdfdfd', 1970, 4);
      expect(() => car.move(), prints('Car moved\n'));
    });

    test('printBrand prints correct brand', () {
      final car = Car('fdfdfd', 1970, 4);
      expect(() => car.printBrand(brand: 'volvo'), prints('Марка: volvo\n'));
    });

    test('takeBreak prints correct brand', () {
      final car = Car('fdfdfd', 1970, 4);
      expect(() => car.printCar('volvo', 1970),
          prints("Марка: volvo; Год: 1970\n"));
    });
  });
}