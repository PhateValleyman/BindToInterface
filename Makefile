# Makefile for BindToInterface - Android SO Builder
# Color Definitions
RED    := \033[0;31m
GREEN  := \033[0;32m
YELLOW := \033[0;33m
BLUE   := \033[0;34m
CYAN   := \033[0;36m
NC     := \033[0m

# Compiler Configuration
CC      ?= gcc
CFLAGS  ?= -fpic -D_GNU_SOURCE
LDFLAGS ?= -shared -nostartfiles -ldl
TARGET   = bindToInterface.so

.PHONY: all legacy clean help

# Default build for modern Android (Android 6+)
all: $(TARGET)
	@echo -e "$(GREEN)Modern build complete! Use for Android 6.0+$(NC)"

# Legacy build for older Android (Android 5.x and below)
legacy: LDFLAGS += -Wl,--hash-style=sysv
legacy: $(TARGET)
	@echo -e "$(YELLOW)Legacy build complete! Use for Android 5.x and below$(NC)"

$(TARGET): bindToInterface.c
	@echo -e "$(CYAN)Building $@ with:$(NC)"
	@echo -e "  $(YELLOW)CC$(NC)      = $(CC)"
	@echo -e "  $(YELLOW)CFLAGS$(NC)  = $(CFLAGS)"
	@echo -e "  $(YELLOW)LDFLAGS$(NC) = $(LDFLAGS)"
	$(CC) $(CFLAGS) $< $(LDFLAGS) -o $@
	@echo -e "$(GREEN)Successfully built $@$(NC)"

clean:
	@rm -f $(TARGET)
	@echo -e "$(RED)Cleaned build artifacts$(NC)"

help:
	@echo -e "$(BLUE)BindToInterface Makefile Help$(NC)"
	@echo -e "$(GREEN)Usage: make [target] [options]$(NC)"
	@echo -e "\n$(YELLOW)Targets:$(NC)"
	@echo -e "  $(CYAN)all$(NC)     - Build for modern Android (Android 6.0+, default)"
	@echo -e "  $(CYAN)legacy$(NC)  - Build for legacy Android (Android 5.x and below)"
	@echo -e "  $(CYAN)clean$(NC)   - Remove build artifacts"
	@echo -e "  $(CYAN)help$(NC)    - Show this help message"
	@echo -e "\n$(YELLOW)Customizable Variables$(NC) (override with VAR=value):"
	@echo -e "  $(CYAN)CC$(NC)      - C compiler (default: gcc)"
	@echo -e "  $(CYAN)CFLAGS$(NC)  - Compiler flags (default: -fpic -D_GNU_SOURCE)"
	@echo -e "  $(CYAN)LDFLAGS$(NC) - Linker flags (default: -shared -nostartfiles -ldl)"
	@echo -e "\n$(YELLOW)Examples:$(NC)"
	@echo -e "  $(CYAN)Default build$(NC): make"
	@echo -e "  $(CYAN)Legacy build$(NC): make legacy"
	@echo -e "  $(CYAN)Custom compiler$(NC): make CC=clang"
	@echo -e "  $(CYAN)Optimized build$(NC): make CFLAGS=\"-fpic -D_GNU_SOURCE -O3\""
	@echo -e "  $(CYAN)Debug build$(NC): make CFLAGS=\"-fpic -D_GNU_SOURCE -g\""
	@echo -e "\n$(RED)Note:$(NC) Use legacy target for Android 5.x devices to fix linker warnings"
