import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/alert_dialog.dart';
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

  String get _email => _eamilController.text;
  String get _password => _passwordController.text;
  EmailFormType _formType = EmailFormType.signIn;

  bool _submitted = false;
  bool _isLoading = false;

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      if (_formType == EmailFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        widget.auth.createAccountWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      showAlertDialog(context,
          title: 'Sign in failed',
          content: e.toString(),
          defaultActionText: 'OK');

//       if(Platform == TargetPlatform.iOS ){
// print('fuck');
//       }else{
//       showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text('Sign in failed'),
//               content: Text(e.toString()),
//               actions: [
//                 TextButton(
//                   child: const Text('OK'),
//                   onPressed: () => Navigator.of(context).pop(),
//                 )
//               ],
//             );
//           });}
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isVaild(_email)
        ? _passwordFocuseNode
        : _emailFocuseNode;
    FocusScope.of(context).requestFocus(newFocus);
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
        widget.passwordValidator.isVaild(_password) &&
        !_isLoading;
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
          enabled: _isLoading == false,
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
          enabled: _isLoading == false,
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
        onPressed: !_isLoading ? _toggleFormType : null,
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
