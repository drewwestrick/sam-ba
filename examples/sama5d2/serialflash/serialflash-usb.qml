import SAMBA 3.1
import SAMBA.Connection.Serial 3.1
import SAMBA.Device.SAMA5D2 3.1

SerialConnection {
	//port: "ttyACM0"
	//port: "COM85"
	//baudRate: 57600

	device: SAMA5D2Xplained {
		// to use a custom config, replace SAMA5D2Xplained by SAMA5D2 and
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
		// initialize serial flash applet
		initializeApplet("serialflash")

		// erase all memory
		applet.erase(0, applet.memorySize)

		// write files
		applet.write(0x00000, "at91bootstrap.bin", true)
		applet.write(0x04000, "u-boot-env.bin")
		applet.write(0x08000, "u-boot.bin")
		applet.write(0x60000, "at91-sama5d2_xplained.dtb")
		applet.write(0x6c000, "zImage")

		// initialize boot config applet
		initializeApplet("bootconfig")

		// Use BUREG0 as boot configuration word
		applet.writeBootCfg(BootCfg.BSCR, BSCR.fromText("VALID,BUREG0"))

		// Enable external boot only on SPI0 IOSET1
		applet.writeBootCfg(BootCfg.BUREG0,
			BCW.fromText("EXT_MEM_BOOT,UART1_IOSET1,JTAG_IOSET1," +
			             "SDMMC1_DISABLED,SDMMC0_DISABLED,NFC_DISABLED," +
			             "SPI1_DISABLED,SPI0_IOSET1," +
			             "QSPI1_DISABLED,QSPI0_DISABLED"))
	}
}
