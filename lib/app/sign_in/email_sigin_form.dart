import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';
import '/app/sign_in/validators.dart';
import '/common_widgets/form_submit_button.dart';

enum EmailFormType { signIn, register }

// ignore: use_key_in_widget_constructors
class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator {
  EmailSignInForm({Key key, @required this.auth}) : super(key: key);
  final Authbase auth;

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _eamilController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocuseNode = FocusNode();
  final FocusNode _passwordFocuseNode = FocusNode();

  EmailFormType _formType = EmailFormType.signIn;
  String get _email => _eamilController.text;
  String get _password => _passwordController.text;
  bool _submitted = false;

  void _submit() async {
    setState(() {
      _submitted = true;
    });
    try {
      if (_formType == EmailFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        widget.auth.createAccountWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocuseNode);
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailFormType.signIn
          ? EmailFormType.register
          : EmailFormType.signIn;
    });
    _eamilController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText =
        _formType == EmailFormType.signIn ? 'Sign in' : 'Create ana account';
    final secondaryText = _formType == EmailFormType.register
        ? 'Need an account? Rigister'
        : 'I have an account';

    bool submitEnabled = widget.emailValidator.isVaild(_email) &&
        widget.passwordValidator.isVaild(_password);
    _email.isNotEmpty && _password.isNotEmpty;

    bool showErrorTextEmail =
        _submitted && !widget.emailValidator.isVaild(_email);
    bool showErrorTextPassowrd =
        _submitted && !widget.passwordValidator.isVaild(_password);
    return [
      TextField(
        controller: _eamilController,
        focusNode: _emailFocuseNode,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'example@test.com',
          errorText: showErrorTextEmail ? widget.invaildEmailErrorText : null,
        ),
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onChanged: (email) => _updateState(),
        onEditingComplete: _emailEditingComplete,
      ),
      const SizedBox(
        height: 8.0,
      ),
      TextField(
        controller: _passwordController,
        focusNode: _passwordFocuseNode,
        decoration: InputDecoration(
          labelText: 'Password',
          errorText:
              showErrorTextPassowrd ? widget.invaildPasswordErrorText : null,
        ),
        onChanged: (password) => _updateState(),
        textInputAction: TextInputAction.done,
        obscureText: true,
      ),
      const SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      const SizedBox(
        height: 8.0,
      ),
      TextButton(
        child: Text(secondaryText),
        onPressed: _toggleFormType,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  _updateState() {
    setState(() {});
  }
}
