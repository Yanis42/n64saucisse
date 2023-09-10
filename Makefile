# Project Settings
BUILD_DIR = build
include $(N64_INST)/include/n64.mk

N64_ROM_TITLE = "Saucisse"
SOURCE_DIR = src
C_FILES := $(foreach dir,$(SOURCE_DIR),$(wildcard $(dir)/*.c))
PNG_FILES := $(foreach dir,assets,$(wildcard $(dir)/*.png))
OBJS = $(C_FILES:%.c=$(BUILD_DIR)/%.o)
DEPS = $(C_FILES:%.c=$(BUILD_DIR)/%.d)

# Files
ROM := saucisse.z64
DFS := $(ROM:.z64=.dfs)
ELF := $(ROM:.z64=.elf)

# Tools
MKSPRITE := $(N64_ROOTDIR)/bin/mksprite

# Create build directory
$(shell mkdir -p $(foreach dir,$(SOURCE_DIR),build/$(dir)))

# Targets
all: $(ROM)

clean:
	rm -rf $(BUILD_DIR) *.z64 *.sprite

run: $(ROM)
	$(ARES) $<

format:
	clang-format-14 -i $(C_FILES)

.PHONY: all clean run format

# Build
$(ROM): $(BUILD_DIR)/$(DFS)

$(BUILD_DIR)/$(DFS): $(wildcard assets/*)
	$(MKSPRITE) -o assets/ -c 0 -f RGBA32 $(PNG_FILES)
	$(N64_MKDFS) $@ assets

$(BUILD_DIR)/$(ELF): $(OBJS)

-include $(DEPS)
