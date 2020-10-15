import 'package:ed_project/models/profile_model.dart';
import 'package:ed_project/providers/profile_provider.dart';
import 'package:ed_project/screens/initial_page.dart';
import 'package:provider/provider.dart';

import '../../widgets/appbar_with_backbutton_widget.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  static const route = 'EditProfilePage';

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userP = Provider.of<ProfileProvider>(context, listen: false).getUser;
    var gender = Gender.FEMALE;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const AppBarWithBackButtonWidget(text: 'Editar perfil'),
            Expanded(
              child: Form(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: [
                    _CustomInputText(
                      icon: Icons.person,
                      label: 'Nombres',
                      initialValue: userP.name,
                      valueCallback: (value) => print(value),
                    ),
                    _CustomInputText(
                      icon: Icons.person,
                      label: 'Apellidos',
                      initialValue: userP.lastName,
                      valueCallback: (value) => print(value),
                    ),
                    _CustomInputText(
                      icon: Icons.room_preferences_rounded,
                      label: 'Nombre de usuario',
                      valueCallback: (value) => print(value),
                      initialValue: userP.username,
                    ),
                    _CustomInputText(
                      icon: Icons.email,
                      label: 'Correo electronico',
                      initialValue: userP.email,
                      valueCallback: (value) => print(value),
                    ),
                    _CustomInputText(
                      icon: Icons.vpn_key,
                      label: 'Contraseña',
                      initialValue: userP.password,
                      valueCallback: (value) => print(value),
                      showText: false,
                    ),
                    _CustomInputText(
                      icon: Icons.location_on,
                      label: 'Ubicacion',
                      initialValue: userP.location,
                      valueCallback: (value) => print(value),
                    ),
                    Row(
                      children: [
                        Radio(
                          //TODO: FIX BUTTON
                          value: Gender.MALE,
                          groupValue: gender,
                          onChanged: (v) => setState(() {
                            print(v);
                            gender = v;
                          }),
                        ),
                        Radio(
                          value: Gender.FEMALE,
                          groupValue: gender,
                          onChanged: (v) => setState(() {
                            print(v);
                            gender = v;
                          }),
                        ),
                      ],
                    ),
                    _CustomInputText(
                      icon: Icons.photo_filter,
                      label: 'Link foto perfil',
                      initialValue: userP.avatarUrl,
                      valueCallback: (value) => print(value),
                    ),
                  ],
                ),
              ),
            ),
            const _ButtonsEditProfile(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _CustomInputText extends StatelessWidget {
  final Function valueCallback;
  final String label;
  final String initialValue;
  final IconData icon;
  final bool showText;

  const _CustomInputText({
    Key key,
    @required this.valueCallback,
    @required this.label,
    @required this.icon,
    @required this.initialValue,
    this.showText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          onChanged: (value) => valueCallback(value),
          cursorColor: Theme.of(context).primaryColor,
          initialValue: initialValue,
          obscureText: !showText,
          decoration: InputDecoration(
            labelText: '$label',
            prefixIcon: Icon(icon),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class _ButtonsEditProfile extends StatelessWidget {
  const _ButtonsEditProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void handleDelete() {
      final res =
          Provider.of<ProfileProvider>(context, listen: false).deleteUser();
      if (!res) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Opps hubo un problema al eliminar el perfil'),
        ));
      } else {
        Navigator.of(context).pushReplacementNamed(InitialPage.route);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          onPressed: () => handleDelete(),
          child: Text(
            'Eliminar perfil',
            style: TextStyle(fontSize: 16),
          ),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          color: Colors.redAccent,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(width: 10),
        RaisedButton(
          //TODO: implement update profile
          onPressed: () {},
          child: Text(
            'Guardar cambios',
            style: TextStyle(fontSize: 18),
          ),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          color: Colors.blueAccent,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
