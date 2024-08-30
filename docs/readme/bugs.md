[Back to main README](/README.md)

# Bugs (Enduser)
Thbese are bugs I encountered while developing this application that affect the enduser.
# Bugs (Developement)
These are bugs I encountered while developing this application that don't affect the enduser. They only affect the  developement process and mostly required workarounds to solve.

1. NavigationBar labelBehavior property can't be set.
If the labelBehavior propert of the NavigationBar gets set to
labelBehavior:alwaysHide, labelBehavior: alwaysShown or labelBehavior: onlyShowSelected, it throws an exception:
```
Try correcting the name to the name of an existing getter, or defining a getter or field named 'alwaysHide'. labelBehavior: alwaysHide,
```
According to google docs, this shouldn't happen:
https://api.flutter.dev/flutter/material/NavigationBar-class.html

Solution: 
labelBehavior: NavigationDestinationLabelBehavior.alwaysHide