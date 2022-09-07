import 'package:flutter/material.dart';
import 'main_menu.dart';
import 'register_page.dart';
import 'account_data.dart';

class MyOnboardingPage extends StatefulWidget{
  const MyOnboardingPage({Key? key}) : super(key: key);

  @override
  State<MyOnboardingPage> createState() => _MyOnboardingPageState();
}

class _MyOnboardingPageState extends State<MyOnboardingPage> {

  String email = '',password = '',username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 540,right: 100),
            child: Container(
              height: 500,
              width: 500,
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(topRight: Radius.circular(300)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 640,right: 210),
            child: Container(
              height: 500,
              width: 500,
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.only(topRight: Radius.circular(200)),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 80),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Insert Email...',
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
                      hintText: 'Insert Password...',
                      labelText: 'Password',
                    ),
                    onChanged: (String value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    child: const Text(
                      'Forgot the password?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                                content: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          decoration: const InputDecoration(
                                            hintText: 'Insert Email...',
                                            labelText: 'Email',
                                          ),
                                          onChanged: (String value) {
                                            setState(() {
                                              email = value;
                                            });
                                          },
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            if(!accountList.containsKey(email)){
                                              showDialog(
                                                  context: context,
                                                  builder: (context){
                                                    return const AlertDialog(
                                                      content: Text('[!]Invalid Email'),
                                                    );
                                                  });
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: (context){
                                                    return AlertDialog(
                                                        content: Padding(
                                                            padding: const EdgeInsets.all(16.0),
                                                            child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  TextField(
                                                                    decoration: const InputDecoration(
                                                                      hintText: 'Insert Username...',
                                                                      labelText: 'Username',
                                                                    ),
                                                                    onChanged: (String value) {
                                                                      setState(() {
                                                                        username = value;
                                                                      });
                                                                    },
                                                                  ),
                                                                  ElevatedButton(
                                                                    onPressed: () {
                                                                      if(accountName[email].toString().compareTo(username) != 0){
                                                                        showDialog(
                                                                            context: context,
                                                                            builder: (context){
                                                                              return const AlertDialog(
                                                                                content: Text('[!]Invalid Username'),
                                                                              );
                                                                            });
                                                                      } else if(accountName[email].toString().compareTo(username) == 0){
                                                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                          return const MainScreen();
                                                                        }));
                                                                      }
                                                                    },
                                                                    child: const Text('Next'),
                                                                  ),
                                                                ]
                                                            )
                                                        )
                                                    );
                                                  });
                                            }
                                          },
                                          child: const Text('Next'),
                                        ),
                                      ],
                                    )
                                )
                            );
                          });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if(!accountList.containsKey(email)){
                        showDialog(
                            context: context,
                            builder: (context){
                              return const AlertDialog(
                                content: Text('[!]Invalid Email'),
                              );
                            });
                      } else if(accountList[email].toString().compareTo(password) != 0){
                        showDialog(
                            context: context,
                            builder: (context){
                              return const AlertDialog(
                                content: Text('[!]Invalid Password'),
                              );
                            });
                      } else if(accountList[email].toString().compareTo(password) == 0){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return const MainScreen();
                        }));
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    child: const Text(
                      'Do not have any account? Sign Up!',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const MyRegisterPage();
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
