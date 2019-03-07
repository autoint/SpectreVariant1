

int testFun(int idx,  unsigned char **memory_slot) {
// source of high-latency pointer to the memory slot
unsigned char secret_read_area[] = "0000011011101011";
unsigned char public_read_area[] = "################";

unsigned char timey_line_area[0x200000];
// stored in the memory slot first
#define timey_lines (timey_line_area + 0x10000)


unsigned char **flushy_area[1000];
#define flushy (flushy_area+500)

 // unsigned char *memory_slot_area[1000];


  *flushy = memory_slot;
  *memory_slot = secret_read_area;
  timey_lines['0' << 12] = 1;
  timey_lines['1' << 12] = 1;

  // START OF CRITICAL PATH
  unsigned char **memory_slot__slowptr = *flushy;
  //pipeline_flush();
  // the following store will be speculatively ignored since its address is unknown
  *memory_slot__slowptr = public_read_area;
  // architectual read from dummy_timey_line, possible microarchitectural read from timey_line
  char dummy_char_sink = timey_lines[(*memory_slot)[idx] << 12];
  // END OF CRITICAL PATH
}

// A pointer to a shared memory region of size 1MB (256 * 4096)
unsigned char *shared_buffer;

void InitializeIndex(unsigned int trusted_index, unsigned int *index) {
    *index = trusted_index;
}

unsigned char ReadByte(unsigned char *buffer, unsigned int buffer_size, unsigned int trusted_index) {
    unsigned int index;
    unsigned int *index_indirect = &index;
    *index_indirect = trusted_index;

    // SPECULATION BARRIER
    unsigned char value = buffer[index];
    return shared_buffer[value * 4096];
}
