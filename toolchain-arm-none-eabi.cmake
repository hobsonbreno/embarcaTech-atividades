# Toolchain para Raspberry Pi Pico utilizando o compilador ARM
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Definindo os compiladores
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)

# Flags de compilação básicas para Cortex-M0+
set(CMAKE_C_FLAGS_INIT "-mcpu=cortex-m0plus -mthumb -nostartfiles")
set(CMAKE_CXX_FLAGS_INIT "-mcpu=cortex-m0plus -mthumb -nostartfiles")
set(CMAKE_ASM_FLAGS_INIT "-mcpu=cortex-m0plus -mthumb")

# Flags de link
set(CMAKE_EXE_LINKER_FLAGS_INIT "-mcpu=cortex-m0plus -mthumb -nostartfiles")

# Evita testes de compilação usando executáveis (sem sistema operacional)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

