import 'dart:io';

import 'package:flutter_challenge/domain/entity/user.dart';
import 'package:flutter_challenge/domain/errors/incorrect_username_or_password_error.dart';
import 'package:flutter_challenge/domain/storage/user_storage.dart';
import 'package:flutter_challenge/domain/use_case/sign_in_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks.mocks.dart';

void main() {
  late UserStorage userStorage;
  late SignInUseCase useCase;

  const email = "some@email";
  const username = "some_username";
  const password = "some_very_strong_password";
  const incorrectPassword = "some_incorrect_password";

  const result = User(email: email, username: username, password: password);

  setUp(() {
    userStorage = MockUserStorage();
    useCase = SignInUseCase(userStorage);
    when(userStorage.getUser(username: username)).thenAnswer((_) async => result);
    when(userStorage.loginUser(result)).thenAnswer((_) async {});
  });

  test("should sign in", () async {
    final user = await useCase.execute(const SignInParams(username: username, password: password));
    expect(user, result);
    verify(userStorage.getUser(username: username)).called(1);
    verify(userStorage.loginUser(user)).called(1);
    verifyNoMoreInteractions(userStorage);
  });

  test("should throw IncorrectUsernameOrPasswordError if no user with given username", () async {
    when(userStorage.getUser(username: username)).thenAnswer((_) async => null);
    await expectLater(
      useCase.execute(const SignInParams(username: username, password: password)),
      throwsA(isA<IncorrectUsernameOrPasswordError>()),
    );
    verify(userStorage.getUser(username: username)).called(1);
    verifyNoMoreInteractions(userStorage);
  });

  test("should throw IncorrectUsernameOrPasswordError if password is incorrect", () async {
    await expectLater(
      useCase.execute(const SignInParams(username: username, password: incorrectPassword)),
      throwsA(isA<IncorrectUsernameOrPasswordError>()),
    );
    verify(userStorage.getUser(username: username)).called(1);
    verifyNoMoreInteractions(userStorage);
  });

  test("should not suppress getUser errors", () async {
    when(userStorage.getUser(username: username)).thenAnswer((_) async => throw const FileSystemException());
    await expectLater(
      useCase.execute(const SignInParams(username: username, password: password)),
      throwsA(isA<FileSystemException>()),
    );
    verify(userStorage.getUser(username: username)).called(1);
    verifyNoMoreInteractions(userStorage);
  });

  test("should not suppress loginUser errors", () async {
    when(userStorage.loginUser(result)).thenAnswer((_) async => throw const FileSystemException());
    await expectLater(
      useCase.execute(const SignInParams(username: username, password: password)),
      throwsA(isA<FileSystemException>()),
    );
    verify(userStorage.getUser(username: username)).called(1);
    verify(userStorage.loginUser(result)).called(1);
    verifyNoMoreInteractions(userStorage);
  });

  test("should throw ArgumentError if params are null", () async {
    await expectLater(useCase.execute(null), throwsArgumentError);
    verifyZeroInteractions(userStorage);
  });
}
