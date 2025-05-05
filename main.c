#include <stdint.h>
#include <stdio.h>
#include "pico/stdlib.h"
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"

#define BUTTON_PIN  14
#define LED_PIN     25

QueueHandle_t buttonQueue;
TaskHandle_t ledTaskHandle;

void vSystemInit(void) {
    stdio_init_all();
    gpio_init(BUTTON_PIN);
    gpio_set_dir(BUTTON_PIN, GPIO_IN);
    gpio_pull_up(BUTTON_PIN);
    gpio_init(LED_PIN);
    gpio_set_dir(LED_PIN, GPIO_OUT);
}

// ---->>>>>> Tarefa 1: Leitura do botão  att:Hobson Nascimento <<<<<<--------

void vButtonTask(void *pvParameters) {
    (void)pvParameters;
    int lastButtonState = 1;

    for (;;) {
        int currentState = gpio_get(BUTTON_PIN);
        if (lastButtonState == 1 && currentState == 0) {
            vTaskDelay(pdMS_TO_TICKS(20));
            currentState = gpio_get(BUTTON_PIN);
            if (currentState == 0) {
                int pressed = 1;
                xQueueSend(buttonQueue, &pressed, portMAX_DELAY);
            }
        }
        lastButtonState = currentState;
        vTaskDelay(pdMS_TO_TICKS(50));
    }
}

// ---->>>>>> Tarefa 2: Processamento do botão  att:Hobson Nascimento <<<<<<--------

void vButtonProcessingTask(void *pvParameters) {
    (void)pvParameters;
    int buttonStatus;

    for (;;) {
        if (xQueueReceive(buttonQueue, &buttonStatus, portMAX_DELAY) == pdTRUE) {
            if (buttonStatus == 1) {
                xTaskNotifyGive(ledTaskHandle);
            }
        }
    }
}

// ---->>>>>> Tarefa 3: Controle do LED  att:Hobson Nascimento <<<<<<--------

void vLEDTask(void *pvParameters) {
    (void)pvParameters;

    for (;;) {
        ulTaskNotifyTake(pdTRUE, portMAX_DELAY);
        static int ledState = 0;
        ledState = !ledState;
        gpio_put(LED_PIN, ledState);
        printf("LED %s\n", ledState ? "LIGADO" : "DESLIGADO");
    }
}

int main(void) {
    vSystemInit();
    buttonQueue = xQueueCreate(5, sizeof(int));
    xTaskCreate(vButtonTask, "Button Task", 256, NULL, 1, NULL);
    xTaskCreate(vButtonProcessingTask, "Button Processing Task", 256, NULL, 2, NULL);
    xTaskCreate(vLEDTask, "LED Task", 256, NULL, 3, &ledTaskHandle);
    vTaskStartScheduler();
    while (1) {}
    return 0;
}