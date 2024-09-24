import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  String email = '';
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisibility = true;
  bool _iconVisibility = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(32),
        children: <Widget>[
          buildEmail(),
          const SizedBox(
            height: 24,
          ),
          buildPassword(),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () {
              //Validar o form

              //Acessar o form
              bool valid = _formKey.currentState!.validate();
              if (valid) {
                print('Email: $email');
                print('Password: ${passwordController.text}');
              }
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }

  Widget buildEmail() => TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Obrigatório informar um e-mail!';
          }
          if (value.contains('@') == false) {
            return 'O email não contém um @!';
          }
          return null;
        },
        controller: emailController,
        onChanged: (value) {
          email = value;
        },
        decoration: InputDecoration(
          hintText: 'name@example.com',
          labelText: 'E-mail',
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.email),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              emailController.clear();
            },
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      );

  Widget buildPassword() => TextFormField(
        validator: (value) {
          if (value!.length < 6) {
            return 'A senha deve conter pelo menos 6 caracteres!';
          }
          return null;
        },
        controller: passwordController,
        obscureText: !_passwordVisibility,
        decoration: InputDecoration(
          hintText: 'Your Password...',
          labelText: 'Password',
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _iconVisibility ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _passwordVisibility = !_passwordVisibility;
                _iconVisibility = !_iconVisibility;
              });
            },
          ),
        ),
      );
}
