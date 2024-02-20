import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/screen/login_page.dart';
import 'package:shopping_ecommerce_app/core/constant_color.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/theme_provider.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/user_info_bloc.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/user_info_bloc_state.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/screens/account_info_page.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/screens/cart_page.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/screens/wishlist_page.dart';
import '../controller/handle_shared_preferences.dart';
import '../screens/show_password_page.dart';

class DrawerPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const DrawerPage({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Drawer(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // hide drawer
                IconButton(
                  onPressed: (){
                    /// TODO: when clicked hide drawer
                    scaffoldKey.currentState!.closeDrawer();
                  },
                  icon: const Icon(
                    Icons.menu_open_outlined,
                    size: 35,
                  ),
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xFFE5E5E5))),
                ),
                const SizedBox(height: 30,),
                // info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // image , name
                    Row(
                      children: [
                        // image
                        const CircleAvatar(radius: 20, foregroundImage: AssetImage("assets/images/twitter.png"),),
                        const SizedBox(width: 5,),
                        // username
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<UserInfoBloc, UserInfoState>(
                              builder: (context, state) {
                                if(state is UserInfoSuccess){
                                  return Text(
                                    state.user.username,
                                    style: const TextStyle(fontSize: 16,),
                                  );
                                }else{
                                  return const Text(
                                    "Username",
                                    style: TextStyle(fontSize: 16,),
                                  );
                                }
                              },
                            ),
                            const Row(
                              children: [
                                Text(
                                  "Verified Profile",
                                  style: TextStyle(fontSize: 12,color: ConstantColor.splashContainerSubTitleColor),
                                ),
                                SizedBox(width: 3,),
                                Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: Color(0xFF52F538),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    // total number of orders which this account have
                    Container(
                      width: 80,
                      height: 40,
                      color: const Color(0xFFF5F5F5),
                      alignment: Alignment.center,
                      child: const Text(
                        "3 orders",
                        style: TextStyle(fontSize: 14, color: ConstantColor.splashContainerSubTitleColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                // toggle dark mode
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.light_mode_outlined, size: 30, color: Color(0xFF545454),),
                        SizedBox(width: 10,),
                        Text("Dark Mode", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                      ],
                    ),
                    Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                      trackOutlineWidth: const MaterialStatePropertyAll(0.2),
                      activeColor: const Color(0xFF32CA5B),
                      thumbColor: const MaterialStatePropertyAll(Colors.white),
                      inactiveTrackColor: const Color(0xFFD6D6D6),
                      trackOutlineColor: const MaterialStatePropertyAll(Color(0xFFD6D6D6)),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                // account info
                InkWell(
                  onTap:(){
                    // TODO: when clicked it go to account info page
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AccountInfoPage(),));
                  },
                  child: drawerListItem(const Icon(Icons.info_outline, size: 30, color: Color(0xFF545454),), "Account Information",
                      ConstantColor.splashContainerTitleColor),
                ),
                const SizedBox(height: 20,),
                // password
                InkWell(
                  onTap: (){
                    // TODO: when click on it go to show password
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ShowPasswordPage(),));
                  },
                  child: drawerListItem(const Icon(Icons.lock_outline, size: 30, color: Color(0xFF545454),), "Password",
                      ConstantColor.splashContainerTitleColor),
                ),
                const SizedBox(height: 20,),
                // Order
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage(),));
                  },
                  child: drawerListItem(const Icon(Icons.shopping_cart_outlined, size: 30, color: Color(0xFF545454),), "Order",
                      ConstantColor.splashContainerTitleColor),
                ),
                const SizedBox(height: 20,),
                // my cards
                drawerListItem(const Icon(Icons.add_card_sharp, size: 30, color: Color(0xFF545454),), "My Cards",
                    ConstantColor.splashContainerTitleColor),
                const SizedBox(height: 20,),
                // wishlist
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WishlistPage(),));
                  },
                  child: drawerListItem(const Icon(Icons.favorite_border_outlined, size: 30, color: Color(0xFF545454),), "Wishlist",
                      ConstantColor.splashContainerTitleColor),
                ),
              ],
            ),
            // logout
            InkWell(
              onTap: (){
                // TODO: remove data from shared preferences
                HandleSharedPreferences.removeDataSharedPreferences();
                // TODO: when clicked on it logout
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage(),));
              },
              child: drawerListItem(const Icon(Icons.logout_outlined, size: 30, color: Color(0xFFF95B5A),), "Logout", const Color(0xFFF95B5A))
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerListItem(Icon icon, String title, Color color){
    return Row(
      children: [
        icon,
        const SizedBox(width: 10,),
        Text(
          title,
          style: TextStyle(
              fontSize: 20,
              color: color,
              fontWeight: FontWeight.w300
          ),
        ),
      ],
    );
  }
}

