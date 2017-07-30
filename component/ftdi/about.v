/*
 * Последовательный порт
 * 
 * Скорость 230400 бод или 25600 байт в секунду (25 кбайт/с)
 */
 
serial SERIAL(

	.clk12    (),      // Частота
	.rx       (),      // Входящие данные
	.rx_byte  (),      // Исходящий байт (8 bit)
	.rx_ready ()       // Строб готовности

);