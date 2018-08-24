# Installation of basic build dependencies
## Debian / Ubuntu
#git submodule update --init --recursive
sudo apt-get install --no-install-recommends gettext build-essential autoconf libtool libpcre3-dev asciidoc xmlto libev-dev libc-ares-dev automake libmbedtls-dev libsodium-dev
## CentOS / Fedora / RHEL
#sudo yum install gettext gcc autoconf libtool automake make asciidoc xmlto c-ares-devel libev-devel
## Arch
#sudo pacman -S gettext gcc autoconf libtool automake make asciidoc xmlto c-ares libev

# Installation of Libsodium
apt-get purge libsodium-dev
export LIBSODIUM_VER=1.0.14
export LIBSODIUM_FILE_NAME=libsodium-$LIBSODIUM_VER.tar.gz

if [ ! -f $LIBSODIUM_FILE_NAME ];then
    echo "File not exists, now downloading!"
    wget https://download.libsodium.org/libsodium/releases/$LIBSODIUM_FILE_NAME
else
    echo "File already exists!"
fi

tar xvf libsodium-$LIBSODIUM_VER.tar.gz
pushd libsodium-$LIBSODIUM_VER
./configure --prefix=/usr && make
sudo make install
popd
sudo ldconfig

# Installation of MbedTLS
export MBEDTLS_VER=2.6.0
export MBEDTLS_FILE_NAME=mbedtls-$MBEDTLS_VER-gpl.tgz

if [ ! -f $MBEDTLS_FILE_NAME ];then
    echo "File not existing, now downloading!"
    wget https://tls.mbed.org/download/$MBEDTLS_FILE_NAME
else
    echo "File already existing, skip!"
fi

tar xvf mbedtls-$MBEDTLS_VER-gpl.tgz
pushd mbedtls-$MBEDTLS_VER
make SHARED=1 CFLAGS=-fPIC
sudo make DESTDIR=/usr install
popd
sudo ldconfig

# Start building
./autogen.sh && ./configure && make
