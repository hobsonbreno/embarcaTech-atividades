#ifndef FREERTOS_CONFIG_H
#define FREERTOS_CONFIG_H

/* Configurações básicas para RP2040 */
#define configUSE_PREEMPTION            1
#define configUSE_IDLE_HOOK             0
#define configUSE_TICK_HOOK             0
#define configCPU_CLOCK_HZ              (133000000)  // Clock do RP2040
#define configTICK_RATE_HZ              (1000)       // 1 kHz = tick a cada 1ms
#define configMAX_PRIORITIES            (5)          // Número de prioridades
#define configMINIMAL_STACK_SIZE        (128)        // Stack mínimo em words (32-bit)
#define configTOTAL_HEAP_SIZE           (32 * 1024)  // Heap de 32KB para o RP2040
#define configMAX_TASK_NAME_LEN         (16)         // Tamanho máximo do nome da task

/* Configurações de otimização para ARM Cortex-M0+ */
#define configUSE_16_BIT_TICKS          0            // RP2040 usa 32-bit ticks
#define configIDLE_SHOULD_YIELD         1            // Permite yield na task idle
#define configUSE_MUTEXES               1            // Habilita mutexes
#define configUSE_RECURSIVE_MUTEXES     1            // Habilita mutexes recursivos
#define configUSE_COUNTING_SEMAPHORES   1            // Habilita semáforos contadores
#define configUSE_TASK_NOTIFICATIONS    1            // Habilita notificações de tasks
#define configUSE_TRACE_FACILITY        0            // Desabilita trace (para reduzir código)
#define configUSE_NEWLIB_REENTRANT      0

/* Configurações específicas do hardware */
#define configKERNEL_INTERRUPT_PRIORITY 255          // Prioridade mais baixa para o kernel
#define configMAX_SYSCALL_INTERRUPT_PRIORITY 191     // Prioridade máxima para syscalls
#define configENABLE_MPU 0                           // Desabilita MPU para RP2040 (não suportado)

/* Alocação de memória */
#define configSUPPORT_STATIC_ALLOCATION    1
#define configSUPPORT_DYNAMIC_ALLOCATION   1

/* APIs úteis */
#define INCLUDE_vTaskDelay                 1
#define INCLUDE_vTaskDelete                1
#define INCLUDE_vTaskSuspend               1
#define INCLUDE_vTaskDelayUntil            1
#define INCLUDE_vTaskPrioritySet           1
#define INCLUDE_uxTaskPriorityGet          1

/* Segurança e debug */
#define configCHECK_FOR_STACK_OVERFLOW     2
#include <assert.h>
#define configASSERT(x) assert(x)

/* Inclusão de headers */
//#include "rp2040_config.h"  // Configurações específicas do RP2040 (opcional)
/* Configurações específicas para RP2040 */
//#define configCPU_CLOCK_HZ 133000000
//#define configSYSTICK_CLOCK_HZ 1000000

#endif /* FREERTOS_CONFIG_H */
