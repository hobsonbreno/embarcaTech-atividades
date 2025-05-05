set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Compiladores
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)
set(CMAKE_AR arm-none-eabi-ar)

# Flags essenciais
set(CMAKE_C_FLAGS "-mcpu=cortex-m0plus -mthumb -Os -ffunction-sections -fdata-sections" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -fno-exceptions -fno-rtti" CACHE INTERNAL "")
set(CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS}" CACHE INTERNAL "")

# Configurações de linking
set(CMAKE_EXE_LINKER_FLAGS "-Wl,--gc-sections -Wl,-Map=freertos_pico.map -nostdlib" CACHE INTERNAL "")

# Desativa testes desnecessários
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Configurações específicas para C++
set(CMAKE_CXX_COMPILE_OBJECT "<CMAKE_CXX_COMPILER> <DEFINES> <INCLUDES> <FLAGS> -o <OBJECT> -c <SOURCE>")
set(CMAKE_CXX_LINK_EXECUTABLE "<CMAKE_CXX_COMPILER> <FLAGS> <CMAKE_CXX_LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_FLAGS> <LINK_LIBRARIES>")
