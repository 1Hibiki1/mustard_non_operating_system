# Makefile for compiling the bootloader and second_stage

# Path to the source directory
SRC_DIR := src

# Temporary directory for object files
OBJ_DIR := obj

# Create the OBJ_DIR if it doesn't exist
$(shell mkdir -p $(OBJ_DIR))

# Ensure that "boot.asm" is placed first in the list
ASM_SOURCES := $(SRC_DIR)/BOOT.ASM $(SRC_DIR)/KERN.ASM

# List of object files generated from assembly source files
OBJ_FILES := $(patsubst $(SRC_DIR)/%.ASM,$(OBJ_DIR)/%.bin,$(ASM_SOURCES))

# Target output file (bootable image)
OUTPUT_FILE := bootable_image.bin

# Default rule to build the bootable image
all: $(OUTPUT_FILE)

# Rule to compile assembly source files to flat binary files in the OBJ_DIR
$(OBJ_DIR)/%.bin: $(SRC_DIR)/%.ASM
	nasm -f bin -i $(SRC_DIR) $< -o $@

# Rule to link object files into the bootable image
$(OUTPUT_FILE): $(OBJ_FILES)
	cat $^ > $(OUTPUT_FILE)

# Rule to clean up generated files and the temporary directory
clean:
	rm -rf $(OBJ_DIR) $(OUTPUT_FILE)

# Rule to run the bootable image in QEMU
run: $(OUTPUT_FILE)
	qemu-system-i386 -drive format=raw,file=$(OUTPUT_FILE)
