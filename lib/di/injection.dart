import 'package:flutter_challenge/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(preferRelativeImports: false)
Future<void> configureDependencies() async {
  GetIt.I.init();
}
