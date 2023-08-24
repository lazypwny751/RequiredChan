PREFIX := /usr
SRCDIR := $(PREFIX)/share/RequiredChan
BINDIR := $(PREFIX)/bin
EXECUT := $(BINDIR)/reqchan

define setup
	mkdir -p $(SRCDIR) $(SRCDIR)/lib $(BINDIR)
	install lib/* $(SRCDIR)/lib
	install -m 755 src/reqchan.sh $(EXECUT)
endef

define remove
	rm -rf $(SRCDIR) $(EXECUT)
endef

install:
	@$(setup)
	@echo "installed.."

uninstall:
	@$(remove)
	@echo "uninstalled.."

reinstall:
	@$(remove)
	@$(setup)
	@echo "reinstalled.."