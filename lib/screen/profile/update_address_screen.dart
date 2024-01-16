import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecom/provider/address_provider.dart';
import 'package:ecom/provider/connectivity_provider.dart';
import 'package:ecom/screen/connectivity_screen.dart';
import 'package:ecom/utils/colors.dart';
import 'package:ecom/utils/hide_keyboard.dart';
import 'package:ecom/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/string.dart';
import '../../widgets/appbar_title.dart';

class UpdateAddressScreen extends StatefulWidget {
  const UpdateAddressScreen({Key? key}) : super(key: key);

  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData()async{
    final addressProvider = Provider.of<AddressProvider>(context,listen: false);
    addressProvider.billingFirstNameController.text=billingFirstName!;
    addressProvider.shippingCountry=shippingCountrys;
    addressProvider.billingCountry=billingCountrys;
  }


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final addressProvider = Provider.of<AddressProvider>(context);
    return  Scaffold (
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBarTitle().appbar(setState, context, UPDATE_ADDRESS,true),
      body: !context.read<ConnectivityProvider>().isConnected?connectivityData(context: context,OnTap: (){
        context.read<ConnectivityProvider>().checkConnection();
      }): Form(
        key: formKey,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width*0.04, vertical: size.height*0.02),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              BILLING_ADDRESS,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                  color: TITLE_COLOR,
                                  fontSize:size.width*0.045,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          SizedBox(height: size.height*0.01,),
                          Divider(color: DIVIDER_COLOR,),
                          SizedBox(height: size.height*0.01,),
                          textField(context: context,Controllers: addressProvider.billingFirstNameController,hintTextMsg: FIRST_HINT_NAME,keyboardTypes: TextInputType.text,Title: FIRST_NAME,isReadOnly: false,index: 1),
                          SizedBox(height: size.height*0.02,),
                          textField(context: context,Controllers: addressProvider.billingLastNameController,hintTextMsg: LAST_HINT_NAME,keyboardTypes: TextInputType.text,Title: LAST_NAME,isReadOnly: false,index: 2 ),
                          SizedBox(height: size.height*0.02,),
                          textField(context: context,Controllers: addressProvider.billingCompanyController,hintTextMsg: COMPANY_HINT_NAME,keyboardTypes: TextInputType.text,Title: COMPANY_NAME,isReadOnly: false,index: 3),
                          SizedBox(height: size.height*0.02,),
                          textField(context: context,Controllers: addressProvider.billingAddress1AddressController,hintTextMsg: ADDRESS1_HINT_NAME,keyboardTypes: TextInputType.text,Title: ADDRESS1_NAME,isReadOnly: false, index: 4),
                          SizedBox(height: size.height*0.02,),
                          textField(context: context,Controllers: addressProvider.billingAddress2AddressController,hintTextMsg: ADDRESS2_HINT_NAME,keyboardTypes: TextInputType.text,Title: ADDRESS2_NAME,isReadOnly: false, index: 5),
                          SizedBox(height: size.height*0.02,),
                          textField(context: context,Controllers: addressProvider.billingCityController,hintTextMsg: CITY_HINT_NAME,keyboardTypes: TextInputType.text,Title: CITY_NAME,isReadOnly: false, index: 6),
                          SizedBox(height: size.height*0.02,),
                          textField(context: context,Controllers: addressProvider.billingPostalCodeController,hintTextMsg: POSTAL_HINT_NAME,keyboardTypes: TextInputType.number,Title: POSTAL_NAME,isReadOnly: false, index: 7),
                          SizedBox(height: size.height*0.02,),
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  COUNTRY_NAME,
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
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
                                  height: size.height*0.075,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey
                                     ),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                alignment: Alignment.centerLeft,
                                child: CountryCodePicker(
                                  padding: EdgeInsets.zero,
                                  onChanged: (CountryCode code) {

                                    addressProvider.billingCountry=code.name;
                                  },
                                  builder: (CountryCode? code) {
                                    return Text(code!.name.toString());
                                  },

                                  showCountryOnly: true,
                                  initialSelection: addressProvider.billingCountry,
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: size.height*0.02,),
                          textField(context: context,Controllers: addressProvider.billingStateController,hintTextMsg: STATE_HINT_NAME,keyboardTypes: TextInputType.text,Title: STATE_NAME,isReadOnly: false, index: 8),
                          SizedBox(height: size.height*0.02,),
                          textField(context: context,Controllers: addressProvider.billingPhoneController,hintTextMsg: PHONE_HINT,keyboardTypes: TextInputType.phone,Title: PHONE_NUMBER,isReadOnly: false,index: 9),
                          SizedBox(height: size.height*0.02,),
                          textField(context: context,Controllers: addressProvider.billingEmailController,hintTextMsg: EMAIL_HINT_NAME,keyboardTypes: TextInputType.emailAddress,Title: EMAIL_NAME,isReadOnly: false,index: 10),
                          SizedBox(height: size.height*0.04,),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              SHIPPING_ADDRESS,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                  color: TITLE_COLOR,
                                  fontSize:size.width*0.045,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          CheckboxListTile(

                            activeColor: BUTTON_COLOR,
                            contentPadding: EdgeInsets.zero,
                            title: Text('Copy from billing address',style: TextStyle(
                                  color: TEXT_COLOR,
                                  fontSize:size.width*0.040,
                                  fontWeight: FontWeight.normal
                              ),),
                            value: addressProvider.isCheckedBillingAddress,
                            onChanged: (bool? newValue) {
                              setState(() {
                                addressProvider.isCheckedBillingAddress = newValue!;
                              });
                            },
                          ),

