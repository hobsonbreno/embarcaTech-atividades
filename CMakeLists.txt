cmake_minimum_required(VERSION 3.15)

# Definir o compilador
set(CMAKE_CXX_COMPILER "/usr/bin/arm-none-eabi-g++")

# Impedir testes de execução durante a configuração
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Caminho do SDK do Raspberry Pi Pico
set(PICO_SDK_PATH "/home/hobson007breno/projetos_embarcados/pico-sdk")

# Verificação de arquivos essenciais
if (NOT DEFINED PICO_SDK_PATH)
    message(FATAL_ERROR "PICO_SDK_PATH não está definido!")
endif()

# Projeto
project(freertos_pico
LANGUAGES C CXX ASM
VERSION 1.0
DESCRIPTION "FreeRTOS para Raspberry Pi Pico"
)

# Importa o SDK e inicializa
include(${PICO_SDK_PATH}/external/pico_sdk_import.cmake)
pico_sdk_init()


# Padrões C/C++
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

# Informações do board
set(PICO_PLATFORM "rp2040")
set(PICO_BOARD "pico")

# Caminho do kernel do FreeRTOS
set(FREERTOS_KERNEL_PATH "${CMAKE_CURRENT_SOURCE_DIR}/FreeRTOS/Source")

# Verifica se os arquivos essenciais existem
if(NOT EXISTS "${FREERTOS_KERNEL_PATH}/include/FreeRTOS.h")
    message(FATAL_ERROR "Arquivo essencial não encontrado: ${FREERTOS_KERNEL_PATH}/include/FreeRTOS.h")
endif()

if(NOT EXISTS "${FREERTOS_KERNEL_PATH}/portable/GCC/ARM_CM0/port.c")
    message(FATAL_ERROR "Arquivo essencial não encontrado: ${FREERTOS_KERNEL_PATH}/portable/GCC/ARM_CM0/port.c")
endif()

if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/config/FreeRTOSConfig.h")
    message(FATAL_ERROR "Arquivo essencial não encontrado: ${CMAKE_CURRENT_SOURCE_DIR}/config/FreeRTOSConfig.h")
endif()

# Define o executável
add_executable(freertos_pico
    main.c
    ${FREERTOS_KERNEL_PATH}/tasks.c
    ${FREERTOS_KERNEL_PATH}/queue.c
    ${FREERTOS_KERNEL_PATH}/list.c
    ${FREERTOS_KERNEL_PATH}/portable/GCC/ARM_CM0/port.c
    ${FREERTOS_KERNEL_PATH}/portable/MemMang/heap_4.c
)

# Definições de compilação
target_compile_definitions(freertos_pico PRIVATE
    PICO_BOARD="pico"
    PICO_NO_HARDWARE=0
    configUSE_CORE_AFFINITY=0
    configCPU_CLOCK_HZ=133000000
)

# Otimizações específicas para Cortex-M0+
target_compile_options(freertos_pico PRIVATE
    -mcpu=cortex-m0plus
    -mthumb
    -Wall
    -ffunction-sections
    -fdata-sections
    -Wno-unused-parameter
    -Wno-implicit-fallthrough
    $<$<CONFIG:Debug>:-Og -g3>
    $<$<CONFIG:Release>:-Os -flto>
)

# Includes
target_include_directories(freertos_pico PRIVATE
    ${FREERTOS_KERNEL_PATH}/include
    ${FREERTOS_KERNEL_PATH}/portable/GCC/ARM_CM0
    ${CMAKE_CURRENT_SOURCE_DIR}/config
    ${PICO_SDK_PATH}/src/common/pico_stdlib/include
    ${PICO_SDK_PATH}/src/rp2_common/hardware_irq/include
)

# Linka bibliotecas do SDK
target_link_libraries(freertos_pico PRIVATE
    pico_stdlib
    hardware_gpio
    hardware_irq
    hardware_sync
    pico_multicore
    pico_time
)

# Opções de linkagem
target_link_options(freertos_pico PRIVATE
    "-Wl,--wrap=_exit"
    "-Wl,--wrap=exit"
    "-Wl,--gc-sections"
    "-Wl,--print-memory-usage"
    "-Wl,-Map=${CMAKE_CURRENT_BINARY_DIR}/freertos_pico.map"
    "-mcpu=cortex-m0plus"
    "-mthumb"
    -flto  # Habilitar otimização de link
)

# Pós-build: mostra uso de memória
add_custom_command(TARGET freertos_pico POST_BUILD
    COMMAND ${CMAKE_SIZE} ${CMAKE_CURRENT_BINARY_DIR}/freertos_pico.elf
    COMMENT "Relatório de uso de memória:"
)
