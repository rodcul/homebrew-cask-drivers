cask 'ftdi-vcp-driver' do
  if MacOS.version <= :mountain_lion
    version '2.2.18'
    sha256 '248f582527175ab07334f6a1255c8be2da4dfc36da49e26d39a2f61f5b7ba2e7'
    pkg 'FTDIUSBSerialDriver_10_4_10_5_10_6_10_7.mpkg'
  else
    version '2.4.2'
    sha256 'b57377e10de1c8ae9ddaffa147e4cc529c3571b512bba4798b2b6054d4fabd92'
    pkg 'FTDIUSBSerial.pkg'
  end

  url "http://www.ftdichip.com/Drivers/VCP/MacOSX/FTDIUSBSerialDriver_v#{version.dots_to_underscores}.dmg"
  name 'FTDI VCP Driver'
  homepage 'http://www.ftdichip.com/Drivers/VCP.htm'

  uninstall pkgutil: 'com.FTDI.ftdiusbserialdriverinstaller.*',
            kext:    'com.FTDI.driver.FTDIUSBSerialDriver',
            delete:  '/Library/Extensions/FTDIUSBSerialDriver.kext'

  caveats do
    reboot

    <<~EOS
      If you don't want to reboot, you can load the driver using the following
      command:

        sudo /sbin/kextload -b com.FTDI.driver.FTDIUSBSerialDriver

      Once you've rebooted or loaded the driver, you can connect your FTDI
      based cable to a USB port and it will show up in /dev, usually like this:

        /dev/tty.usbserial-XXXXXXXX

      where XXXXXXXX is a random ID, based on the serial number of your FTDI
      based cable.

      NOTE: If your FTDI based cable was already connected before you installed
      the driver, you'll need to unplug the cable from the USB port and
      reconnect it for it to show up in /dev.
    EOS
  end
end
