import 'package:flutter/material.dart';

void main() => runApp(const SingUpScreen());

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isVisibleObscure = false;

  void _submittedForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("¡Formulario enviado exitosamente!"),
        ),
      );
    }
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return "Ingresa tu nombre";
    } else if (RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
      return "Por favor ingresa un nombre válido sin números o caracteres especiales";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Por favor ingresa tu correo electrónico";
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value)) {
      return "Por favor ingresa un correo electrónico válido";
    }
    return null;
  }

  String? validatePassword(String? value, String? text) {
    if (value!.isEmpty) {
      return "Ingresa tu contraseña";
    } else if (value.length < 6) {
      return "La contraseña debe tener al menos 6 caracteres";
    } else if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value)) {
      return "La contraseña solo puede contener letras y números";
    }
    return null;
  }

  String? confirmValidatePassword(String? value, String? text) {
    if (value!.isEmpty) {
      return "Por favor confirma tu contraseña";
    } else if (value != text) {
      return "Las contraseñas no coinciden";
    }
    return validatePassword(value, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Image(
                    image: AssetImage("assets/images/jm.png"), height: 200),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Crear \n Nueva cuenta",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2954a4),
                            height: 1),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) => validateName(value),
                        controller: _nameController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person), hintText: "Nombre"),
                      ),
                      TextFormField(
                        validator: (value) => validateEmail(value),
                        controller: _emailController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: "Correo electronico"),
                      ),
                      TextFormField(
                        validator: (value) =>
                            validatePassword(value, _passwordController.text),
                        controller: _passwordController,
                        autocorrect: false,
                        enableSuggestions: false,
                        obscureText: isVisibleObscure,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisibleObscure = !isVisibleObscure;
                                  });
                                },
                                icon: isVisibleObscure
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            prefixIcon: Icon(Icons.password),
                            hintText: "Contraseña"),
                      ),
                      TextFormField(
                        autocorrect: false,
                        enableSuggestions: false,
                        obscureText: isVisibleObscure,
                        validator: (value) => confirmValidatePassword(
                            value, _passwordController.text),
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            hintText: "Confirmar contraseña"),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5a86e3),
                              minimumSize: const Size(400, 50)),
                          onPressed: () {
                            _submittedForm();
                          },
                          child: const Text(
                            "Crear",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
