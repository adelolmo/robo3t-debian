# Robo3T Debian Package

Find the original Robo3T releases in here: https://github.com/Studio3T/robomongo/releases

## How to build

    apt-get install fakeroot
    make VERSION=1.4.3 TAR_URL=https://github.com/Studio3T/robomongo/releases/download/v1.4.3/robo3t-1.4.3-linux-x86_64-48f7dfd.tar.gz
    
## How to install

    dpkg -i build/release/robo3t_1.4.3_amd64.deb
