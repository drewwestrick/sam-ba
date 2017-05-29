import SAMBA 3.1
import SAMBA.Connection.JLink 3.1
import SAMBA.Device.SAMA5D4 3.1

JLinkConnection {
	//port: "99999999"

	device: SAMA5D4Xplained {
		// to use a custom config, replace SAMA5D4Xplained by SAMA5D4 and
		// uncomment the following lines, or see documentation for
		// custom board creation.
		//config {
		//	serialflash {
		//		instance: 0
		//		ioset: 1
		//		chipSelect: 0
		//		freq: 66
		//	}
		//}
	}

	onConnectionOpened: {
		// initialize Low-Level applet
		initializeApplet("lowlevel")

		// initialize serial flash applet
		initializeApplet("serialflash")

		// erase all memory
		applet.erase(0, applet.memorySize)

		// write files
		applet.write(0x00000, "application.bin", true)
	}
}
