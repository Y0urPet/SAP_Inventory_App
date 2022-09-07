import 'package:flutter/material.dart';
import 'account_data.dart';
import 'login.dart';

class MyRegisterPage extends StatefulWidget{
  const MyRegisterPage({Key? key}) : super(key: key);

  @override
  State<MyRegisterPage> createState() => _MyRegisterPage();
}

class _MyRegisterPage extends State<MyRegisterPage> {

  String email = '',password = '',username = '';
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 550,right: 100),
            child: Container(
              height: 500,
              width: 500,
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(300)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 640,left: 210),
            child: Container(
              height: 500,
              width: 500,
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(200)),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  const SizedBox(height: 70),
                  const Text(
                    'Register Account',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 80),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Name...',
                      labelText: 'Username',
                    ),
                    onChanged: (String value) {
                      setState(() {
                        username = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Email...',
                      labelText: 'Email',
                    ),
                    onChanged: (String value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Password...',
                      labelText: 'Password',
                    ),
                    onChanged: (String value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: Checkbox(
                      value: agree,
                      onChanged: (bool? value) {
                        setState(() {
                          agree = value!;
                        });
                      },
                    ),
                    title: const Text('I am agree to accept the terms & policy'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if(accountList.containsKey(email)){
                        showDialog(
                            context: context,
                            builder: (context){
                              return const AlertDialog(
                                content: Text('[!]Email Already Used'),
                              );
                            });
                      } else if(!email.endsWith('.com') || !email.contains('@')){
                        showDialog(
                            context: context,
                            builder: (context){
                              return const AlertDialog(
                                content: Text('[!]Email must end with .com and contain @'),
                              );
                            });
                      } else if(password.length < 6){
                        showDialog(
                            context: context,
                            builder: (context){
                              return const AlertDialog(
                                content: Text('[!]Password must at leash have 6 characters'),
                              );
                            });
                      }else if (agree == false) {
                        showDialog(
                            context: context,
                            builder: (context){
                              return const AlertDialog(
                                content: Text('[!]You must agree to the Term & Policy'),
                              );
                            });
                      } else {
                        //insert data
                        //navigation ke log in
                        accountList[email] = password;
                        accountName[email] = username;
                        Navigator.pop(context, MaterialPageRoute(builder: (context) {
                          return const MyOnboardingPage();
                        }));
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  TextButton(
                    child: const Text(
                      'Already have an account? Sign In!',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const MyOnboardingPage();
                      }));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
