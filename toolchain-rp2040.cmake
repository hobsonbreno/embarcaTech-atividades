# Definir o sistema e processador
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR cortex-m0plus)

# Definir os compiladores para o arm-none-eabi
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)

# Flags para o compilador C e C++
set(CMAKE_C_FLAGS "-mcpu=cortex-m0plus -mthumb -ffreestanding -nostdlib")
set(CMAKE_CXX_FLAGS "-mcpu=cortex-m0plus -mthumb -ffreestanding -nostdlib")

# Flags para o linker
set(CMAKE_EXE_LINKER_FLAGS "-nostartfiles -Wl,--gc-sections -T${CMAKE_SOURCE_DIR}/src/rp2_common/pico_crt0/rp2040/memmap_default.ld")

# Impede a ligação com a biblioteca C padrão
set(CMAKE_C_STANDARD_LIBRARIES "")
set(CMAKE_CXX_STANDARD_LIBRARIES "")

# Definir tipo de compilação para criar uma biblioteca estática (no caso de tentativas de compilação de teste)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
