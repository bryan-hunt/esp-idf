#
# Component Makefile
#
COMPONENT_SUBMODULES += cryptoauthlib

CRYPTOAUTHLIB_DIR := cryptoauthlib/lib

COMPONENT_SRCDIRS := $(CRYPTOAUTHLIB_DIR)/atcacert \
                     $(CRYPTOAUTHLIB_DIR)/basic \
                     $(CRYPTOAUTHLIB_DIR)/crypto \
                     $(CRYPTOAUTHLIB_DIR)/crypto/hashes \
                     $(CRYPTOAUTHLIB_DIR)/host \
                     $(CRYPTOAUTHLIB_DIR)/mbedtls \
                     $(CRYPTOAUTHLIB_DIR)

COMPONENT_OBJS := $(foreach compsrcdir,$(COMPONENT_SRCDIRS),$(patsubst %.c,%.o,$(wildcard $(COMPONENT_PATH)/$(compsrcdir)/*.c))) \
                  $(CRYPTOAUTHLIB_DIR)/hal/atca_hal.o \
                  $(CRYPTOAUTHLIB_DIR)/hal/hal_freertos.o \
                  $(CRYPTOAUTHLIB_DIR)/hal/hal_esp32_i2c.o \
                  $(CRYPTOAUTHLIB_DIR)/hal/hal_esp32_timer.o

# Make relative by removing COMPONENT_PATH from all found object paths
COMPONENT_OBJS := $(patsubst $(COMPONENT_PATH)/%,%,$(COMPONENT_OBJS))

COMPONENT_ADD_INCLUDEDIRS := $(CRYPTOAUTHLIB_DIR) $(CRYPTOAUTHLIB_DIR)/hal 

CFLAGS+=-DESP32 -DATCA_HAL_I2C -DATCA_USE_RTOS_TIMER

$(CRYPTOAUTHLIB_DIR)/hal/hal_freertos.o: CFLAGS+= -I$(IDF_PATH)/components/freertos/include/freertos
