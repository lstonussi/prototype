import 'package:flutter/material.dart';
import 'package:salesforce/model/repository/login_repository.dart';
import 'package:salesforce/model/user_model.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();
  UserModel user = UserModel();

  final LoginRepository repository;
  LoginController(this.repository);

  userUsuario(String value) => user.nome = value;
  userSenha(String value) => user.senha = value;

  Future<bool> login() async {
    if (!formKey.currentState.validate()) {
      return false;
    }
    formKey.currentState.save();
    try {
      return await repository.doLogin(user);
    } catch (e) {
      return false;
    }
  }
}
