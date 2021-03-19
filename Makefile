MAKEFLAGS += --silent

BUILD_DIR = build
RELEASE_DIR = $(BUILD_DIR)/release
TMP_DIR = $(BUILD_DIR)/tmp
TAR_FILE = robo3t-$(VERSION).tar.gz
TAR_PATH = $(BUILD_DIR)/$(TAR_FILE)

VERSION = 1.4.3
TAR_URL = https://github.com/Studio3T/robomongo/releases/download/v1.4.3/robo3t-1.4.3-linux-x86_64-48f7dfd.tar.gz

package: clean prepare $(TAR_PATH) cp control
	@echo Building package...
	fakeroot dpkg-deb -b -z9 $(TMP_DIR) $(RELEASE_DIR)/robo3t_$(VERSION)_amd64.deb

clean:
	rm -rf $(TMP_DIR) $(RELEASE_DIR)

prepare:
	mkdir -p $(RELEASE_DIR) $(TMP_DIR)/opt/robo3t

$(TAR_PATH):
	@echo Downloading tar ball...
	wget --quiet -O $(TAR_PATH) $(TAR_URL)

cp:
	cp -R deb/* $(TMP_DIR)
	cp $(TAR_PATH) $(TMP_DIR)/opt/robo3t/
	tar zxf $(TAR_PATH) --strip=1 --directory=$(TMP_DIR)/opt/robo3t
	rm -rf $(TMP_DIR)/opt/robo3t/$(TAR_FILE)

control:
	$(eval SIZE=$(shell du -sbk $(TMP_DIR)/ | grep -o '[0-9]*'))
	sed -i "s/{{version}}/$(VERSION)/;s/{{size}}/$(SIZE)/" $(TMP_DIR)/DEBIAN/control
	sed -i "s/{{version}}/$(VERSION)/;s/{{size}}/$(SIZE)/" $(TMP_DIR)/usr/share/applications/robo3t.desktop
