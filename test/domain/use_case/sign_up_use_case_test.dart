import 'dart:io';

import 'package:flutter_challenge/domain/entity/user.dart';
import 'package:flutter_challenge/domain/errors/user_already_exists_error.dart';
import 'package:flutter_challenge/domain/errors/username_already_taken_error.dart';
import 'package:flutter_challenge/domain/storage/user_storage.dart';
import 'package:flutter_challenge/domain/use_case/sign_up_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks.mocks.dart';

void main() {
  late UserStorage userStorage;
  late SignUpUseCase useCase;

  const email = "some@email";
  const username = "some_username";
  const password = "some_very_strong_password";

  const result = User(email: email, username: username, password: password);

  setUp(() {
    userStorage = MockUserStorage();
    useCase = SignUpUseCase(userStorage);

    when(userStorage.isEmailTaken(email: email)).thenAnswer((_) async => false);
    when(userStorage.isUsernameTaken(username: username)).thenAnswer((_) async => false);
    when(userStorage.storeUser(email: email, username: username, password: password)).thenAnswer((_) async => result);
    when(userStorage.loginUser(result)).thenAnswer((_) async {});
  });

  test("should store user", () async {
    final user = await useCase.execute(const SignUpParams(email: email, username: username, password: password));
    expect(user, result);
    verify(userStorage.isEmailTaken(email: email)).called(1);
    verify(userStorage.isUsernameTaken(username: username)).called(1);
    verify(userStorage.storeUser(email: email, username: username, password: password)).called(1);
    verify(userStorage.loginUser(result)).called(1);
    verifyNoMoreInteractions(userStorage);
  });

  test("should throw UserAlreadyExistsError if user with same email exists", () async {
    when(userStorage.isEmailTaken(email: email)).thenAnswer((_) async => true);
    await expectLater(
      useCase.execute(const SignUpParams(email: email, username: username, password: password)),
      throwsA(isA<UserAlreadyExistsError>()),
    );
    verify(userStorage.isEmailTaken(email: email)).called(1);
    verifyNoMoreInteractions(userStorage);
  });

  test("should throw UsernameAlreadyTakenError if user with same username exists", () async {
    when(userStorage.isUsernameTaken(username: username)).thenAnswer((_) async => true);
    await expectLater(
      useCase.execute(const SignUpParams(email: email, username: username, password: password)),
      throwsA(isA<UsernameAlreadyTakenError>()),
    );
    verify(userStorage.isEmailTaken(email: email)).called(1);
    verify(userStorage.isUsernameTaken(username: username)).called(1);
    verifyNoMoreInteractions(userStorage);
  });

  test("should not suppress email check errors", () async {
    when(userStorage.isEmailTaken(email: email)).thenAnswer((_) async => throw const FileSystemException());
    await expectLater(
      useCase.execute(const SignUpParams(email: email, username: username, password: password)),
      throwsA(isA<FileSystemException>()),
    );
    verify(userStorage.isEmailTaken(email: email)).called(1);
    verifyNoMoreInteractions(userStorage);
  });

  test("should not suppress username check errors", () async {
    when(userStorage.isUsernameTaken(username: username)).thenAnswer((_) async => throw const FileSystemException());
    await expectLater(
      useCase.execute(const SignUpParams(email: email, username: username, password: password)),
      throwsA(isA<FileSystemException>()),
    );
    verify(userStorage.isEmailTaken(email: email)).called(1);
    verify(userStorage.isUsernameTaken(username: username)).called(1);
    verifyNoMoreInteractions(userStorage);
  });

  test("should not suppress user saving errors", () async {
    when(userStorage.storeUser(email: email, username: username, password: password))
        .thenAnswer((_) async => throw const FileSystemException());
    await expectLater(
      useCase.execute(const SignUpParams(email: email, username: username, password: password)),
      throwsA(isA<FileSystemException>()),
    );
    verify(userStorage.isEmailTaken(email: email)).called(1);
    verify(userStorage.isUsernameTaken(username: username)).called(1);
    verify(userStorage.storeUser(email: email, username: username, password: password)).called(1);
    verifyNoMoreInteractions(userStorage);
  });

  test("should not suppress loginUser errors", () async {
    when(userStorage.loginUser(result)).thenAnswer((_) async => throw const FileSystemException());
    await expectLater(
      useCase.execute(const SignUpParams(email: email, username: username, password: password)),
      throwsA(isA<FileSystemException>()),
    );
    verify(userStorage.isEmailTaken(email: email)).called(1);
    verify(userStorage.isUsernameTaken(username: username)).called(1);
    verify(userStorage.storeUser(email: email, username: username, password: password)).called(1);
    verify(userStorage.loginUser(result)).called(1);
    verifyNoMoreInteractions(userStorage);
  });

  test("should throw ArgumentError if params are null", () async {
    await expectLater(useCase.execute(null), throwsArgumentError);
    verifyZeroInteractions(userStorage);
  });
}
