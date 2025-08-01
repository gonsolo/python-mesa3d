VERSION=0.1.0
WHEEL=dist/python_mesa3d-$(VERSION)-cp313-cp313-linux_x86_64.whl
PACKAGE=python-mesa3d-$(VERSION)-1-x86_64.pkg.tar.zst

all: install
	python test.py
install: build
	makepkg -si --noconfirm
build: $(PACKAGE)
$(PACKAGE): $(WHEEL)
	cp $(WHEEL) .
	updpkgsums
	makepkg -f
$(WHEEL): bindings.cpp
	python -m build --wheel
clean:
	rm -rf dist pkg src *.zst *.whl
	yay -R python-mesa3d

.PHONY: all build install clean
