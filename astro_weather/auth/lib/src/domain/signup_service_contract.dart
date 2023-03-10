import 'package:async/async.dart';
import '../domain/token.dart';

abstract class ISignUpService{
  Future<Result<Token>> signUp(
    String email,
    String password,
  );
}