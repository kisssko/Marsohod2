/*
 * PWM-модуль для преобразования числа 0..255 в PWM для канала аудио на шилде Марсоход2
 */

audio_pwm AUDIO_PWM(

    .clk(...),                  // 25 MHz
    .vol(...),                  // громкость 0..255 [0..1]
    .pwm(sound_left)            // sound_left или sound_right, либо другой wire

);