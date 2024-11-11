import 'package:examen2_eduardoflores/modules/login/domain/dto/credenciales_usuario.dart';
import 'package:examen2_eduardoflores/modules/login/useCase/usecase.dart';
import 'package:examen2_eduardoflores/rutas/routers.dart';
import 'package:examen2_eduardoflores/screens/pantalla_categorias.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class PantallaLogin extends StatelessWidget {
  PantallaLogin({super.key});

  final TextEditingController ControladorUsuario = TextEditingController();
  final TextEditingController ControladorContrasena = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Login')),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white ,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Container(
          height: 200,
          child: Image.asset('lib/assets/imagen.jpg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: TextField(
                controller: ControladorUsuario,
          decoration: InputDecoration(
            labelText: 'Usuario',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: TextField(
                controller: ControladorContrasena,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: SizedBox(
          child: ElevatedButton(
            onPressed: () async { //async porque estamos haciendo una peticion a la api

            //esta variable se podria definir en el usecase del login pero lo hice aqui porque asi esta el ejemplo del profe
                final LocalStorage localstorage = LocalStorage('localstorage');

                final credenciales = CredencialesUsuario(
                    user: ControladorUsuario.text,
                    password: ControladorContrasena.text
                  );
                //guardamos el token de acceso para verificar si exite en las demas pantallas
                LoginUseCase().execute(credenciales).then((response) {
                  localstorage.setItem("tokendeacceso", response.accessToken);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaCategorias()));
                });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white ,
              padding: EdgeInsets.symmetric(horizontal: 55, vertical: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'Ingresar',
              style: TextStyle(fontSize: 16),
            ),
          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}