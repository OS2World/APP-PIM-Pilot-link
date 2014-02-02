Pilot-Link 0.12-pre4
a suite of tools used to connect your Palm or PalmOS© compatible handheld
with OS/2 and eComStation
===========================================
30/Jul/2005 - Yuri Dario <mc6530@mclink.it>


General:
--------
pilot-link is a suite of tools used to connect your Palm or PalmOS© compatible handheld
with Unix, Linux, and any other POSIX-compatible machine. pilot-link works with all 
PalmOS© handhelds, including those made by Handspring, Sony, and Palm, as well as others.
pilot-link includes userspace "conduits" that allow you to syncronize information to and
from your Palm device, as well as libraries of Palm-compatible functions that allow other
applications to take advantage of the code included in pilot-link. There are also several
language "bindings" that allow you to use your favorite development language with
pilot-link, such as Java, Tcl, Perl, and Python.


Requirements:
-------------
Innotek LIBC 0.6rc1 (included).
Netlabs usbcalls package (included).


Installation:
-------------
To enable USB communications, usbcalls.dll and related device driver usbresmg.sys 
must be installed.
As usual, place the dll into our LIBPATH and the device driver into your x:\os2\boot
and add
	
	DEVICE=x:\os2\boot\usbresmg.sys

to your config.sys.
Connect a device to your usb port and run

	testlibusb.exe

the output should be like

	E:\usr\local\libusb\bin>testlibusb.exe
	Dev #1: EPSON - USB Printer
	Dev #2: Palm, Inc. - Palm Handheld

You can run 'testlibusb -v' to retrieve device descriptors.
You can have more logging informations enabling the USB_DEBUG enviroment
variable (set USB_DEBUG=x where x=1..10).

To enable hotsync via USB bus, the hotsync operation must be initiated first on
your handheld, then start the applications: this is because hotplug is not implemented
in current enumeration, so libusb will not see the device until you press the hotsync
button. This will be changed soon.

Test your device protocol using dlpsh:

	dlpsh -p usb: -i

NOTE: serial port communications are not supported in this version.
NOTE: -p usb: must be specified to read from usb port.

To create object icons, enter the os2 subdirectory and start

	makefolder.cmd


Support
-------
Since this is a OpenSource freeware product there are no
formal support options available.


Donations
---------
Since this software is ported for free, donations are welcome! you can use PayPal
to donate me and support OS/2 developement. See my homepage for details, or ask :-)
At least, a post card is welcome!


Acknowledgement
---------------
Thanks to Voytek Eymont for converting some of the icons from Windows.
And thanks to Garey Smiley <garey@slink.com> for the first OS/2 port of 
pilot-link.0.8.13 and the scripts for creating the pilot link folder
(the os2 subdir).


History
-------
30/07/2005 
	public release

===============================================================================
Yuri Dario <mc6530@mclink.it>
http://www.os2power.com/yuri
