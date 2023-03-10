import 'package:async/async.dart';
import 'package:auth/src/domain/credential.dart';
import '../../domain/auth_service_contract.dart';
import '../../domain/signup_service_contract.dart';
import '../../domain/token.dart';
import '../../infra/api/auth_api_contact.dart';

class EmailAuth implements IAuthService, ISignUpService{

  final IAuthApi _api;
  Credential _credential;
  EmailAuth(this._api);

  @override
  Future<Result<Token>> signIn() async{
    assert(_credential != null);
    var result = await _api.signIn(_credential);
    if(result.isError) return result.asError;
    return Result.value(Token(result.asValue.value));
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Result<Token>> signUp(String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

}