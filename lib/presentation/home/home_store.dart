import 'package:flutter_challenge/domain/entity/user.dart';
import 'package:flutter_challenge/domain/use_case/logout_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

@injectable
class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final LogoutUseCase _logoutUseCase;

  HomeStoreBase(this._logoutUseCase);

  @observable
  User? currentUser;

  @action
  Future<void> logout() async {
    await _logoutUseCase.execute(null);
    currentUser = null;
  }
}
