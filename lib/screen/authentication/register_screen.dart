import 'package:ecom/provider/connectivity_provider.dart';
import 'package:ecom/screen/authentication/login_screen.dart';
import 'package:ecom/screen/profile/about_us_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/authentication_provider.dart';
import '../../utils/hide_keyboard.dart';
import '../../widgets/app_button.dart';
import '../../utils/colors.dart';
import '../../utils/string.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscureTexts = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final  authenticationProvider  = Provider.of<AuthenticationProvider>(context ,listen: false);
    authenticationProvider.firstNameRegisterController.text="";
    authenticationProvider.lastNameRegisterController.text="";
    authenticationProvider.userNameRegisterController.text="";
    authenticationProvider.emailRegisterController.text="";
    authenticationProvider.passwordRegisterController.text="";
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    final  authenticationProvider  = Provider.of<AuthenticationProvider>(context ,);
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: SingleChildScrollView(
        child: Form(
          key:formKey ,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height*0.07,),

                    Container(
                      height: size.width*0.40,
                      width: size.width*0.40,
                      child: Image.asset('Images/logo1.png') ,
                    ),

                    SizedBox(height: size.height*0.04,),

                    textField(context: context,Controllers: authenticationProvider.firstNameRegisterController,hintTextMsg: FIRST_HINT_NAME,keyboardTypes: TextInputType.text,Title: FIRST_NAME,
                        index: 1),
                    SizedBox(height: size.height*0.02,),

                    textField(context: context,Controllers: authenticationProvider.lastNameRegisterController,hintTextMsg: LAST_HINT_NAME,keyboardTypes: TextInputType.text,Title: LAST_NAME, index: 2),
                    SizedBox(height: size.height*0.02,),

                    textField(context: context,Controllers: authenticationProvider.userNameRegisterController,hintTextMsg:USER_HINT_NAME ,keyboardTypes: TextInputType.text,Title:USER,index: 3),
                    SizedBox(height: size.height*0.02,),

                    textField(context: context,Controllers: authenticationProvider.emailRegisterController,hintTextMsg: EMAIL_HINT,keyboardTypes: TextInputType.text,Title: EMAIL_NAME,index: 4),
                    SizedBox(height: size.height*0.02,),

                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        PASSWORD_TEXT,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
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
                        obscureText: obscureTexts,
                        controller: authenticationProvider.passwordRegisterController,
                        cursorColor: CURSOR_COLOR,
                        style: TextStyle(
                            fontSize: size.width*0.038,
                            color: TEXT_COLOR
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
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
                                  obscureTexts = !obscureTexts;
                                });
                              },
                              child: Icon(
                                obscureTexts?
                                Icons.visibility
                                    :
                                Icons.visibility_off,
                                color: ICON_COLOR,
                              ),
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: size.height*0.04,),

                  ],
                ),
              ),

               Container(
                 padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
                 child: Row(
                   children: [
                     Checkbox(
                       checkColor: Colors.white,
                       // fillColor: MaterialStateProperty.resolveWith(getColor),
                       value: isChecked,
                       onChanged: (bool? value) {
                         setState(() {
                           isChecked = value!;
                         });
                       },
                     ),
                   RichText(
                     text: TextSpan(
                       // style: DefaultTextStyle.of(context).style,
                       children: <TextSpan>[
                         TextSpan(
                           text: 'I Agree to the ',
                           style: TextStyle(
                             // fontWeight: FontWeight.bold,
                             color: Colors.black,
                             fontSize: 15,
                           ),
                         ),

                         TextSpan(
                           text: 'Terms and Condition',
                           recognizer: TapGestureRecognizer()
                             ..onTap = () {
                               // Define the action to be taken when the text is clicked.
                               // You can navigate to another screen, show a dialog, etc.
                               Navigator.of(context).push(MaterialPageRoute(builder: (builder) => AboutUsScreen(Title: TERM_CONDITION,)));
                             },
                           style: TextStyle(
                             // fontStyle: FontStyle.italic,
                             color: Colors.blue,
                             fontSize: 15,
                             // decoration: TextDecoration.underline,
                           ),
                         ),
                       ],
                     ),
                   ),
                 ],
                 ),
               ),

              authenticationProvider.isApiLoading?
              Container(
                child: CircularProgressIndicator(
                  color: CIRCULAR_INDICATOR_COLOR,
                ),
              )
                  :
              GestureDetector(
                onTap: (){
                     if (formKey.currentState!.validate()) {
                       if(isChecked){
                         KeyboardUtil.hideKeyboard(context);
                         context.read<ConnectivityProvider>().checkConnection();
                         !context.read<ConnectivityProvider>().isConnected?
                         authenticationProvider.snackBarConnection(context):
                         authenticationProvider.registerUser(context: context,setState: setState);
                       }else{
                         ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text("Please Accept Term & Condition")));
                       }

                     }
                 },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                    child: button(title: SIGN_IN,context: context)),
              ),

              SizedBox(height: size.height*0.04,),

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                },
                child: Container(
                  width: size.width*0.90,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                    ALREADY_LOGIN_MSG,
                    style: TextStyle(
                        color: TITLE_COLOR,
                        fontWeight: FontWeight.w400,
                        fontSize: size.width*0.040
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height*0.04,),

            ],
          ),
        ),
      ),
    );

  }

  Widget textField({required BuildContext context, required TextEditingController Controllers,
    required String hintTextMsg,required String Title,required TextInputType keyboardTypes,required int index}) {
    var size = MediaQuery.of(context).size;
    return  Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              Title,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(
                  color: TITLE_COLOR,
                  fontSize:size.width*0.045,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          SizedBox(height: size.height*0.005,),

          TextFormField(
            controller: Controllers,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: hintTextMsg,
                hintStyle: TextStyle(
                    color: HINT_TEXT_COLOR,
                    fontWeight: FontWeight.normal,
                    fontSize: size.width*0.040
                )
            ),
            keyboardType: keyboardTypes,
            cursorColor: CURSOR_COLOR,
            validator: (value) {

              if(index==1){
                if (value!.isEmpty) {
                  return FIRST_NAME_VALIDATION_TEXT;
                }
              }else if(index==2){
                if (value!.isEmpty) {
                  return LAST_NAME_VALIDATION_TEXT;
                }
              }else if(index==3){
                if (value!.isEmpty) {
                  return USER_NAME_VALIDATION_TEXT;
                }
              }else if(index==4){
                if (value!.isEmpty) {
                  return EMAIL_VALIDATION_TEXT;
                }
              }
              return null; // Return null if the input is valid
            },

          ),
        ],
      ),
    );

  }
}
