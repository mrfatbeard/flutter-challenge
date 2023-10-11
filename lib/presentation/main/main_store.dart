import 'package:flutter_challenge/domain/entity/user.dart';
import 'package:flutter_challenge/domain/use_case/get_current_user_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'main_store.g.dart';

@injectable
class MainStore = MainStoreBase with _$MainStore;

abstract class MainStoreBase with Store {
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  MainStoreBase(this._getCurrentUserUseCase);

  @observable
  User? currentUser;

  @action
  Future<void> checkLogin() async {
    currentUser = await _getCurrentUserUseCase.execute(null);
  }
}
