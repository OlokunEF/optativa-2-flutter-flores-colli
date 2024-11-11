import 'package:examen2_eduardoflores/infrastructure/app/repository/repository.dart';
import 'package:examen2_eduardoflores/modules/login/domain/dto/credenciales_usuario.dart';
import 'package:examen2_eduardoflores/modules/login/domain/dto/respuesta_login.dart';
import '../../../../../infrastructure/connection/connection.dart';


//Esto fue copiado del codigo que paso el profe
class LoginRepository
    implements Repository<RespuestaLoginUsuario, CredencialesUsuario> {
  @override
  Future<RespuestaLoginUsuario> execute(CredencialesUsuario params) async {
    final data = {
      "username": params.user,
      "password": params.password,
      "expiresInMins": 30,
    };
    String url = "https://dummyjson.com/auth/login";
    Connection connection = Connection();
    final response = await connection.post(url, data, headers: {
      'Content-Type': 'application/json',
    });
    
    return RespuestaLoginUsuario.fromJson(response);
  }
}
