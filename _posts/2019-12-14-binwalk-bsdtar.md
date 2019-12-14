---
layout: post
title:  "Firmware dump extraction with binwalk and bsdtar"
---

Nathan Henrie [extracted the firmware from a wi-fi
borescope](https://n8henrie.com/2019/02/reverse-engineering-my-wifi-endoscope-part-2/)
and posted the extracted firmware online.

I downloaded the firmware and prepared it for analysis:

```console
$ wget https://n8henrie.com/uploads/2019/02/W25Q32_endoscope_merged.eeprom.gz
$ gunzip W25Q32_endoscope_merged.eeprom.gz
$ md5sum W25Q32_endoscope_merged.eeprom
8da2f08e906520d4a67fc20dec346360  W25Q32_endoscope_merged.eeprom
```

The `md5sum` output differs from the expected
`35d014b329d8e94318b59247a41139f6`, so the firmware file was probably updated
without a corresponding update to the page text.  It's therefore worth
re-running [`binwalk`](https://github.com/ReFirmLabs/binwalk) to recursively
extract contents from the firmware dump:

```console
$ binwalk -Me W25Q32_endoscope_merged.eeprom

Scan Time:     2019-12-14 11:10:00
Target File:   /Users/mplough/Projects/depstech/firmware/W25Q32_endoscope_merged.eeprom
MD5 Checksum:  8da2f08e906520d4a67fc20dec346360
Signatures:    391

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             uImage header, header size: 64 bytes, header CRC: 0x7EBF92E6, created: 2013-09-02 14:03:02, image size: 81904 bytes, Data Address: 0x80200000, Entry Point: 0x80200000, data CRC: 0x739ABB93, OS: Linux, CPU: MIPS, image type: Standalone Program, compression type: none, image name: "SPI Flash Image"
69296         0x10EB0         U-Boot version string, "U-Boot 1.1.3 (Sep  2 2013 - 22:03:00)"
327680        0x50000         uImage header, header size: 64 bytes, header CRC: 0x24EF36B4, created: 2017-07-30 08:41:54, image size: 1578918 bytes, Data Address: 0x80000000, Entry Point: 0x8031F000, data CRC: 0x67F11261, OS: Linux, CPU: MIPS, image type: OS Kernel Image, compression type: lzma, image name: "Linux Kernel Image"
327744        0x50040         LZMA compressed data, properties: 0x5D, dictionary size: 33554432 bytes, uncompressed size: 3926339 bytes


Scan Time:     2019-12-14 11:10:02
Target File:   /Users/mplough/Projects/depstech/firmware/_W25Q32_endoscope_merged.eeprom.extracted/50040
MD5 Checksum:  966ea70c3127490310ab0feec1b5e36f
Signatures:    391

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
2096284       0x1FFC9C        MySQL MISAM compressed data file Version 8
2859060       0x2BA034        Linux kernel version 2.6.21
2860048       0x2BA410        CRC32 polynomial table, little endian
2883552       0x2BFFE0        SHA256 hash constants, little endian
2938004       0x2CD494        Unix path: /usr/gnemul/irix/
2940148       0x2CDCF4        Unix path: /usr/lib/libc.so.1
2953804       0x2D124C        Unix path: /var/run/udhcpc.pid
3019052       0x2E112C        Unix path: /etc/Wireless/RT2860AP/RT2860AP.dat
3021496       0x2E1AB8        Unix path: /usr/bin/killall
3082311       0x2F0847        Neighborly text, "neighbor %.2x%.2x.%.2x:%.2x:%.2x:%.2x:%.2x:%.2x lost on port %d(%s)(%s)"
3204032       0x30E3C0        CRC32 polynomial table, little endian
3411968       0x341000        LZMA compressed data, properties: 0x5D, dictionary size: 1048576 bytes, uncompressed size: 2059264 bytes


Scan Time:     2019-12-14 11:10:05
Target File:   /Users/mplough/Projects/depstech/firmware/_W25Q32_endoscope_merged.eeprom.extracted/_50040.extracted/341000
MD5 Checksum:  45a0880b002ebd3ceafe21ed076e0e14
Signatures:    391

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             ASCII cpio archive (SVR4 with no CRC), file name: "/bin", file name length: "0x00000005", file size: "0x00000000"
116           0x74            ASCII cpio archive (SVR4 with no CRC), file name: "/bin/rm", file name length: "0x00000008", file size: "0x00000008"
244           0xF4            ASCII cpio archive (SVR4 with no CRC), file name: "/bin/iwpriv", file name length: "0x0000000C", file size: "0x00008D78"
36584         0x8EE8          ASCII cpio archive (SVR4 with no CRC), file name: "/bin/busybox", file name length: "0x0000000D", file size: "0x00066F68"
458444        0x6FECC         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/ralink_init", file name length: "0x00000011", file size: "0x00008D04"
494672        0x78C50         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/ping", file name length: "0x0000000A", file size: "0x00000008"
494800        0x78CD0         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/hostname", file name length: "0x0000000E", file size: "0x00000008"
494932        0x78D54         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/nvram_daemon", file name length: "0x00000012", file size: "0x00001A38"
501772        0x7A80C         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/sync", file name length: "0x0000000A", file size: "0x00000008"
501900        0x7A88C         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/iwlist", file name length: "0x0000000C", file size: "0x0000A540"
544328        0x84E48         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/vi", file name length: "0x00000008", file size: "0x00000008"
544456        0x84EC8         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/date", file name length: "0x0000000A", file size: "0x00000008"
544584        0x84F48         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/nvram_get", file name length: "0x0000000F", file size: "0x0000000C"
544724        0x84FD4         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/touch", file name length: "0x0000000B", file size: "0x00000008"
544856        0x85058         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/mknod", file name length: "0x0000000B", file size: "0x00000008"
544988        0x850DC         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/chmod", file name length: "0x0000000B", file size: "0x00000008"
545120        0x85160         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/app_cam", file name length: "0x0000000D", file size: "0x0001C4B0"
661132        0xA168C         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/mv", file name length: "0x00000008", file size: "0x00000008"
661260        0xA170C         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/ping6", file name length: "0x0000000B", file size: "0x00000008"
661392        0xA1790         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/lsusb", file name length: "0x0000000B", file size: "0x0000CEE0"
714476        0xAE6EC         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/dmesg", file name length: "0x0000000B", file size: "0x00000008"
714608        0xAE770         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/mkdir", file name length: "0x0000000B", file size: "0x00000008"
714740        0xAE7F4         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/ash", file name length: "0x00000009", file size: "0x00000008"
714868        0xAE874         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/ps", file name length: "0x00000008", file size: "0x00000008"
714996        0xAE8F4         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/mtd_write", file name length: "0x0000000F", file size: "0x000031C8"
727868        0xB1B3C         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/sed", file name length: "0x00000009", file size: "0x00000008"
727996        0xB1BBC         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/ls", file name length: "0x00000008", file size: "0x00000008"
728124        0xB1C3C         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/mount", file name length: "0x0000000B", file size: "0x00000008"
728256        0xB1CC0         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/nvram_set", file name length: "0x0000000F", file size: "0x0000000C"
728396        0xB1D4C         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/ated", file name length: "0x0000000A", file size: "0x000026C0"
738436        0xB4484         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/switch", file name length: "0x0000000C", file size: "0x00003F6C"
754796        0xB846C         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/flash", file name length: "0x0000000B", file size: "0x000037A8"
769168        0xBBC90         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/cp", file name length: "0x00000008", file size: "0x00000008"
769296        0xBBD10         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/pwd", file name length: "0x00000009", file size: "0x00000008"
769424        0xBBD90         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/mii_mgr", file name length: "0x0000000D", file size: "0x00001490"
774812        0xBD29C         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/kill", file name length: "0x0000000A", file size: "0x00000008"
774940        0xBD31C         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/umount", file name length: "0x0000000C", file size: "0x00000008"
775072        0xBD3A0         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/grep", file name length: "0x0000000A", file size: "0x00000008"
775200        0xBD420         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/sleep", file name length: "0x0000000B", file size: "0x00000008"
775332        0xBD4A4         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/cat", file name length: "0x00000009", file size: "0x00000008"
775460        0xBD524         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/echo", file name length: "0x0000000A", file size: "0x00000008"
775588        0xBD5A4         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/sh", file name length: "0x00000008", file size: "0x00000008"
775716        0xBD624         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/reg", file name length: "0x00000009", file size: "0x00001AD0"
782700        0xBF16C         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/login", file name length: "0x0000000B", file size: "0x00000008"
782832        0xBF1F0         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/iwconfig", file name length: "0x0000000E", file size: "0x0000A3D8"
824900        0xC9644         ASCII cpio archive (SVR4 with no CRC), file name: "/bin/app_detect", file name length: "0x00000010", file size: "0x0000269C"
834912        0xCBD60         ASCII cpio archive (SVR4 with no CRC), file name: "/dev", file name length: "0x00000005", file size: "0x00000000"
835028        0xCBDD4         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/spiS0", file name length: "0x0000000B", file size: "0x00000000"
835152        0xCBE50         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/ac0", file name length: "0x00000009", file size: "0x00000000"
835272        0xCBEC8         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtdblock2", file name length: "0x0000000F", file size: "0x00000000"
835400        0xCBF48         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtdblock7", file name length: "0x0000000F", file size: "0x00000000"
835528        0xCBFC8         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd6ro", file name length: "0x0000000C", file size: "0x00000000"
835652        0xCC044         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd3ro", file name length: "0x0000000C", file size: "0x00000000"
835776        0xCC0C0         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/kmem", file name length: "0x0000000A", file size: "0x00000000"
835896        0xCC138         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd0", file name length: "0x0000000A", file size: "0x00000000"
836016        0xCC1B0         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd1ro", file name length: "0x0000000C", file size: "0x00000000"
836140        0xCC22C         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/pts", file name length: "0x00000009", file size: "0x00000000"
836260        0xCC2A4         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/pts/1", file name length: "0x0000000B", file size: "0x00000000"
836384        0xCC320         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/pts/3", file name length: "0x0000000B", file size: "0x00000000"
836508        0xCC39C         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/pts/0", file name length: "0x0000000B", file size: "0x00000000"
836632        0xCC418         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/pts/2", file name length: "0x0000000B", file size: "0x00000000"
836756        0xCC494         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/ttyp0", file name length: "0x0000000B", file size: "0x00000000"
836880        0xCC510         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/pcm0", file name length: "0x0000000A", file size: "0x00000000"
837000        0xCC588         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/random", file name length: "0x0000000C", file size: "0x00000000"
837124        0xCC604         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd5ro", file name length: "0x0000000C", file size: "0x00000000"
837248        0xCC680         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mem", file name length: "0x00000009", file size: "0x00000000"
837368        0xCC6F8         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/ram1", file name length: "0x0000000A", file size: "0x00000000"
837488        0xCC770         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/urandom", file name length: "0x0000000D", file size: "0x00000000"
837612        0xCC7EC         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd4ro", file name length: "0x0000000C", file size: "0x00000000"
837736        0xCC868         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/ttyp1", file name length: "0x0000000B", file size: "0x00000000"
837860        0xCC8E4         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/ram3", file name length: "0x0000000A", file size: "0x00000000"
837980        0xCC95C         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/hwnat0", file name length: "0x0000000C", file size: "0x00000000"
838104        0xCC9D8         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd2ro", file name length: "0x0000000C", file size: "0x00000000"
838228        0xCCA54         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtdblock3", file name length: "0x0000000F", file size: "0x00000000"
838356        0xCCAD4         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/i2cM0", file name length: "0x0000000B", file size: "0x00000000"
838480        0xCCB50         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd0ro", file name length: "0x0000000C", file size: "0x00000000"
838604        0xCCBCC         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/swnat0", file name length: "0x0000000C", file size: "0x00000000"
838728        0xCCC48         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/nvram", file name length: "0x0000000B", file size: "0x00000000"
838852        0xCCCC4         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/video0", file name length: "0x0000000C", file size: "0x00000000"
838976        0xCCD40         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd1", file name length: "0x0000000A", file size: "0x00000000"
839096        0xCCDB8         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd4", file name length: "0x0000000A", file size: "0x00000000"
839216        0xCCE30         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/ptyp0", file name length: "0x0000000B", file size: "0x00000000"
839340        0xCCEAC         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd2", file name length: "0x0000000A", file size: "0x00000000"
839460        0xCCF24         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd5", file name length: "0x0000000A", file size: "0x00000000"
839580        0xCCF9C         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/cls0", file name length: "0x0000000A", file size: "0x00000000"
839700        0xCD014         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/ttyS1", file name length: "0x0000000B", file size: "0x00000000"
839824        0xCD090         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/ppp", file name length: "0x00000009", file size: "0x00000000"
839944        0xCD108         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtdblock1", file name length: "0x0000000F", file size: "0x00000000"
840072        0xCD188         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/flash0", file name length: "0x0000000C", file size: "0x00000000"
840196        0xCD204         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/null", file name length: "0x0000000A", file size: "0x00000000"
840316        0xCD27C         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd6", file name length: "0x0000000A", file size: "0x00000000"
840436        0xCD2F4         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtdblock6", file name length: "0x0000000F", file size: "0x00000000"
840564        0xCD374         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/ptyp1", file name length: "0x0000000B", file size: "0x00000000"
840688        0xCD3F0         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtdblock5", file name length: "0x0000000F", file size: "0x00000000"
840816        0xCD470         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtr0", file name length: "0x0000000A", file size: "0x00000000"
840936        0xCD4E8         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd3", file name length: "0x0000000A", file size: "0x00000000"
841056        0xCD560         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/acl0", file name length: "0x0000000A", file size: "0x00000000"
841176        0xCD5D8         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd7", file name length: "0x0000000A", file size: "0x00000000"
841296        0xCD650         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/ttyS0", file name length: "0x0000000B", file size: "0x00000000"
841420        0xCD6CC         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/i2s0", file name length: "0x0000000A", file size: "0x00000000"
841540        0xCD744         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/ram", file name length: "0x00000009", file size: "0x00000000"
841660        0xCD7BC         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtd7ro", file name length: "0x0000000C", file size: "0x00000000"
841784        0xCD838         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/ram0", file name length: "0x0000000A", file size: "0x00000000"
841904        0xCD8B0         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/rdm0", file name length: "0x0000000A", file size: "0x00000000"
842024        0xCD928         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/ram2", file name length: "0x0000000A", file size: "0x00000000"
842144        0xCD9A0         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/ptmx", file name length: "0x0000000A", file size: "0x00000000"
842264        0xCDA18         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtdblock0", file name length: "0x0000000F", file size: "0x00000000"
842392        0xCDA98         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/mtdblock4", file name length: "0x0000000F", file size: "0x00000000"
842520        0xCDB18         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/watchdog", file name length: "0x0000000E", file size: "0x00000000"
842644        0xCDB94         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/gpio", file name length: "0x0000000A", file size: "0x00000000"
842764        0xCDC0C         ASCII cpio archive (SVR4 with no CRC), file name: "/dev/console", file name length: "0x0000000D", file size: "0x00000000"
842888        0xCDC88         ASCII cpio archive (SVR4 with no CRC), file name: "/sbin", file name length: "0x00000006", file size: "0x00000000"
843004        0xCDCFC         ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/config.sh", file name length: "0x00000010", file size: "0x00001943"
849600        0xCF6C0         ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/mdev", file name length: "0x0000000B", file size: "0x0000000F"
849740        0xCF74C         ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/rmmod", file name length: "0x0000000C", file size: "0x0000000F"
849880        0xCF7D8         ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/wan.sh", file name length: "0x0000000D", file size: "0x00000459"
851120        0xCFCB0         ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/start.sh", file name length: "0x0000000F", file size: "0x00000804"
853300        0xD0534         ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/ifconfig", file name length: "0x0000000F", file size: "0x0000000F"
853444        0xD05C4         ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/video_ko.sh", file name length: "0x00000012", file size: "0x00000412"
854616        0xD0A58         ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/dhcp6s", file name length: "0x0000000D", file size: "0x000213C0"
990868        0xF1E94         ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/lsmod", file name length: "0x0000000C", file size: "0x0000000F"
991008        0xF1F20         ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/config_save.sh", file name length: "0x00000015", file size: "0x000004BB"
992352        0xF2460         ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/dhcp6c", file name length: "0x0000000D", file size: "0x00032418"
1198324       0x1248F4        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/wifi_ap.sh", file name length: "0x00000011", file size: "0x000009E1"
1200984       0x125358        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/vconfig", file name length: "0x0000000E", file size: "0x0000000F"
1201124       0x1253E4        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/syslogd", file name length: "0x0000000E", file size: "0x0000000F"
1201264       0x125470        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/insmod", file name length: "0x0000000D", file size: "0x0000000F"
1201404       0x1254FC        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/runapp.sh", file name length: "0x00000010", file size: "0x000000EE"
1201772       0x12566C        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/reboot", file name length: "0x0000000D", file size: "0x0000000F"
1201912       0x1256F8        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/fdisk", file name length: "0x0000000C", file size: "0x0000000F"
1202052       0x125784        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/init", file name length: "0x0000000B", file size: "0x0000000F"
1202192       0x125810        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/klogd", file name length: "0x0000000C", file size: "0x0000000F"
1202332       0x12589C        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/logread", file name length: "0x0000000E", file size: "0x0000000F"
1202472       0x125928        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/halt", file name length: "0x0000000B", file size: "0x0000000F"
1202612       0x1259B4        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/wifi_nuotai.sh", file name length: "0x00000015", file size: "0x00000A08"
1205312       0x126440        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/poweroff", file name length: "0x0000000F", file size: "0x0000000F"
1205456       0x1264D0        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/chpasswd.sh", file name length: "0x00000012", file size: "0x00000169"
1205948       0x1266BC        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/route", file name length: "0x0000000C", file size: "0x0000000F"
1206088       0x126748        ASCII cpio archive (SVR4 with no CRC), file name: "/sbin/udhcpc", file name length: "0x0000000D", file size: "0x0000000F"
1206228       0x1267D4        ASCII cpio archive (SVR4 with no CRC), file name: "/media", file name length: "0x00000007", file size: "0x00000000"
1206348       0x12684C        ASCII cpio archive (SVR4 with no CRC), file name: "/home", file name length: "0x00000006", file size: "0x00000000"
1206464       0x1268C0        ASCII cpio archive (SVR4 with no CRC), file name: "/proc", file name length: "0x00000006", file size: "0x00000000"
1206580       0x126934        ASCII cpio archive (SVR4 with no CRC), file name: "/usr", file name length: "0x00000005", file size: "0x00000000"
1206696       0x1269A8        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin", file name length: "0x00000009", file size: "0x00000000"
1206816       0x126A20        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/expr", file name length: "0x0000000E", file size: "0x00000012"
1206960       0x126AB0        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/find", file name length: "0x0000000E", file size: "0x00000012"
1207104       0x126B40        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/tftp", file name length: "0x0000000E", file size: "0x00000012"
1207248       0x126BD0        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/printf", file name length: "0x00000010", file size: "0x00000012"
1207396       0x126C64        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/time", file name length: "0x0000000E", file size: "0x00000012"
1207540       0x126CF4        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/[", file name length: "0x0000000B", file size: "0x00000012"
1207684       0x126D84        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/logger", file name length: "0x00000010", file size: "0x00000012"
1207832       0x126E18        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/test", file name length: "0x0000000E", file size: "0x00000012"
1207976       0x126EA8        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/basename", file name length: "0x00000012", file size: "0x00000012"
1208124       0x126F3C        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/tr", file name length: "0x0000000C", file size: "0x00000012"
1208268       0x126FCC        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/[[", file name length: "0x0000000C", file size: "0x00000012"
1208412       0x12705C        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/killall", file name length: "0x00000011", file size: "0x00000012"
1208560       0x1270F0        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/uptime", file name length: "0x00000010", file size: "0x00000012"
1208708       0x127184        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/wc", file name length: "0x0000000C", file size: "0x00000012"
1208852       0x127214        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/free", file name length: "0x0000000E", file size: "0x00000012"
1208996       0x1272A4        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/bin/top", file name length: "0x0000000D", file size: "0x00000012"
1209140       0x127334        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/sbin", file name length: "0x0000000A", file size: "0x00000000"
1209260       0x1273AC        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/sbin/brctl", file name length: "0x00000010", file size: "0x00000012"
1209408       0x127440        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/sbin/udhcpd", file name length: "0x00000011", file size: "0x00000012"
1209556       0x1274D4        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/sbin/chpasswd", file name length: "0x00000013", file size: "0x00000012"
1209708       0x12756C        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/sbin/telnetd", file name length: "0x00000012", file size: "0x00000012"
1209856       0x127600        ASCII cpio archive (SVR4 with no CRC), file name: "/usr/codepages", file name length: "0x0000000F", file size: "0x00000000"
1209984       0x127680        ASCII cpio archive (SVR4 with no CRC), file name: "/sys", file name length: "0x00000005", file size: "0x00000000"
1210100       0x1276F4        ASCII cpio archive (SVR4 with no CRC), file name: "/etc", file name length: "0x00000005", file size: "0x00000000"
1210216       0x127768        ASCII cpio archive (SVR4 with no CRC), file name: "/etc/motd", file name length: "0x0000000A", file size: "0x00000011"
1210356       0x1277F4        ASCII cpio archive (SVR4 with no CRC), file name: "/etc/fstab", file name length: "0x0000000B", file size: "0x000001A8"
1210904       0x127A18        ASCII cpio archive (SVR4 with no CRC), file name: "/var", file name length: "0x00000005", file size: "0x00000000"
1211020       0x127A8C        ASCII cpio archive (SVR4 with no CRC), file name: "/mnt", file name length: "0x00000005", file size: "0x00000000"
1211136       0x127B00        ASCII cpio archive (SVR4 with no CRC), file name: "/init", file name length: "0x00000006", file size: "0x0000000C"
1211264       0x127B80        ASCII cpio archive (SVR4 with no CRC), file name: "/lib", file name length: "0x00000005", file size: "0x00000000"
1211380       0x127BF4        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libnvram.so.0", file name length: "0x00000013", file size: "0x00000013"
1211532       0x127C8C        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libpthread.so.0", file name length: "0x00000015", file size: "0x00000015"
1211688       0x127D28        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libm.so", file name length: "0x0000000D", file size: "0x0000000F"
1211828       0x127DB4        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libuClibc-0.9.28.so", file name length: "0x00000019", file size: "0x0005F634"
1602672       0x187470        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libcrypt.so", file name length: "0x00000011", file size: "0x00000013"
1602820       0x187504        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/modules", file name length: "0x0000000D", file size: "0x00000000"
1602944       0x187580        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/modules/2.6.21", file name length: "0x00000014", file size: "0x00000000"
1603076       0x187604        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/modules/2.6.21/kernel", file name length: "0x0000001B", file size: "0x00000000"
1603216       0x187690        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/modules/2.6.21/kernel/drivers", file name length: "0x00000023", file size: "0x00000000"
1603364       0x187724        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/modules/2.6.21/kernel/drivers/media", file name length: "0x00000029", file size: "0x00000000"
1603516       0x1877BC        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/modules/2.6.21/kernel/drivers/media/video", file name length: "0x0000002F", file size: "0x00000000"
1603676       0x18785C        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/modules/2.6.21/kernel/drivers/media/video/videodev.ko", file name length: "0x0000003B", file size: "0x00009718"
1642528       0x191020        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/modules/2.6.21/kernel/drivers/media/video/uvc", file name length: "0x00000033", file size: "0x00000000"
1642692       0x1910C4        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/modules/2.6.21/kernel/drivers/media/video/uvc/uvcvideo.ko", file name length: "0x0000003F", file size: "0x000151E4"
1729368       0x1A6358        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/modules/2.6.21/kernel/drivers/media/video/compat_ioctl32.ko", file name length: "0x00000041", file size: "0x00000660"
1731176       0x1A6A68        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/modules/2.6.21/kernel/drivers/media/video/v4l1-compat.ko", file name length: "0x0000003E", file size: "0x00004ADC"
1750512       0x1AB5F0        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/modules/2.6.21/kernel/drivers/media/video/v4l2-common.ko", file name length: "0x0000003E", file size: "0x000054D0"
1772396       0x1B0B6C        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libcrypt.so.0", file name length: "0x00000013", file size: "0x00000013"
1772548       0x1B0C04        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libm-0.9.28.so", file name length: "0x00000014", file size: "0x00007848"
1803472       0x1B84D0        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libc.so.0", file name length: "0x0000000F", file size: "0x00000014"
1803620       0x1B8564        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libc.so", file name length: "0x0000000D", file size: "0x00000014"
1803764       0x1B85F4        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libpthread-0.9.28.so", file name length: "0x0000001A", file size: "0x00017BBC"
1901112       0x1D0238        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libutil.so.0", file name length: "0x00000012", file size: "0x00000012"
1901260       0x1D02CC        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libpthread.so", file name length: "0x00000013", file size: "0x00000015"
1901416       0x1D0368        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/ld-uClibc.so.0", file name length: "0x00000014", file size: "0x00000014"
1901568       0x1D0400        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libusb.so.1.0.0", file name length: "0x00000015", file size: "0x0000D248"
1955532       0x1DD6CC        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libdl-0.9.28.so", file name length: "0x00000015", file size: "0x000024A0"
1965040       0x1DFBF0        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libnvram-0.9.28.so", file name length: "0x00000018", file size: "0x00008524"
1999260       0x1E819C        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libcrypt-0.9.28.so", file name length: "0x00000018", file size: "0x000034D8"
2012924       0x1EB6FC        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libdl.so", file name length: "0x0000000E", file size: "0x00000010"
2013064       0x1EB788        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libutil-0.9.28.so", file name length: "0x00000017", file size: "0x000013A8"
2018232       0x1ECBB8        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libdl.so.0", file name length: "0x00000010", file size: "0x00000010"
2018376       0x1ECC48        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libutil.so", file name length: "0x00000010", file size: "0x00000012"
2018524       0x1ECCDC        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/ipsec", file name length: "0x0000000B", file size: "0x00000000"
2018648       0x1ECD58        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libm.so.0", file name length: "0x0000000F", file size: "0x0000000F"
2018792       0x1ECDE8        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/ld-uClibc-0.9.28.so", file name length: "0x00000019", file size: "0x00006790"
2045440       0x1F3600        ASCII cpio archive (SVR4 with no CRC), file name: "/lib/libnvram.so", file name length: "0x00000011", file size: "0x00000013"
2045588       0x1F3694        ASCII cpio archive (SVR4 with no CRC), file name: "/tmp", file name length: "0x00000005", file size: "0x00000000"
2045704       0x1F3708        ASCII cpio archive (SVR4 with no CRC), file name: "/etc_ro", file name length: "0x00000008", file size: "0x00000000"
2045824       0x1F3780        ASCII cpio archive (SVR4 with no CRC), file name: "/etc_ro/web", file name length: "0x0000000C", file size: "0x00000000"
2045948       0x1F37FC        ASCII cpio archive (SVR4 with no CRC), file name: "/etc_ro/Wireless", file name length: "0x00000011", file size: "0x00000000"
2046076       0x1F387C        ASCII cpio archive (SVR4 with no CRC), file name: "/etc_ro/Wireless/RT2860AP", file name length: "0x0000001A", file size: "0x00000000"
2046212       0x1F3904        ASCII cpio archive (SVR4 with no CRC), file name: "/etc_ro/Wireless/RT2860AP/RT2860_default_novlan", file name length: "0x00000030", file size: "0x00000C07"
2049452       0x1F45AC        ASCII cpio archive (SVR4 with no CRC), file name: "/etc_ro/Wireless/RT2860AP/RT2860_default_vlan", file name length: "0x0000002E", file size: "0x00000B25"
2052464       0x1F5170        ASCII cpio archive (SVR4 with no CRC), file name: "/etc_ro/dhcp6c.conf", file name length: "0x00000014", file size: "0x00000070"
2052708       0x1F5264        ASCII cpio archive (SVR4 with no CRC), file name: "/etc_ro/wlan", file name length: "0x0000000D", file size: "0x00000000"
2052832       0x1F52E0        ASCII cpio archive (SVR4 with no CRC), file name: "/etc_ro/wlan/LEWEIAP_Password.dat", file name length: "0x00000022", file size: "0x00000E1F"
2056592       0x1F6190        ASCII cpio archive (SVR4 with no CRC), file name: "/etc_ro/wlan/RT5350_AP_1T1R_V1_0.bin", file name length: "0x00000025", file size: "0x00000200"
2057252       0x1F6424        ASCII cpio archive (SVR4 with no CRC), file name: "/etc_ro/dhcp6s.conf", file name length: "0x00000014", file size: "0x0000014A"
2057716       0x1F65F4        ASCII cpio archive (SVR4 with no CRC), file name: "/etc_ro/inittab", file name length: "0x00000010", file size: "0x0000002D"
2057892       0x1F66A4        ASCII cpio archive (SVR4 with no CRC), file name: "/etc_ro/rcS", file name length: "0x0000000C", file size: "0x000002C6"
2058728       0x1F69E8        ASCII cpio archive (SVR4 with no CRC), file name: "TRAILER!!!", file name length: "0x0000000B", file size: "0x00000000"
```

The recursive extraction results in a file structure as follows:

```console
$ tree _W25Q32_endoscope_merged.eeprom.extracted/
_W25Q32_endoscope_merged.eeprom.extracted/
├── 50040
├── 50040.7z
└── _50040.extracted
    ├── 341000
    ├── 341000.7z
    └── _341000.extracted
        ├── 0.cpio
        └── cpio-root

3 directories, 5 files
```

Most of `binwalk`'s output comes from analysis of a [cpio
archive](https://en.wikipedia.org/wiki/Cpio) with the archive's contents left
unextracted.  To make individual files available for further analysis by
specialized tools, we'll need to extract them from `0.cpio`.  Two files
in the `/bin` folder (`app_cam` and `app_detect`) aren't present on
in typical Linux installations, making them look particularly interesting.  I'd
like to extract those quickly and easily.

The obvious first tool to try is `cpio`, but it's a poor choice.  It obeys
absolute paths, making it attempt to extract files to privileged locations:

```console
$ cpio -i <0.cpio
/bin/rm: Can't create '/bin/rm'
/bin/iwpriv: Can't create '/bin/iwpriv'
/bin/busybox: Can't create '/bin/busybox'
/bin/ralink_init: Can't create '/bin/ralink_init'
...
```

The `bsdtar` program (which is also just `tar` on macOS) is a better choice.
It can understand `cpio` archives and ignores absolute paths by default.  This
behavior is documented in the man page under the `-P` option:
```
By default, absolute pathnames (those that begin with a / character) have the
leading slash removed both when creating archives and extracting from them.
Also, tar will refuse to extract archive entries whose pathnames contain .. or
whose target directory would be altered by a symlink.
 ```

Listing the archive's contents is straightforward.  Note that absolute paths
are listed but will be ignored during extraction:
```console
$ cat 0.cpio | bsdtar -t
```
Alternatively, without risking a [useless use of cat
award](http://porkmail.org/era/unix/award.html):
```console
$ <0.cpio bsdtar -t
```

Extraction is also straightforward.  Note that the command fails to extract
certain device files, which is fine for our purposes.  The `binwalk` output has
shown that they are zero-length, so they can't contain any interesting
information:
```console
$ <0.cpio bsdtar -xkvv
bsdtar: Removing leading '/' from member names
x bin
x bin/rm
x bin/iwpriv
...
x dev
x dev/spiS0: Can't create 'dev/spiS0'
x dev/ac0: Can't create 'dev/ac0'
x dev/mtdblock2: Can't create 'dev/mtdblock2'
...
x etc_ro/dhcp6s.conf
x etc_ro/inittab
x etc_ro/rcS
bsdtar: Error exit delayed from previous errors.
```

At this point, interesting files in `/bin` are available for further analysis
in MIPS disassemblers or decompilers:

```console
$ ls -l bin/app_*
-rwxr-xr-x  1 mplough  staff  115888 Jul 30  2017 bin/app_cam
-rwxr-xr-x  1 mplough  staff    9884 Apr 25  2017 bin/app_detect
```
