# Makefile for BindToInterface - Android SO Builder
# Color Definitions (using printf for better portability)
RED    := \033[0;31m
GREEN  := \033[0;32m
YELLOW := \033[0;33m
BLUE   := \033[0;34m
CYAN   := \033[0;36m
NC     := \033[0m

# Default target is help
.DEFAULT_GOAL := help

# Compiler Configuration
CC      ?= gcc
CFLAGS  ?= -fpic -D_GNU_SOURCE
LDFLAGS ?= -shared -nostartfiles -ldl
TARGET   = bindToInterface.so

.PHONY: all old clean help

# Show help by default
help:
	@printf "$(BLUE)BindToInterface Makefile Help$(NC)\n"
	@printf "$(GREEN)Usage: make [target] [options]$(NC)\n\n"
	@printf "$(YELLOW)Targets:$(NC)\n"
	@printf "  $(CYAN)all$(NC)     - Build for modern Android (Android 6.0+)\n"
	@printf "  $(CYAN)old$(NC)  - Build for old Android (Android 5.x and below)\n"
	@printf "  $(CYAN)clean$(NC)   - Remove build artifacts\n"
	@printf "  $(CYAN)help$(NC)    - Show this help message (default)\n\n"
	@printf "$(YELLOW)Customizable Variables$(NC) (override with VAR=value):\n"
	@printf "  $(CYAN)CC$(NC)      - C compiler (default: gcc)\n"
	@printf "  $(CYAN)CFLAGS$(NC)  - Compiler flags (default: -fpic -D_GNU_SOURCE)\n"
	@printf "  $(CYAN)LDFLAGS$(NC) - Linker flags (default: -shared -nostartfiles -ldl)\n\n"
	@printf "$(YELLOW)Examples:$(NC)\n"
	@printf "  $(CYAN)Modern build$(NC): make all\n"
	@printf "  $(CYAN)Old build$(NC): make old\n"
	@printf "  $(CYAN)Custom compiler$(NC): make all CC=clang\n"
	@printf "  $(CYAN)Optimized build$(NC): make all CFLAGS=\"-fpic -D_GNU_SOURCE -O3\"\n"
	@printf "  $(CYAN)Debug build$(NC): make all CFLAGS=\"-fpic -D_GNU_SOURCE -g\"\n\n"
	@printf "$(RED)Note:$(NC) Use old target for Android 5.x devices to fix linker warnings\n"

# Build for modern Android (Android 6+)
all: $(TARGET)
	@printf "$(GREEN)Modern build complete! Use for Android 6.0+$(NC)\n"

# Old build for older Android (Android 5.x and below)
old: LDFLAGS += -Wl,--hash-style=sysv
old: $(TARGET)
	@printf "$(YELLOW)Old build complete! Use for Android 5.x and below$(NC)\n"

$(TARGET): bindToInterface.c
	@printf "$(CYAN)Building $@ with:$(NC)\n"
	@printf "  $(YELLOW)CC$(NC)      = $(CC)\n"
	@printf "  $(YELLOW)CFLAGS$(NC)  = $(CFLAGS)\n"
	@printf "  $(YELLOW)LDFLAGS$(NC) = $(LDFLAGS)\n"
	$(CC) $(CFLAGS) $< $(LDFLAGS) -o $@
	@printf "$(GREEN)Successfully built $@$(NC)\n"

clean:
	@rm -f $(TARGET)
	@printf "$(RED)Cleaned build artifacts$(NC)\n"
