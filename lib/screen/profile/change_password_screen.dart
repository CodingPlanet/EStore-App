import 'package:ecom/provider/change_password_provider.dart';
import 'package:ecom/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/appbar_title.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final changePasswordProvider = Provider.of<ChangePasswordProvider>(context, listen: false);
    changePasswordProvider.NewPasswordController.text="";
    changePasswordProvider.oldPasswordController.text="";
    changePasswordProvider.ConfirmPassWordController.text="";
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final changePasswordProvider = Provider.of<ChangePasswordProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBarTitle().appbar(setState, context, CHANGE_PASSWORD,true),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width*0.04, vertical: size.height*0.02),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        PASSWORDS,
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
                      controller: changePasswordProvider.oldPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                            return OLD_PASSWORD_VALIDATION_TEXT;
                          }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Password",
                        hintStyle: TextStyle(
                            color: HINT_TEXT_COLOR,
                            fontWeight: FontWeight.normal,
                            fontSize: size.width*0.040
                        ),
                        suffixIcon: InkWell(
                          onTap: (){
                            setState(() {
                              changePasswordProvider.isHidden = !changePasswordProvider.isHidden;
                            });
                          },
                          child: Icon(changePasswordProvider.isHidden? Icons.visibility_off_sharp:Icons.visibility, color: ICON_COLOR,),
                        ),
                      ),
                      obscureText: changePasswordProvider.isHidden,
                      keyboardType: TextInputType.text,
                      cursorColor: CURSOR_COLOR,
                    ),

                    SizedBox(height: size.height*0.02,),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        NEW_PASSWORD_TEXT,
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
                      controller: changePasswordProvider.NewPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return NEW_PASSWORD_VALIDATION_TEXT;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter New Password",
                        hintStyle: TextStyle(
                            color: HINT_TEXT_COLOR,
                            fontWeight: FontWeight.normal,
                            fontSize: size.width*0.040
                        ),
                        suffixIcon: InkWell(
                          onTap: (){
                            setState(() {
                              changePasswordProvider.isHidden1 = !changePasswordProvider.isHidden1;
                            });
                          },
                          child: Icon(changePasswordProvider.isHidden1? Icons.visibility_off_sharp:Icons.visibility, color: ICON_COLOR,),
                        ),
                      ),
                      obscureText: changePasswordProvider.isHidden1,
                      keyboardType: TextInputType.text,
                      cursorColor: CURSOR_COLOR,
                    ),

                    SizedBox(height: size.height*0.02,),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        CONFIRM_PASSWORD,
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
                      controller: changePasswordProvider.ConfirmPassWordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Confirm Password",
                        hintStyle: TextStyle(
                            color: HINT_TEXT_COLOR,
                            fontWeight: FontWeight.normal,
                            fontSize: size.width*0.040
                        ),
                        suffixIcon: InkWell(
                          onTap: (){
                            setState(() {
                              changePasswordProvider.isHidden2 = !changePasswordProvider.isHidden2;
                            });
                          },
                          child: Icon(changePasswordProvider.isHidden2? Icons.visibility_off_sharp:Icons.visibility, color: ICON_COLOR,),
                        ),
                      ),
                      validator: (value) => changePasswordProvider.validateConfirmPassword(value!,context),
                      obscureText: changePasswordProvider.isHidden2,
                      keyboardType: TextInputType.text,
                      cursorColor: CURSOR_COLOR,
                    ),
                    SizedBox(height: size.height*0.02,),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: changePasswordProvider.isApiLoading?CircularProgressIndicator( color: Colors.white,):GestureDetector(
              onTap: (){
                final form = _formKey.currentState;
                if(form != null && form.validate()){
                  changePasswordProvider.changePasswordData(context);
                }
              },
              child: Container(
                height: size.height*0.12,
                padding: EdgeInsets.symmetric(horizontal: size.width*0.02, vertical: size.width*0.02),
                decoration: BoxDecoration(
                  color: CARD_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Center(child: button(title: SAVE, context: context )),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget textField({required BuildContext context, required TextEditingController Controllers,
    required String hintTextMsg,required String Title,required TextInputType keyboardTypes ,required bool isHidden }) {
    var size = MediaQuery.of(context).size;
    return  Column(
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
              ),
            suffixIcon: InkWell(
              onTap: (){
                setState(() {
                  isHidden = !isHidden;
                });
              },
              child: Icon(isHidden? Icons.visibility:Icons.visibility_off_sharp, color: ICON_COLOR,),
            ),
          ),
          obscureText: isHidden,
          keyboardType: keyboardTypes,
          cursorColor: CURSOR_COLOR,
          ),
      ],
    );
  }
}


