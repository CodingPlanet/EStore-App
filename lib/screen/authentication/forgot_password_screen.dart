import 'package:ecom/provider/connectivity_provider.dart';
import 'package:ecom/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/authentication_provider.dart';
import '../../utils/hide_keyboard.dart';
import '../../utils/string.dart';
import '../../widgets/app_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    final  authenticationProvider  = Provider.of<AuthenticationProvider>(context , listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: Form(
          key: formKey,
          child: Stack(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(FORGOT_PASSWORD_MSG,
                        style: TextStyle(
                        color: TITLE_COLOR,
                        fontSize: size.width*0.045,
                        fontWeight: FontWeight.bold
                      ),),
                    ),

                    SizedBox(height: size.height*0.01,),

                    Container(
                      width: size.width*0.90,
                      child: Text(
                        FORGOT_PASSWORD_MSG1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: TITLE_COLOR,
                            fontSize: size.width*0.043,
                          fontWeight: FontWeight.normal
                      ),),
                    ),

                    SizedBox(height: size.height*0.02,),

                    Container(
                      width: size.width*0.90,
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        EMAIL_NAME,
                        style: TextStyle(
                            color: TITLE_COLOR,
                            fontSize:size.width*0.045,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    Container(
                      width: size.width*0.90,
                      child: TextFormField(
                        controller: authenticationProvider.emailForgotPasswordController,
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
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: size.height*0.05,),

                    authenticationProvider.isApiLoading
                        ?
                    Container(
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
                         authenticationProvider.forgotPasswordData(context: context, setState: setState);
                       }


                      },
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: size.width*0.02),
                          child: button(title: "Verify Email",context: context)),
                    ),

                  ],
                ),
              ),

              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: size.height*0.02,horizontal: size.width*0.03),
                    child: Icon(Icons.arrow_back,color: ICON_COLOR,size: size.width*0.07),)),
            ],
          ),
        ),
      ),
    );
  }

}
