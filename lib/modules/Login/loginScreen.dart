import 'package:flutter/material.dart';
import 'package:pet_care/modules/HomeScreen/HomeScreen.dart';
import 'package:pet_care/modules/Login/login_vm.dart';
import 'package:pet_care/modules/createAccount/createAccount.dart';
import 'package:pet_care/shared/colors.dart';
import 'package:provider/provider.dart';
import '../../base.dart';
import '../../models/myUser.dart';
import '../../providers/userProvider.dart';
import 'loginNavigator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = 'LogIn';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<login_vm, LoginScreen>
    implements loginNavigator {
  GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this; //important .......................
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome Back',
                    style: TextStyle(fontFamily: 'DMSans',fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image(
                    image: AssetImage('assets/images/login.png'),
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    // height: MediaQuery.of(context).size.height*.42,

                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: FormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "E-mail",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: MyColors.primaryColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: MyColors.primaryColor),
                              )),
                          validator: (value) {
                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!);
                            if (value == null ||
                                value!.isEmpty ||
                                emailValid == false) {
                              return "Please Enter Email ...";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: passController,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: MyColors.primaryColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: MyColors.primaryColor),
                              )),
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              return "Please Enter Password ...";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                            onTap: () {
                              viewModel.resetPassword(
                                  emailController.text, context);
                            },
                            child: Text(
                              "Forget Password" ,
                              style: TextStyle(
                                  fontFamily: 'DMSans',
                                  color: MyColors.primaryColor,
                                  decoration: TextDecoration.underline),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: MyColors.primaryColor,
                              minimumSize: Size.fromHeight(50),
                            ),
                            onPressed: () {
                              ValidateForm();
                            },
                            child: Text(
                              'LogIn',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 18
                              ),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, createAccountScreen.routeName);
                            },
                            child: Text(
                              "Don't have an account ?",
                              style: TextStyle(
                                  fontFamily: 'DMSans',
                                  color: MyColors.primaryColor,
                                  decoration: TextDecoration.underline),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void ValidateForm() {
    if (FormKey.currentState?.validate() == true) {
      viewModel.login(emailController.text, passController.text);
    }
  }

  @override
  init_VM() {
    return login_vm();
  }

  @override
  void goHome(myUser user) {
    var provider = Provider.of<UserProvider>(context, listen: false);
    provider.user = user;
    Navigator.pushReplacementNamed(context, homeScreen.routeName);
  }
}
