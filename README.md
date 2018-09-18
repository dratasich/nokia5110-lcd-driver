# Nokia 5110 LCD Driver displaying Daisy's Status

Code and scripts to control an LCD displaying
[Daisy's](https://tuw-cpsg.github.io/tutorials/daisy/) Status.

`status.sh` prints following status information:
* WiFi connection (`iwconfig`)
* WiFi IP (`ifconfig`)
* Ping Jetson board (`daisy`)


## Setup

* Connect according to the [pinout](https://components101.com/nokia-5110-lcd)
  to a 3.3V power supply.

| LCD   | Pi (see `disp.c`) | Gertboard |
|-------|-------------------|-----------|
| RST   | BCM 27            | GP21      |
| CE    | BCM 22            | GP22      |
| DC    | BCM 23            | GP23      |
| DIN   | BCM 24            | GP24      |
| CLK   | BCM 25            | GP25      |
| VCC   | not connected     | 3V3       |
| LIGHT | not connected     | GND       |
| GND   | not connected     | GND       |

* Clone this repo to Daisy's Pi, here: `/home/pi/status-lcd`.

* Install Linux [Kernel Headers].
  ```bash
  sudo apt-get install raspberrypi-kernel-headers
  ```

* Build by calling `make` in this directory on the Pi.

* Add following lines to `/etc/rc.local` to start the status display at boot.
  ```bash
  # status display
  /home/pi/status-lcd/prepare.sh
  insmod /home/pi/status-lcd/lcd5110.ko
  /home/pi/status-lcd/status.sh > /dev/lcd5110 &
  echo "endlessly write the Pi's status to the Nokia5110 LCD"
  ```
  Prepare and load the driver (`sudo prepare.sh`, `sudo insmod lcd5110.ko`).
  Finally start the `status.sh` script
  that continuously prints the status to `stdout`
  which is forwarded to the LCD.


## License Information

This repo has been forked: [Original Repo] by Christian Hirsch.
Code is [licensed](https://www.tldp.org/LDP/lkmpg/2.6/html/x279.html)
under Dual BSD/GPL
([GPLv2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.de.html)
or [BSD](https://directory.fsf.org/wiki/License:BSD-4-Clause)
choice).
Following changes have been made:
added the `status.sh` script,
changed pinout
and added instructions.


## References

* [Original Repo]
* [Kernel Headers]
* [Kernel Module Tutorial]


[Original Repo]: https://github.com/ChristianHirsch/nokia5110-lcd-driver
[Kernel Headers]: https://www.raspberrypi.org/documentation/linux/kernel/headers.md
[Kernel Module Tutorial]: https://blog.fazibear.me/the-beginners-guide-to-linux-kernel-module-raspberry-pi-and-led-matrix-790e8236e8e9
