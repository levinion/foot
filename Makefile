PKGDIR ?= /

install: build
	cd foot && \
	sudo DESTDIR="${PKGDIR}" ninja -C build install && \
	sudo install -Dm 644 LICENSE "${pkgdir}/usr/share/licenses/foot/LICENSE"

patch: foot
	cd foot && git apply -v ../foot.patch

clean:
	rm -rf foot build

.PHONY: patch install clean

build: patch
	cd foot && ./pgo/pgo.sh auto . ./build

foot:
	git clone "https://codeberg.org/dnkl/foot"
