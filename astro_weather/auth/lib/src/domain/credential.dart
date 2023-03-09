
class Credential{
  final AuthType type;
  final String email;
  final String password;

  Credential({
    required this.type,
    required this.email,
    required this.password, 
    });
}

enum AuthType{email, google}