import 'package:async/async.dart';
import '../domain/token.dart';


abstract class IAuthService{
  Future<Result<Token>> signIn();
  Future<void> signOut();
}