import 'package:buy_and_sell/buy.dart';
import 'package:buy_and_sell/profile.dart';
import 'package:buy_and_sell/sell.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  final String token;

  HomeView(this.token);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            BuyView(widget.token),
            SellView(widget.token),
            ProfileView(widget.token),
          ],
        ),
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, -4),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            NavbarButton(
              icon: Icons.attach_money,
              title: "Buy",
              callback: () {
                setState(
                  () {
                    _selectedIndex = 0;
                    _pageController.jumpToPage(0);
                  },
                );
              },
              selected: (_selectedIndex == 0),
            ),
            NavbarButton(
              icon: Icons.money_outlined,
              title: "Sell",
              callback: () {
                setState(
                  () {
                    _selectedIndex = 1;
                    _pageController.jumpToPage(1);
                  },
                );
              },
              selected: (_selectedIndex == 1),
            ),
            NavbarButton(
              icon: Icons.home,
              title: "Profile",
              callback: () {
                setState(
                  () {
                    _selectedIndex = 2;
                    _pageController.jumpToPage(2);
                  },
                );
              },
              selected: (_selectedIndex == 2),
            ),
          ],
        ),
      ),
    );
  }
}

class NavbarButton extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final Function callback;
  final String title;
  NavbarButton({this.icon, this.selected, this.callback, this.title});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: SizedBox(
        height: 64,
        child: Column(
          children: <Widget>[
            Container(
              color: selected ? Colors.orange : Colors.transparent,
              height: 2,
              width: 100,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Icon(
                icon,
                color: selected ? Colors.orange : Color(0xFF979797),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: selected ? Colors.orange : Color(0xFF979797),
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
      padding: EdgeInsets.all(0),
      onPressed: callback,
    );
  }
}
