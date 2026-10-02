# Third-Party Notices

The `windows/` folder contains a Windows build of **ipmitool** compiled with **Cygwin**, plus the Cygwin runtime libraries it needs.
These components are **not** written by this repository's author and keep their own licenses:

| Component | Files | License (see upstream for exact terms) |
|-----------|-------|-----------------------------------------|
| ipmitool | `ipmitool.exe`, `ipmievd.exe` | BSD-style license (https://github.com/ipmitool/ipmitool) |
| Cygwin runtime | `cygwin1.dll` | LGPL (https://cygwin.com, source available there) |
| OpenSSL | `cygcrypto-1_0_0.dll` | OpenSSL/SSLeay license (https://www.openssl.org) |
| GNU Readline | `cygreadline7.dll` | GPL (https://www.gnu.org/software/readline/) |
| ncurses | `cygncursesw-10.dll` | MIT-style (https://invisible-island.net/ncurses/) |
| zlib | `cygz.dll` | zlib license (https://zlib.net) |

The repository's own scripts, documentation and lab page are released under the repository license (GPL-3.0).
