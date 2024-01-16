//
//
// import 'package:ecom/provider/connectivity_provider.dart';
// import 'package:ecom/provider/customer_provider.dart';
// import 'package:ecom/screen/connectivity_screen.dart';
// import 'package:ecom/utils/colors.dart';
// import 'package:ecom/widgets/app_button.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../model/customer/customerBillingModel.dart';
// import '../../model/customer/customerCreateModel.dart';
// import '../../utils/shared_preferences_string.dart';
// import '../../utils/string.dart';
// import '../../widgets/appbar_title.dart';
//
// class UpdateProfileScreen extends StatefulWidget {
//   const UpdateProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
// }
//
// class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
//
//   TextEditingController firstnameController = new TextEditingController();
//   TextEditingController lastController = new TextEditingController();
//   TextEditingController emailController = new TextEditingController();
//   TextEditingController companyController = new TextEditingController();
//   TextEditingController primaryAddressController = new TextEditingController();
//   TextEditingController cityController = new TextEditingController();
//   TextEditingController stateController = new TextEditingController();
//   TextEditingController postalCodeController = new TextEditingController();
//   TextEditingController phoneController = new TextEditingController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     // Future.delayed( Duration(seconds: 2), () {
//     //   getData();
//     // });
//     getData();
//
//     super.initState();
//   }
//
//
//   getData()async{
//     final customerProvider = Provider.of<CustomerProvider>(context, listen: false);
//     customerProvider.loginCustomer(context: context);
//     customerProvider.getCustomerDetailsPref();
//
//     Future.delayed( Duration(seconds: 1), () async{
//       final prefs = await SharedPreferences.getInstance();
//       String? emails = await prefs.getString(EMAIL);
//       String? f_name = await prefs.getString(F_NAME);
//       String? l_name = await prefs.getString(L_NAME);
//       Billing billings = await customerProvider.createCustomer.billing;
//
//       firstnameController.text=billings.first_name = f_name.toString();
//       lastController.text=billings.last_name = l_name.toString();
//       emailController.text= billings.email = emails.toString();
//       companyController.text=billings.company!;
//       primaryAddressController.text=billings.address_1!;
//       cityController.text=billings.city!;
//       // countrySelected=billing.country;
//       stateController.text=billings.state!;
//       postalCodeController.text=billings.postcode!;
//       phoneController.text=billings.phone!;
//     });
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     var size = MediaQuery.of(context).size;
//     final customerProvider = Provider.of<CustomerProvider>(context,);
//     return  Scaffold(
//       backgroundColor: BACKGROUND_COLOR,
//       appBar: AppBarTitle().appbar(setState, context, UPDATE_PROFILE,true),
//       body: !context.read<ConnectivityProvider>().isConnected?connectivityData(context: context,OnTap: (){
//         print("ontap:: profile update");
//         context.read<ConnectivityProvider>().checkConnection();
//         getData();
//       }): Stack(
//         children: [
//           SingleChildScrollView(
//             child: customerProvider.isLoading?CircularProgressIndicator(color: CIRCULAR_INDICATOR_COLOR,):Container(
//               margin: EdgeInsets.symmetric(horizontal: size.width*0.04, vertical: size.height*0.02),
//               child: Column(
//                children: [
//                  textField(context: context,Controllers: firstnameController,hintTextMsg: "Enter First Name",keyboardTypes: TextInputType.text,Title: FIRST_NAME,isReadOnly: false),
//                  SizedBox(height: size.height*0.02,),
//                  textField(context: context,Controllers: lastController,hintTextMsg: "Enter Last Name",keyboardTypes: TextInputType.text,Title: LAST_NAME,isReadOnly: false),
//                  SizedBox(height: size.height*0.02,),
//                  textField(context: context,Controllers: emailController,hintTextMsg: "Enter Email",keyboardTypes: TextInputType.text,Title: EMAIL_NAME,isReadOnly: true),
//                  SizedBox(height: size.height*0.02,),
//                  textField(context: context,Controllers: companyController,hintTextMsg: "Enter Company",keyboardTypes: TextInputType.text,Title: COMPANY,isReadOnly: false),
//                  SizedBox(height: size.height*0.02,),
//                  textField(context: context,Controllers: primaryAddressController,hintTextMsg: "Enter Address",keyboardTypes: TextInputType.text,Title: ADDRESS_NAME,isReadOnly: false),
//                  SizedBox(height: size.height*0.02,),
//                  textField(context: context,Controllers: cityController,hintTextMsg: "Enter City",keyboardTypes: TextInputType.text,Title: CITY,isReadOnly: false),
//                  SizedBox(height: size.height*0.02,),
//                  textField(context: context,Controllers: stateController,hintTextMsg: "Enter State",keyboardTypes: TextInputType.text,Title: STATE,isReadOnly: false),
//                  SizedBox(height: size.height*0.02,),
//                  textField(context: context,Controllers: postalCodeController,hintTextMsg: "Enter Postal Code",keyboardTypes: TextInputType.number,Title: POSTAL_CODE,isReadOnly: false),
//                  SizedBox(height: size.height*0.02,),
//                 textField(context: context,Controllers: phoneController,hintTextMsg: "Enter Phone Number",keyboardTypes: TextInputType.phone,Title: PHONE,isReadOnly: false),
//                 SizedBox(height: size.height*0.12,),
//
//                ],
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               // width: double.infinity,
//               height: size.height*0.12,
//
//               padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
//               decoration: BoxDecoration(
//                 color: CARD_BACKGROUND_COLOR,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10),
//                   topRight: Radius.circular(10),
//                 ),
//               ),
//               child: GestureDetector(
//                 onTap: ()async{
//
//                   context.read<ConnectivityProvider>().checkConnection();
//
//                   final customerProvider = Provider.of<CustomerProvider>(context, listen: false);
//                   var customer =  await customerProvider.createCustomer;
//
//                   // Future.delayed( Duration(seconds: 2), () async{
//                   //   Billing billings = await customerProvider.createCustomer.billing;
//                   //
//                   //   firstnameController.text=billings.first_name!;
//                   //
//                   //   lastController.text=billings.last_name!;
//                   //   emailController.text=billings.email!;
//                   //   // companyController.text=billings.company;
//                   //   primaryAddressController.text=billings.address_1!;
//                   //   cityController.text=billings.city!;
//                   //   // countrySelected=billing.country;
//                   //   stateController.text=billings.state!;
//                   //   postalCodeController.text=billings.postcode!;
//                   //   phoneController.text=billings.phone!;
//                   // });
//                   String newFirstName = customer.shipping.first_name =  customer.billing.first_name = customer.first_name = firstnameController.text;
//                   String newLastName =customer.shipping.last_name =   customer.billing.last_name = customer.last_name = lastController.text;
//                   customer.shipping.company =     customer.billing.company = companyController.text;
//                   customer.shipping.address_2 =   customer.shipping.address_1 = customer.billing.address_1 = primaryAddressController.text;
//                   customer.shipping.city =        customer.billing.city = cityController.text;
//                   customer.shipping.state =       customer.billing.state = stateController.text;
//                   customer.shipping.postcode =    customer.billing.postcode = postalCodeController.text;
//                   customer.shipping.country =     customer.billing.country = "";
//                   String newEmailName =customer.billing.email =        customer.email = emailController.text;
//                   customer.billing.phone =        phoneController.text;
//
//
//                   print("updateProfile ${newFirstName} ${newLastName} ${newEmailName}");
//                   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//                   await prefs.setString(F_NAME, newFirstName);
//                   await prefs.setString(L_NAME, newLastName);
//                   await prefs.setString(EMAIL, newEmailName);
//                   customerProvider.setCustomerDetailsPref(customer);
//                   Navigator.pop(context);
//                 },
//                   child: Center(child: button(title: SAVE, context: context ))),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget textField({required BuildContext context, required TextEditingController Controllers,
//     required String hintTextMsg,required String Title,required TextInputType keyboardTypes , required bool isReadOnly}) {
//     var size = MediaQuery.of(context).size;
//     return  Column(
//       children: [
//         Container(
//           alignment: Alignment.topLeft,
//           child: Text(
//             Title,
//             overflow: TextOverflow.ellipsis,
//             maxLines: 3,
//             style: TextStyle(
//                 color: TITLE_COLOR,
//                 fontSize:size.width*0.045,
//                 fontWeight: FontWeight.bold
//             ),
//           ),
//         ),
//         SizedBox(height: size.height*0.005,),
//
//         TextFormField(
//           controller: Controllers,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             hintText: hintTextMsg,
//             hintStyle: TextStyle(
//               color: HINT_TEXT_COLOR,
//               fontWeight: FontWeight.normal,
//               fontSize: size.width*0.040
//             )
//           ),
//           keyboardType: keyboardTypes,
//           cursorColor: CURSOR_COLOR,
//           readOnly:  isReadOnly,
//
//
//         ),
//       ],
//     );
//
//   }
// }
