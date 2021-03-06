module marsohod2(

    /* ----------------
     * Archectural Marsohod2
     * ---------------- */

    // CLOCK    100 Mhz
    input   wire        clk,

    // LED      4
    output  wire [3:0]  led,

    // KEYS     2
    input   wire [1:0]  keys,

    // ADC      8 bit
    output  wire        adc_clock_20mhz,
    input   wire [7:0]  adc_input,

    // SDRAM
    output  wire        sdram_clock,
    output  wire [11:0] sdram_addr,
    output  wire [1:0]  sdram_bank,
    inout   wire [15:0] sdram_dq,
    output  wire        sdram_ldqm,
    output  wire        sdram_udqm,
    output  wire        sdram_ras,
    output  wire        sdram_cas,
    output  wire        sdram_we,

    // VGA
    output  wire [4:0]  vga_red,
    output  wire [5:0]  vga_green,
    output  wire [4:0]  vga_blue,
    output  wire        vga_hs,
    output  wire        vga_vs,

    // FTDI (PORT-B)
    input   wire        ftdi_rx,
    output  wire        ftdi_tx,

    /* ----------------
     * Extension Shield
     * ---------------- */

    // USB-A    2 pins
    inout   wire [1:0]  usb,

    // SOUND    2 channel
    output  wire        sound_left,
    output  wire        sound_right,

    // PS/2     keyb / mouse
    inout   wire [1:0]  ps2_keyb,
    inout   wire [1:0]  ps2_mouse
);
// --------------------------------------------------------------------------

// ��������� ������ �������
wire [11:0] adapter_font;
wire [ 7:0] adapter_data;
wire [11:0] font_char_addr;
wire [ 7:0] font_char_data;

// ��������� ���� ��� ������
// .green - ��������� �������� ���� � ����� ������
// vga_green - ������� (������)

vga VGA_ADAPTER(

	.clk	(clk),	
	.red 	(vga_red),
	.green	(vga_green),
	.blue	(vga_blue),
	.hs		(vga_hs),
	.vs		(vga_vs),
    
    // �������� ���������������
    .adapter_font (adapter_font),
    .adapter_data (adapter_data),
    
    // ������������ ��������
    .font_char_addr (font_char_addr),
    .font_char_data (font_char_data)

);

// ����� �������� ������ (��������������)
fontrom VGA_FONT_ROM(

    .clock      (clk),          // �������� ������� - 100 ��� ��� ������
    .addr_rd    (adapter_font), // ������� ����� ��������� �����, ������� ��� ���������,
                                // ����� ������ �������� ��������� 8 ��� ��� ������
    .q          (adapter_data)  // ����� ����� ��� �������� ����� 2 ����� �� �������� 100 ���
);


// ���������� � �������� � ���������
fontram VGA_VIDEORAM(

    .clock      (clk),            // �������� ������� - 100 ��� ��� ������
    .addr_rd    (font_char_addr), // � ������ ������� �������� ������, ����� ��� ����
    .q          (font_char_data)  // ��� ����� ��������� 
);


endmodule
