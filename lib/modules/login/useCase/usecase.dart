
import 'package:examen2_eduardoflores/infrastructure/app/useCase/use_case.dart';
import 'package:examen2_eduardoflores/modules/login/domain/dto/credenciales_usuario.dart';
import 'package:examen2_eduardoflores/modules/login/domain/dto/respuesta_login.dart';

import '../domain/repository/login_repository.dart';

//esto tambien fue copiado del codigo que paso el profe
class LoginUseCase implements UseCase<dynamic, CredencialesUsuario> {
  @override
  Future<dynamic> execute(CredencialesUsuario params) async {
    try {
      final CredencialesUsuario credenciales = CredencialesUsuario(
        user: params.user,
        password: params.password,
      );
      print(credenciales.user);
      final RespuestaLoginUsuario response = await LoginRepository().execute(credenciales);
      return response;
    } catch (e) {
      return Future.error(e);  
    }
  }
}