# Definindo o sistema e processador alvo
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Caminho do SDK do Raspberry Pi Pico
set(PICO_SDK_PATH "/home/hobson007breno/projetos_embarcados/pico-sdk")

# Verifique se o SDK está sendo encontrado corretamente
message(STATUS "PICO_SDK_PATH: ${PICO_SDK_PATH}")

# Incluir o SDK do Raspberry Pi Pico
include(${PICO_SDK_PATH}/external/pico_sdk_import.cmake)

# Verifique se o SDK está sendo encontrado corretamente
message(STATUS "PICO_SDK_PATH: ${PICO_SDK_PATH}")

# Verifique se o arquivo realmente existe
if (NOT EXISTS "${PICO_SDK_PATH}/external/pico_sdk_import.cmake")
    message(FATAL_ERROR "O arquivo pico_sdk_import.cmake não foi encontrado em ${PICO_SDK_PATH}/external/")
endif ()

# Compiladores
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)
set(CMAKE_AR arm-none-eabi-ar)

# Flags essenciais de compilação
set(CMAKE_C_FLAGS "-mcpu=cortex-m0plus -mthumb -Os -ffunction-sections -fdata-sections" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -fno-exceptions -fno-rtti" CACHE INTERNAL "")
set(CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS}" CACHE INTERNAL "")

# Configurações de linking
set(CMAKE_EXE_LINKER_FLAGS "-Wl,--gc-sections -Wl,-Map=freertos_pico.map -nostdlib" CACHE INTERNAL "")

# Desativa testes desnecessários
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
