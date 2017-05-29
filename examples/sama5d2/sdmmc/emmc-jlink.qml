import SAMBA 3.1
import SAMBA.Connection.JLink 3.1
import SAMBA.Device.SAMA5D2 3.1

JLinkConnection {
	//port: "99999999"

	device: SAMA5D2Xplained {
	}

	onConnectionOpened: {
		// initialize SD/MMC applet
		initializeApplet("sdmmc")

		// write file
		applet.write(0, "filesystem_image.raw", false)

		// initialize boot config applet
		initializeApplet("bootconfig")

		// Use BUREG0 as boot configuration word
		applet.writeBootCfg(BootCfg.BSCR, BSCR.fromText("VALID,BUREG0"))

		// Enable external boot only on SDMMC0
		applet.writeBootCfg(BootCfg.BUREG0,
			BCW.fromText("EXT_MEM_BOOT,UART1_IOSET1,JTAG_IOSET1," +
			             "SDMMC0,SDMMC1_DISABLED,NFC_DISABLED," +
			             "SPI1_DISABLED,SPI0_DISABLED," +
			             "QSPI1_DISABLED,QSPI0_DISABLED"))
	}
}
