import 'package:ecom/provider/connectivity_provider.dart';
import 'package:ecom/screen/authentication/forgot_password_screen.dart';
import 'package:ecom/screen/authentication/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/authentication_provider.dart';
import '../../utils/hide_keyboard.dart';
import '../../widgets/app_button.dart';
import '../../utils/colors.dart';
import '../../utils/string.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final  authenticationProvider  = Provider.of<AuthenticationProvider>(context , listen: false);
    authenticationProvider.emailController.text="";
    authenticationProvider.passwordController.text="";
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    final  authenticationProvider  = Provider.of<AuthenticationProvider>(context , listen: false);
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: SingleChildScrollView(
        child: Form(
          key:formKey,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height*0.08,),

                Container(
                  height: size.width*0.40,
                  width: size.width*0.40,
                  child: Image.asset('Images/logo1.png') ,
                ),

                SizedBox(height: size.height*0.06,),

                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                  child: Text(
                    EMAIL_NAME,
                    style:TextStyle(
                      color: TITLE_COLOR,
                      fontSize: size.width*0.045,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                  child: TextFormField(
                    controller: authenticationProvider.emailController,
                    style: TextStyle(
                        fontSize: size.width*0.038,
                        color: TEXT_COLOR
                    ),
                    cursorColor: CURSOR_COLOR,
                    validator: (value) {
                      if (value!.isEmpty) {
                          return EMAIL_VALIDATION_TEXT;
                        }
                      return null; // Return null if the input is valid
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: EMAIL_HINT,
                        hintStyle: TextStyle(
                          color: HINT_TEXT_COLOR,
                          fontWeight: FontWeight.normal,
                          fontSize: size.width*0.040
                        )
                    ),
                  ),
                ),

                SizedBox(height: size.height*0.02,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                  alignment: Alignment.topLeft,
                  child: Text(
                    PASSWORD_TEXT,
                    style:TextStyle(
                        color: TITLE_COLOR,
                        fontSize: size.width*0.045,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                  child: TextFormField(
                    obscureText: authenticationProvider.obscureTexts,
                    controller: authenticationProvider.passwordController,
                    cursorColor: CURSOR_COLOR,
                    style: TextStyle(
                        fontSize: size.width*0.038,
                        color: TEXT_COLOR
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return PASSWORD_VALIDATION_TEXT;
                      }
                      return null; // Return null if the input is valid
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: PASSWORD_HINT,

                        hintStyle: TextStyle(
                            color: HINT_TEXT_COLOR,
                            fontWeight: FontWeight.normal,
                            fontSize: size.width*0.040
                        ),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            setState(() {
                              authenticationProvider.obscureTexts = !authenticationProvider.obscureTexts;
                            });
                          },
                          child: Icon(
                            authenticationProvider.obscureTexts?
                            Icons.visibility_off:Icons.visibility,
                            color: ICON_COLOR,
                          ),
                        )
                    ),
                  ),
                ),

                SizedBox(height: size.height*0.02,),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                    alignment: Alignment.topRight,
                    child: Text(
                      FORGOT_PASSWORD_TEXT,
                      style: TextStyle(
                          color: TITLE_COLOR,
                          fontWeight: FontWeight.w400,
                          fontSize: size.width*0.040
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height*0.04,),

                authenticationProvider.isApiLoading?Container(
                  child: CircularProgressIndicator(
                    color: CIRCULAR_INDICATOR_COLOR,
                  ),
                )
                    :
                GestureDetector(
                  onTap: (){
                    if (formKey.currentState!.validate()) {
                      KeyboardUtil.hideKeyboard(context);
                      context.read<ConnectivityProvider>().checkConnection();
                      !context.read<ConnectivityProvider>().isConnected?
                      authenticationProvider.snackBarConnection(context):
                      authenticationProvider.loginUser(context: context,isUpdateAddress: false);
                    }
                  },
                  child: Container(
                      // margin: EdgeInsets.symmetric(horizontal: size.width*0.02),
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
                      child: button(title: LOGIN, context: context)),
                ),

                SizedBox(height: size.height*0.04,),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()));
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
                      child: buttonWithoutColor(SIGNUP, context)),
                ),
                SizedBox(height: size.height*0.04,),

              ],
            ),
          ),
        ),
      ),
    );

  }
}
