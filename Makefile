PKGDIR ?= /

install: build
	cd foot && \
	sudo DESTDIR="${PKGDIR}" ninja -C build install && \
	sudo install -Dm 644 LICENSE "${pkgdir}/usr/share/licenses/foot/LICENSE"

patch: foot
	cd foot && git apply -v ../foot.patch

clean:
	rm -rf foot build

update:
	${MAKE} clean
	${MAKE} install

version: foot
	@cd foot &&\
  git describe --tags --long | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g'

.PHONY: patch install clean update version

build: patch
	cd foot && ./pgo/pgo.sh auto . ./build

foot:
	git clone "https://codeberg.org/dnkl/foot"
