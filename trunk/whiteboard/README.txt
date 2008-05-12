Please Read if having trouble getting the whiteboard to run

1. This application was written using Flex Builder 3, which you'll need to run it.
2. You will need to download the latest version of Red5 (this app was built with v0.7) from http://osflash.org/red5
3. Install red5, then run it by going to program files>red5
4. In the class scr/model/DrawProxy.as change the DEFAULT_RED5 String to use your ip address (or the address of
the red5 server you just installed if you installed it on a different machine)
5. You're ready to go! The whiteboard also uses PureMVC (http://puremvc.org/) as an MVC framework; and FlexUnit 
from Abode for the UnitTests. You don't need to add these libraries to the buildpath, they're already in the
src/libs folder. You can run the unit tests by running the BoardUnitTests.mxml file