                          Divider(color: DIVIDER_COLOR,),
                          addressProvider.isCheckedBillingAddress?SizedBox(height: size.height*0.12,):Column(
                            children: [
                              SizedBox(height: size.height*0.01,),
                              textField(context: context,Controllers: addressProvider.shippingFirstNameController,hintTextMsg: FIRST_HINT_NAME,keyboardTypes: TextInputType.text,Title: FIRST_NAME,isReadOnly: false, index: 1),
                              SizedBox(height: size.height*0.02,),
                              textField(context: context,Controllers: addressProvider.shippingLastNameController,hintTextMsg: LAST_HINT_NAME,keyboardTypes: TextInputType.text,Title: LAST_NAME,isReadOnly: false, index: 2),
                              SizedBox(height: size.height*0.02,),
                              textField(context: context,Controllers: addressProvider.shippingCompanyController,hintTextMsg: COMPANY_HINT_NAME,keyboardTypes: TextInputType.text,Title: COMPANY_NAME,isReadOnly: false, index: 3),
                              SizedBox(height: size.height*0.02,),
                              textField(context: context,Controllers: addressProvider.shippingAddress1AddressController,hintTextMsg: ADDRESS1_HINT_NAME,keyboardTypes: TextInputType.text,Title: ADDRESS1_NAME,isReadOnly: false, index: 4),
                              SizedBox(height: size.height*0.02,),
                              textField(context: context,Controllers: addressProvider.shippingAddress2AddressController,hintTextMsg: ADDRESS2_HINT_NAME,keyboardTypes: TextInputType.text,Title: ADDRESS2_NAME,isReadOnly: false, index: 5),
                              SizedBox(height: size.height*0.02,),
                              textField(context: context,Controllers: addressProvider.shippingCityController,hintTextMsg: CITY_HINT_NAME,keyboardTypes: TextInputType.text,Title: CITY_NAME,isReadOnly: false,  index: 6),
                              SizedBox(height: size.height*0.02,),
                              textField(context: context,Controllers: addressProvider.shippingPostalCodeController,hintTextMsg: POSTAL_HINT_NAME,keyboardTypes: TextInputType.number,Title: POSTAL_NAME,isReadOnly: false,  index: 7),
                              SizedBox(height: size.height*0.02,),
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      COUNTRY_NAME,
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
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
                                    height: size.height*0.075,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey
                                        ),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: CountryCodePicker(
                                      padding: EdgeInsets.zero,
                                      onChanged: (CountryCode code) {
                                        KeyboardUtil.hideKeyboard(context);
                                        addressProvider.shippingCountry=code.name;
                                      },
                                      builder: (CountryCode? code) {
                                        return Text(code!.name.toString());
                                      },

                                      showCountryOnly: true,
                                      initialSelection: addressProvider.shippingCountry,
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: size.height*0.02,),
                              textField(context: context,Controllers: addressProvider.shippingStateController,hintTextMsg: STATE_HINT_NAME,keyboardTypes: TextInputType.text,Title: STATE_NAME,isReadOnly: false, index: 8),
                              SizedBox(height: size.height*0.02,),
                              textField(context: context,Controllers: addressProvider.shippingPhoneController,hintTextMsg: PHONE_HINT,keyboardTypes: TextInputType.phone,Title: PHONE_NUMBER,isReadOnly: false, index: 9),
                              SizedBox(height: size.height*0.02,),
                              textField(context: context,Controllers: addressProvider.shippingEmailController,hintTextMsg: EMAIL_HINT_NAME,keyboardTypes: TextInputType.emailAddress,Title: EMAIL_NAME,isReadOnly: false, index: 10),
                              SizedBox(height: size.height*0.12,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: addressProvider.isApiLoading?Padding(
                padding: EdgeInsets.symmetric(vertical: size.width*0.02),
                child: CircularProgressIndicator(color: CIRCULAR_INDICATOR_COLOR,),
              ):Container(
                height: size.height*0.12,
                padding: EdgeInsets.symmetric(horizontal: size.width*0.02, vertical: size.width*0.02),
                decoration: BoxDecoration(
                  color: CARD_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: GestureDetector(
                    onTap: ()async{
                      if (formKey.currentState!.validate()) {
                        // _formKey.currentState.save();
                        addressProvider.UpdateAddress(context: context,isChecked: addressProvider.isCheckedBillingAddress );
                      }

                    },
                    child: Center(child: button(title: SAVE, context: context ))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textField({required BuildContext context, required TextEditingController Controllers,
    required String hintTextMsg,required String Title,required TextInputType keyboardTypes , required bool isReadOnly,
    required int index}) {
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
              )
          ),
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
                return COMPANY_NAME_VALIDATION_TEXT;
              }
            }else if(index==4){
              if (value!.isEmpty) {
                return ADDRESS_LINE1_VALIDATION_TEXT;
              }
            }else if(index==5){
              if (value!.isEmpty) {
                return ADDRESS_LINE2_VALIDATION_TEXT;
              }
            }else if(index==6){
              if (value!.isEmpty) {
                return CITY_VALIDATION_TEXT;
              }
            }
            else if(index==7){
              if (value!.isEmpty) {
                return POSTCODE_ZIP_VALIDATION_TEXT;
              }
            }else if(index==8){
              if (value!.isEmpty) {
                return STATE_VALIDATION_TEXT;
              }
            }
            else if(index==9){
              if (value!.isEmpty) {
                return PHONE_VALIDATION_TEXT;
              }
            }
            else if(index==10){
              if (value!.isEmpty) {
                return EMAIL_VALIDATION_TEXT;
              }
            }
            return null; // Return null if the input is valid
          },
          keyboardType: keyboardTypes,
          cursorColor: CURSOR_COLOR,
          readOnly:  isReadOnly,
          onSaved: (value) {
            },


        ),
      ],
    );

  }
}
